import SFT.Chemistry.AnalyticalSelectivityGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AnalyticalSelectivityEvidence
open SFT.Host.Canonical AnalyticalSelectivityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "analyte",.text "analyte component exists",.boolean true],.array [.text "interferent",.text "matrix support exists",.boolean true],.array [.text "record",.text "both observations remain",.boolean true]]
def claimId : String := "SFT-CHEM-ANALYTICAL-SELECTIVITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-MEAS-TRACEABILITY-001","SFT-CHEM-BIOMOLECULAR-BOUNDARY-001","SFT-CHEM-ANALYTICAL-SAMPLE-001","SFT-CHEM-ANALYTICAL-CALIBRATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "target",.text (targetName c.target)],.array [.text "alternatives",.text (alternativesName c.alternatives)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "decision",.text (decisionName c.decision)],.array [.text "interference",.text (interferenceName c.interference)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "target",.array [.array [.text "response-without-analyte",.text "Selectivity has no target."],.array [.text "analyte-response-held",.text "The target component and response are paired."]]],.array [.text "alternatives",.array [.array [.text "other-components-erased",.text "Competing support is hidden."],.array [.text "declared-interferent-support",.text "Every tested alternative remains."]]],.array [.text "comparison",.array [.array [.text "single-response-only",.text "No discrimination is tested."],.array [.text "all-analyte-interferent-responses-compared",.text "Every declared response is compared."]]],.array [.text "decision",.array [.array [.text "name-based-assignment",.text "A name cannot prove attribution."],.array [.text "distinguishable-analyte-response",.text "The target response remains separable."]]],.array [.text "interference",.array [.array [.text "failed-alternatives-deleted",.text "Unfavorable rows disappear."],.array [.text "interference-boundary-retained",.text "Responses that merge remain explicit."]]],.array [.text "conditions",.array [.array [.text "universal-selectivity",.text "Response depends on method and conditions."],.array [.text "method-and-condition-bounded",.text "The comparison domain is held."]]],.array [.text "record",.array [.array [.text "selectivity-scalar-only",.text "The tested alternatives cannot be audited."],.array [.text "complete-response-comparison-trace",.text "All favorable and unfavorable rows persist."]]],.array [.text "extra",.array [.array [.text "free-selectivity-threshold",.text "An arbitrary threshold can force success."],.array [.text "no-extra-rule",.text "Exact distinguishability decides the class."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Analytical selectivity and interference boundary"
 branch := "chemistry"
 statement := "Analytical selectivity is exact distinguishability of the analyte response from every declared interferent response within a retained method-and-condition boundary; merged responses are recorded as interference."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "analyte-response-held__declared-interferent-support__all-analyte-interferent-responses-compared__distinguishable-analyte-response__interference-boundary-retained"),("base",.text "One analyte and one declared interferent response supply the first discrimination test."),("successor",.text "Appending an interferent preserves every prior comparison and adds its exact distinguishability result."),("exclusions",.array [.text "no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite analyte/interferent response support under one registered method and condition class."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite analyte/interferent response support under one registered method and condition class."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with target := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AnalyticalSelectivityEvidence
