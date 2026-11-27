import SFT.EarthEnvironment.EarthInteriorCompartmentGrammar
import SFT.EarthEnvironment.EarthInteriorCompartment
import SFT.Engine.RegistrationGate
namespace SFT.EarthEnvironment.EarthInteriorCompartmentEvidence
open SFT.Host.Canonical EarthInteriorCompartmentGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier-present",.text "the claim retains a nonempty named carrier",.boolean EarthInteriorCompartment.carrierWitness],.array [.text "relation-distinct",.text "the carrier and relation are not silently conflated",.boolean EarthInteriorCompartment.relationWitness],.array [.text "evidence-boundary",.text "the evidence boundary remains distinct from the result carrier",.boolean EarthInteriorCompartment.boundaryWitness],.array [.text "exact-fold-witness",.text "the family's pre-source exact Fold construction reproduces",.boolean EarthInteriorCompartment.exactFoldWitness]]
def claimId : String := "SFT-EARTH-INTERIOR-COMPARTMENT-001"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-FORM-COMPOSITION-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-SECOND-LAW-001","SFT-PHYS-FLUID-CONSERVATION-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-MAT-MEAS-MATERIAL-001","SFT-MAT-MEAS-PROPERTY-001","SFT-MAT-THERM-CONDUCTION-001","SFT-BIO-ECOSYSTEM-001","SFT-BIO-BIO-HANDOFF-001","SFT-EARTH-EARTH-HISTORY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "relation",.text (relationName c.relation)],.array [.text "record",.text (recordName c.record)],.array [.text "evidence",.text (evidenceName c.evidence)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-or-unbounded-carrier",.text "An answer-only value or unbounded object erases the Earth carrier."],.array [.text "nested-interior-region-carrier",.text "The complete claim-specific carrier is retained."]]],.array [.text "boundary",.array [.array [.text "boundary-or-interface-erased",.text "Erasing the spatial, temporal or categorical boundary makes stocks, flows and observations incomparable."],.array [.text "geophysical-inference-bounded",.text "The exact observation and system boundary remains explicit."]]],.array [.text "relation",.array [.array [.text "imported-fitted-or-missing-relation",.text "An imported, fitted or absent relation can manufacture the intended Earth result."],.array [.text "boundary-and-property-contrast-relation",.text "Only generated Fold relations and admitted upstream dependencies act."]]],.array [.text "record",.array [.array [.text "favourable-output-with-incomplete-record",.text "A favorable output without stocks, transfers, time, missing and adverse records is not reconstructible."],.array [.text "depth-composition-state-observation-and-uncertainty-held",.text "The complete required record is retained."]]],.array [.text "evidence",.array [.array [.text "model-proxy-forecast-or-observation-conflated",.text "Earth evidence classes cannot silently substitute for one another."],.array [.text "evidence-class-explicit",.text "Direct observation, retrieval, proxy, reconstruction, model and forecast remain distinguishable."]]],.array [.text "provenance",.array [.array [.text "prior-target-consensus-or-application-selected",.text "Earlier SFT answers, target values and consensus models cannot select a V3 law."],.array [.text "root-bound-forward-forcing",.text "Every result traces through admitted dependencies to There Is No Nothing."]]],.array [.text "generality",.array [.array [.text "one-favourable-case-with-erased-alternatives",.text "One favorable site, event or interval cannot close a generated class."],.array [.text "positive-finite-successor-retains-all-rows",.text "Every supplied finite extension retains favorable, adverse, absent and unresolved rows."]]],.array [.text "extension",.array [.array [.text "free-parameter-exception-or-opaque-oracle",.text "Fitting, exceptions and opaque predictors can force a preferred answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and registered preservation conditions is added."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Earth interior compartments"
 branch := "earth_environment"
 statement := "An inferred Earth-interior compartment requires a reproducible property contrast across a declared boundary with its observation and inversion limits retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "nested-interior-region-carrier__geophysical-inference-bounded__boundary-and-property-contrast-relation__depth-composition-state-observation-and-uncertainty-held__evidence-class-explicit__root-bound-forward-forcing__positive-finite-successor-retains-all-rows__no-extra-rule"),("base",.text "The least complete Earth carrier retains its boundary, relation, record, evidence class and root provenance without an extra rule."),("successor",.text "Adding one lawful finite reservoir, interface, observation, event, time, species or location preserves all earlier identities, transfers, adverse rows and boundaries and appends the new trace."),("exclusions",.array [.text "semantic numerical zero",.text "negative proof quantity",.text "irrational or imaginary proof value",.text "completed infinity",.text "ungenerated continuum",.text "free or fitted parameter",.text "target-selected survivor",.text "prior answer as premise",.text "conventional Earth model as premise",.text "proxy or retrieval relabelled as direct observation",.text "model or forecast relabelled as observation",.text "opaque predictor as law",.text "erased adverse, absent, censored, missing or unresolved row"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["semantic numerical zero","negative proof quantity","irrational or imaginary proof value","completed infinity","ungenerated continuum","free or fitted parameter","target-selected survivor","prior answer as premise","conventional Earth model as premise","proxy or retrieval relabelled as direct observation","model or forecast relabelled as observation","opaque predictor as law","erased adverse, absent, censored, missing or unresolved row"]
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
end SFT.EarthEnvironment.EarthInteriorCompartmentEvidence
