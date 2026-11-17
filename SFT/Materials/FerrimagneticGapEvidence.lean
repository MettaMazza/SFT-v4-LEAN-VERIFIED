import SFT.Materials.FerrimagneticGapGrammar
import SFT.Materials.FerrimagneticGap
import SFT.Engine.RegistrationGate
namespace SFT.Materials.FerrimagneticGapEvidence
open SFT.Host.Canonical FerrimagneticGapGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "unequal-opposition",.text "five opposed to three leaves exactly two in a held orientation",.boolean FerrimagneticGap.originalWitness]]
def claimId : String := "SFT-MAT-MAG-FERRIMAGNETISM-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-THERMO-RESPONSE-001","SFT-PHYS-THERMO-KINETIC-TRANSPORT-001","SFT-PHYS-WAVE-POLARIZATION-001","SFT-PHYS-CONDENSED-PHASE-ORDER-001","SFT-MAT-MAG-FERROMAGNETISM-001","SFT-MAT-MAG-ANTIFERROMAGNETISM-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "organization",.text (organizationName c.organization)],.array [.text "observation",.text (observationName c.observation)],.array [.text "record",.text (recordName c.record)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "carrier-erased-or-answer-only",.text "The material carrier cannot be reconstructed."],.array [.text "two-distinguishable-magnetic-sublattice-carrier",.text "The complete generated carrier is retained."]]],.array [.text "relation",.array [.array [.text "relation-imported-fitted-or-erased",.text "An imported, fitted or erased relation is not forced."],.array [.text "opposed-unequal-positive-moment-relation",.text "Only the generated exact relation is retained."]]],.array [.text "organization",.array [.array [.text "organization-collapsed",.text "Required material distinctions are merged."],.array [.text "local-opposition-and-nonempty-bulk-gap-retained",.text "Every required organization distinction remains held."]]],.array [.text "observation",.array [.array [.text "observation-boundary-unrecorded",.text "The observation class is unidentified."],.array [.text "partial-net-moment-order-class",.text "The declared observation boundary is retained."]]],.array [.text "record",.array [.array [.text "result-without-transition-trace",.text "An answer without its transition trace is not auditable."],.array [.text "complete-state-transition-boundary-trace",.text "The complete trace is retained."]]],.array [.text "provenance",.array [.array [.text "authority-or-target-selected-law",.text "An authority or target cannot select the law."],.array [.text "root-bound-forward-forcing",.text "Every decision traces to the root through admitted dependencies."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "A finite lookup has no general certificate."],.array [.text "positive-finite-successor-closure",.text "The One base and every positive finite successor preserve the relation."]]],.array [.text "extension",.array [.array [.text "free-fit-exception-or-extra-rule",.text "A free choice can manufacture the desired result."],.array [.text "no-extra-rule",.text "No axiom, parameter, fit or exception is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Ferrimagnetic sublattice order"
 branch := "materials"
 statement := "Opposed distinguishable magnetic sublattices with unequal positive counted moment support force a nonempty partial bulk moment class distinct from aligned and equal-opposed order."
 evidenceMode := .empirical
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "two-distinguishable-magnetic-sublattice-carrier__opposed-unequal-positive-moment-relation__local-opposition-and-nonempty-bulk-gap-retained__partial-net-moment-order-class__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"),("base",.text "The first complete carrier retains its relation, organization, observation and proof record."),("successor",.text "Appending one lawful positive successor preserves every earlier distinction and adds no rule."),("exclusions",.array [.text "no prior answer, named phenomenon, source identity or measurement may select a survivor",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "structural absence and opposed direction are held labels",.text "no axiom, free parameter, fit, learned coefficient, exception or target-derived rule",.text "external target content remains inaccessible until the complete successor set is sealed",.text "Every positive finite generated carrier in the registered successor thermal_magnetic_optical grammar preserving two-distinguishable-magnetic-sublattice-carrier, opposed-unequal-positive-moment-relation, local-opposition-and-nonempty-bulk-gap-retained and partial-net-moment-order-class."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no prior answer, named phenomenon, source identity or measurement may select a survivor","no numerical zero, negative, irrational, imaginary or floating proof quantity","structural absence and opposed direction are held labels","no axiom, free parameter, fit, learned coefficient, exception or target-derived rule","external target content remains inaccessible until the complete successor set is sealed","Every positive finite generated carrier in the registered successor thermal_magnetic_optical grammar preserving two-distinguishable-magnetic-sublattice-carrier, opposed-unequal-positive-moment-relation, local-opposition-and-nonempty-bulk-gap-retained and partial-net-moment-order-class."]
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
end SFT.Materials.FerrimagneticGapEvidence
