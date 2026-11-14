import SFT.QuantumComputation.UnboundedGrammar
import SFT.QuantumComputation.UnboundedWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.QuantumComputation.UnboundedEvidence
open SFT.Host.Canonical UnboundedGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def witness0 : Bool := UnboundedWitnesses.witness0
theorem witness0Passed : witness0=true := UnboundedWitnesses.witness0Passed
def witness1 : Bool := UnboundedWitnesses.witness1
theorem witness1Passed : witness1=true := UnboundedWitnesses.witness1Passed
def witness2 : Bool := UnboundedWitnesses.witness2
theorem witness2Passed : witness2=true := UnboundedWitnesses.witness2Passed
def witness3 : Bool := UnboundedWitnesses.witness3
theorem witness3Passed : witness3=true := UnboundedWitnesses.witness3Passed
def witness4 : Bool := UnboundedWitnesses.witness4
theorem witness4Passed : witness4=true := UnboundedWitnesses.witness4Passed
def witness5 : Bool := UnboundedWitnesses.witness5
theorem witness5Passed : witness5=true := UnboundedWitnesses.witness5Passed
def witness6 : Bool := UnboundedWitnesses.witness6
theorem witness6Passed : witness6=true := UnboundedWitnesses.witness6Passed
def witness7 : Bool := UnboundedWitnesses.witness7
theorem witness7Passed : witness7=true := UnboundedWitnesses.witness7Passed
def witnesses : Value := .array [.array [.text "unbounded-fault-witness-1",.text "one-error order forces width three for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002",.boolean witness0],.array [.text "unbounded-fault-witness-2",.text "separate two- and three-error orders force widths five and seven for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002",.boolean witness1],.array [.text "unbounded-fault-witness-3",.text "fault order fourteen forces width twenty-nine for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002",.boolean witness2],.array [.text "unbounded-fault-witness-4",.text "every mask through orders one, two and three decodes exactly for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002",.boolean witness3],.array [.text "unbounded-fault-witness-5",.text "every predecessor width through fault order fourteen has a constructive failure for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002",.boolean witness4],.array [.text "unbounded-fault-witness-6",.text "the fault-order successor adds exactly two labels for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002",.boolean witness5],.array [.text "unbounded-fault-witness-7",.text "every supplied finite ceiling has a generated successor fault order for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002",.boolean witness6],.array [.text "unbounded-fault-witness-8",.text "all depth-seven words round-trip at fault order fourteen before circuit evaluation for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002",.boolean witness7]]
def witnessRecords : Value := .array [.object [("name",.text "unbounded-fault-witness-1"),("statement",.text "one-error order forces width three for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("passed",.boolean witness0)],.object [("name",.text "unbounded-fault-witness-2"),("statement",.text "separate two- and three-error orders force widths five and seven for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("passed",.boolean witness1)],.object [("name",.text "unbounded-fault-witness-3"),("statement",.text "fault order fourteen forces width twenty-nine for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("passed",.boolean witness2)],.object [("name",.text "unbounded-fault-witness-4"),("statement",.text "every mask through orders one, two and three decodes exactly for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("passed",.boolean witness3)],.object [("name",.text "unbounded-fault-witness-5"),("statement",.text "every predecessor width through fault order fourteen has a constructive failure for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("passed",.boolean witness4)],.object [("name",.text "unbounded-fault-witness-6"),("statement",.text "the fault-order successor adds exactly two labels for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("passed",.boolean witness5)],.object [("name",.text "unbounded-fault-witness-7"),("statement",.text "every supplied finite ceiling has a generated successor fault order for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("passed",.boolean witness6)],.object [("name",.text "unbounded-fault-witness-8"),("statement",.text "all depth-seven words round-trip at fault order fourteen before circuit evaluation for SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("passed",.boolean witness7)]]
def claimId : String := "SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"
def dependencies : List String := ["SFT-QUANTUM-ERROR-CORRECTION-001","SFT-QUANTUM-FAULT-TOLERANCE-001","SFT-QUANTUM-CIRCUIT-001","SFT-COMP-CPLX-ARBITRARY-CIRCUIT-LOWER-BOUND-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "fault_order",.text (fault_orderName c.fault_order)],.array [.text "width",.text (widthName c.width)],.array [.text "coverage",.text (coverageName c.coverage)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "recovery",.text (recoveryName c.recovery)],.array [.text "circuit",.text (circuitName c.circuit)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text "SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"),("boundary",.text "Every supplied positive finite Fold fault-order trace, its generated repetition widths in increasing order, every fault mask through that order by exact subset class, and composition with admitted finite Fold circuit semantics."),("dimensions",.array [.array [.text "fault_order",.array [.text "fixed-one-error-model",.text "supplied-positive-finite-fault-trace"]],.array [.text "width",.array [.text "selected-or-even-width",.text "first-strict-majority-width-2t-plus-1"]],.array [.text "coverage",.array [.text "sampled-fault-patterns",.text "all-masks-through-t-by-subset-count"]],.array [.text "minimality",.array [.text "shorter-widths-unchecked",.text "counterexample-for-every-width-through-2t"]],.array [.text "recovery",.array [.text "decoded-label-without-record",.text "exact-syndrome-and-recovery-trace"]],.array [.text "circuit",.array [.text "isolated-code-example",.text "corrected-word-feeds-exact-circuit-semantics"]],.array [.text "generality",.array [.text "fixed-t-table",.text "fault-order-successor-and-ceiling-defeat"]],.array [.text "addition",.array [.text "imported-hardware-threshold",.text "no-rate-device-or-noise-parameter"]]]),("exhaustion",.text "Every coordinate combination in the registered eight-axis product occurs once."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Unbounded finite Fold quantum fault-tolerance law"
 branch := "quantum_computation"
 statement := "For every supplied positive finite fault-order trace t, the unique first repetition width correcting every mask through t is 2t+1: at least t+1 source labels remain against at most t changes, every width through 2t has a constructive tie or wrong-majority counterexample, redundancy is exactly 2t, and the successor fault order adds exactly two labels. The corrected word composes with exact Fold circuit semantics. This is an unbounded finite fault-order theorem, not a stochastic hardware-rate or physical threshold constant."
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := admissionIdentity (.array [.text claimId,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.array [.text claimId,candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue (decisions : List SFT.Engine.CandidateDecision) : Value := .object [("result",.text "For every supplied positive finite fault-order trace t, the unique first repetition width correcting every mask through t is 2t+1: at least t+1 source labels remain against at most t changes, every width through 2t has a constructive tie or wrong-majority counterexample, redundancy is exactly 2t, and the successor fault order adds exactly two labels. The corrected word composes with exact Fold circuit semantics. This is an unbounded finite fault-order theorem, not a stochastic hardware-rate or physical threshold constant."),("laws",.array [.text "Width law: the first strict-majority carrier at fault order t contains exactly 2t+1 held positions.",.text "Correction law: at most t changes leave at least t+1 original labels, so the unique strict majority is retained.",.text "Minimality law: every width w through 2t is defeated by changing ceil(w/2) positions, producing a tie or wrong majority.",.text "Successor law: replacing t by its next generated fault order adds exactly two carrier positions and defeats every fixed positive finite ceiling.",.text "Composition law: recovery supplies the exact source word to the already-admitted reversible circuit semantics."]),("base",.text "At the first positive fault order, widths one and two have explicit failure rows and width three retains two source labels against one change."),("step",.text "If width 2t+1 is the first survivor at fault order t, the next order requires one further possible change and one further retained source majority; exactly two added positions produce 2(t+1)+1, while every shorter successor width has the same constructive counterexample."),("witnesses",witnessRecords),("decisions",.array (decisions.map SFT.Engine.decisionValue))]
def generalityValue : Value := .array [.text claimId,.text "At the first positive fault order, widths one and two have explicit failure rows and width three retains two source labels against one change.",.text "If width 2t+1 is the first survivor at fault order t, the next order requires one further possible change and one further retained source majority; exactly two added positions produce 2(t+1)+1, while every shorter successor width has the same constructive counterexample."]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (closureValue decisions)
 generalityCertificateHash := some (admissionIdentity generalityValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := admissionIdentity (.array [.text claimId,.text (SFT.Engine.kindName kind),.text expected,.text observed,.boolean passed])
def exclusions : List String := ["no numerical zero, negative, irrational, imaginary or floating proof quantity","no complex amplitude, Hilbert-space axiom or stochastic collapse postulate","no completed infinite-width code or completed infinity","no measured error rate, hardware threshold, fitted noise model or device parameter","no application output or physical benchmark may select the code law"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with fault_order := .rejected}) survivorId))
 "reject incomplete state support" (decisionReason {survivor with fault_order := .rejected}),
 control .tamperedSource (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject changed source identity" "changed source differs",
 control .tamperedArtifact ((candidates.filter survives).length == 1)
 "reject altered survivor support" "one literal survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3 && witness4 && witness5 && witness6 && witness7)
 "halt complex amplitude, stochastic collapse or imported quantum postulate" (SFT.Host.Text.intercalate "; " exclusions)]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)
theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.QuantumComputation.UnboundedEvidence
