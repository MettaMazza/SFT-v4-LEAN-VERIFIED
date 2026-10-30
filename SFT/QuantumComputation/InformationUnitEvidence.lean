import SFT.QuantumComputation.InformationUnitControls
import SFT.Engine.RegistrationGate
namespace SFT.QuantumComputation.InformationUnitEvidence
open SFT.Host.Canonical SFT.QuantumComputation.InformationUnitGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "unit",.text (unitName c.unit)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "phase",.text (phaseName c.phase)],.array [.text "transformation",.text (transformationName c.transformation)],.array [.text "observation",.text (observationName c.observation)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-QUANTUM-INFORMATION-UNIT-001"),("boundary",.text grammarBoundary),
  ("dimensions",.array [.array [.text "support",.array [.text "partial-or-selected-branch-support",.text "complete-generated-branch-support"]],.array [.text "unit",.array [.text "imported-bit-or-qubit",.text "one-Fold-distinction-unit"]],.array [.text "composition",.array [.text "sampled-joint-states",.text "complete-pair-cell-joint-support"]],.array [.text "phase",.array [.text "complex-amplitude-postulate",.text "period-held-phase-action"]],.array [.text "transformation",.array [.text "partial-or-irreversible-map",.text "total-reversible-source-bound-map"]],.array [.text "observation",.array [.text "collapse-without-record",.text "retained-class-and-complete-record"]],.array [.text "generality",.array [.text "fixed-circuit-examples",.text "branch-and-depth-successor-certificate"]],.array [.text "addition",.array [.text "imported-quantum-model",.text "no-extra-quantum-premise"]]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("exhaustion",.text "Every coordinate combination in the registered eight-axis product occurs once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-QUANTUM-INFORMATION-UNIT-001"
  title := "Fold quantum information-unit law"
  branch := "quantum_computation"
  statement := "The forced quantum information units kernel retains one Fold distinction; two held fibre labels; complete word support; exact observation classes; retained phase-label carrier; branch support, phase, transformation, observation, composition and resources remain exact, finite, source-bound and free of imported amplitudes or postulates."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-QUANTUM-REVERSIBLE-MODEL-001","SFT-COMP-SCI-MATHEMATICAL-MODELLING-001","SFT-COMP-FORM-CIRCUIT-001","SFT-COMP-FORM-UNIVERSALITY-001","SFT-COMP-CPLX-REVERSIBILITY-COST-001","SFT-COMP-SEC-POST-QUANTUM-BOUNDARY-001","SFT-COMP-LEARN-CLASSICAL-LEARNING-001","SFT-INFO-QUANTUM-CORRESPONDENCE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-QUANTUM-INFORMATION-UNIT-001",candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-QUANTUM-INFORMATION-UNIT-001",candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("result",.text "The forced quantum information units kernel retains one Fold distinction; two held fibre labels; complete word support; exact observation classes; retained phase-label carrier; branch support, phase, transformation, observation, composition and resources remain exact, finite, source-bound and free of imported amplitudes or postulates."),
    ("laws",.array [.text "Support law: one Fold distinction; two held fibre labels; complete word support; exact observation classes; retained phase-label carrier.",.text "Phase law: period-held label actions transform branch provenance without imaginary or irrational proof values.",.text "Reversibility law: transformations are total bijections or retain the exact predecessor label needed for inversion.",.text "Observation law: selected support and every closed distinction remain reconstructible from the measurement record.",.text "Composition law: joint pair-cell words preserve component identity and explicitly classify factorable and nonfactorable support."]),
    ("base",.text "One Fold distinction supplies the minimal two-label support and one exact quantum information units record."),("step",.text "Adding one generated branch, component, fault position or circuit location appends all new joint cells, phase rows, transformations and observation distinctions while retaining prior records."),
    ("witnesses",.array ((SFT.QuantumComputation.ReversibleWitnesses.operationalWitnesses "SFT-QUANTUM-INFORMATION-UNIT-001").map fun (name,statement,passed) =>
      .object [("name",.text name),("statement",.text statement),("passed",.boolean passed)])),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.array [.text "SFT-QUANTUM-INFORMATION-UNIT-001",.text "One Fold distinction supplies the minimal two-label support and one exact quantum information units record.",.text "Adding one generated branch, component, fault position or circuit location appends all new joint cells, phase rows, transformations and observation distinctions while retaining prior records."]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold quantum information-unit law must be forced from admitted Fold and computation laws before conventional quantum models may be compared."

def derivation : String := "Complete Fold-word support, exact information ledgers, reversible classical processes and pair-cell composition force the registered kernel: one Fold distinction; two held fibre labels; complete word support; exact observation classes; retained phase-label carrier."

def check : String := "Execute all 256 structural candidates, decide every member, verify the sole survivor, replay eight quantum operational witnesses, exhaust fault masks at widths three, five and seven, run four controls and independently regenerate the product."

def limitations : String := "The unit is structural support, not an imported complex vector or conventional qubit."

def correspondenceTerms : List String := ["qubit","quantum information unit"]

end SFT.QuantumComputation.InformationUnitEvidence
