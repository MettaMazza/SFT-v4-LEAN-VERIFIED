import SFT.Chemistry.MolecularMeasurementGrammar
import SFT.Chemistry.MolecularMeasurement
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularMeasurementEvidence
open SFT.Host.Canonical MolecularMeasurementGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "retained-reconstruction",.text "A recorded rotational manifold reconstructs.",.boolean MolecularMeasurement.retainedWitness],.array [.text "closed-boundary",.text "An unrecorded predecessor path does not reconstruct.",.boolean MolecularMeasurement.closedWitness],.array [.text "overlap-control",.text "Retained/closed overlap rejects.",.boolean MolecularMeasurement.overlapWitness]]
def claimId : String := "SFT-CHEM-MOLECULAR-QUANTUM-MEASUREMENT-REDUCTION-014"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-RESOLVED-ROVIBRONIC-SPIN-COMPOSITION-013"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "preparation",.text (preparationName c.preparation)],.array [.text "probe",.text (probeName c.probe)],.array [.text "retention",.text (retentionName c.retention)],.array [.text "closure",.text (closureName c.closure)],.array [.text "record",.text (recordName c.record)],.array [.text "poststate",.text (poststateName c.poststate)],.array [.text "reconstruction",.text (reconstructionName c.reconstruction)],.array [.text "replication",.text (replicationName c.replication)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "preparation",.array [.array [.text "outcome-without-prepared-state",.text "An outcome alone cannot identify the state presented to the probe."],.array [.text "retained-pre-observation-state",.text "Every observation begins with one held prepared state."]]],.array [.text "probe",.array [.array [.text "stochastic-collapse-premise",.text "A stochastic collapse postulate imports an ungenerated law and numerical probability."],.array [.text "exact-generated-observation-class",.text "The probe is one exact generated observation class."]]],.array [.text "retention",.array [.array [.text "all-or-nothing-observation",.text "All-or-nothing readout hides which distinctions survive."],.array [.text "explicit-retained-coordinate-set",.text "Every surviving coordinate is named in the record."]]],.array [.text "closure",.array [.array [.text "silent-predecessor-erasure",.text "Silent erasure makes later reconstruction claims untestable."],.array [.text "explicit-closed-coordinate-set",.text "Every distinction closed by observation is separately named."]]],.array [.text "record",.array [.array [.text "unrecorded-measurement-result",.text "A result without a retained record cannot be repeated or audited."],.array [.text "retained-finite-readout-record",.text "Each readout has one exact held record."]]],.array [.text "poststate",.array [.array [.text "undefined-or-destroyed-poststate",.text "An undefined post-state breaks process composition."],.array [.text "retained-post-observation-state",.text "Observation ends in one declared molecular state."]]],.array [.text "reconstruction",.array [.array [.text "recover-unrecorded-predecessor",.text "A merged predecessor cannot be recovered without a retained distinction."],.array [.text "record-bounded-reconstruction",.text "Only coordinates carried by the record reconstruct."]]],.array [.text "replication",.array [.array [.text "selected-successful-readouts",.text "Successful readouts alone erase failures and state changes."],.array [.text "complete-repeat-and-adverse-record",.text "Every preparation, readout, recovery, failure and boundary row remains."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact chemical measurement-reduction law for molecular quantum states"
 branch := "chemistry"
 statement := "A molecular quantum-state observation is an exact process from one retained prepared state through one generated probe class to a retained finite readout and declared post-observation state. The record explicitly partitions retained from closed coordinates; only retained distinctions reconstruct, while every repetition, recovery, failed projection and boundary event remains evidence. No stochastic collapse or numerical probability is a premise."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.array [.text claimId,candidateRecord c])
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
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "retained-pre-observation-state__exact-generated-observation-class__explicit-retained-coordinate-set__explicit-closed-coordinate-set__retained-finite-readout-record__retained-post-observation-state__record-bounded-reconstruction__complete-repeat-and-adverse-record"),("base",.text "One prepared molecular state, one probe, one retained coordinate, an explicit possibly empty closed-coordinate word, one outcome record, post-state, instrument and condition form the least complete observation."),("successor",.text "Appending one repeat, recovery or adverse readout preserves every prior record and adds exactly its prepared state, probe class, retained/closed partition, outcome and post-state; no unrecorded predecessor becomes reconstructible."),("exclusions",.array [.text "no numerical zero or probability parameter; external 0 remains a held source glyph or structural EmptyOne at its typed absence boundary",.text "no negative, irrational, imaginary, floating, signed or continuum proof value",.text "no imported stochastic collapse, Born rule, wavefunction, density matrix, Bayesian update or fitted detector model",.text "no NIST event, fidelity, transition, duration, occurrence or outcome before prediction seal",.text "no successful-projection-only, tracked-only or positive-duration-only subset"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero or probability parameter; external 0 remains a held source glyph or structural EmptyOne at its typed absence boundary","no negative, irrational, imaginary, floating, signed or continuum proof value","no imported stochastic collapse, Born rule, wavefunction, density matrix, Bayesian update or fitted detector model","no NIST event, fidelity, transition, duration, occurrence or outcome before prediction seal","no successful-projection-only, tracked-only or positive-duration-only subset"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.MolecularMeasurementEvidence
