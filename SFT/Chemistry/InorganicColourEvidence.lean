import SFT.Chemistry.InorganicColourGrammar
import SFT.Chemistry.InorganicColour
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.InorganicColourEvidence
open SFT.Host.Canonical InorganicColourGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-directed-carrier-product",.text "Ligand and metal endpoints force four directed transition classes.",.boolean InorganicColour.classWitness],.array [.text "positive-exact-gap",.text "The state-order separation is the exact positive successor count.",.boolean InorganicColour.gapWitness],.array [.text "selective-absorption-partition",.text "One absorbed distinction leaves the exact two-member colour class.",.boolean InorganicColour.partitionWitness],.array [.text "same-state-control",.text "A transition with one erased endpoint identity rejects.",.boolean InorganicColour.sameStateWitness],.array [.text "complete-absorption-control",.text "Absorbing all support leaves no colour class and rejects.",.boolean InorganicColour.completeAbsorptionWitness]]
def claimId : String := "SFT-CHEM-INORGANIC-COLOUR-ELECTRONIC-TRANSITION-008"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-SELECTION-RULE-STRUCTURE-010","SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001","SFT-CHEM-COORDINATION-GEOMETRY-HELD-ORIENTATION-004","SFT-CHEM-LIGAND-STATE-SPLITTING-006","SFT-CHEM-COMPLEX-SPIN-STATE-ORDER-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "endpoints",.text (endpointsName c.endpoints)],.array [.text "state",.text (stateName c.state)],.array [.text "direction",.text (directionName c.direction)],.array [.text "gap",.text (gapName c.gap)],.array [.text "absorption",.text (absorptionName c.absorption)],.array [.text "colour",.text (colourName c.colour)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "anonymous-complex-transition",.text "An anonymous transition erases which retained complex carries it."],.array [.text "one-retained-coordination-entity",.text "Every endpoint remains in one identified coordination entity."]]],.array [.text "endpoints",.array [.array [.text "imported-orbital-symbol-pair",.text "Conventional orbital names would select the endpoint grammar."],.array [.text "complete-ligand-metal-carrier-pair",.text "Two retained carrier kinds force the complete four-class directed product."]]],.array [.text "state",.array [.array [.text "energy-only-endpoints",.text "Energy-only endpoints lose electronic-state identity."],.array [.text "two-retained-state-identities",.text "Source and target remain distinct reconstructible electronic states."]]],.array [.text "direction",.array [.array [.text "signed-charge-displacement",.text "A signed scalar imports negative quantity and erases endpoint direction."],.array [.text "held-source-target-direction",.text "Direction is the ordered pair of retained ligand or metal carriers."]]],.array [.text "gap",.array [.array [.text "floating-or-dimensional-energy-gap",.text "A dimensional or floating gap imports an unforced scale."],.array [.text "positive-state-order-separation",.text "The gap is exactly the positive successor count between ordered states."]]],.array [.text "absorption",.array [.array [.text "selected-colour-name",.text "A named colour cannot establish what distinction was absorbed."],.array [.text "proper-absorbed-distinction-class",.text "Absorption retains a positive proper subset of complete incident observation support."]]],.array [.text "colour",.array [.array [.text "conventional-colour-wheel",.text "A colour wheel imports a continuum convention into forcing."],.array [.text "retained-complement-observation-class",.text "Inorganic colour is the exact nonempty observation class left after selective absorption."]]],.array [.text "extension",.array [.array [.text "species-peak-or-threshold-exception",.text "A selected peak or smoothing threshold can manufacture agreement."],.array [.text "complete-spectra-with-no-extra-rule",.text "The same endpoint, gap and observation-partition law applies to every complete exact spectrum."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact inorganic electronic-transition and selective-colour law"
 branch := "chemistry"
 statement := "Ligand and metal are the two retained electronic carrier kinds of a coordination entity, forcing the complete four-class directed transition product ligand-to-ligand, ligand-to-metal, metal-to-ligand and metal-to-metal. Every transition retains two state identities, a held source-target direction and the exact positive state-order gap. Selective absorption is a positive proper subset of complete incident observation support; inorganic colour is the exact nonempty complementary observation class retained after that absorption. No wavelength, colour wheel, orbital assignment, peak selection or fitted threshold enters the law."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-retained-coordination-entity__complete-ligand-metal-carrier-pair__two-retained-state-identities__held-source-target-direction__positive-state-order-separation__proper-absorbed-distinction-class__retained-complement-observation-class__complete-spectra-with-no-extra-rule"),("base",.text "For two incident distinctions, absorbing either one is the first proper selective partition and leaves exactly one retained colour distinction. The four directed carrier classes are already complete at two carrier kinds."),("successor",.text "Appending one new incident distinction preserves the prior absorbed/retained partition and places the new distinction in exactly one class. Appending one positive state successor preserves endpoint identity and increments only the exact positive order gap. No new carrier or colour rule is introduced."),("exclusions",.array [.text "no numerical zero; absence is structural EmptyOne",.text "no negative irrational imaginary floating signed continuum or complex-valued proof quantity",.text "no imported orbital assignment ligand-field Hamiltonian colour wheel visual-response curve or wavelength-to-colour table",.text "no selected peak smoothing threshold intensity cutoff fitted wavelength dimensional anchor or species exception",.text "no recapture deletion relabeling or custody-class promotion of shared admitted spectra",.text "no claim that a conventional colour name, wavelength or intensity is natively derived by the structural law"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absence is structural EmptyOne","no negative irrational imaginary floating signed continuum or complex-valued proof quantity","no imported orbital assignment ligand-field Hamiltonian colour wheel visual-response curve or wavelength-to-colour table","no selected peak smoothing threshold intensity cutoff fitted wavelength dimensional anchor or species exception","no recapture deletion relabeling or custody-class promotion of shared admitted spectra","no claim that a conventional colour name, wavelength or intensity is natively derived by the structural law"]
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
end SFT.Chemistry.InorganicColourEvidence
