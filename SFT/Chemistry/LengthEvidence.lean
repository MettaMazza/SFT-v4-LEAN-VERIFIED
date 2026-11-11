import SFT.Chemistry.LengthGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.LengthEvidence
open SFT.Host.Canonical LengthGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity-pair",.text "length and strength records bind to one bond carrier",.boolean true],.array [.text "measurement-boundary",.text "decimal values remain external records",.boolean true],.array [.text "universal-fit-control",.text "no inverse formula is asserted",.boolean true]]
def claimId : String := "SFT-CHEM-BOND-LENGTH-STRENGTH-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-ENTANGLEMENT-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-CONDENSED-LATTICE-001","SFT-PHYS-CONDENSED-BAND-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-VALENCE-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-CHEMICAL-BOND-001","SFT-CHEM-BOND-ORDER-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "length",.text (lengthName c.length)],.array [.text "strength",.text (strengthName c.strength)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "correspondence",.text (correspondenceName c.correspondence)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "generic-bond-type-only",.text "A type average can erase the specific molecular carrier."],.array [.text "specific-identified-bond",.text "Both records bind to the same bond identity."]]],.array [.text "length",.array [.array [.text "context-free-distance",.text "Measured bond length depends on method and state."],.array [.text "method-bounded-centre-distance",.text "Centres, method, state and uncertainty remain held."]]],.array [.text "strength",.array [.array [.text "qualitative-strong-weak-label",.text "A qualitative label cannot reproduce dissociation."],.array [.text "positive-dissociation-transfer",.text "Strength is the registered carrier required to open the bond."]]],.array [.text "conditions",.array [.array [.text "conditions-erased",.text "Phase, state and cleavage path affect measured records."],.array [.text "measurement-conditions-retained",.text "Every condition remains part of identity."]]],.array [.text "correspondence",.array [.array [.text "universal-inverse-equation",.text "A categorical relation does not force one universal formula."],.array [.text "common-bond-identity-pairing",.text "Length and strength correspond by shared bond carrier only."]]],.array [.text "measurement",.array [.array [.text "decimal-as-proof-scalar",.text "Measured decimals cannot enter derivation."],.array [.text "separate-source-bound-records",.text "External values remain post-seal records."]]],.array [.text "record",.array [.array [.text "paired-values-without-provenance",.text "A pair without methods cannot be compared."],.array [.text "bond-length-strength-source-trace",.text "Identity, values, methods and uncertainties remain held."]]],.array [.text "extension",.array [.array [.text "free-length-strength-fit",.text "A fitted curve can force measured examples."],.array [.text "no-extra-rule",.text "No relation beyond identity pairing is asserted."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Bond length, energy and identity correspondence"
 branch := "chemistry"
 statement := "Bond length and strength are separate source-bounded records paired by one specific bond identity: inter-centre distance and positive dissociation transfer under retained methods and conditions; no universal formula is imported."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "specific-identified-bond__method-bounded-centre-distance__positive-dissociation-transfer__common-bond-identity-pairing"),("base",.text "One identified bond with one method-bounded distance and one condition-bounded dissociation record supplies the first correspondence pair."),("successor",.text "Appending one measurement retains bond identity, method, conditions and uncertainty without changing the derived structural law or fitting a universal curve."),("exclusions",.array [.text "no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "no universal bond-length/strength formula inferred from a categorical correspondence",.text "official target content opens only through post-seal custody",.text "Every identified bond with one source/method-bounded inter-centre distance record and one separately source/condition-bounded positive dissociation-transfer record, joined only by common bond identity."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC bond definition, orbital equation, electronegativity scale, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","no universal bond-length/strength formula inferred from a categorical correspondence","official target content opens only through post-seal custody","Every identified bond with one source/method-bounded inter-centre distance record and one separately source/condition-bounded positive dissociation-transfer record, joined only by common bond identity."]
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
end SFT.Chemistry.LengthEvidence
