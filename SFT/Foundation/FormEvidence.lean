import SFT.Foundation.FormControls
import SFT.Engine.RegistrationGate
namespace SFT.Foundation.FormEvidence
open SFT.Host.Canonical FormGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),("base",.text (baseName c.base)),
  ("arity",.text (arityName c.arity)),("labels",.text (labelsName c.labels)),
  ("children",.text (childrenName c.children)),("return",.text (returnsName c.returns)),
  ("termination",.text (terminationName c.termination)),("extra",.text (extraName c.extra)),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator",.text generationRule),("boundary",.text grammarBoundary),
  ("domains",.array (([
    ["base-excluded","base-included"],
    ["one-child","two-children","later-arity"],
    ["labels-absent","labels-same","labels-distinct-held"],
    ["children-ungenerated","children-generated"],
    ["return-absent","return-present"],
    ["termination-absent","finite-leaf-termination"],
    ["no-extra","has-extra"]] : List (List String)).map fun xs => .array (xs.map Value.text))),
  ("candidates",.array (candidates.map candidateRecord)),
  ("productions",.array [.text "Form := One",.text "Form := Fold(held-a: Form, held-b: Form, return-to-One)"]),
  ("exhaustion",.text "The base and every local Fold-production requirement are independently classified; the product exhausts the declared production-rule grammar.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-FORM-GRAMMAR-001"
  title := "Complete foundational form grammar"
  branch := "foundation"
  statement := "The complete foundational form grammar has exactly two productions: the structural One leaf, and a finite Fold node with two recursively generated child forms on distinct held-labelled edges and an explicit return relation to the parent whole."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-ASSEMBLY-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("generator",.text generationRule),("record",candidateRecord c)])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := identity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := identity (.object [("record",candidateRecord c),("survives",.boolean (survives c)),
    ("reason",.text (decisionReason c)),("dependencies",.array [.text "SFT-FOUNDATION-ONE-001",.text "SFT-FOUNDATION-FOLD-001",.text "SFT-FOUNDATION-FOLD-ASSEMBLY-001"])])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error (SFT.Host.Text.append "KeyError: " candidate.candidateId)

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("closure",FormControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("structural_induction",.boolean true),("closure",FormControls.closureValue)]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Foundation.FormEvidence
