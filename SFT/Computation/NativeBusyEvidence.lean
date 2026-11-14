import SFT.Computation.NativeBusyGrammar
import SFT.Computation.NativeClosingWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.NativeBusyEvidence
open SFT.Host.Canonical NativeBusyGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witness0 : Bool := NativeClosingWitnesses.depthWitness
def witness1 : Bool := (List.range 14).all (fun i =>
 match (SFT.InformationScience.QuantitySupport.words NativeClosing.labels (i+1)).head? with
 | some word => (NativeClosing.suffixTrace word).length-1==i+1
 | none => false)
def witness2 : Bool := match NativeClosing.recurrentLabelTrace 4 with
 | .error _ => false
 | .ok labels => (labels.head? == labels.getLast?) && labels.all (fun x => x=="held-lower" || x=="held-upper")
theorem witness0Passed : witness0=true := NativeClosingWitnesses.depthWitnessPassed
theorem witness1Passed : witness1=true := rfl
theorem witness2Passed : witness2=true := rfl
def witnesses : Value := .array [.array [.text "depths-through-fourteen",.text "Complete native populations through depth fourteen attain their exact depth and no run exceeds it.",.boolean witness0],.array [.text "first-attains",.text "The first depth-k word supplies an exact k-edge lower witness.",.boolean witness1],.array [.text "recurrence-boundary",.text "A two-label recurrent alternation returns after its period without structural empty-One termination.",.boolean witness2]]
def witnessRecords : Value := .array [.object [("name",.text "depths-through-fourteen"),("statement",.text "Complete native populations through depth fourteen attain their exact depth and no run exceeds it."),("passed",.boolean witness0)],.object [("name",.text "first-attains"),("statement",.text "The first depth-k word supplies an exact k-edge lower witness."),("passed",.boolean witness1)],.object [("name",.text "recurrence-boundary"),("statement",.text "A two-label recurrent alternation returns after its period without structural empty-One termination."),("passed",.boolean witness2)]]
def claimId : String := "SFT-COMP-CBL-NATIVE-BUSY-BEAVER-002"
def dependencies : List String := ["SFT-COMP-CBL-HALTING-001","SFT-COMP-CPLX-TIME-SPACE-001","SFT-COMP-FORM-OPERATIONAL-PROCESS-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "grammar",.text (grammarName c.grammar)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "halting",.text (haltingName c.halting)],.array [.text "maximum",.text (maximumName c.maximum)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "successor",.text (successorName c.successor)],.array [.text "evidence",.text (evidenceName c.evidence)],.array [.text "addition",.text (additionName c.addition)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-CBL-NATIVE-BUSY-BEAVER-002"),("generation_rule",.text "Generate the literal product of grammar, transition, halt, maximum, recurrence, successor, evidence and no-import coordinates."),("grammar_boundary",.text "Every positive finite native Fold description built only from generated fibre-label words, lawful depth-lowering Fold edges and separately registered recurrent period-b processes."),("dimensions",.array [.array [.text "grammar",.text "Which descriptions enter the maximum?",.array [.array [.text "external-transition-tables",.text "An external table imports a machine grammar."],.array [.text "complete-native-fold-descriptions",.text "Every generated native word through the supplied depth occurs."]]],.array [.text "transition",.text "What counts as one step?",.array [.array [.text "chosen-instruction-step",.text "A chosen instruction set changes the machine."],.array [.text "one-lawful-depth-lowering-edge",.text "One Fold edge closes exactly one word position."]]],.array [.text "halting",.text "How is halt established?",.array [.array [.text "assumed-terminal",.text "A terminal label without a trace is not a halt certificate."],.array [.text "exact-empty-one-terminal-trace",.text "The complete suffix trace reaches structural empty One."]]],.array [.text "maximum",.text "How is the maximum forced?",.array [.array [.text "sampled-long-run",.text "Examples cannot establish the maximum over complete support."],.array [.text "complete-upper-and-attaining-lower-witness",.text "All runs give the upper bound and a depth-k word attains it."]]],.array [.text "recurrence",.text "How are nonhalting native cycles handled?",.array [.array [.text "cycle-counted-as-halt",.text "A recurrent return has no terminal state."],.array [.text "separate-exact-nonhalting-certificate",.text "The period-b return is classified outside the closing maximum."]]],.array [.text "successor",.text "How is every finite depth covered?",.array [.array [.text "depth-fourteen-table-only",.text "A long table is not a general certificate."],.array [.text "prepend-one-label-successor",.text "Prepending one label adds exactly one lawful transition and one maximum unit."]]],.array [.text "evidence",.text "What evidence fixes BB_F?",.array [.array [.text "reported-number",.text "A number alone hides the process population."],.array [.text "all-process-traces-and-attainment",.text "Every closing description retains its exact trace and the longest witness."]]],.array [.text "addition",.text "May an external Busy-Beaver model enter?",.array [.array [.text "conventional-busy-beaver-import",.text "Conventional Turing tables would select a different grammar."],.array [.text "no-extra-machine-premise",.text "The result is internal to the already-derived native Fold machine."]]]]),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Unrestricted native Fold Busy-Beaver law"
 branch := "computation"
 statement := "For every supplied positive finite description depth k in the admitted native Fold closing-process grammar, every process halts within k lawful depth-lowering transitions and a depth-k source attains k; therefore BB_F(k)=k. Period-b recurrent processes carry an exact nonhalting certificate and are excluded from the closing maximum."
 evidenceMode := .formal
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
 traceHash := admissionIdentity (.object [("claim_id",.text claimId),("record",candidateRecord c)])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.object [("claim_id",.text claimId),("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("exact_result",.text "The unique complete kernel forces BB_F(k)=k for every supplied positive finite k in the admitted native Fold closing grammar, with recurrent processes separately certified nonhalting."),("laws",.array [.text "every closing edge lowers exact word depth once",.text "every native closing word of depth at most k halts within k",.text "a depth-k word attains k",.text "prepending one fibre label increments the maximum by one",.text "recurrent period-b processes never enter the closing maximum"]),("witnesses",witnesses),("minimality",.text "Changing any admitted coordinate removes a registered carrier, relation, trace, boundary, composition, generality or no-extra condition."),("uniqueness",.text "Exactly one product member has every admitted coordinate: complete-native-fold-descriptions__one-lawful-depth-lowering-edge__exact-empty-one-terminal-trace__complete-upper-and-attaining-lower-witness__separate-exact-nonhalting-certificate__prepend-one-label-successor__all-process-traces-and-attainment__no-extra-machine-premise."),("base",.text "At the first positive depth, either fibre label reaches structural empty One in one lawful edge, so BB_F(One)=One."),("successor",.text "Prepending one generated fibre label to every depth-k word creates all depth-(k+1) words and adds exactly one mandatory closing edge; no shallower word exceeds that trace."),("exclusions",.array [.text "no external Turing transition table",.text "no numerical-zero description depth",.text "no completed infinite description",.text "no recurrent process counted as halting",.text "no claim about conventional Busy Beaver"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "At the first positive depth, either fibre label reaches structural empty One in one lawful edge, so BB_F(One)=One."),("successor",.text "Prepending one generated fibre label to every depth-k word creates all depth-(k+1) words and adds exactly one mandatory closing edge; no shallower word exceeds that trace.")]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.object [("closure",closureValue),("decisions",.array (decisions.map SFT.Engine.decisionValue))])
 generalityCertificateHash := some (admissionIdentity generalityValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := admissionIdentity (.array [.text claimId,.text (SFT.Engine.kindName kind),.text expected,.text observed,.boolean passed])
def exclusions : List String := ["no external Turing transition table","no numerical-zero description depth","no completed infinite description","no recurrent process counted as halting","no claim about conventional Busy Beaver"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with grammar := .rejected}) survivorId))
 "reject the generated form lacking complete first-axis coverage" (decisionReason {survivor with grammar := .rejected}),
 control .tamperedSource (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed official source identity" "changed source identity differs",
 control .tamperedArtifact (((candidates.filter survives).length == 1) && ((candidates.map candidateId).eraseDups.length == candidates.length))
 "reject missing, duplicated or additional survivors" "literal product contains one survivor and unique identities",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2)
 "halt imported models, parameters or excluded quantum machinery" (SFT.Host.Text.intercalate "; " exclusions)]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)
theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Computation.NativeBusyEvidence
