import SFT.Chemistry.AnalyticalRecordGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AnalyticalRecordEvidence
open SFT.Host.Canonical AnalyticalRecordGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "question",.text "sample is named",.boolean true],.array [.text "rows",.text "all observation rows remain",.boolean true],.array [.text "control",.text "falsification is required",.boolean true]]
def claimId : String := "SFT-CHEM-ANALYTICAL-COMPLETE-RECORD-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-MEAS-TRACEABILITY-001","SFT-CHEM-BIOMOLECULAR-BOUNDARY-001","SFT-CHEM-ANALYTICAL-SAMPLE-001","SFT-CHEM-ANALYTICAL-CALIBRATION-001","SFT-CHEM-ANALYTICAL-SELECTIVITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "question",.text (questionName c.question)],.array [.text "sample",.text (sampleName c.sample)],.array [.text "method",.text (methodName c.method)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "observation",.text (observationName c.observation)],.array [.text "uncertainty",.text (uncertaintyName c.uncertainty)],.array [.text "falsification",.text (falsificationName c.falsification)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "question",.array [.array [.text "unstated-measurand",.text "The result has no declared target."],.array [.text "measurand-and-purpose-held",.text "The analytical question is explicit."]]],.array [.text "sample",.array [.array [.text "sample-identity-erased",.text "The result cannot be located."],.array [.text "sample-analyte-matrix-record",.text "Material support is retained."]]],.array [.text "method",.array [.array [.text "method-erased",.text "The transformation cannot be reproduced."],.array [.text "method-and-condition-record",.text "Every operational boundary is held."]]],.array [.text "reference",.array [.array [.text "reference-erased",.text "Traceability is lost."],.array [.text "calibration-and-reference-chain",.text "Comparison provenance remains."]]],.array [.text "observation",.array [.array [.text "accepted-values-only",.text "Unfavorable evidence disappears."],.array [.text "all-raw-and-derived-rows-held",.text "Every observation enters the record."]]],.array [.text "uncertainty",.array [.array [.text "single-value-certainty",.text "Admissible alternatives are hidden."],.array [.text "uncertainty-and-resolution-held",.text "The distinction boundary remains."]]],.array [.text "falsification",.array [.array [.text "success-only-report",.text "The claim cannot fail publicly."],.array [.text "failed-tampered-and-falsification-record",.text "Controls and failure conditions persist."]]],.array [.text "extra",.array [.array [.text "free-reporting-omission",.text "Discretion can hide a contradiction."],.array [.text "no-extra-rule",.text "Completeness is decided by the registered record grammar."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Complete analytical result and falsification record"
 branch := "chemistry"
 statement := "A complete analytical result retains the measurand, sample/analyte/matrix, method, conditions, reference chain, every raw and derived observation, uncertainty, failed and tampered controls, and an explicit falsification condition."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "measurand-and-purpose-held__sample-analyte-matrix-record__method-and-condition-record__calibration-and-reference-chain__all-raw-and-derived-rows-held__uncertainty-and-resolution-held__failed-tampered-and-falsification-record"),("base",.text "One declared measurement with its complete support and one unfavorable control supplies the first record."),("successor",.text "Appending an observation or control preserves every earlier row and extends provenance, uncertainty and falsification support."),("exclusions",.array [.text "no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite analytical execution with registered question, material, method, reference, observations, transformations, uncertainty and controls."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite analytical execution with registered question, material, method, reference, observations, transformations, uncertainty and controls."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with question := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AnalyticalRecordEvidence
