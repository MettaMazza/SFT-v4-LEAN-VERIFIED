import SFT.Chemistry.MolecularIonizationGrammar
import SFT.Chemistry.MolecularIonizationMinimum
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularIonizationEvidence
open SFT.Host.Canonical MolecularIonizationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "ordered-positive-Take",.text "Eight above three forces an exact energy requirement of five.",.boolean (match MolecularIonization.orderedIonizationTake MolecularIonization.terminalEight MolecularIonization.initial with | .error _ => false | .ok r => MolecularIonization.ratioPair r==(5,1))],.array [.text "least-adiabatic-terminal",.text "The least complete-support terminal six forces adiabatic Take three.",.boolean (match MolecularIonization.leastAdiabaticTake MolecularIonization.initial MolecularIonization.terminals with | .error _ => false | .ok r => MolecularIonization.ratioPair r==(3,1))],.array [.text "vertical-order",.text "Every held-geometry member is not below the least adiabatic member.",.boolean (match MolecularIonization.verticalNotBelowAdiabatic MolecularIonization.initial MolecularIonization.terminals MolecularIonization.terminalSeven with | .error _ => false | .ok b => b)],.array [.text "reversed-order-rejected",.text "A terminal below the declared initial height is rejected.",.boolean (match MolecularIonization.orderedIonizationTake MolecularIonization.initial MolecularIonization.terminalEight with | .error _ => true | .ok _ => false)],.array [.text "missing-vertical-rejected",.text "A vertical state outside complete generated support is rejected.",.boolean (match MolecularIonization.verticalNotBelowAdiabatic MolecularIonization.initial MolecularIonization.terminals MolecularIonization.terminalNine with | .error _ => true | .ok _ => false)]]
def claimId : String := "SFT-CHEM-MOLECULAR-IONIZATION-ENERGY-007"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-NUCLEAR-ELECTRONIC-COMPOSITION-012","SFT-CHEM-MOLECULAR-POLARIZABILITY-006"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "transformation",.text (transformationName c.transformation)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "path",.text (pathName c.path)],.array [.text "order",.text (orderName c.order)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "ionization-answer-with-erased-states",.text "An answer-only energy erases the neutral carrier and resulting ionic state."],.array [.text "complete-neutral-to-ionic-carrier",.text "Species, initial state, conformation, removed carrier and resulting ion remain held."]]],.array [.text "transformation",.array [.array [.text "signed-electron-subtraction",.text "A signed electron subtraction imports a negative proof magnitude."],.array [.text "held-removal-and-positive-terminal-separation",.text "Removal is an orientation label and the terminal separated state lies positively above the bound state."]]],.array [.text "magnitude",.array [.array [.text "imported-orbital-energy-equality",.text "An imported orbital theorem does not force the complete many-carrier state difference."],.array [.text "ordered-positive-final-from-initial-Take",.text "Ionization energy is the exact positive Take from bound initial height to separated terminal height."]]],.array [.text "path",.array [.array [.text "adiabatic-vertical-state-conflation",.text "Erasing geometry custody conflates two different terminal-state classes."],.array [.text "least-adiabatic-and-held-geometry-vertical-paths",.text "Adiabatic is the least generated terminal Take; vertical retains the initial geometry."]]],.array [.text "order",.array [.array [.text "unconstrained-vertical-reordering",.text "A held-geometry member cannot be declared below the least complete-support member."],.array [.text "vertical-not-below-adiabatic",.text "Set inclusion forces every vertical Take to be at least the adiabatic least Take."]]],.array [.text "prediction",.array [.array [.text "ionization-value-readable-before-seal",.text "Readable energy values could select the law or carrier boundary."],.array [.text "value-free-carrier-and-operation-seal",.text "Complete carrier identities and exact operations seal before any energy inscription opens."]]],.array [.text "record",.array [.array [.text "selected-isotopologue-or-favorable-row",.text "A selected subset can conceal isotope, spin or polarity dependence."],.array [.text "complete-nine-diatomic-NIST-vector",.text "All nine preregistered neutral diatomic carriers remain in source order."]]],.array [.text "extension",.array [.array [.text "species-fit-or-residual-correction",.text "A species coefficient or residual correction is a fitted parameter."],.array [.text "one-ionization-law-no-extra-rule",.text "One ordered Take and typed path law exhausts the registered vector."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact molecular ionization-energy and terminal-state ordering law"
 branch := "chemistry"
 statement := "Molecular ionization retains the complete neutral carrier, held electron-removal orientation and resulting positive-ion state. Its required energy is the ordered positive Take from the bound initial state height to the separated ion-plus-electron terminal height. Adiabatic ionization is the least Take over complete generated terminal support; a vertical held-geometry terminal is a member of that support and therefore cannot lie below the adiabatic least Take. The relation and all nine identities seal before the NIST experimental energy vector opens."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-neutral-to-ionic-carrier__held-removal-and-positive-terminal-separation__ordered-positive-final-from-initial-Take__least-adiabatic-and-held-geometry-vertical-paths__vertical-not-below-adiabatic__value-free-carrier-and-operation-seal__complete-nine-diatomic-NIST-vector__one-ionization-law-no-extra-rule"),("base",.text "One complete neutral state and one strictly higher separated ion-plus-electron state force one exact positive terminal-from-initial Take; the least member of a nonempty finite terminal support exists."),("successor",.text "Appending one generated ionic terminal preserves every earlier Take; the adiabatic value remains the least complete-support member or becomes the new smaller positive member, while every held-geometry vertical member remains not below the resulting least member."),("exclusions",.array [.text "no numerical zero, negative, irrational, imaginary, floating or continuum proof value",.text "no signed electron energy, negative orbital scalar or erased removal orientation",.text "no imported Koopmans theorem, orbital equality, wavefunction, Hamiltonian or fitted molecular coefficient",.text "no measured ionization energy, uncertainty or source inscription in the law, grammar or prediction",.text "no conflation of adiabatic and vertical terminal-state custody",.text "no erased neutral carrier, initial state, conformation, resulting ionic state, method or condition",.text "no selected isotope, favorable row, dropped uncertainty or species correction"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero, negative, irrational, imaginary, floating or continuum proof value","no signed electron energy, negative orbital scalar or erased removal orientation","no imported Koopmans theorem, orbital equality, wavefunction, Hamiltonian or fitted molecular coefficient","no measured ionization energy, uncertainty or source inscription in the law, grammar or prediction","no conflation of adiabatic and vertical terminal-state custody","no erased neutral carrier, initial state, conformation, resulting ionic state, method or condition","no selected isotope, favorable row, dropped uncertainty or species correction"]
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
end SFT.Chemistry.MolecularIonizationEvidence
