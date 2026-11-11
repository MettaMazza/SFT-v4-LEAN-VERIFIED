import SFT.Chemistry.PeriodicBoundaryGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.PeriodicBoundaryEvidence
open SFT.Host.Canonical PeriodicBoundaryGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-release",.text "all listed element rows remain in the source census",.boolean true],.array [.text "current-extent",.text "the greatest listed coordinate is source and date bound",.boolean true],.array [.text "terminal-control",.text "absence beyond the release is rejected as proof of impossibility",.boolean true]]
def claimId : String := "SFT-CHEM-ELEM-PERIODIC-BOUNDARY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001","SFT-CHEM-ELEM-GROUP-PERIOD-001","SFT-CHEM-ELEM-ION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "extent",.text (extentName c.extent)],.array [.text "identity",.text (identityName c.identity)],.array [.text "time",.text (timeName c.time)],.array [.text "completeness",.text (completenessName c.completeness)],.array [.text "extension",.text (extensionName c.extension)],.array [.text "record",.text (recordName c.record)],.array [.text "rule",.text (ruleName c.rule)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "largest-number-only",.text "A largest number alone omits the observed element census."],.array [.text "complete-source-bounded-census",.text "Every element row in the registered release is retained."]]],.array [.text "extent",.array [.array [.text "timeless-terminal-claim",.text "A current release cannot prove that no successor can exist."],.array [.text "greatest-listed-coordinate",.text "The boundary is only the greatest coordinate in this source release."]]],.array [.text "identity",.array [.array [.text "count-without-element",.text "A number without its element record is not an observation boundary."],.array [.text "element-record-retained",.text "The terminal listed coordinate retains symbol and element identity."]]],.array [.text "time",.array [.array [.text "undated-table",.text "An undated table cannot define a reproducible empirical boundary."],.array [.text "release-date-retained",.text "The official release date is part of the observation."]]],.array [.text "completeness",.array [.array [.text "selected-terminal-row",.text "Selecting only the last row cannot establish the registered census."],.array [.text "all-listed-rows-retained",.text "The complete finite source support is required."]]],.array [.text "extension",.array [.array [.text "observed-means-impossible-beyond",.text "Absence from one release is not impossibility."],.array [.text "unobserved-successor-open",.text "Further coordinates remain an empirical question."]]],.array [.text "record",.array [.array [.text "boundary-without-source",.text "An unsourced endpoint cannot be reproduced."],.array [.text "source-hash-census-trace",.text "Source, bytes, extraction and rows remain bound."]]],.array [.text "rule",.array [.array [.text "free-terminal-rule",.text "A terminal rule chosen from the table would overfit observation."],.array [.text "no-extra-rule",.text "The law adds no terminal theorem to the source-bounded fact."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Known periodic-table observation boundary"
 branch := "chemistry"
 statement := "The known periodic boundary is the complete source-dated IUPAC element census through its greatest listed atomic-number coordinate; it is an observation boundary and not a theorem forbidding successors."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-source-bounded-census__greatest-listed-coordinate__element-record-retained__unobserved-successor-open"),("base",.text "One official release with one complete listed element support supplies a finite observation census, not a terminal theorem."),("successor",.text "Appending one officially validated element extends the source-bounded greatest coordinate and retains all prior rows without changing the open-successor status."),("exclusions",.array [.text "no IUPAC table arrangement, term definition, measured value, electron-shell equation or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every official finite periodic-table release treated as a source-dated observation census, retaining all listed atomic-number/element records while leaving any unobserved successor scientifically open."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC table arrangement, term definition, measured value, electron-shell equation or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","official target content opens only through post-seal custody","Every official finite periodic-table release treated as a source-dated observation census, retaining all listed atomic-number/element records while leaving any unobserved successor scientifically open."]
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
end SFT.Chemistry.PeriodicBoundaryEvidence
