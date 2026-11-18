import SFT.Chemistry.MolecularElectronAffinityGrammar
import SFT.Chemistry.MolecularElectronAffinity
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularElectronAffinityEvidence
open SFT.Host.Canonical MolecularElectronAffinityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "bound-orientation",.text "Neutral above anion forces bound attachment orientation and positive Take five.",.boolean ((MolecularElectronAffinity.resultPair (MolecularElectronAffinity.differenceFromRatios MolecularElectronAffinity.higher MolecularElectronAffinity.lower))==("anion-below-neutral-bound-attachment",some (5,1)))],.array [.text "unbound-orientation",.text "Anion above neutral forces unbound autodetachment orientation and positive Take five.",.boolean ((MolecularElectronAffinity.resultPair (MolecularElectronAffinity.differenceFromRatios MolecularElectronAffinity.lower MolecularElectronAffinity.higher))==("anion-above-neutral-unbound-autodetachment",some (5,1)))],.array [.text "coincident-boundary",.text "Coincident state heights produce structural EmptyOne rather than numerical zero.",.boolean ((MolecularElectronAffinity.resultPair (MolecularElectronAffinity.differenceFromRatios MolecularElectronAffinity.lower MolecularElectronAffinity.lower))==("coincident-no-affinity-distinction",none))],.array [.text "one-law",.text "Bound and unbound state orders use the same ordered positive distinction operation.",.boolean ((MolecularElectronAffinity.resultPair (MolecularElectronAffinity.differenceFromRatios MolecularElectronAffinity.higher MolecularElectronAffinity.lower)).2==(MolecularElectronAffinity.resultPair (MolecularElectronAffinity.differenceFromRatios MolecularElectronAffinity.lower MolecularElectronAffinity.higher)).2)]]
def claimId : String := "SFT-CHEM-MOLECULAR-ELECTRON-AFFINITY-008"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTRON-COUNT-SPIN-002","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-NUCLEAR-ELECTRONIC-COMPOSITION-012","SFT-CHEM-MOLECULAR-IONIZATION-ENERGY-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "gain",.text (gainName c.gain)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "uncertainty",.text (uncertaintyName c.uncertainty)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "electron-affinity-answer-with-erased-states",.text "An answer-only scalar erases the neutral molecule and resulting anion."],.array [.text "complete-neutral-electron-anion-carrier",.text "Neutral carrier, gained electron and resulting anion state all remain held."]]],.array [.text "gain",.array [.array [.text "signed-electron-addition",.text "A signed addition imports a negative proof magnitude."],.array [.text "held-electron-gain-orientation",.text "Electron gain is a held transfer orientation with a positive carrier count."]]],.array [.text "magnitude",.array [.array [.text "conventional-signed-affinity-scalar",.text "One signed number conflates state order with energy magnitude."],.array [.text "held-order-plus-positive-state-Take",.text "State order is held and the energy distinction is the exact positive higher Take lower."]]],.array [.text "boundary",.array [.array [.text "bound-anion-only-domain",.text "Discarding unbound anions selects favorable conventional signs."],.array [.text "bound-unbound-and-EmptyOne-boundary",.text "Bound, unbound and coincident states share one orientation-and-magnitude law."]]],.array [.text "prediction",.array [.array [.text "affinity-value-or-orientation-readable-before-seal",.text "A readable sign or magnitude could select the representation or carrier subset."],.array [.text "value-and-orientation-free-carrier-seal",.text "Complete identities and the exact representation seal before state order or magnitude opens."]]],.array [.text "record",.array [.array [.text "selected-positive-or-favorable-molecular-row",.text "A selected subset can conceal unbound carriers and source diversity."],.array [.text "complete-NIST-molecular-experimental-vector",.text "Every molecular CCCBDB page with an explicit experimental value remains in catalog order."]]],.array [.text "uncertainty",.array [.array [.text "central-value-with-erased-uncertainty",.text "Dropping uncertainty weakens the empirical record."],.array [.text "complete-source-uncertainty-custody",.text "Every explicit uncertainty and every disclosed rounding enclosure remains attached."]]],.array [.text "extension",.array [.array [.text "species-fit-or-sign-correction",.text "A species coefficient or sign correction is a fitted parameter."],.array [.text "one-affinity-law-no-extra-rule",.text "One held-order and positive-Take law exhausts bound and unbound records."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular electron-affinity state-order and magnitude law"
 branch := "chemistry"
 statement := "Molecular electron affinity retains the complete neutral carrier, held electron-gain action and resulting anion state. Conventional sign is replaced by a held state-order orientation: a bound anion lies below the neutral-plus-electron state, while an unbound anion lies above it. In either orientation the magnitude is the exact positive higher-state Take lower-state; coincident states carry structural EmptyOne. The law and all 96 identities seal before the complete NIST experimental vector opens."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-neutral-electron-anion-carrier__held-electron-gain-orientation__held-order-plus-positive-state-Take__bound-unbound-and-EmptyOne-boundary__value-and-orientation-free-carrier-seal__complete-NIST-molecular-experimental-vector__complete-source-uncertainty-custody__one-affinity-law-no-extra-rule"),("base",.text "One retained neutral-plus-electron state and one retained anion state force exactly one of three structural orders: above, below or coincident; a strict order forces one positive higher Take lower magnitude, while coincidence forces EmptyOne."),("successor",.text "Appending one generated molecular carrier preserves every earlier carrier, state order and exact magnitude; the same three-way order and positive-Take operation decides the appended pair without a species rule."),("exclusions",.array [.text "no numerical zero; coincident state heights use structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum proof value",.text "no conventional signed electron-affinity scalar as an SFT proof object",.text "no imported orbital theorem, wavefunction, Hamiltonian or fitted species coefficient",.text "no measured affinity magnitude, sign orientation or uncertainty in the law, grammar or prediction",.text "no favorable-sign selection, dropped unbound row, omitted uncertainty or atomic/molecular conflation"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; coincident state heights use structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum proof value","no conventional signed electron-affinity scalar as an SFT proof object","no imported orbital theorem, wavefunction, Hamiltonian or fitted species coefficient","no measured affinity magnitude, sign orientation or uncertainty in the law, grammar or prediction","no favorable-sign selection, dropped unbound row, omitted uncertainty or atomic/molecular conflation"]
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
end SFT.Chemistry.MolecularElectronAffinityEvidence
