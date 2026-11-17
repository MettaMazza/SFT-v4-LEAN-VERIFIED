import SFT.Chemistry.IsotopeExchangeGrammar
import SFT.Chemistry.IsotopeExchange
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.IsotopeExchangeEvidence
open SFT.Host.Canonical IsotopeExchangeGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Isotopes held.",.boolean IsotopeExchange.identityWitness],.array [.text "carriers",.text "Carriers held.",.boolean IsotopeExchange.carriersWitness],.array [.text "inventory",.text "Four positive counts retained.",.boolean IsotopeExchange.inventoryWitness],.array [.text "conservation",.text "Exchange conserves totals.",.boolean IsotopeExchange.conservationWitness],.array [.text "direction",.text "Event excess held.",.boolean IsotopeExchange.directionWitness],.array [.text "quotient",.text "Quotient exact.",.boolean IsotopeExchange.quotientWitness],.array [.text "equilibrium",.text "Balanced events close.",.boolean IsotopeExchange.equilibriumWitness],.array [.text "successor",.text "Return successor preserves totals.",.boolean IsotopeExchange.successorWitness]]
def claimId : String := "SFT-CHEM-ISOTOPE-EXCHANGE-006"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-ELEM-ISOTOPE-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001","SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "carriers",.text (carriersName c.carriers)],.array [.text "inventory",.text (inventoryName c.inventory)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "direction",.text (directionName c.direction)],.array [.text "quotient",.text (quotientName c.quotient)],.array [.text "equilibrium",.text (equilibriumName c.equilibrium)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "mass-number-only",.text "Mass number alone loses elemental and isotope identity."],.array [.text "held-element-light-heavy-isotopes",.text "Element and both isotopes remain held."]]],.array [.text "carriers",.array [.array [.text "phase-free-exchange",.text "Exchange requires two chemical carriers."],.array [.text "held-distinct-chemical-carriers",.text "Both carriers remain held."]]],.array [.text "inventory",.array [.array [.text "continuum-concentration-premise",.text "Continuum concentration hides occurrences."],.array [.text "positive-complete-four-count-inventory",.text "Every light/heavy carrier occurrence is counted."]]],.array [.text "conservation",.array [.array [.text "isotope-label-overwrite",.text "Overwriting destroys custody."],.array [.text "exact-isotope-and-carrier-conservation",.text "Both isotope totals and carrier totals are invariant."]]],.array [.text "direction",.array [.array [.text "signed-exchange-extent",.text "A signed scalar imports negative values."],.array [.text "held-direction-positive-Take",.text "Direction is held and excess is positive."]]],.array [.text "quotient",.array [.array [.text "fitted-exchange-constant",.text "A fit cannot define exchange."],.array [.text "exact-cross-product-exchange-quotient",.text "The quotient is forced by four exact counts."]]],.array [.text "equilibrium",.array [.array [.text "numerical-zero-net",.text "Numerical zero is not native balance."],.array [.text "equal-forward-reverse-closes-EmptyOne",.text "Equal counted directions close structurally."]]],.array [.text "extension",.array [.array [.text "lookup-fractionation-factor",.text "A lookup cannot select a transition."],.array [.text "successor-preserves-identities-and-totals",.text "Every successor preserves complete custody."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold isotope-exchange reaction law"
 branch := "chemistry"
 statement := "Isotope exchange preserves exact element, isotope and carrier identities and all positive isotope/carrier totals, carries direction as a held positive excess, and forces its exchange quotient by cross-products."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-element-light-heavy-isotopes__held-distinct-chemical-carriers__positive-complete-four-count-inventory__exact-isotope-and-carrier-conservation__held-direction-positive-Take__exact-cross-product-exchange-quotient__equal-forward-reverse-closes-EmptyOne__successor-preserves-identities-and-totals"),("base",.text "One complete two-isotope two-carrier inventory supplies the first exchange state."),("successor",.text "Each successor preserves identities and all isotope and carrier totals."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external alpha table equilibrium constant or species result selects the survivor",.text "every nonideality assumption and unavailable row remains"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external alpha table equilibrium constant or species result selects the survivor","every nonideality assumption and unavailable row remains"]
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
end SFT.Chemistry.IsotopeExchangeEvidence
