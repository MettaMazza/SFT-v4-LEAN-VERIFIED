import SFT.Foundation.MeasurementControls
import SFT.Engine.RegistrationGate
namespace SFT.Foundation.MeasurementEvidence
open SFT.Host.Canonical MeasurementGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("flow",.text (flowName c.flow)),
  ("proof",.text (proofName c.proof)),
  ("target",.text (targetName c.target)),
  ("rows",.text (rowsName c.rows)),
  ("source",.text (sourceName c.source)),
  ("law",.text (lawName c.law)),
  ("extra",.text (extraName c.extra)),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator",.text generationRule),("boundary",.text grammarBoundary),
  ("domains",.array (([["disconnected","derivation-to-measurement","measurement-to-derivation","bidirectional"],["proof-inexact","proof-exact"],["target-before-seal","target-after-seal"],["rows-selective","rows-complete"],["source-absent","source-identified"],["law-mutated","law-unchanged"],["no-extra","has-extra"]] : List (List String)).map fun xs => .array (xs.map Value.text))),
  ("candidates",.array (candidates.map candidateRecord)),
  ("phase_order",.array [.text "exact derivation",.text "seal",.text "open separately held target",.text "measure",.text "preserve every row"]),
  ("quarantine",.text "Conventional decimal values exist only in measured records and cannot become SFT proof quantities.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"
  title := "One-way derivation-to-measurement boundary"
  branch := "foundation"
  statement := "The unique admissible interface between SFT derivation and conventional measurement is one-way: an exact source-bound law seals its consequence before an identified external target is opened, measurement preserves every row, and no measured value, score or target may select or mutate the law."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001"]
  axioms := []
  freeParameters := []
  provenance := [.constitutionalRelation]
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
    ("reason",.text (decisionReason c)),("dependency",.text "SFT-FOUNDATION-FORM-ENFORCEMENT-001")])

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
  proofHash := identity (.object [("closure",MeasurementControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("branch_independent_phase_order",.boolean true),("closure",MeasurementControls.closureValue)]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Foundation.MeasurementEvidence
