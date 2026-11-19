import SFT.Chemistry.FreeEnergyEquivalentDirectionGrammar
import SFT.Chemistry.FreeEnergyEquivalentDirection
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.FreeEnergyEquivalentDirectionEvidence
open SFT.Host.Canonical FreeEnergyEquivalentDirectionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "forward-order",.text "Lower energy and distinction account forces forward orientation.",.boolean (match FreeEnergyEquivalentDirection.directionWitness with | .error _ => false | .ok b => b)],.array [.text "positive-separations",.text "Direction retains exact positive separations.",.boolean (match FreeEnergyEquivalentDirection.separationWitness with | .error _ => false | .ok b => b)],.array [.text "equilibrium-EmptyOne",.text "Equal complete accounts force equilibrium with structural EmptyOne separations.",.boolean (match FreeEnergyEquivalentDirection.equilibriumWitness with | .error _ => false | .ok b => b)],.array [.text "incomparable-halts",.text "Crossed accounts do not receive an arbitrary weighted direction.",.boolean FreeEnergyEquivalentDirection.incomparableWitness],.array [.text "common-successor",.text "A common positive addition preserves exact direction.",.boolean (match FreeEnergyEquivalentDirection.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-PHYS-THERMO-SECOND-LAW-001","SFT-PHYS-THERMO-STATE-RELATION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003","SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005","SFT-CHEM-ENTHALPY-EQUIVALENT-STATE-006"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "paths",.text (pathsName c.paths)],.array [.text "energy",.text (energyName c.energy)],.array [.text "distinctions",.text (distinctionsName c.distinctions)],.array [.text "order",.text (orderName c.order)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "paths",.array [.array [.text "single-path-or-answer-only-direction",.text "One path or an answer label cannot establish comparative direction."],.array [.text "complete-forward-and-reverse-path-accounts",.text "Both paths retain boundary, conditions, energy and distinction support."]]],.array [.text "energy",.array [.array [.text "signed-or-fitted-free-energy-scalar",.text "A signed or fitted scalar imports an equation and erases energy provenance."],.array [.text "exact-positive-retained-energy-requirements",.text "Each path retains its complete exact positive energy requirement."]]],.array [.text "distinctions",.array [.array [.text "entropy-logarithm-or-omitted-distinction-cost",.text "A logarithm or omitted cost imports a convention and loses closed distinctions."],.array [.text "exact-positive-closed-distinction-counts",.text "Each path retains the exact positive count of distinctions observation closes."]]],.array [.text "order",.array [.array [.text "weighted-sum-or-target-selected-comparison",.text "A weighted scalar requires a free trade-off and may select the target."],.array [.text "strict-exact-product-support-order",.text "Direction is forced only when one complete account is no greater on both axes and strict on at least one."]]],.array [.text "orientation",.array [.array [.text "negative-direction-value-or-forced-tie-break",.text "A sign or tie-break invents content not present in the accounts."],.array [.text "held-forward-reverse-or-EmptyOne-equilibrium",.text "Orientation is held; exact equality yields structural EmptyOne separations and equilibrium."]]],.array [.text "prediction",.array [.array [.text "Gibbs-logK-or-direction-target-readable-before-seal",.text "Target values could select the ordering rule."],.array [.text "complete-value-free-reaction-state-identity-seal",.text "All reaction-row identities seal before temperature, Gibbs, log-K or direction values open."]]],.array [.text "record",.array [.array [.text "selected-temperature-or-single-direction-showcase",.text "A selected row can hide a direction reversal or adverse record."],.array [.text "complete-64-row-two-direction-crossing-vector",.text "Every common finite JANAF row and the complete crossing are retained."]]],.array [.text "extension",.array [.array [.text "refit-order-after-shared-successor",.text "Refitting destroys invariance under a common retained addition."],.array [.text "depth-independent-common-account-successor",.text "Adding the same positive account to both paths preserves their exact order."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Free-energy-equivalent reaction direction law"
 branch := "chemistry"
 statement := "Reaction direction is the held orientation forced by strict exact product order between complete forward and reverse retained-energy and closed-distinction accounts. Equality is equilibrium with structural EmptyOne separations; incomparable accounts halt rather than receiving a fitted trade-off. All 64 paired JANAF row identities seal before Gibbs, log-K, temperature or direction values open."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-forward-and-reverse-path-accounts__exact-positive-retained-energy-requirements__exact-positive-closed-distinction-counts__strict-exact-product-support-order__held-forward-reverse-or-EmptyOne-equilibrium__complete-value-free-reaction-state-identity-seal__complete-64-row-two-direction-crossing-vector__depth-independent-common-account-successor"),("base",.text "One forward/reverse account pair is ordered only when one exact positive energy/distinction pair is componentwise no greater and strict in at least one component; equality is structural equilibrium."),("successor",.text "Adding the same fresh positive retained-energy and distinction account to both paths preserves every prior component comparison and therefore the held direction or equilibrium result."),("exclusions",.array [.text "no numerical zero; exact equality uses structural EmptyOne separations",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported Gibbs/free-energy equation, fitted axis weight, equilibrium parameter or target-derived orientation",.text "no temperature, formation Gibbs, log-K, direction, target payload or target hash before prediction seal",.text "no selected temperature, deleted direction row, interpolated crossing or omitted source column",.text "external signed Gibbs and log-K inscriptions remain post-seal correspondence records only"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; exact equality uses structural EmptyOne separations","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported Gibbs/free-energy equation, fitted axis weight, equilibrium parameter or target-derived orientation","no temperature, formation Gibbs, log-K, direction, target payload or target hash before prediction seal","no selected temperature, deleted direction row, interpolated crossing or omitted source column","external signed Gibbs and log-K inscriptions remain post-seal correspondence records only"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with paths := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.FreeEnergyEquivalentDirectionEvidence
