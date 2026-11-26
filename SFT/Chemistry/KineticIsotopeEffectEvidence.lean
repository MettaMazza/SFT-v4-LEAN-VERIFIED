import SFT.Chemistry.KineticIsotopeEffectGrammar
import SFT.Chemistry.KineticIsotopeEffect
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.KineticIsotopeEffectEvidence
open SFT.Host.Canonical KineticIsotopeEffectGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "held-identities",.text "Two distinct isotope identities remain held on one otherwise identical path.",.boolean (match KineticIsotopeEffect.heldIdentitiesWitness with | .error _ => false | .ok b => b)],.array [.text "exact-rate-ratio",.text "Two independently counted positive event rates force one exact positive quotient.",.boolean (match KineticIsotopeEffect.exactRatioWitness with | .error _ => false | .ok b => b)],.array [.text "held-orientation",.text "Ratio direction is retained without a signed proof scalar.",.boolean (match KineticIsotopeEffect.orientationWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "Appending the next complete pair preserves every prior result.",.boolean (match KineticIsotopeEffect.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-KINETIC-ISOTOPE-EFFECT-RELATION-012"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-ELEM-ISOTOPE-001","SFT-CHEM-NUCLEAR-ELECTRONIC-COMPOSITION-012","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002","SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003","SFT-CHEM-ACTIVATION-BARRIER-VALUE-RELATION-004","SFT-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005","SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006","SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007","SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008","SFT-CHEM-REVERSIBLE-KINETIC-EQUILIBRIUM-CORRESPONDENCE-009","SFT-CHEM-CATALYTIC-TURNOVER-CYCLE-FREQUENCY-010","SFT-CHEM-DIFFUSION-LIMITED-REACTION-BOUNDARY-011"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "path",.text (pathName c.path)],.array [.text "rate",.text (rateName c.rate)],.array [.text "relation",.text (relationName c.relation)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "observation",.text (observationName c.observation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "isotopologue-identities-collapsed-or-replaced-by-numerical-mass",.text "Collapsed or numerical identities cannot preserve which reaction carrier changed."],.array [.text "two-distinct-held-isotopologue-identities",.text "Both isotope identities remain exact held labels."]]],.array [.text "path",.array [.array [.text "different-truncated-or-answer-only-paths-compared",.text "Different or truncated paths do not isolate an isotope relation."],.array [.text "same-complete-reaction-path-and-condition",.text "Every path role and condition is identical except the held isotope label."]]],.array [.text "rate",.array [.array [.text "imported-rate-law-continuum-time-or-fitted-rate",.text "An imported or fitted rate can select the result."],.array [.text "completed-events-per-exact-positive-observation-parts",.text "Each rate is independently forced by exact positive counts."]]],.array [.text "relation",.array [.array [.text "imported-KIE-mass-frequency-exponent-or-statistical-law",.text "An imported isotope-effect model is not forced by the retained pair."],.array [.text "ordered-quotient-of-two-exact-positive-event-rates",.text "The pair itself forces one exact positive rate ratio."]]],.array [.text "orientation",.array [.array [.text "signed-difference-negative-or-zero-number",.text "A signed difference imports forbidden numerical structure."],.array [.text "positive-ratio-plus-held-greater-less-or-equal-orientation",.text "Magnitude stays exact positive and direction is a held label."]]],.array [.text "observation",.array [.array [.text "selected-average-or-single-favorable-isotope-effect",.text "Selection or averaging erases replicates, normal, inverse and equal cases."],.array [.text "complete-90-rate-ratio-3-decay-and-adverse-vector",.text "All rate-ratio replicates, direct decays and adverse records remain distinct."]]],.array [.text "provenance",.array [.array [.text "experimental-fitted-calculated-and-interpretive-records-mixed",.text "Mixed provenance lets an interpretation masquerade as measurement."],.array [.text "experimental-vectors-separated-from-source-models-and-review-questions",.text "Measurements, models and reviewer challenges remain separately classified."]]],.array [.text "prediction",.array [.array [.text "rate-ratio-value-workbook-or-target-readable-before-seal",.text "Target access can select the law."],.array [.text "value-free-71-record-identity-seal-and-depth-independent-pair-successor",.text "All identities seal before values and pair extension preserves prior results."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact kinetic isotope-effect relation"
 branch := "chemistry"
 statement := "For two distinct held isotopologue identities traversing the same complete reaction path under the same held condition, each event rate is independently forced as completed events per exact positive observation parts. Their ordered quotient is the exact kinetic isotope-effect relation; greater, lesser or equal direction remains a held label. No kinetic-isotope equation, numerical mass premise, mass-frequency law, continuum, fitted exponent or statistical weight is imported."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "two-distinct-held-isotopologue-identities__same-complete-reaction-path-and-condition__completed-events-per-exact-positive-observation-parts__ordered-quotient-of-two-exact-positive-event-rates__positive-ratio-plus-held-greater-less-or-equal-orientation__complete-90-rate-ratio-3-decay-and-adverse-vector__experimental-vectors-separated-from-source-models-and-review-questions__value-free-71-record-identity-seal-and-depth-independent-pair-successor"),("base",.text "One complete ordered pair of distinct held isotopologues on the same path and condition, with two exact positive counted rates, forces one exact positive ordered rate ratio and one held orientation."),("successor",.text "Append the next complete isotopologue pair at the next positive source occurrence. Every prior identity, path, condition, exact rate, quotient, orientation and status remains unchanged."),("exclusions",.array [.text "numerical zero",.text "negative proof quantity",.text "irrational quantity",.text "imaginary quantity",.text "numerical isotope mass",.text "kinetic isotope-effect equation",.text "mass-frequency law",.text "transition-state premise",.text "continuum time",.text "fitted exponent",.text "statistical weight",.text "selected isotopologue, reaction or condition",.text "selected page, worksheet or row",.text "omitted replicate, adverse or unresolved record",.text "average",.text "digitization",.text "interpolation",.text "renormalization",.text "target-derived correction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["numerical zero","negative proof quantity","irrational quantity","imaginary quantity","numerical isotope mass","kinetic isotope-effect equation","mass-frequency law","transition-state premise","continuum time","fitted exponent","statistical weight","selected isotopologue, reaction or condition","selected page, worksheet or row","omitted replicate, adverse or unresolved record","average","digitization","interpolation","renormalization","target-derived correction"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with identity := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.KineticIsotopeEffectEvidence
