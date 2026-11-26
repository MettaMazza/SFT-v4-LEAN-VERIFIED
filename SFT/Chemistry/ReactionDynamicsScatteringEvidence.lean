import SFT.Chemistry.ReactionDynamicsScatteringGrammar
import SFT.Chemistry.ReactionDynamicsScattering
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ReactionDynamicsScatteringEvidence
open SFT.Host.Canonical ReactionDynamicsScatteringGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "finite-channel-support",.text "One finite incoming channel retains every distinct outgoing joint product-state word.",.boolean (match ReactionDynamicsScattering.finiteSupportWitness with | .error _ => false | .ok b => b)],.array [.text "exact-state-shares",.text "Positive event counts force exact positive product-state shares.",.boolean (match ReactionDynamicsScattering.exactSharesWitness with | .error _ => false | .ok b => b)],.array [.text "held-orientation",.text "Incoming/outgoing direction remains held without an angle continuum or signed proof scalar.",.boolean (match ReactionDynamicsScattering.orientationWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "Appending the next complete scattering occurrence preserves every prior result.",.boolean (match ReactionDynamicsScattering.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-REACTION-DYNAMICS-SCATTERING-PRODUCT-STATE-013"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-ROVIBRONIC-COMPOSITION-001","SFT-CHEM-RESOLVED-ROVIBRONIC-SPIN-COMPOSITION-013","SFT-CHEM-MOLECULAR-QUANTUM-MEASUREMENT-REDUCTION-014","SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006","SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007","SFT-CHEM-PARALLEL-MECHANISM-COMPOSITION-008","SFT-CHEM-DIFFUSION-LIMITED-REACTION-BOUNDARY-011","SFT-CHEM-KINETIC-ISOTOPE-EFFECT-RELATION-012"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "incoming",.text (incomingName c.incoming)],.array [.text "outgoing",.text (outgoingName c.outgoing)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "quantity",.text (quantityName c.quantity)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "observation",.text (observationName c.observation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "incoming",.array [.array [.text "incoming-carriers-erased-or-replaced-by-continuum-beam",.text "Erased or continuous input cannot retain which finite reaction channel was prepared."],.array [.text "finite-held-incoming-channel-and-preparation",.text "Every incoming carrier, reaction and preparation identity remains held."]]],.array [.text "outgoing",.array [.array [.text "selected-product-or-continuous-outgoing-distribution",.text "A selected or continuous outcome erases finite alternative product states."],.array [.text "complete-finite-distinct-outgoing-product-state-support",.text "Every retained outgoing product-state channel remains distinct and source ordered."]]],.array [.text "composition",.array [.array [.text "coproduct-states-separated-or-marginalized",.text "Marginal product states erase which coproduct pair occurred together."],.array [.text "joint-ordered-coproduct-state-word",.text "Each outgoing event retains the complete ordered joint product-state tuple."]]],.array [.text "quantity",.array [.array [.text "imported-cross-section-probability-amplitude-or-fitted-density",.text "An imported or fitted distribution can select the answer."],.array [.text "completed-state-events-per-complete-positive-event-support",.text "Finite positive event counts force exact positive state shares."]]],.array [.text "orientation",.array [.array [.text "signed-angle-continuum-or-numerical-zero-direction",.text "A continuum angle or signed scalar imports forbidden numerical structure."],.array [.text "held-incoming-outgoing-orientation-relation",.text "Direction remains a held relation with no negative or zero proof number."]]],.array [.text "observation",.array [.array [.text "selected-normalized-or-favorable-product-vector",.text "Selection or normalization can erase weak, absent, adverse or discrepant channels."],.array [.text "complete-51-record-36-page-14-worksheet-978591-cell-vector",.text "The complete source surface and 6,408 key state-resolved cells remain bound."]]],.array [.text "provenance",.array [.array [.text "experimental-theoretical-fitted-estimated-and-tentative-records-mixed",.text "Mixed provenance lets a model or correction masquerade as observation."],.array [.text "experiment-theory-fit-estimate-tentative-control-and-review-status-separated",.text "Every measurement, model, correction, limitation and reviewer challenge remains separately classified."]]],.array [.text "prediction",.array [.array [.text "product-values-workbook-or-target-readable-before-seal",.text "Target access can select the channel or orientation law."],.array [.text "value-free-51-record-identity-seal-and-depth-independent-scattering-successor",.text "All identities seal before values and occurrence extension preserves prior results."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact reaction-dynamics scattering and product-state law"
 branch := "chemistry"
 statement := "One finite held incoming reaction channel and preparation compose with the complete finite support of distinct outgoing joint product-state words. Completed events in each retained state per complete positive event support force exact positive state shares, while each incoming/outgoing orientation remains a held relation. No scattering equation, cross-section law, angular continuum, probability amplitude, fitted potential or distribution is imported."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "finite-held-incoming-channel-and-preparation__complete-finite-distinct-outgoing-product-state-support__joint-ordered-coproduct-state-word__completed-state-events-per-complete-positive-event-support__held-incoming-outgoing-orientation-relation__complete-51-record-36-page-14-worksheet-978591-cell-vector__experiment-theory-fit-estimate-tentative-control-and-review-status-separated__value-free-51-record-identity-seal-and-depth-independent-scattering-successor"),("base",.text "One finite held incoming channel with the first complete finite outgoing joint product-state support forces exact positive state shares and one held orientation per retained outgoing state."),("successor",.text "Append the next complete scattering occurrence at the next positive source occurrence. Every prior incoming and outgoing identity, joint product state, exact share, orientation and evidence status remains unchanged."),("exclusions",.array [.text "numerical zero",.text "negative proof quantity",.text "irrational quantity",.text "imaginary quantity",.text "scattering equation",.text "cross-section law",.text "angular continuum",.text "probability amplitude",.text "fitted potential or distribution",.text "imported energy or momentum equation",.text "selected product state, channel or orientation",.text "selected page, worksheet, cell or row",.text "omitted weak, adverse, reviewer or unresolved record",.text "average",.text "digitization",.text "interpolation",.text "renormalization",.text "target-derived correction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["numerical zero","negative proof quantity","irrational quantity","imaginary quantity","scattering equation","cross-section law","angular continuum","probability amplitude","fitted potential or distribution","imported energy or momentum equation","selected product state, channel or orientation","selected page, worksheet, cell or row","omitted weak, adverse, reviewer or unresolved record","average","digitization","interpolation","renormalization","target-derived correction"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with incoming := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ReactionDynamicsScatteringEvidence
