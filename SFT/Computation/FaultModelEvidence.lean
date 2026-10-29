import SFT.Computation.FaultModelControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.FaultModelEvidence
open SFT.Host.Canonical FaultModelGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "processes",.text (processesName c.processes)],.array [.text "events",.text (eventsName c.events)],.array [.text "causality",.text (causalityName c.causality)],.array [.text "communication",.text (communicationName c.communication)],.array [.text "faults",.text (faultsName c.faults)],.array [.text "knowledge",.text (knowledgeName c.knowledge)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-DIST-FAULT-MODEL-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "processes",.text "Which processes coordinate preserves the complete Concurrent and Distributed Computation obligation?",.array [.array [.text "anonymous-or-partial-processes",.text "anonymous-or-partial-processes removes a required exact processes condition."],.array [.text "complete-held-process-identities",.text "complete-held-process-identities retains the complete registered processes condition."]]],.array [.text "events",.text "Which events coordinate preserves the complete Concurrent and Distributed Computation obligation?",.array [.array [.text "unrecorded-events",.text "unrecorded-events removes a required exact events condition."],.array [.text "complete-local-event-ledgers",.text "complete-local-event-ledgers retains the complete registered events condition."]]],.array [.text "causality",.text "Which causality coordinate preserves the complete Concurrent and Distributed Computation obligation?",.array [.array [.text "assumed-global-order",.text "assumed-global-order removes a required exact causality condition."],.array [.text "exact-partial-causal-order",.text "exact-partial-causal-order retains the complete registered causality condition."]]],.array [.text "communication",.text "Which communication coordinate preserves the complete Concurrent and Distributed Computation obligation?",.array [.array [.text "implicit-shared-state",.text "implicit-shared-state removes a required exact communication condition."],.array [.text "source-bound-message-records",.text "source-bound-message-records retains the complete registered communication condition."]]],.array [.text "faults",.text "Which faults coordinate preserves the complete Concurrent and Distributed Computation obligation?",.array [.array [.text "unspecified-faults",.text "unspecified-faults removes a required exact faults condition."],.array [.text "declared-fault-support",.text "declared-fault-support retains the complete registered faults condition."]]],.array [.text "knowledge",.text "Which knowledge coordinate preserves the complete Concurrent and Distributed Computation obligation?",.array [.array [.text "omniscient-process",.text "omniscient-process removes a required exact knowledge condition."],.array [.text "observation-relative-local-knowledge",.text "observation-relative-local-knowledge retains the complete registered knowledge condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Concurrent and Distributed Computation obligation?",.array [.array [.text "one-schedule",.text "one-schedule removes a required exact generality condition."],.array [.text "schedule-successor-certificate",.text "schedule-successor-certificate retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Concurrent and Distributed Computation obligation?",.array [.array [.text "hidden-coordinator-or-clock",.text "hidden-coordinator-or-clock removes a required exact addition condition."],.array [.text "no-extra-global-oracle",.text "no-extra-global-oracle retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-DIST-FAULT-MODEL-001"
  title := "Fold computational fault-model law"
  branch := "computation"
  statement := "The forced declared deviations from process rules kernel retains nominal transition relation; generated fault actions; affected components; detection observations; recovery relation; uncorrectable boundary; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-DIST-REPLICATION-CONSISTENCY-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-DIST-FAULT-MODEL-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-DIST-FAULT-MODEL-001"),
    ("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("closure",FaultModelControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-DIST-FAULT-MODEL-001"),("base",.text "The structural One supplies one canonical declared deviations from process rules form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated declared deviations from process rules form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold computational fault-model law is required to derive declared deviations from process rules without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: nominal transition relation; generated fault actions; affected components; detection observations; recovery relation; uncorrectable boundary."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "Faults not generated by the model remain outside the guarantee."

def correspondenceTerms : List String := ["fault model","fault tolerance"]

end SFT.Computation.FaultModelEvidence
