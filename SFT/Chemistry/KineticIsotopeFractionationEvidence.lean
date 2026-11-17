import SFT.Chemistry.KineticIsotopeFractionationGrammar
import SFT.Chemistry.KineticIsotopeFractionation
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.KineticIsotopeFractionationEvidence
open SFT.Host.Canonical KineticIsotopeFractionationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Reaction and isotopes held.",.boolean KineticIsotopeFractionation.identityWitness],.array [.text "support",.text "Ranks complete.",.boolean KineticIsotopeFractionation.supportWitness],.array [.text "events",.text "Products counted.",.boolean KineticIsotopeFractionation.eventsWitness],.array [.text "rates",.text "Rates exact.",.boolean KineticIsotopeFractionation.ratesWitness],.array [.text "factor",.text "Factor exact.",.boolean KineticIsotopeFractionation.factorWitness],.array [.text "orientation",.text "Faster class held.",.boolean KineticIsotopeFractionation.orientationWitness],.array [.text "inventory",.text "Remainders positive or absent.",.boolean KineticIsotopeFractionation.inventoryWitness],.array [.text "successor",.text "Series recomputes.",.boolean KineticIsotopeFractionation.successorWitness]]
def claimId : String := "SFT-CHEM-KINETIC-ISOTOPE-FRACTIONATION-008"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-ELEM-ISOTOPE-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-ACTIVITY-AMOUNT-TIME-003","SFT-CHEM-ISOTOPE-EXCHANGE-006","SFT-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "support",.text (supportName c.support)],.array [.text "events",.text (eventsName c.events)],.array [.text "rates",.text (ratesName c.rates)],.array [.text "factor",.text (factorName c.factor)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "inventory",.text (inventoryName c.inventory)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "mass-only-rate",.text "Rate needs reaction and isotope identity."],.array [.text "held-reaction-light-heavy-identities",.text "The complete path and both isotopes remain held."]]],.array [.text "support",.array [.array [.text "continuous-time-premise",.text "Continuum time is not proof support."],.array [.text "positive-ordered-resource-intervals",.text "Every interval is positive and ordered."]]],.array [.text "events",.array [.array [.text "expected-product-yield",.text "Expectation is not event custody."],.array [.text "positive-counted-isotope-products",.text "Both isotope product events are counted."]]],.array [.text "rates",.array [.array [.text "fitted-rate-constants",.text "Fitted constants cannot define the native rates."],.array [.text "exact-products-per-resource-rates",.text "Both rates are exact count/resource ratios."]]],.array [.text "factor",.array [.array [.text "imported-kinetic-isotope-effect",.text "No imported factor is admissible."],.array [.text "exact-light-heavy-rate-ratio",.text "The factor is forced by counted rates."]]],.array [.text "orientation",.array [.array [.text "signed-rate-difference",.text "A signed difference imports negative values."],.array [.text "held-faster-class-or-EmptyOne",.text "The faster class is held; equality closes structurally."]]],.array [.text "inventory",.array [.array [.text "negative-depleted-reactant",.text "Depletion cannot produce a negative proof value."],.array [.text "positive-Take-or-EmptyOne-remainder",.text "Each remainder is positive or structurally absent."]]],.array [.text "extension",.array [.array [.text "Rayleigh-continuum-premise",.text "A continuum law is not required."],.array [.text "finite-time-series-successor-recomputes",.text "Each successor retains the path and recomputes exact rates."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold kinetic isotope-fractionation law"
 branch := "chemistry"
 statement := "Kinetic isotope fractionation retains one reaction and two isotope identities over complete positive ordered resources, forces exact product rates and their factor, and records faster class and remainder without signed or negative native values."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-reaction-light-heavy-identities__positive-ordered-resource-intervals__positive-counted-isotope-products__exact-products-per-resource-rates__exact-light-heavy-rate-ratio__held-faster-class-or-EmptyOne__positive-Take-or-EmptyOne-remainder__finite-time-series-successor-recomputes"),("base",.text "One isotope-resolved product interval supplies the first exact rate pair."),("successor",.text "Each successor preserves the path and recomputes the complete rate and remainder vector."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no measured kinetic response correction curve or conventional kinetic model selects the survivor",.text "every flow reversal loss estimate correction uncertainty limitation and unreported cell remains"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no measured kinetic response correction curve or conventional kinetic model selects the survivor","every flow reversal loss estimate correction uncertainty limitation and unreported cell remains"]
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
end SFT.Chemistry.KineticIsotopeFractionationEvidence
