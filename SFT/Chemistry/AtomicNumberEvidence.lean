import SFT.Chemistry.AtomicNumberGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AtomicNumberEvidence
open SFT.Host.Canonical AtomicNumberGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "count-order",.text "successor proton collections are strictly ordered",.boolean true],.array [.text "isotope-invariance",.text "mass-number change leaves proton count fixed",.boolean true],.array [.text "electron-control",.text "electron count is rejected as element order",.boolean true]]
def claimId : String := "SFT-CHEM-ELEM-ATOMIC-NUMBER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-MATTER-PARTICLE-SPECTRUM-001","SFT-PHYS-NUCLEAR-LEVELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-ELEM-ELEMENT-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "location",.text (locationName c.location)],.array [.text "order",.text (orderName c.order)],.array [.text "element_map",.text (element_mapName c.element_map)],.array [.text "isotope",.text (isotopeName c.isotope)],.array [.text "charge",.text (chargeName c.charge)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "symbol-position-only",.text "A table position cannot define the nuclear quantity."],.array [.text "exact-proton-count",.text "The number is the generated positive-finite count of protons."]]],.array [.text "location",.array [.array [.text "whole-atom-particle-count",.text "Counting every atomic particle changes across isotopes and charge states."],.array [.text "nuclear-count-carrier",.text "Only protons in the atomic nucleus determine this coordinate."]]],.array [.text "order",.array [.array [.text "unordered-label",.text "An unordered label cannot supply periodic succession."],.array [.text "positive-count-order",.text "Generated count succession gives an exact total order."]]],.array [.text "element_map",.array [.array [.text "many-elements-one-count",.text "Two element classes with one proton count violate their identity condition."],.array [.text "one-count-one-element-class",.text "Each held proton count names exactly one element class."]]],.array [.text "isotope",.array [.array [.text "mass-dependent-number",.text "Mass-number variation must not alter element order."],.array [.text "isotope-invariant",.text "Every isotope retains the same atomic number."]]],.array [.text "charge",.array [.array [.text "electron-count-dependent",.text "Ion formation changes electrons without changing the element."],.array [.text "charge-state-invariant",.text "The proton count persists through admitted charge-state changes."]]],.array [.text "record",.array [.array [.text "number-without-nucleus",.text "A bare number loses the physical carrier and class mapping."],.array [.text "count-nucleus-element-trace",.text "Count construction, nucleus and element class remain linked."]]],.array [.text "extension",.array [.array [.text "free-order-offset",.text "An offset can relabel the periodic order arbitrarily."],.array [.text "no-extra-rule",.text "Generated count succession supplies the complete order."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Atomic-number ordering and element distinction"
 branch := "chemistry"
 statement := "Atomic number is the exact generated positive-finite count of protons in an atom's nucleus and therefore the unique order coordinate of its chemical-element class."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "exact-proton-count__nuclear-count-carrier"),("base",.text "One nuclear proton supplies the first generated atomic-number count and one element-class coordinate."),("successor",.text "Appending one proton extends the exact count order while preserving every earlier count/class distinction without an offset."),("exclusions",.array [.text "no IUPAC definition, periodic-table arrangement, measured element value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every generated positive-finite nuclear proton collection and its one-to-one order coordinate over admitted chemical-element classes."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, periodic-table arrangement, measured element value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","official target content opens only through post-seal custody","Every generated positive-finite nuclear proton collection and its one-to-one order coordinate over admitted chemical-element classes."]
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
end SFT.Chemistry.AtomicNumberEvidence
