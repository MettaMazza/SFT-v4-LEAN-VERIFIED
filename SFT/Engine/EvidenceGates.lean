import SFT.Engine.DecisionGate
/-! Source engine/model.py closure/control dataclasses and engine.py closure/control
checks. ClosureScope and ControlKind preserve the source enum domains. Python values
outside annotated field types require importer validation and are not silently admitted. -/
namespace SFT.Engine

inductive ClosureScope where
 | conditionalGrammar | finiteComplete | depthIndependent

inductive ControlKind where
 | falsePremise | tamperedSource | tamperedArtifact | boundary

def scopeName : ClosureScope → String
 | .conditionalGrammar => "conditional_grammar"
 | .finiteComplete => "finite_complete"
 | .depthIndependent => "depth_independent"

def kindName : ControlKind → String
 | .falsePremise => "false_premise"
 | .tamperedSource => "tampered_source"
 | .tamperedArtifact => "tampered_artifact"
 | .boundary => "boundary"

def depthIndependent : ClosureScope → Bool
 | .depthIndependent => true
 | .conditionalGrammar => false
 | .finiteComplete => false

structure ClosureEvidence where
  scope : ClosureScope
  exactBoundary : String
  minimalityPassed : Bool
  namedShapeUniquenessPassed : Bool
  proofHash : String
  generalityCertificateHash : Option String := none

structure ControlResult where
  kind : ControlKind
  passed : Bool
  expectedBehavior : String
  observedBehavior : String
  receiptHash : String

def optionalIdentity : Option String → Bool
 | none => false
 | some s => isSha256Identity s

def closureEvidenceValue (c : ClosureEvidence) : SFT.Host.Canonical.Value := .object [
  ("scope", .text (scopeName c.scope)), ("exact_boundary", .text c.exactBoundary),
  ("minimality_passed", .boolean c.minimalityPassed),
  ("named_shape_uniqueness_passed", .boolean c.namedShapeUniquenessPassed),
  ("proof_hash", .text c.proofHash),
  ("generality_certificate_hash", match c.generalityCertificateHash with | none => .null | some s => .text s)]

def controlResultValue (c : ControlResult) : SFT.Host.Canonical.Value := .object [
  ("kind", .text (kindName c.kind)), ("passed", .boolean c.passed),
  ("expected_behavior", .text c.expectedBehavior), ("observed_behavior", .text c.observedBehavior),
  ("receipt_hash", .text c.receiptHash)]

-- isinstance(scope, ClosureScope) is necessarily true in the source-typed domain.
def closureViolations (c : ClosureEvidence) : List String := collectViolations [
  (blank c.exactBoundary, "closure boundary is missing"),
  (!c.minimalityPassed, "minimality gate failed"),
  (!c.namedShapeUniquenessPassed, "named-shape uniqueness gate failed"),
  (!isSha256Identity c.proofHash, "closure proof hash is invalid"),
  (depthIndependent c.scope && !optionalIdentity c.generalityCertificateHash,
    "depth-independent closure lacks a generality certificate")]

def hasKind (kind : ControlKind) (cs : List ControlResult) : Bool :=
  cs.any (fun c => SFT.Host.Text.equal (kindName kind) (kindName c.kind))

-- Sorted source REQUIRED_CONTROLS.difference(kinds) by item.value.
def missingKinds (cs : List ControlResult) : List ControlKind :=
  [ControlKind.boundary,.falsePremise,.tamperedArtifact,.tamperedSource].filter (fun k => !hasKind k cs)

def duplicateKinds : List ControlResult → Bool
 | [] => false
 | c::cs => hasKind c.kind cs || duplicateKinds cs

def perControlViolations (c : ControlResult) : List String := collectViolations [
  (!c.passed, SFT.Host.Text.append "control failed: " (kindName c.kind)),
  (blank c.expectedBehavior || blank c.observedBehavior,
    SFT.Host.Text.append "control lacks expected or observed behavior: " (kindName c.kind)),
  (!isSha256Identity c.receiptHash,
    SFT.Host.Text.append "control receipt hash is invalid: " (kindName c.kind))]

def controlViolations (cs : List ControlResult) : List String :=
  collectViolations [
    (!(missingKinds cs).isEmpty,
      SFT.Host.Text.append "missing required controls: " (SFT.Host.Text.intercalate ", " ((missingKinds cs).map kindName))),
    (duplicateKinds cs, "control kinds must not be duplicated")] ++
  cs.flatMap perControlViolations

theorem trueOfNotFalse (b : Bool) (h : (!b) = false) : b = true := by
  cases b with
  | false => cases h
  | true => rfl

theorem passingClosureHasBoundary (c : ClosureEvidence) (h : closureViolations c = []) :
    blank c.exactBoundary = false := collectEmptyHeadFalse _ _ _ h

theorem passingClosureHasMinimality (c : ClosureEvidence) (h : closureViolations c = []) :
    c.minimalityPassed = true :=
  trueOfNotFalse _ (collectEmptyHeadFalse _ _ _ (collectEmptyTail _ _ _ h))

theorem passingClosureHasUniqueness (c : ClosureEvidence) (h : closureViolations c = []) :
    c.namedShapeUniquenessPassed = true :=
  trueOfNotFalse _ (collectEmptyHeadFalse _ _ _ (collectEmptyTail _ _ _ (collectEmptyTail _ _ _ h)))

theorem passingDepthIndependentHasCertificate (c : ClosureEvidence)
    (hd : depthIndependent c.scope = true) (h : closureViolations c = []) :
    optionalIdentity c.generalityCertificateHash = true := by
  have last := collectEmptyTail _ _ _ (collectEmptyTail _ _ _ (collectEmptyTail _ _ _ (collectEmptyTail _ _ _ h)))
  have bad := collectEmptyHeadFalse _ _ _ last
  rw [hd] at bad
  exact trueOfNotFalse _ bad

theorem appendEmptyLeft {α : Type} (xs ys : List α) (h : xs ++ ys = []) : xs = [] := by
  cases xs with
  | nil => rfl
  | cons x xs => cases h

theorem appendEmptyRight {α : Type} (xs ys : List α) (h : xs ++ ys = []) : ys = [] := by
  cases xs with
  | nil => exact h
  | cons x xs => cases h

theorem emptyPerControlImpliesPassed (c : ControlResult) (h : perControlViolations c = []) :
    c.passed = true := trueOfNotFalse _ (collectEmptyHeadFalse _ _ _ h)

theorem emptyControlDetailsAllPassed (cs : List ControlResult)
    (h : cs.flatMap perControlViolations = []) : cs.all ControlResult.passed = true := by
  induction cs with
  | nil => rfl
  | cons c cs ih =>
    have first := emptyPerControlImpliesPassed c (appendEmptyLeft _ _ h)
    have rest := ih (appendEmptyRight _ _ h)
    change (c.passed && cs.all ControlResult.passed) = true
    rw [first, rest]
    rfl

theorem passingControlsAllPassed (cs : List ControlResult) (h : controlViolations cs = []) :
    cs.all ControlResult.passed = true :=
  emptyControlDetailsAllPassed cs (appendEmptyRight _ _ h)

end SFT.Engine
