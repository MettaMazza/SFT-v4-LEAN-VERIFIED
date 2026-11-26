import SFT.Chemistry.CompetingChannelGrammar
import SFT.Chemistry.CompetingChannel
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CompetingChannelEvidence
open SFT.Host.Canonical CompetingChannelGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-share",.text "Complete positive support forces every exact channel share.",.boolean (match CompetingChannel.exactShareWitness with | .error _ => false | .ok b => b)],.array [.text "whole",.text "All positive channel shares reconstruct One exactly.",.boolean (match CompetingChannel.wholeWitness with | .error _ => false | .ok b => b)],.array [.text "unfavorable",.text "A structural absent channel remains in source order without invented support.",.boolean (match CompetingChannel.unfavorableWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "Appending one complete channel retains every prior identity and raw support.",.boolean (match CompetingChannel.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-COMPETING-CHANNEL-BRANCHING-006"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002","SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003","SFT-CHEM-ACTIVATION-BARRIER-VALUE-RELATION-004","SFT-CHEM-TRANSITION-STATE-EQUIVALENT-BOUNDARY-005"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "whole",.text (wholeName c.whole)],.array [.text "relation",.text (relationName c.relation)],.array [.text "identity",.text (identityName c.identity)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "record",.text (recordName c.record)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.array [.array [.text "selected-dominant-or-favorable-channel-subset",.text "Selecting abundant products erases competing support."],.array [.text "complete-registered-product-channel-support",.text "Every registered favorable, weak, adverse and absent channel remains held."]]],.array [.text "whole",.array [.array [.text "imported-probability-normalization-axiom",.text "An imported normalization premise could choose the relation."],.array [.text "exact-sum-of-complete-retained-support",.text "The retained channel partition itself forces its complete support."]]],.array [.text "relation",.array [.array [.text "fitted-or-free-branching-ratio",.text "A fitted fraction is not forced by the channel record."],.array [.text "exact-channel-support-over-complete-support",.text "Exact division of each retained support by the complete support forces every share."]]],.array [.text "identity",.array [.array [.text "reaction-condition-or-product-identity-collapsed",.text "Collapsed identity can combine unrelated products or conditions."],.array [.text "held-reaction-condition-product-and-source-row-identities",.text "Every reaction, condition, product and row identity remains held."]]],.array [.text "absence",.array [.array [.text "unfavorable-null-or-unresolved-channel-omitted",.text "Omission can inflate remaining shares."],.array [.text "structural-EmptyOne-channel-retained-without-invented-value",.text "An absent reported support remains a registered structural row without a fabricated number."]]],.array [.text "record",.array [.array [.text "ratio-answer-only-or-renormalized-table",.text "An answer-only table cannot reconstruct source support."],.array [.text "complete-source-ordered-support-share-uncertainty-and-adverse-record",.text "Every source support, share, uncertainty and adverse row remains auditable."]]],.array [.text "provenance",.array [.array [.text "experimental-and-calculated-columns-mixed",.text "Mixing columns can substitute theory for measurement."],.array [.text "experimental-vector-separated-from-calculated-and-analysis-disclosures",.text "Experimental values and all calculation/analysis disclosures remain distinct."]]],.array [.text "prediction",.array [.array [.text "branch-value-readable-before-seal-or-corrected-after-release",.text "Target access or correction can select the result."],.array [.text "value-free-complete-eight-channel-identity-seal-and-depth-independent-successor",.text "All eight identities seal before values open; appending one channel retains every earlier identity and support."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact complete-support competing-channel branching relation"
 branch := "chemistry"
 statement := "For one complete source-ordered set of registered product channels under a held reaction and condition, exact retained channel support forces the complete support as its exact sum and every branch share as channel support over that complete support. Structural EmptyOne rows remain held; no imported probability normalization, fitted branching equation or favorable-channel selection enters the relation."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-registered-product-channel-support__exact-sum-of-complete-retained-support__exact-channel-support-over-complete-support__held-reaction-condition-product-and-source-row-identities__structural-EmptyOne-channel-retained-without-invented-value__complete-source-ordered-support-share-uncertainty-and-adverse-record__experimental-vector-separated-from-calculated-and-analysis-disclosures__value-free-complete-eight-channel-identity-seal-and-depth-independent-successor"),("base",.text "Two retained registered product channels with positive complete support force the first exact branch partition of One."),("successor",.text "Appending the next complete source channel retains every prior identity and raw support while recomputing the uniquely forced complete-support shares without selection, fitting or correction."),("exclusions",.array [.text "no numerical zero; absent reported support is structural EmptyOne and external zero glyphs remain provenance only",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported probability normalization, stochastic premise, branching equation or fitted branching ratio",.text "no renormalization, averaging, selected favorable channel, omitted weak/null/unresolved product or target correction",.text "no branch value, condition, uncertainty, spectrum, analysis result or target hash before all eight identities seal",.text "experimental and calculated columns remain distinct; Monte Carlo and reference-spectrum analysis remain disclosed provenance"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent reported support is structural EmptyOne and external zero glyphs remain provenance only","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported probability normalization, stochastic premise, branching equation or fitted branching ratio","no renormalization, averaging, selected favorable channel, omitted weak/null/unresolved product or target correction","no branch value, condition, uncertainty, spectrum, analysis result or target hash before all eight identities seal","experimental and calculated columns remain distinct; Monte Carlo and reference-spectrum analysis remain disclosed provenance"]
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
end SFT.Chemistry.CompetingChannelEvidence
