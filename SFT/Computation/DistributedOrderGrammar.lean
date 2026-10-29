import SFT.Computation.DistributedOrderWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.DistributedOrderGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Processes where
  | rejected | admitted

def processesName : Processes → String
  | .rejected => "anonymous-or-partial-processes"
  | .admitted => "complete-held-process-identities"

inductive Events where
  | rejected | admitted

def eventsName : Events → String
  | .rejected => "unrecorded-events"
  | .admitted => "complete-local-event-ledgers"

inductive Causality where
  | rejected | admitted

def causalityName : Causality → String
  | .rejected => "assumed-global-order"
  | .admitted => "exact-partial-causal-order"

inductive Communication where
  | rejected | admitted

def communicationName : Communication → String
  | .rejected => "implicit-shared-state"
  | .admitted => "source-bound-message-records"

inductive Faults where
  | rejected | admitted

def faultsName : Faults → String
  | .rejected => "unspecified-faults"
  | .admitted => "declared-fault-support"

inductive Knowledge where
  | rejected | admitted

def knowledgeName : Knowledge → String
  | .rejected => "omniscient-process"
  | .admitted => "observation-relative-local-knowledge"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "one-schedule"
  | .admitted => "schedule-successor-certificate"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "hidden-coordinator-or-clock"
  | .admitted => "no-extra-global-oracle"

structure Candidate where
  processes : Processes
  events : Events
  causality : Causality
  communication : Communication
  faults : Faults
  knowledge : Knowledge
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [processesName c.processes, eventsName c.events, causalityName c.causality, communicationName c.communication, faultsName c.faults, knowledgeName c.knowledge, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "processes=" (processesName c.processes), SFT.Host.Text.append "events=" (eventsName c.events), SFT.Host.Text.append "causality=" (causalityName c.causality), SFT.Host.Text.append "communication=" (communicationName c.communication), SFT.Host.Text.append "faults=" (faultsName c.faults), SFT.Host.Text.append "knowledge=" (knowledgeName c.knowledge), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-held-process-identities__complete-local-event-ledgers__exact-partial-causal-order__source-bound-message-records__declared-fault-support__observation-relative-local-knowledge__schedule-successor-certificate__no-extra-global-oracle"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (processesName c.processes) "complete-held-process-identities" &&
  SFT.Host.Text.equal (eventsName c.events) "complete-local-event-ledgers" &&
  SFT.Host.Text.equal (causalityName c.causality) "exact-partial-causal-order" &&
  SFT.Host.Text.equal (communicationName c.communication) "source-bound-message-records" &&
  SFT.Host.Text.equal (faultsName c.faults) "declared-fault-support" &&
  SFT.Host.Text.equal (knowledgeName c.knowledge) "observation-relative-local-knowledge" &&
  SFT.Host.Text.equal (generalityName c.generality) "schedule-successor-certificate" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-global-oracle"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (processesName c.processes) "complete-held-process-identities") then "anonymous-or-partial-processes removes a required exact processes condition." else
  if !(SFT.Host.Text.equal (eventsName c.events) "complete-local-event-ledgers") then "unrecorded-events removes a required exact events condition." else
  if !(SFT.Host.Text.equal (causalityName c.causality) "exact-partial-causal-order") then "assumed-global-order removes a required exact causality condition." else
  if !(SFT.Host.Text.equal (communicationName c.communication) "source-bound-message-records") then "implicit-shared-state removes a required exact communication condition." else
  if !(SFT.Host.Text.equal (faultsName c.faults) "declared-fault-support") then "unspecified-faults removes a required exact faults condition." else
  if !(SFT.Host.Text.equal (knowledgeName c.knowledge) "observation-relative-local-knowledge") then "omniscient-process removes a required exact knowledge condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "schedule-successor-certificate") then "one-schedule removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-global-oracle") then "hidden-coordinator-or-clock removes a required exact addition condition." else
  "The forced causal event ordering kernel retains event carrier; reflexive identity ledger; antisymmetric strict precedence; transitive closure; incomparable pairs; linear-extension support; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Concurrent and Distributed Computation structural axes for causal event ordering."
def grammarBoundary : String := "All generated finite causal event ordering structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. A total global order is not assumed where events are incomparable."

def candidates : List Candidate :=
  ([Processes.rejected,Processes.admitted]).flatMap fun processes =>
  ([Events.rejected,Events.admitted]).flatMap fun events =>
  ([Causality.rejected,Causality.admitted]).flatMap fun causality =>
  ([Communication.rejected,Communication.admitted]).flatMap fun communication =>
  ([Faults.rejected,Faults.admitted]).flatMap fun faults =>
  ([Knowledge.rejected,Knowledge.admitted]).flatMap fun knowledge =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨processes,events,causality,communication,faults,knowledge,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk processes events causality communication faults knowledge generality addition =>
    have hprocesses : processes ∈ [Processes.rejected,Processes.admitted] := by
      cases processes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevents : events ∈ [Events.rejected,Events.admitted] := by
      cases events <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcausality : causality ∈ [Causality.rejected,Causality.admitted] := by
      cases causality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcommunication : communication ∈ [Communication.rejected,Communication.admitted] := by
      cases communication <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfaults : faults ∈ [Faults.rejected,Faults.admitted] := by
      cases faults <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hknowledge : knowledge ∈ [Knowledge.rejected,Knowledge.admitted] := by
      cases knowledge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ processes _ hprocesses
    apply CommonRefinement.memFlatMap _ _ events _ hevents
    apply CommonRefinement.memFlatMap _ _ causality _ hcausality
    apply CommonRefinement.memFlatMap _ _ communication _ hcommunication
    apply CommonRefinement.memFlatMap _ _ faults _ hfaults
    apply CommonRefinement.memFlatMap _ _ knowledge _ hknowledge
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk processes events causality communication faults knowledge generality addition =>
    cases processes <;> cases events <;> cases causality <;> cases communication <;> cases faults <;> cases knowledge <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk processes events causality communication faults knowledge generality addition =>
    cases processes <;> cases events <;> cases causality <;> cases communication <;> cases faults <;> cases knowledge <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.processes = .admitted ∧ c.events = .admitted ∧ c.causality = .admitted ∧ c.communication = .admitted ∧ c.faults = .admitted ∧ c.knowledge = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk processes events causality communication faults knowledge generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem processes_rejected_rejected (c : Candidate) (h : c.processes = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.processes eq
    rw [h] at field
    cases field

theorem events_rejected_rejected (c : Candidate) (h : c.events = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.events eq
    rw [h] at field
    cases field

theorem causality_rejected_rejected (c : Candidate) (h : c.causality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.causality eq
    rw [h] at field
    cases field

theorem communication_rejected_rejected (c : Candidate) (h : c.communication = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.communication eq
    rw [h] at field
    cases field

theorem faults_rejected_rejected (c : Candidate) (h : c.faults = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.faults eq
    rw [h] at field
    cases field

theorem knowledge_rejected_rejected (c : Candidate) (h : c.knowledge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.knowledge eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Computation.DistributedOrderGrammar
