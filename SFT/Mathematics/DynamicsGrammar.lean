import SFT.Mathematics.DynamicsWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.DynamicsGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive States where
  | rejected | admitted

def statesName : States → String
  | .rejected => "partial-or-aliased-state"
  | .admitted => "complete-canonical-states"

inductive Transitions where
  | rejected | admitted

def transitionsName : Transitions → String
  | .rejected => "opaque-update-rule"
  | .admitted => "held-state-relation"

inductive Trajectory where
  | rejected | admitted

def trajectoryName : Trajectory → String
  | .rejected => "endpoint-only"
  | .admitted => "complete-transition-trace"

inductive Time where
  | rejected | admitted

def timeName : Time → String
  | .rejected => "continuous-clock-parameter"
  | .admitted => "positive-transition-count"

inductive Fixed where
  | rejected | admitted

def fixedName : Fixed → String
  | .rejected => "visual-sameness"
  | .admitted => "retained-identity-transition"

inductive Return where
  | rejected | admitted

def returnsName : Return → String
  | .rejected => "periodic-assertion"
  | .admitted => "explicit-first-return-trace"

inductive Basin where
  | rejected | admitted

def basinName : Basin → String
  | .rejected => "sampled-neighborhood"
  | .admitted => "complete-reachability-selection"

inductive Reversibility where
  | rejected | admitted

def reversibilityName : Reversibility → String
  | .rejected => "infer-unrecorded-predecessor"
  | .admitted => "retained-predecessor-record"

inductive Stability where
  | rejected | admitted

def stabilityName : Stability → String
  | .rejected => "epsilon-parameter"
  | .admitted => "registered-perturbation-closure"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-force-or-random-law"
  | .admitted => "no-extra-dynamic-law"

structure Candidate where
  states : States
  transitions : Transitions
  trajectory : Trajectory
  time : Time
  fixed : Fixed
  returns : Return
  basin : Basin
  reversibility : Reversibility
  stability : Stability
  addition : Addition

