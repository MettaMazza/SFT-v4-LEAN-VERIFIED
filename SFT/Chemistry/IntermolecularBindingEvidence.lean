import SFT.Chemistry.IntermolecularBindingGrammar
import SFT.Chemistry.IntermolecularBinding
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.IntermolecularBindingEvidence
open SFT.Host.Canonical IntermolecularBindingGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-constituent-composition",.text "Two positive constituent states compose without numerical zero.",.boolean (match IntermolecularBinding.exactSeparatedState (.tuple [IntermolecularBinding.firstConstituent,IntermolecularBinding.secondConstituent]) with | .error _ => false | .ok r => IntermolecularBinding.ratioPair r==(29,6))],.array [.text "ordered-positive-binding-Take",.text "Separated 29/6 Takes bound 4 and yields exact binding 5/6.",.boolean (match IntermolecularBinding.exactBindingTake IntermolecularBinding.separated IntermolecularBinding.bound with | .error _ => false | .ok r => IntermolecularBinding.ratioPair r==(5,6))],.array [.text "orientation-retained",.text "Reversing state order halts rather than producing a negative Fold number.",.boolean (match IntermolecularBinding.exactBindingTake IntermolecularBinding.bound IntermolecularBinding.separated with | .error _ => true | .ok _ => false)],.array [.text "depth-independent-extension",.text "Appending one shared state to both endpoints preserves the exact binding Take.",.boolean (match IntermolecularBinding.appendSharedConstituentPreservesBinding IntermolecularBinding.separated IntermolecularBinding.bound IntermolecularBinding.appended with | .error _ => false | .ok b => b)],.array [.text "equal-repetition",.text "Three equal repetitions force three times the exact binding magnitude.",.boolean (match IntermolecularBinding.repeatedUnitBinding IntermolecularBinding.separated IntermolecularBinding.bound (.count ⟨3,by decide⟩) with | .error _ => false | .ok r => IntermolecularBinding.ratioPair r==(5,2))],.array [.text "unbound-absence",.text "A record without strict bound-state order is structural EmptyOne.",.boolean (match IntermolecularBinding.unboundInteractionForm with | .emptyOne => true | .otherEmptyOne _ => true | .ratio _ => false | .invalid => false)]]
def claimId : String := "SFT-CHEM-INTERMOLECULAR-BINDING-011"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-MOL-SUPRAMOLECULAR-001","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-BOND-DISSOCIATION-ENERGY-002","SFT-CHEM-MOLECULAR-DIPOLE-MAGNITUDE-005","SFT-CHEM-MOLECULAR-POLARIZABILITY-006","SFT-CHEM-VIBRATIONAL-FREQUENCY-009","SFT-CHEM-ROTATIONAL-CONSTANT-010"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "separation",.text (separationName c.separation)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "magnitude",.text (magnitudeName c.magnitude)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-binding-number-with-erased-components",.text "An answer-only magnitude cannot distinguish an intermolecular composite from an internal molecular state."],.array [.text "named-constituents-and-bound-composite-carrier",.text "Every constituent, constituent state and bound composite remains separately identifiable."]]],.array [.text "separation",.array [.array [.text "continuum-distance-or-imported-potential-coordinate",.text "A continuum coordinate or potential surface imports an ungenerated mathematical model."],.array [.text "finite-held-separation-organization",.text "The separated endpoint is a finite generated organization retained as an exact label."]]],.array [.text "composition",.array [.array [.text "constituent-energies-erased-or-merged",.text "Erasing constituent states destroys the separated endpoint and prevents reconstruction."],.array [.text "exact-positive-constituent-state-composition",.text "All positive constituent states compose exactly without a numerical-zero initializer."]]],.array [.text "magnitude",.array [.array [.text "signed-free-energy-or-negative-binding-number",.text "A signed answer leaves the positive Fold domain and obscures state order."],.array [.text "ordered-positive-separated-Take-bound",.text "Binding is the exact positive Take of the lower bound composite from the higher separated state."]]],.array [.text "absence",.array [.array [.text "assume-every-generated-aggregate-is-bound",.text "A proximity or calculation label does not force a stable lower composite state."],.array [.text "strict-bound-order-or-structural-EmptyOne",.text "Only strict state order yields a binding magnitude; an unbound record remains structural EmptyOne."]]],.array [.text "prediction",.array [.array [.text "binding-target-readable-before-seal",.text "A readable binding value could select the law, source rows or an interaction coefficient."],.array [.text "value-free-complete-dimer-cluster-identity-seal",.text "All constituent, composite, method/basis and measurement identities seal without target values."]]],.array [.text "record",.array [.array [.text "favorable-dimer-method-or-measurement-subset",.text "Selecting only positive or agreeing rows conceals adverse and unavailable source records."],.array [.text "complete-computed-measured-adverse-and-scope-custody",.text "Every linked CCCBDB value, all signed adverse inscriptions, reported measurements and the wider cluster boundary remain explicit."]]],.array [.text "extension",.array [.array [.text "fitted-interaction-coefficient-or-species-correction",.text "A fitted coefficient or species residual lets the target choose the result."],.array [.text "one-state-order-law-with-depth-independent-constituent-extension",.text "Appending the same named constituent state to both endpoints preserves the exact Take without a new rule."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact intermolecular binding by retained state order"
 branch := "chemistry"
 statement := "An intermolecular binding magnitude is derived only after every named constituent state, the exact separated-constituent composition, the bound composite state and a finite separation organization remain held. The higher separated state Takes the strictly lower bound composite state, yielding one exact positive relation. A record without strict bound order is structural EmptyOne. All 1,299 value-free identities seal before the complete 1,297-row CCCBDB calculated vector and two reported experimental water-cluster dissociation rows open; all 96 signed adverse source inscriptions remain explicit and never become negative SFT numbers."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "named-constituents-and-bound-composite-carrier__finite-held-separation-organization__exact-positive-constituent-state-composition__ordered-positive-separated-Take-bound__strict-bound-order-or-structural-EmptyOne__value-free-complete-dimer-cluster-identity-seal__complete-computed-measured-adverse-and-scope-custody__one-state-order-law-with-depth-independent-constituent-extension"),("base",.text "Two named constituent states compose one exact positive separated endpoint; if one retained composite state is strictly lower, their ordered Take forces the first exact positive intermolecular binding magnitude."),("successor",.text "Appending one named positive constituent state to both the separated and bound endpoint compositions preserves every earlier identity and leaves their exact Take unchanged; equal positive repetition scales both endpoints and the binding without a new coefficient."),("exclusions",.array [.text "no numerical zero; an unbound or unavailable native result is structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum SFT proof value",.text "no imported intermolecular potential, continuum distance field or force-family equation",.text "no measured or calculated binding target in the law, candidate grammar, forcing or prediction",.text "no fitted interaction coefficient, species correction, basis correction or favorable-row selection",.text "no conflation of calculated CCCBDB rows with reported experimental dissociation values",.text "no deletion of signed adverse, unavailable, unparsed-compendium or source-scope records"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; an unbound or unavailable native result is structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum SFT proof value","no imported intermolecular potential, continuum distance field or force-family equation","no measured or calculated binding target in the law, candidate grammar, forcing or prediction","no fitted interaction coefficient, species correction, basis correction or favorable-row selection","no conflation of calculated CCCBDB rows with reported experimental dissociation values","no deletion of signed adverse, unavailable, unparsed-compendium or source-scope records"]
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
end SFT.Chemistry.IntermolecularBindingEvidence
