import SFT.Physics.GravityGeodesicSelection
namespace SFT.Physics.GravityGeodesicBridge
open GravityGeodesic SFT.Mathematics.GeometryTopology SFT.Mathematics.DiscreteObjects

variable {Source Word Force : Type} {recurrence : Word → Word}

def events {a b : String} {initial final : Word} :
 FreePath String Source Word Force recurrence a initial b final → List String
 | .empty _ _ => [a]
 | .append prior _ _ => events prior ++ [b]

def Supported (edges : Boundary) {a b : String} {initial final : Word} :
 FreePath String Source Word Force recurrence a initial b final → Prop
 | .empty _ _ => True
 | @FreePath.append _ _ _ _ _ _ held next _ _ prior _ _ =>
   Supported edges prior ∧ ((held,next) ∈ edges ∨ (next,held) ∈ edges)

theorem completeEventCount {a b : String} {initial final : Word}
 (path : FreePath String Source Word Force recurrence a initial b final) :
 (events path).length=transitions path+1 := by
 induction path with
 | empty => rfl
 | append prior step joins ih =>
  change (events prior ++ [_]).length=(transitions prior+1)+1
  rw [SFT.Foundation.CommonRefinement.appendLength,ih]
  rfl

theorem everySupportedPathIsGenerated (edges : Boundary) {a b : String} {initial final : Word}
 (path : FreePath String Source Word Force recurrence a initial b final) :
 Supported edges path → UndirectedTrace edges a b (events path) := by
 induction path with
 | empty => intro _; exact .start
 | append prior step joins ih =>
  intro supported
  exact .step _ _ _ (ih supported.1) supported.2

theorem everyGeneratedTraceLifts (edges : Boundary) (source : String → String → Source)
 (recurrence : Word → Word) (initial : Word) (a b : String) (nodes : List String)
 (trace : UndirectedTrace edges a b nodes) :
 ∃ final, ∃ path : FreePath String Source Word Force recurrence a initial b final,
 Supported edges path ∧ events path=nodes := by
 induction trace with
 | start => exact ⟨initial,.empty a initial,True.intro,rfl⟩
 | step held next nodes trace edge ih =>
  obtain ⟨current,prior,supported,full⟩ := ih
  let step : LocalStep String Source Word Force recurrence held next :=
   ⟨⟨source held next⟩,current,recurrence current,rfl,[],rfl⟩
  refine ⟨recurrence current,.append prior step rfl,⟨supported,edge⟩,?_⟩
  change events prior ++ [next]=nodes ++ [next]
  exact congrArg (fun xs => xs ++ [next]) full

theorem selectedTraceHasCompleteFreeRealization (edges : Boundary) (source : String → String → Source)
 (recurrence : Word → Word) (initial : Word) (nodes : List String) (a b : String)
 (different : a ≠ b) (selected : List String)
 (found : GravityGeodesicSelection.select nodes edges a b=.ok (some selected)) :
 ∃ final, ∃ path : FreePath String Source Word Force recurrence a initial b final,
 Supported edges path ∧ events path=selected ∧ forces path=[] ∧
 final=recurrenceSteps recurrence (transitions path) initial := by
 obtain ⟨final,path,supported,full⟩ := everyGeneratedTraceLifts (Force:=Force) edges source recurrence initial a b selected
  (GravityGeodesicSelection.selectedPathIsGenerated nodes edges a b different selected found)
 exact ⟨final,path,supported,full,everyTransitionUnforced path,completeRecurrencePreserved path⟩

theorem selectedFreePathIsMinimal (edges : Boundary) (nodes : List String) (a b : String)
 (admitted : (has nodes a && has nodes b)=true) (different : a ≠ b)
 {initial final : Word} (path : FreePath String Source Word Force recurrence a initial b final)
 (found : GravityGeodesicSelection.select nodes edges a b=.ok (some (events path)))
 {otherFinal : Word} (other : FreePath String Source Word Force recurrence a initial b otherFinal)
 (supported : Supported edges other) : transitions path ≤ transitions other := by
 have bound := GravityGeodesicSelection.selectedPathIsShortest nodes edges a b admitted different (events path) found
  (events other) (everySupportedPathIsGenerated edges other supported)
 rw [completeEventCount,completeEventCount] at bound
 exact Nat.le_of_succ_le_succ bound
end SFT.Physics.GravityGeodesicBridge
