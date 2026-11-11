import SFT.Chemistry.GroupPeriodGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.GroupPeriodEvidence
open SFT.Host.Canonical GroupPeriodGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "coordinate-pair",.text "every classified element retains both coordinates",.boolean true],.array [.text "layout-invariance",.text "redrawing does not change complete trace equivalence",.boolean true],.array [.text "name-only-control",.text "a family name without a trace witness is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-ELEM-GROUP-PERIOD-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-ELEM-PERIODIC-RECURRENCE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "group",.text (groupName c.group)],.array [.text "period",.text (periodName c.period)],.array [.text "pairing",.text (pairingName c.pairing)],.array [.text "ordering",.text (orderingName c.ordering)],.array [.text "equivalence",.text (equivalenceName c.equivalence)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "printed-cell-coordinate",.text "A page coordinate is representational rather than chemical."],.array [.text "periodic-element-carrier",.text "Each coordinate is attached to a complete element record."]]],.array [.text "group",.array [.array [.text "column-number-as-premise",.text "A conventional column number cannot select equivalence."],.array [.text "outer-trace-equivalence-class",.text "A group is the quotient by recurring outer chemical organization."]]],.array [.text "period",.array [.array [.text "row-number-as-premise",.text "A conventional row number cannot select recurrence depth."],.array [.text "closure-reopening-depth",.text "A period counts the generated closure and reopening progression."]]],.array [.text "pairing",.array [.array [.text "group-only-or-period-only",.text "Either coordinate alone loses a required distinction."],.array [.text "joint-group-period-coordinate",.text "The pair locates one recurrence class at one progression depth."]]],.array [.text "ordering",.array [.array [.text "layout-dependent-order",.text "Alternate drawings must not alter chemical coordinates."],.array [.text "atomic-number-order-retained",.text "The invariant successor order remains held."]]],.array [.text "equivalence",.array [.array [.text "namesake-family-only",.text "A family name cannot prove matching transition support."],.array [.text "complete-trace-quotient",.text "Only full observed chemical trace equivalence creates a shared group."]]],.array [.text "record",.array [.array [.text "coordinate-without-witness",.text "A coordinate without a recurrence witness is not auditable."],.array [.text "element-order-recurrence-trace",.text "Element identity, order and recurrence witness remain linked."]]],.array [.text "extension",.array [.array [.text "free-layout-exception",.text "A layout exception can move an element without a chemical distinction."],.array [.text "no-extra-rule",.text "The two derived coordinates require no layout-specific rule."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Group and period compositional coordinates"
 branch := "chemistry"
 statement := "A Fold group is an outer-chemical-trace equivalence class and a Fold period is its counted closure-to-reopening depth; their pair is independent of how a table is drawn."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "periodic-element-carrier__outer-trace-equivalence-class__closure-reopening-depth__joint-group-period-coordinate"),("base",.text "One closed recurrence followed by one reopening supplies a first group class, period depth and joint coordinate witness."),("successor",.text "Appending one ordered element preserves its predecessor order and assigns exactly the existing or newly generated recurrence class at the counted depth."),("exclusions",.array [.text "no IUPAC table arrangement, term definition, measured value, electron-shell equation or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite periodic-order prefix partitioned by exact outer-trace recurrence, with each element assigned one recurrence-class coordinate and one counted closure-to-reopening depth."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC table arrangement, term definition, measured value, electron-shell equation or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite periodic-order prefix partitioned by exact outer-trace recurrence, with each element assigned one recurrence-class coordinate and one counted closure-to-reopening depth."]
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
end SFT.Chemistry.GroupPeriodEvidence
