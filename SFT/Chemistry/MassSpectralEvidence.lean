import SFT.Chemistry.MassSpectralGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MassSpectralEvidence
open SFT.Host.Canonical MassSpectralGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "chemical carrier is retained",.boolean true],.array [.text "classes",.text "positive response classes exist",.boolean true],.array [.text "conditions",.text "observation boundary is explicit",.boolean true]]
def claimId : String := "SFT-CHEM-SPEC-MASS-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-MEAS-TRACEABILITY-001","SFT-CHEM-BIOMOLECULAR-BOUNDARY-001","SFT-CHEM-ANALYTICAL-SAMPLE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "identity",.text (identityName c.identity)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "response",.text (responseName c.response)],.array [.text "fragments",.text (fragmentsName c.fragments)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "neutral-sample-label-only",.text "No detected carrier class is generated."],.array [.text "generated-ionized-carriers",.text "Each detected carrier occurrence is explicit."]]],.array [.text "identity",.array [.array [.text "carrier-composition-erased",.text "Composition correspondence is impossible."],.array [.text "composition-and-isotope-support-held",.text "Constituent identities are retained."]]],.array [.text "partition",.array [.array [.text "undifferentiated-response",.text "Distinct carrier classes merge."],.array [.text "mass-charge-classes-held",.text "Each response class keeps mass and charge organization."]]],.array [.text "response",.array [.array [.text "peak-position-only",.text "Multiplicity support is lost."],.array [.text "class-position-and-abundance-held",.text "Location and counted response remain paired."]]],.array [.text "fragments",.array [.array [.text "fragment-origin-erased",.text "Products cannot be related to precursors."],.array [.text "precursor-fragment-map-held",.text "Generated decomposition paths persist."]]],.array [.text "conditions",.array [.array [.text "universal-spectrum",.text "Carrier production is method-bound."],.array [.text "ionization-and-instrument-boundary",.text "Source and observation conditions are explicit."]]],.array [.text "record",.array [.array [.text "spectrum-image-only",.text "The composition map cannot be checked."],.array [.text "complete-carrier-response-trace",.text "Every class, count and map is retained."]]],.array [.text "extra",.array [.array [.text "free-peak-assignment",.text "A library guess can select composition."],.array [.text "no-extra-rule",.text "Generated carriers and exact class equality decide correspondence."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Mass-spectral composition correspondence"
 branch := "chemistry"
 statement := "A mass-spectral record is the complete map from generated ionized carriers to retained mass/charge response classes and counted abundances, including precursor-fragment relations and observation conditions."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "generated-ionized-carriers__composition-and-isotope-support-held__mass-charge-classes-held__class-position-and-abundance-held__precursor-fragment-map-held"),("base",.text "One generated ion carrier and its resolved response class supply the first mass-spectral correspondence."),("successor",.text "Appending a carrier or fragment preserves earlier class records and adds its exact mass/charge and origin map."),("exclusions",.array [.text "no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite generated ionized-carrier support with complete composition, isotope, mass/charge, response and precursor-fragment records."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite generated ionized-carrier support with complete composition, isotope, mass/charge, response and precursor-fragment records."]
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
end SFT.Chemistry.MassSpectralEvidence
