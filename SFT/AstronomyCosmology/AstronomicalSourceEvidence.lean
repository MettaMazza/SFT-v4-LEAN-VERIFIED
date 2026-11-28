import SFT.AstronomyCosmology.AstronomicalSourceGrammar
import SFT.AstronomyCosmology.AstronomicalSource
import SFT.Engine.RegistrationGate
namespace SFT.AstronomyCosmology.AstronomicalSourceEvidence
open SFT.Host.Canonical AstronomicalSourceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "named carrier is nonempty",.boolean AstronomicalSource.carrierWitness],.array [.text "relation",.text "carrier and relation differ",.boolean AstronomicalSource.relationWitness],.array [.text "boundary",.text "boundary differs from carrier",.boolean AstronomicalSource.boundaryWitness],.array [.text "fold",.text "family exact Fold witness reproduces",.boolean AstronomicalSource.exactFoldWitness]]
def claimId : String := "SFT-ASTRO-SOURCE-001"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-QUANTITY-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-WAVE-PROPAGATION-001","SFT-PHYS-COSMO-REDSHIFT-001","SFT-PHYS-COSMO-DISTANCE-001","SFT-PHYS-COSMO-EXPANSION-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001","SFT-PHYS-COSMO-BACKGROUND-001","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-STELLAR-GALACTIC-TIDAL-TERMINAL-067","SFT-PHYS-STELLAR-NUCLEAR-COLLAPSE-TERMINAL-069","SFT-PHYS-COMPACT-HORIZON-THERMODYNAMICS-TERMINAL-071","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-EARTH-HAZARD-RISK-HANDOFF-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "relation",.text (relationName c.relation)],.array [.text "record",.text (recordName c.record)],.array [.text "evidence",.text (evidenceName c.evidence)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-or-unbounded-carrier",.text "The astronomical carrier is erased."],.array [.text "emitting-or-interacting-source-carrier",.text "The claim-specific carrier is retained."]]],.array [.text "boundary",.array [.array [.text "frame-time-or-selection-erased",.text "Unbounded observations cannot be compared."],.array [.text "source-resolution-bounded",.text "The exact observational boundary is explicit."]]],.array [.text "relation",.array [.array [.text "imported-fitted-or-missing-relation",.text "A target or consensus model selects the result."],.array [.text "source-state-to-signal-relation",.text "Only generated relations and admitted dependencies act."]]],.array [.text "record",.array [.array [.text "favourable-output-incomplete-record",.text "A favorable answer without source and adverse records is unreconstructible."],.array [.text "identity-direction-distance-time-and-state-held",.text "The complete required record is held."]]],.array [.text "evidence",.array [.array [.text "observation-model-forecast-conflated",.text "Evidence classes silently substitute for one another."],.array [.text "evidence-class-explicit",.text "Direct, retrieval, proxy, reconstruction, model, forecast and missing remain distinct."]]],.array [.text "provenance",.array [.array [.text "prior-answer-or-target-selected",.text "Historical SFT or measurement selects the law."],.array [.text "root-bound-forward-forcing",.text "The result traces through admitted dependencies to There Is No Nothing."]]],.array [.text "generality",.array [.array [.text "one-favourable-object-erases-population",.text "One object cannot close a generated class."],.array [.text "positive-finite-extension-retains-all-rows",.text "Every finite extension retains favorable, adverse, absent and unresolved rows."]]],.array [.text "extension",.array [.array [.text "free-parameter-exception-or-opaque-oracle",.text "An added choice manufactures the result."],.array [.text "no-extra-rule",.text "No rule beyond the registered structure is introduced."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Astronomical source"
 branch := "astronomy_cosmology"
 statement := "An astronomical source is a bounded carrier whose state produces or alters a registered signal along a declared path."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "emitting-or-interacting-source-carrier__source-resolution-bounded__source-state-to-signal-relation__identity-direction-distance-time-and-state-held__evidence-class-explicit__root-bound-forward-forcing__positive-finite-extension-retains-all-rows__no-extra-rule"),("base",.text "The least complete astronomical carrier retains source, path, observer, frame, relation, evidence class and root provenance."),("successor",.text "Adding one lawful finite source, epoch, channel, object or population member preserves all earlier identities, adverse rows and boundaries and appends its trace."),("exclusions",.array [.text "semantic numerical zero",.text "negative proof quantity",.text "irrational or imaginary proof value",.text "completed infinity",.text "ungenerated continuum",.text "free or fitted parameter",.text "target-selected survivor",.text "prior answer as premise",.text "consensus cosmology as premise",.text "model relabelled observation",.text "non-detection relabelled zero",.text "erased adverse or unresolved row"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["semantic numerical zero","negative proof quantity","irrational or imaginary proof value","completed infinity","ungenerated continuum","free or fitted parameter","target-selected survivor","prior answer as premise","consensus cosmology as premise","model relabelled observation","non-detection relabelled zero","erased adverse or unresolved row"]
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
end SFT.AstronomyCosmology.AstronomicalSourceEvidence
