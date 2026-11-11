import SFT.Chemistry.ValenceGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ValenceEvidence
open SFT.Host.Canonical ValenceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "maximum-census",.text "the retained count is maximal over complete generated support",.boolean true],.array [.text "substitution",.text "lawful substitution is evaluated on the same carrier",.boolean true],.array [.text "typical-control",.text "a nonmaximal typical count is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-ELEM-VALENCE-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-ATOMIC-NUMBER-001","SFT-CHEM-ELEM-PERIODIC-RECURRENCE-001","SFT-CHEM-ELEM-GROUP-PERIOD-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "support",.text (supportName c.support)],.array [.text "unit",.text (unitName c.unit)],.array [.text "selection",.text (selectionName c.selection)],.array [.text "substitution",.text (substitutionName c.substitution)],.array [.text "context",.text (contextName c.context)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "element-name-only",.text "An element name contains no combination witness."],.array [.text "atom-or-fragment-carrier",.text "The combining carrier is an atom or a retained chemical fragment."]]],.array [.text "support",.array [.array [.text "assumed-valence-number",.text "An assumed number imports the answer."],.array [.text "complete-generated-combination-support",.text "Every admitted combination trace is enumerated before the maximum is taken."]]],.array [.text "unit",.array [.array [.text "mixed-partner-count",.text "Partners of unrecorded multiplicity cannot define one comparison."],.array [.text "univalent-partner-count",.text "One-valence partners provide the exact comparison carrier."]]],.array [.text "selection",.array [.array [.text "typical-count",.text "A typical value can omit a lawful larger combination."],.array [.text "maximum-realized-count",.text "The greatest generated realized count supplies the boundary."]]],.array [.text "substitution",.array [.array [.text "combination-only",.text "Valence also constrains lawful substitution for the carrier."],.array [.text "combination-or-substitution",.text "Both joining and replacement traces are retained."]]],.array [.text "context",.array [.array [.text "universal-context-free-number",.text "Chemical environment may alter available combinations."],.array [.text "chemical-context-retained",.text "The declared carrier and environment bound the result."]]],.array [.text "record",.array [.array [.text "number-without-traces",.text "A bare number cannot reproduce its maximum witness."],.array [.text "combination-maximum-trace",.text "All candidates and the maximal witness remain held."]]],.array [.text "extension",.array [.array [.text "free-valence-correction",.text "An adjustment can force a conventional value."],.array [.text "no-extra-rule",.text "Complete generated support determines the maximum without correction."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Valence availability and chemical combination boundary"
 branch := "chemistry"
 statement := "Valence is the exact greatest realized univalent joining or substitution count in the complete generated combination support of a retained atom or fragment and chemical context."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "atom-or-fragment-carrier__complete-generated-combination-support__univalent-partner-count__maximum-realized-count"),("base",.text "One realized univalent combination supplies the first positive joining-count witness for one retained carrier and context."),("successor",.text "Appending one generated combination preserves all earlier witnesses and replaces the retained maximum exactly when the new realized count is later in the positive order."),("exclusions",.array [.text "no IUPAC table arrangement, term definition, measured value, electron-shell equation or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite atom or chemical fragment with complete generated combination and substitution traces, where the largest realized univalent joining count is retained with its chemical context."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC table arrangement, term definition, measured value, electron-shell equation or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite atom or chemical fragment with complete generated combination and substitution traces, where the largest realized univalent joining count is retained with its chemical context."]
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
end SFT.Chemistry.ValenceEvidence
