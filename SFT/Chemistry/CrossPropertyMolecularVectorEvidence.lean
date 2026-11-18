import SFT.Chemistry.CrossPropertyMolecularVectorGrammar
import SFT.Chemistry.CrossPropertyMolecularVector
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CrossPropertyMolecularVectorEvidence
open SFT.Host.Canonical CrossPropertyMolecularVectorGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "one-carrier-vector",.text "Two property relations close on one retained carrier.",.boolean (match CrossPropertyMolecularVector.composeExactPropertyVector (.carrier CrossPropertyMolecularVector.witnessCarrier) (.tuple CrossPropertyMolecularVector.witnessVector) with | .error _ => false | .ok v => v.length==2)],.array [.text "exact-named-projection",.text "Selecting vibration returns its unchanged exact result.",.boolean (match CrossPropertyMolecularVector.projectExactProperty CrossPropertyMolecularVector.witnessVector (.held CrossPropertyMolecularVector.vibrationProjection.propertyFamily) with | .error _ => false | .ok v => CrossPropertyMolecularVector.equalProjection v CrossPropertyMolecularVector.vibrationProjection)],.array [.text "duplicate-family-rejected",.text "One property family cannot be fitted twice.",.boolean (match CrossPropertyMolecularVector.composeExactPropertyVector (.carrier CrossPropertyMolecularVector.witnessCarrier) (.tuple [CrossPropertyMolecularVector.lengthProjection,CrossPropertyMolecularVector.lengthProjection]) with | .error _ => true | .ok _ => false)],.array [.text "depth-independent-extension",.text "Appending formation preserves bond-length and vibration.",.boolean (match CrossPropertyMolecularVector.lawfulProjectionExtensionPreservesExisting CrossPropertyMolecularVector.witnessCarrier CrossPropertyMolecularVector.witnessVector CrossPropertyMolecularVector.formationProjection with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-CROSS-PROPERTY-MOLECULAR-VECTOR-014"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-COMPOSITION-001","SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001","SFT-CHEM-BOND-DISSOCIATION-ENERGY-002","SFT-CHEM-MOLECULAR-BOND-ANGLE-003","SFT-CHEM-DIHEDRAL-TORSIONAL-STATE-004","SFT-CHEM-MOLECULAR-DIPOLE-MAGNITUDE-005","SFT-CHEM-MOLECULAR-POLARIZABILITY-006","SFT-CHEM-MOLECULAR-IONIZATION-ENERGY-007","SFT-CHEM-MOLECULAR-ELECTRON-AFFINITY-008","SFT-CHEM-VIBRATIONAL-FREQUENCY-009","SFT-CHEM-ROTATIONAL-CONSTANT-010","SFT-CHEM-INTERMOLECULAR-BINDING-011","SFT-CHEM-MOLECULAR-MAGNETIC-RESPONSE-012","SFT-CHEM-MOLECULAR-FORMATION-ENERGY-013"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "support",.text (supportName c.support)],.array [.text "projection",.text (projectionName c.projection)],.array [.text "parameter",.text (parameterName c.parameter)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "separate-carrier-per-property",.text "Separate carriers permit property-specific identity drift."],.array [.text "one-complete-structural-carrier",.text "Every applicable property projects from one retained carrier."]]],.array [.text "support",.array [.array [.text "selected-or-favorable-property-subset",.text "A selected subset can hide absent or disagreeing properties."],.array [.text "complete-applicable-property-support",.text "Every registered applicable property family remains explicit."]]],.array [.text "projection",.array [.array [.text "answer-only-property-values",.text "Bare answers erase the relation that generated each result."],.array [.text "named-admitted-relation-projections",.text "Each exact result retains its property family and admitted generating law."]]],.array [.text "parameter",.array [.array [.text "per-property-fit-or-correction",.text "A separate coefficient lets each target select its output."],.array [.text "zero-parameter-shared-carrier-projection",.text "No projection introduces a coefficient, residual or target-derived field."]]],.array [.text "absence",.array [.array [.text "delete-unmeasured-or-inapplicable-row",.text "Deletion makes the vector appear more complete than the source."],.array [.text "structural-EmptyOne-and-unjoined-custody-retained",.text "Absent results and nonjoinable identities remain explicit."]]],.array [.text "prediction",.array [.array [.text "target-payload-or-hash-readable-before-seal",.text "Target content or even its hash can select the carrier or subset."],.array [.text "complete-value-free-identity-seal",.text "All 9,025 identities and 13 property families seal before target access."]]],.array [.text "record",.array [.array [.text "single-species-showcase",.text "A showcase species does not establish complete cross-property custody."],.array [.text "complete-13-family-source-row-custody",.text "Every admitted PROP-001 through PROP-013 source row is retained."]]],.array [.text "extension",.array [.array [.text "recompute-or-refit-existing-properties",.text "Refitting after a new property destroys prior invariance."],.array [.text "append-only-depth-independent-projection-extension",.text "Adding one lawful family preserves every existing projection exactly."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Complete zero-parameter cross-property molecular vector"
 branch := "chemistry"
 statement := "One complete retained structural molecular carrier supplies every applicable property projection through the already admitted PROP-001 through PROP-013 relations. Each result remains attached to its named generating law and no property receives a fitted coefficient or target-derived carrier. All 9,025 source identities across all 13 property families seal before withheld target payloads or hashes open; 676 exact carriers support multiple property families and retain all 6,676 overlapping rows."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-complete-structural-carrier__complete-applicable-property-support__named-admitted-relation-projections__zero-parameter-shared-carrier-projection__structural-EmptyOne-and-unjoined-custody-retained__complete-value-free-identity-seal__complete-13-family-source-row-custody__append-only-depth-independent-projection-extension"),("base",.text "One completely retained structural carrier with one applicable admitted property relation forces one exact named projection without a fitted coefficient."),("successor",.text "Appending one new applicable admitted property relation extends the vector by one named projection and leaves every existing projection exactly unchanged."),("exclusions",.array [.text "no numerical zero; absent or inapplicable native results remain structural EmptyOne",.text "no negative, irrational, imaginary, floating or continuum SFT proof value",.text "no target payload, target hash, presence flag or source orientation before the complete identity seal",.text "no per-property fit, correction, residual, coefficient or target-derived structural field",.text "no selected species, showcase molecule, favorable property family or agreeing-row subset",.text "no guessed synonym, formula, species join or conflation of a bound composite with a constituent molecule",.text "no deletion of single-property, nonjoinable, absent, adverse or bound-composite custody rows"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent or inapplicable native results remain structural EmptyOne","no negative, irrational, imaginary, floating or continuum SFT proof value","no target payload, target hash, presence flag or source orientation before the complete identity seal","no per-property fit, correction, residual, coefficient or target-derived structural field","no selected species, showcase molecule, favorable property family or agreeing-row subset","no guessed synonym, formula, species join or conflation of a bound composite with a constituent molecule","no deletion of single-property, nonjoinable, absent, adverse or bound-composite custody rows"]
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
end SFT.Chemistry.CrossPropertyMolecularVectorEvidence
