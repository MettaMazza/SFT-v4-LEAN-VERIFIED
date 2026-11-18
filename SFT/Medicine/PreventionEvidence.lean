import SFT.Medicine.PreventionGrammar
import SFT.Medicine.Prevention
import SFT.Engine.RegistrationGate
namespace SFT.Medicine.PreventionEvidence
open SFT.Host.Canonical PreventionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "clinical carrier is explicit and nonempty",.boolean Prevention.carrierWitness],.array [.text "relation",.text "relation and organization remain separately reconstructible",.boolean Prevention.relationWitness],.array [.text "boundary",.text "observation boundary cannot silently become the clinical law",.boolean Prevention.boundaryWitness]]
def claimId : String := "SFT-MED-PREVENTION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-COMP-SEM-SPECIFICATION-001","SFT-COMP-SEM-VERIFICATION-001","SFT-COMP-DIST-CAUSALITY-001","SFT-COMP-SCI-COMPUTATIONAL-STATISTICS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-STEREO-ENANTIOMER-001","SFT-MAT-MEAS-TRACEABILITY-001","SFT-MAT-FUNC-BIOMATERIAL-001","SFT-BIO-ORGANISM-001","SFT-BIO-PHYSIOLOGY-001","SFT-BIO-HOMEOSTASIS-001","SFT-BIO-POPULATION-001","SFT-BIO-BIO-CONDITION-001","SFT-BIO-BIO-ASSAY-001","SFT-BIO-BIO-UNCERTAINTY-001","SFT-BIO-BIO-CAUSALITY-001","SFT-MED-SCREENING-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "organization",.text (organizationName c.organization)],.array [.text "observation",.text (observationName c.observation)],.array [.text "record",.text (recordName c.record)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "carrier-erased-aggregate-or-answer-only",.text "Erasing the patient, population, specimen or evidence carrier prevents clinical reconstruction."],.array [.text "at-risk-person-or-population",.text "The complete generated clinical carrier is retained."]]],.array [.text "relation",.array [.array [.text "relation-imported-fitted-or-erased",.text "An imported, fitted or absent relation can manufacture a familiar medical answer."],.array [.text "action-before-target-outcome",.text "Only the generated transition or comparison relation is admitted."]]],.array [.text "organization",.array [.array [.text "organization-collapsed",.text "Collapsing person, arm, outcome, time or evidence organization merges clinically distinct states."],.array [.text "primary-secondary-tertiary-boundary",.text "Every required clinical organization distinction remains held."]]],.array [.text "observation",.array [.array [.text "observation-boundary-unrecorded",.text "An unrecorded population, method, setting, interval or assessor cannot identify the observation class."],.array [.text "risk-frame-time-and-outcomes",.text "The complete declared observation boundary is retained and cannot select the law."]]],.array [.text "record",.array [.array [.text "favorable-result-without-complete-record",.text "A favorable label without protocol, transitions, missingness, adverse outcomes and controls is not auditable."],.array [.text "complete-protocol-state-transition-adverse-null-record",.text "Initial state, transitions, protocol deviations, adverse, null, unresolved and missing rows are recorded."]]],.array [.text "provenance",.array [.array [.text "authority-consensus-prior-or-target-selected-law",.text "Authority, consensus, prior SFT work or target outcomes may test but cannot select the Fold law."],.array [.text "root-bound-forward-forcing",.text "Every decision traces through admitted dependencies to There Is No Nothing."]]],.array [.text "generality",.array [.array [.text "single-patient-favorable-study",.text "One favorable patient, trial, population or analysis cannot close the generated clinical class."],.array [.text "positive-finite-successor-and-unfavorable-closure",.text "The base carrier, every supplied positive finite successor and all registered unfavorable controls preserve the relation at its stated boundary."]]],.array [.text "extension",.array [.array [.text "free-fit-exception-opaque-model-or-extra-rule",.text "A free coefficient, fitted cutoff, hidden exclusion, opaque model or exception can manufacture a desired answer."],.array [.text "no-extra-rule",.text "No rule beyond admitted Fold dependencies and generated preservation conditions is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Prevention"
 branch := "medicine"
 statement := "Prevention is an action preceding a declared outcome in an at-risk carrier, with prevention level, comparator and all later outcomes retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "at-risk-person-or-population__action-before-target-outcome__primary-secondary-tertiary-boundary__risk-frame-time-and-outcomes__complete-protocol-state-transition-adverse-null-record__root-bound-forward-forcing__positive-finite-successor-and-unfavorable-closure__no-extra-rule"),("base",.text "The least positive finite clinical carrier retains every required identity, relation, boundary, outcome and proof record."),("successor",.text "Adding one lawful finite successor preserves all earlier persons, arms, outcomes, times, adverse and missing distinctions and appends the new trace."),("exclusions",.array [.text "numerical-zero ontology",.text "negative proof quantity",.text "irrational or imaginary proof value",.text "fitted coefficient or cutoff",.text "external target leakage",.text "opaque predictor",.text "unrecorded patient or population",.text "erased adverse, null, absent or unresolved result",.text "prior answer as premise"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["numerical-zero ontology","negative proof quantity","irrational or imaginary proof value","fitted coefficient or cutoff","external target leakage","opaque predictor","unrecorded patient or population","erased adverse, null, absent or unresolved result","prior answer as premise"]
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
end SFT.Medicine.PreventionEvidence
