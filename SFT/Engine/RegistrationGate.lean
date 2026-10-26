import SFT.Engine.CensusGate
/-! Exact source-typed ClaimRegistration and engine.py::_registration_violations.
The authority lookup argument is the source AuthorityLedger.contains method;
its receipt validation is integrated separately. Enum fields encode the annotated
source domain; malformed runtime Python values require importer validation. -/
namespace SFT.Engine

inductive EvidenceMode where
  | formal | empirical

inductive ProvenanceClass where
  | directForcing | forwardForcing | constitutionalRelation | observationalDerivation

def evidenceModeName : EvidenceMode → String
  | .formal => "formal"
  | .empirical => "empirical"

def provenanceName : ProvenanceClass → String
  | .directForcing => "direct_forcing"
  | .forwardForcing => "forward_forcing"
  | .constitutionalRelation => "constitutional_relation"
  | .observationalDerivation => "observational_derivation"

structure ClaimRegistration where
  claimId : String
  title : String
  branch : String
  statement : String
  evidenceMode : EvidenceMode
  rootTheorems : List String
  dependencies : List String
  axioms : List String
  freeParameters : List String
  provenance : List ProvenanceClass
  sourceHash : String

def registrationValue (r : ClaimRegistration) : SFT.Host.Canonical.Value := .object [
  ("claim_id", .text r.claimId), ("title", .text r.title), ("branch", .text r.branch),
  ("statement", .text r.statement), ("evidence_mode", .text (evidenceModeName r.evidenceMode)),
  ("root_theorems", .array (r.rootTheorems.map .text)),
  ("dependencies", .array (r.dependencies.map .text)),
  ("axioms", .array (r.axioms.map .text)), ("free_parameters", .array (r.freeParameters.map .text)),
  ("provenance", .array (r.provenance.map fun p => .text (provenanceName p))),
  ("source_hash", .text r.sourceHash)]

def rootTheoremId : String := "SFT-ROOT-THERE-IS-NO-NOTHING"

def insertIdentifier (x : String) : List String → List String
  | [] => [x]
  | y::ys => if SFT.Host.Text.le x y then x::y::ys else y::insertIdentifier x ys

def sortIdentifiers : List String → List String
  | [] => []
  | x::xs => insertIdentifier x (sortIdentifiers xs)

def missingDependencies (contains : String → Bool) (r : ClaimRegistration) : List String :=
  r.dependencies.filter fun id => !(contains id)

def registrationHeaderViolations (r : ClaimRegistration) : List String :=
  collectViolations [
    (blank r.claimId, "claim_id is missing"), (blank r.title, "title is missing"),
    (blank r.branch, "branch is missing"), (blank r.statement, "statement is missing")] ++
  (if SFT.Host.Text.equal r.claimId rootTheoremId then collectViolations [
    (!r.rootTheorems.isEmpty, "the root theorem cannot cite itself as a premise"),
    (!r.dependencies.isEmpty, "the root theorem cannot depend on a prior model claim")]
  else collectViolations [(!(sameIdentifiers r.rootTheorems [rootTheoremId]),
    "foundation trace must contain exactly the single self-proven root theorem")])

def registrationCoreViolations (contains : String → Bool) (r : ClaimRegistration) : List String :=
  let missing := missingDependencies contains r
  collectViolations [
    (!r.axioms.isEmpty, "axioms are forbidden"),
    (!r.freeParameters.isEmpty, "free, fitted or learned parameters are forbidden"),
    (duplicateIdentifiers r.dependencies, "dependency list contains duplicates"),
    (!missing.isEmpty, SFT.Host.Text.append "dependencies lack model-admitted receipts: "
      (SFT.Host.Text.intercalate ", " (sortIdentifiers missing))),
    (r.provenance.isEmpty, "derivation provenance is unclassified"),
    (!(isSha256Identity r.sourceHash), "source hash is not a canonical SHA-256 identity")]

def executedSourceViolations (r : ClaimRegistration) : Option String → List String
  | none => []
  | some executed =>
    if !(isSha256Identity executed) then ["executed source manifest hash is invalid"]
    else if !(SFT.Host.Text.equal r.sourceHash executed) then
      ["registered source hash differs from the files loaded by the official runner"]
    else []

def registrationViolations (contains : String → Bool) (r : ClaimRegistration)
    (executed : Option String) : List String :=
  registrationHeaderViolations r ++
    (registrationCoreViolations contains r ++ executedSourceViolations r executed)

theorem passingRegistrationCore (contains : String → Bool) (r : ClaimRegistration)
    (e : Option String) (h : registrationViolations contains r e = []) :
    registrationCoreViolations contains r = [] :=
  appendEmptyLeft _ _ (appendEmptyRight _ _ h)

theorem listEmptyOfIsEmpty {α : Type} (xs : List α) (h : xs.isEmpty = true) : xs = [] := by
  cases xs with
  | nil => rfl
  | cons x xs => cases h

theorem passingRegistrationHasNoAxioms (contains : String → Bool) (r : ClaimRegistration)
    (e : Option String) (h : registrationViolations contains r e = []) : r.axioms = [] :=
  listEmptyOfIsEmpty _ (trueOfNotFalse _ (collectEmptyHeadFalse _ _ _
    (passingRegistrationCore contains r e h)))

theorem passingRegistrationHasNoFreeParameters (contains : String → Bool) (r : ClaimRegistration)
    (e : Option String) (h : registrationViolations contains r e = []) : r.freeParameters = [] :=
  listEmptyOfIsEmpty _ (trueOfNotFalse _ (collectEmptyHeadFalse _ _ _
    (collectEmptyTail _ _ _ (passingRegistrationCore contains r e h))))

theorem passingRegistrationNoMissingDependencies (contains : String → Bool) (r : ClaimRegistration)
    (e : Option String) (h : registrationViolations contains r e = []) :
    missingDependencies contains r = [] :=
  listEmptyOfIsEmpty _ (trueOfNotFalse _ (collectEmptyHeadFalse _ _ _
    (collectEmptyTail _ _ _ (collectEmptyTail _ _ _
      (collectEmptyTail _ _ _ (passingRegistrationCore contains r e h))))))

end SFT.Engine