def sourceFields (c : Candidate) : List String := [statesName c.states, transitionsName c.transitions, trajectoryName c.trajectory, timeName c.time, fixedName c.fixed, returnsName c.returns, basinName c.basin, reversibilityName c.reversibility, stabilityName c.stability, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "states=" (statesName c.states), SFT.Host.Text.append "transitions=" (transitionsName c.transitions), SFT.Host.Text.append "trajectory=" (trajectoryName c.trajectory), SFT.Host.Text.append "time=" (timeName c.time), SFT.Host.Text.append "fixed=" (fixedName c.fixed), SFT.Host.Text.append "return=" (returnsName c.returns), SFT.Host.Text.append "basin=" (basinName c.basin), SFT.Host.Text.append "reversibility=" (reversibilityName c.reversibility), SFT.Host.Text.append "stability=" (stabilityName c.stability), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-states__held-state-relation__complete-transition-trace__positive-transition-count__retained-identity-transition__explicit-first-return-trace__complete-reachability-selection__retained-predecessor-record__registered-perturbation-closure__no-extra-dynamic-law"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (statesName c.states) "complete-canonical-states" &&
  SFT.Host.Text.equal (transitionsName c.transitions) "held-state-relation" &&
  SFT.Host.Text.equal (trajectoryName c.trajectory) "complete-transition-trace" &&
  SFT.Host.Text.equal (timeName c.time) "positive-transition-count" &&
  SFT.Host.Text.equal (fixedName c.fixed) "retained-identity-transition" &&
  SFT.Host.Text.equal (returnsName c.returns) "explicit-first-return-trace" &&
  SFT.Host.Text.equal (basinName c.basin) "complete-reachability-selection" &&
  SFT.Host.Text.equal (reversibilityName c.reversibility) "retained-predecessor-record" &&
  SFT.Host.Text.equal (stabilityName c.stability) "registered-perturbation-closure" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-dynamic-law"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (statesName c.states) "complete-canonical-states") then "Omitted or aliased states change possible evolution." else
  if !(SFT.Host.Text.equal (transitionsName c.transitions) "held-state-relation") then "An opaque update hides which relation cells exist." else
  if !(SFT.Host.Text.equal (trajectoryName c.trajectory) "complete-transition-trace") then "Endpoints erase intervening states and cannot prove reachability." else
  if !(SFT.Host.Text.equal (timeName c.time) "positive-transition-count") then "A free real clock imports scale and continuum." else
  if !(SFT.Host.Text.equal (fixedName c.fixed) "retained-identity-transition") then "Presentation similarity does not prove dynamical identity." else
  if !(SFT.Host.Text.equal (returnsName c.returns) "explicit-first-return-trace") then "A period name without a trace omits return structure." else
  if !(SFT.Host.Text.equal (basinName c.basin) "complete-reachability-selection") then "Sampling cannot establish reachability for the registered perturbation class." else
  if !(SFT.Host.Text.equal (reversibilityName c.reversibility) "retained-predecessor-record") then "A merged image does not identify which predecessor occurred." else
  if !(SFT.Host.Text.equal (stabilityName c.stability) "registered-perturbation-closure") then "A chosen epsilon imports a free scale." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-dynamic-law") then "An added force, differential equation or random update is not supplied by the state relation." else
  "The dynamical kernel is complete canonical states, held transitions, complete trajectories, transition-count time, witnessed fixed/return/basin structure, retained-record reversibility and registered perturbation stability."

def generationRule : String := "Generate the complete product of state coverage, transition provenance, trajectory trace, time, fixed forms, return, basin/recurrence, reversibility, stability and extra-dynamic status."
def grammarBoundary : String := "All finite dynamics generated from canonical state carriers, held transition relations, complete paths, return traces, reachability basins, retained predecessor records and registered finite perturbation classes."

def candidates : List Candidate :=
  ([States.rejected,States.admitted]).flatMap fun states =>
  ([Transitions.rejected,Transitions.admitted]).flatMap fun transitions =>
  ([Trajectory.rejected,Trajectory.admitted]).flatMap fun trajectory =>
  ([Time.rejected,Time.admitted]).flatMap fun time =>
  ([Fixed.rejected,Fixed.admitted]).flatMap fun fixed =>
  ([Return.rejected,Return.admitted]).flatMap fun returns =>
  ([Basin.rejected,Basin.admitted]).flatMap fun basin =>
  ([Reversibility.rejected,Reversibility.admitted]).flatMap fun reversibility =>
  ([Stability.rejected,Stability.admitted]).flatMap fun stability =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨states,transitions,trajectory,time,fixed,returns,basin,reversibility,stability,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk states transitions trajectory time fixed returns basin reversibility stability addition =>
    have hstates : states ∈ [States.rejected,States.admitted] := by
      cases states <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransitions : transitions ∈ [Transitions.rejected,Transitions.admitted] := by
      cases transitions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrajectory : trajectory ∈ [Trajectory.rejected,Trajectory.admitted] := by
      cases trajectory <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htime : time ∈ [Time.rejected,Time.admitted] := by
      cases time <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfixed : fixed ∈ [Fixed.rejected,Fixed.admitted] := by
      cases fixed <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturns : returns ∈ [Return.rejected,Return.admitted] := by
      cases returns <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbasin : basin ∈ [Basin.rejected,Basin.admitted] := by
      cases basin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreversibility : reversibility ∈ [Reversibility.rejected,Reversibility.admitted] := by
      cases reversibility <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstability : stability ∈ [Stability.rejected,Stability.admitted] := by
      cases stability <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ states _ hstates
    apply CommonRefinement.memFlatMap _ _ transitions _ htransitions
    apply CommonRefinement.memFlatMap _ _ trajectory _ htrajectory
    apply CommonRefinement.memFlatMap _ _ time _ htime
    apply CommonRefinement.memFlatMap _ _ fixed _ hfixed
    apply CommonRefinement.memFlatMap _ _ returns _ hreturns
    apply CommonRefinement.memFlatMap _ _ basin _ hbasin
    apply CommonRefinement.memFlatMap _ _ reversibility _ hreversibility
    apply CommonRefinement.memFlatMap _ _ stability _ hstability
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk states transitions trajectory time fixed returns basin reversibility stability addition =>
    cases states <;> cases transitions <;> cases trajectory <;> cases time <;> cases fixed <;> cases returns <;> cases basin <;> cases reversibility <;> cases stability <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk states transitions trajectory time fixed returns basin reversibility stability addition =>
    cases states <;> cases transitions <;> cases trajectory <;> cases time <;> cases fixed <;> cases returns <;> cases basin <;> cases reversibility <;> cases stability <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.states = .admitted ∧ c.transitions = .admitted ∧ c.trajectory = .admitted ∧ c.time = .admitted ∧ c.fixed = .admitted ∧ c.returns = .admitted ∧ c.basin = .admitted ∧ c.reversibility = .admitted ∧ c.stability = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk states transitions trajectory time fixed returns basin reversibility stability addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem states_rejected_rejected (c : Candidate) (h : c.states = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.states eq
    rw [h] at field
    cases field

theorem transitions_rejected_rejected (c : Candidate) (h : c.transitions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transitions eq
    rw [h] at field
    cases field

theorem trajectory_rejected_rejected (c : Candidate) (h : c.trajectory = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trajectory eq
    rw [h] at field
    cases field

theorem time_rejected_rejected (c : Candidate) (h : c.time = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.time eq
    rw [h] at field
    cases field

theorem fixed_rejected_rejected (c : Candidate) (h : c.fixed = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fixed eq
    rw [h] at field
    cases field

theorem returns_rejected_rejected (c : Candidate) (h : c.returns = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.returns eq
    rw [h] at field
    cases field

theorem basin_rejected_rejected (c : Candidate) (h : c.basin = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.basin eq
    rw [h] at field
    cases field

theorem reversibility_rejected_rejected (c : Candidate) (h : c.reversibility = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reversibility eq
    rw [h] at field
    cases field

theorem stability_rejected_rejected (c : Candidate) (h : c.stability = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.stability eq
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

end SFT.Mathematics.DynamicsGrammar
