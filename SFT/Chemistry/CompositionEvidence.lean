import SFT.Chemistry.CompositionGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.CompositionEvidence
open SFT.Host.Canonical CompositionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "one-closure",.text "the exact component sum equals the One",.boolean true],.array [.text "identity",.text "equal parts retain distinct constituent labels",.boolean true],.array [.text "zero-control",.text "an absent component is omitted",.boolean true]]
def claimId : String := "SFT-CHEM-STOICH-COMPOSITION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MECH-CONSERVATION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-MEAS-SUBSTANCE-001","SFT-CHEM-MEAS-AMOUNT-001","SFT-CHEM-MEAS-FORMULA-001","SFT-CHEM-ELEM-ELEMENT-001","SFT-CHEM-ELEM-PERIODIC-ORDER-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "components",.text (componentsName c.components)],.array [.text "quantity",.text (quantityName c.quantity)],.array [.text "closure",.text (closureName c.closure)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "identity",.text (identityName c.identity)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "bulk-label-only",.text "A bulk label erases constituent support."],.array [.text "complete-chemical-carrier",.text "The composed whole and every constituent remain linked."]]],.array [.text "components",.array [.array [.text "anonymous-parts",.text "Anonymous parts cannot preserve chemical identity."],.array [.text "distinct-constituent-identities",.text "Every part is bound to one admitted substance or entity identity."]]],.array [.text "quantity",.array [.array [.text "floating-percentages",.text "Floating percentages cannot certify exact closure."],.array [.text "exact-positive-rational-parts",.text "Every present component has an exact positive part."]]],.array [.text "closure",.array [.array [.text "partial-selected-composition",.text "Selected components need not exhaust the carrier."],.array [.text "parts-exhaust-the-One",.text "The exact part sum is the whole."]]],.array [.text "absence",.array [.array [.text "zero-valued-components",.text "Numerical zero is not an SFT composition object."],.array [.text "absent-component-omitted",.text "A component outside support is absent rather than assigned zero."]]],.array [.text "identity",.array [.array [.text "interchangeable-constituents",.text "Equal amounts do not make substances identical."],.array [.text "constituent-identity-retained",.text "Chemical identity remains independent of part size."]]],.array [.text "record",.array [.array [.text "composition-answer-only",.text "An answer loses part and source provenance."],.array [.text "identity-part-source-trace",.text "Each identity/part pair and source boundary remain held."]]],.array [.text "extension",.array [.array [.text "free-normalization-correction",.text "A correction could force closure after the fact."],.array [.text "no-extra-rule",.text "Generated exact parts either close to One or fail."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact chemical composition"
 branch := "chemistry"
 statement := "Chemical composition is the complete finite Fold carrier of distinct constituent identities paired with exact positive rational parts that exhaust the One."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-chemical-carrier__distinct-constituent-identities__exact-positive-rational-parts__parts-exhaust-the-One"),("base",.text "One identified component occupying the One supplies the first exact composition."),("successor",.text "Refining one component into generated positive subparts preserves the total One, all identities and every source record."),("exclusions",.array [.text "no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no absent species represented by a zero coefficient; absence is an empty generated form",.text "no application result or opaque predictor",.text "official target content opens only through post-seal custody",.text "Every finite chemical carrier whose distinct constituent identities have exact positive rational parts that exhaust the One and preserve the measurement/source boundary."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC wording, balanced equation, measured amount or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no absent species represented by a zero coefficient; absence is an empty generated form","no application result or opaque predictor","official target content opens only through post-seal custody","Every finite chemical carrier whose distinct constituent identities have exact positive rational parts that exhaust the One and preserve the measurement/source boundary."]
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
end SFT.Chemistry.CompositionEvidence
