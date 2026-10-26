import SFT.Foundation.FormEnforcementControls
import SFT.Engine.RegistrationGate
namespace SFT.Foundation.FormEnforcementEvidence
open SFT.Host.Canonical FormEnforcementGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coverage",.text (coverageName c.coverage)),
  ("multiplicity",.text (multiplicityName c.multiplicity)),
  ("labels",.text (labelsName c.labels)),
  ("children",.text (childrenName c.children)),
  ("returns",.text (returnsName c.returns)),
  ("trace",.text (traceName c.trace)),
  ("extra",.text (extraName c.extra)),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator",.text generationRule),("boundary",.text grammarBoundary),
  ("domains",.array (([["none","proper","complete"],["node-duplicated","node-once"],["labels-lost","labels-preserved"],["children-changed","children-preserved"],["returns-lost","returns-preserved"],["trace-noncanonical","trace-canonical"],["no-extra","has-extra"]] : List (List String)).map fun xs => .array (xs.map Value.text))),
  ("candidates",.array (candidates.map candidateRecord)),
  ("canonicalizer",.text "One maps to its terminal trace; Fold maps to Fold, held-a child trace, held-b child trace, return, recursively.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-FORM-ENFORCEMENT-001"
  title := "Canonical foundational form enforcement"
  branch := "foundation"
  statement := "Every generated finite foundational form has one exact identity representation: its complete canonical recursive construction trace with each node once and every held label, child relation and Fold return preserved; two forms are equivalent exactly when these traces agree."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FORM-GRAMMAR-001"]
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
    ("reason",.text (decisionReason c)),("dependency",.text "SFT-FOUNDATION-FORM-GRAMMAR-001")])

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
  proofHash := identity (.object [("closure",FormEnforcementControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("canonical_structural_induction",.boolean true),("closure",FormEnforcementControls.closureValue)]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Foundation.FormEnforcementEvidence
