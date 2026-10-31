import SFT.Physics.CosmoDistance
import SFT.InformationScience.ClassicalResolution
import SFT.Mathematics.DynamicsTraces
namespace SFT.Physics.CosmoStructureGrowth
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.GeometryTopology
open SFT.InformationScience.ClassicalSupport SFT.InformationScience.ClassicalResolution

structure DensityNetwork where
 graph : SFT.Mathematics.GraphOperations.GeneratedGraph
 generated : SFT.Mathematics.GraphOperations.makeGraph graph.nodes graph.edges=.ok graph
 densities : List (String × SFT.Foundation.ExactOperations.PositiveFraction)
 completeDensitySupport : densities.map Prod.fst=graph.nodes

-- Labels identify complete finite network states. A registered map is the
-- held local interaction/expansion transition relation, not a random draw.
structure Evolution where
 states : List String
 network : String → DensityNetwork
 transition : Observation
 admitted : validatePushforward states transition=.ok transition
 gravityRecords : Observation
 expansionRecords : Observation
 gravityComplete : gravityRecords.map Prod.fst=transition.map Prod.fst
 expansionComplete : expansionRecords.map Prod.fst=transition.map Prod.fst

inductive History (system : Evolution) : String → Nat → String → Type where
 | start (initial : String) : History system initial 0 initial
 | append {initial before : String} {n : Nat} (prior : History system initial n before)
   (after : String) (step : image system.transition before=some after) : History system initial (Nat.succ n) after

variable {system : Evolution} {initial final : String} {n : Nat}

def states {initial : String} : {n : Nat} → {final : String} → History system initial n final → List String
 | _,_,.start .(initial) => [initial]
 | _,_,.append prior after _ => states prior ++ [after]
termination_by structural _ _ history => history

theorem sameStepUnique (system : Evolution) (before left right : String)
 (a : image system.transition before=some left) (b : image system.transition before=some right) : left=right :=
 Option.some.inj (a.symm.trans b)

theorem allRegisteredStatesHaveSuccessor (system : Evolution) (state : String) (member : state ∈ system.states) :
 ∃ next, image system.transition state=some next := by
 have mapping := (pushforwardMeaning _ _ _).mp system.admitted
 exact admittedImage system.states system.transition ((SFT.InformationScience.MutualObservation.mapMeaning _ _).mp mapping.2.1).2 state member

private theorem appendOneLength (xs : List String) (x : String) :
 (xs ++ [x]).length = Nat.succ xs.length := by
 induction xs with
 | nil => rfl
 | cons a rest ih => exact congrArg Nat.succ ih

theorem completeHistoryLength (history : History system initial n final) : (states history).length=n+1 := by
 induction history with
 | start => rfl
 | append prior after step ih =>
  change (states prior ++ [after]).length=_
  exact (appendOneLength (states prior) after).trans (congrArg Nat.succ ih)

private theorem deterministicAtEqualLength {first : String} (left : History system initial n first) :
 ∀ {m : Nat} {second : String} (right : History system initial m second),
 n=m → first=second ∧ states left=states right := by
 induction left with
 | start =>
  intro m second right
  cases right with
  | start => intro _; exact ⟨rfl,rfl⟩
  | append prior after step => intro h; exact False.elim (Nat.noConfusion h)
 | append prior after step ih =>
  intro m second right
  cases right with
  | start => intro h; exact False.elim (Nat.noConfusion h)
  | append other otherAfter otherStep =>
   intro h
   obtain ⟨same,records⟩ := ih other (Nat.succ.inj h)
   have last : after=second := Option.some.inj
    (step.symm.trans ((congrArg (image system.transition) same).trans otherStep))
   exact ⟨last,(congrArg (fun xs => xs ++ [after]) records).trans (congrArg (fun x => states other ++ [x]) last)⟩

theorem finiteHistoryDeterministic {first second : String} (left : History system initial n first)
 (right : History system initial n second) : first=second ∧ states left=states right :=
 deterministicAtEqualLength left right rfl

def traceRecords {initial : String} : {n : Nat} → {final : String} → History system initial n final → List (String × String)
 | _,_,.start .(initial) => []
 | _,_,@History.append _ _ before _ prior after _ => traceRecords prior ++ [(before,after)]
termination_by structural _ _ history => history

theorem allSourcesRemainInDensitySupport (network : DensityNetwork) :
 network.densities.map Prod.fst=network.graph.nodes := network.completeDensitySupport

def unresolvedHistory (support : List String) (observation : Observation) := deterministicRealization support observation

theorem unresolvedWeightsRetainTheirMembers (row : SFT.InformationScience.ClassicalLedger.ProbabilityRow) :
 (realizationRow row).observedLabel=row.observedLabel ∧
 (realizationRow row).exactSupportPart=row.exactSupportPart ∧
 (realizationRow row).members.map Prod.fst=row.microstates := realizationProvenance row

-- Bind the existing finite construction to STRUCTURE_GROWTH's retained
-- initial/network/interaction/expansion statement without a new evolution law.
theorem sourceStatement {first second : String}
 (a : History system initial n first) (b : History system initial n second) :
 first=second ∧ states a=states b ∧ (states a).length=n+1 ∧
 (system.network initial).densities.map Prod.fst=(system.network initial).graph.nodes ∧
 system.gravityRecords.map Prod.fst=system.transition.map Prod.fst ∧
 system.expansionRecords.map Prod.fst=system.transition.map Prod.fst :=
 ⟨(finiteHistoryDeterministic a b).1,(finiteHistoryDeterministic a b).2,
 completeHistoryLength a,(system.network initial).completeDensitySupport,
 system.gravityComplete,system.expansionComplete⟩

theorem sourceBase (system : Evolution) (initial : String) :
 states (History.start (system:=system) initial)=[initial] := rfl

theorem sourceSuccessor (prior : History system initial n final) (after : String)
 (step : image system.transition final=some after) :
 states (History.append prior after step)=states prior ++ [after] ∧
 traceRecords (History.append prior after step)=traceRecords prior ++ [(final,after)] := ⟨rfl,rfl⟩

end SFT.Physics.CosmoStructureGrowth
