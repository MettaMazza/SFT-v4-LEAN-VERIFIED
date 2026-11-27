import SFT.Chemistry.AdditionCarrier
import SFT.Mathematics.GraphReachability
namespace SFT.Chemistry.AdditionGraph
open SFT.Host SFT.Physics.CapabilityValues
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open AdditionCarrier
open DihedralTorsion (equalLabel)
open NucleophilicCarrier (contains)
-- Atom families are fixed by the original carrier; labels therefore identify its graph nodes.
def graph (s : State) : GeneratedGraph :=
 ⟨s.atoms.map HeldLabel.label, s.bonds.flatMap fun b => [(b.left.label,b.right.label),(b.right.label,b.left.label)]⟩
def insertBy {α : Type} (before : α → α → Bool) (a : α) : List α → List α
 | [] => [a]
 | b::bs => if before a b then a::b::bs else b::insertBy before a bs
def sortBy {α : Type} (before : α → α → Bool) : List α → List α
 | [] => []
 | a::rest => insertBy before a (sortBy before rest)
def sortLabels (xs : List HeldLabel) : List HeldLabel := sortBy (fun a b => Text.le a.label b.label) xs
def connectedComponents (s : State) : List (List HeldLabel) :=
 (sortLabels s.atoms).foldl (fun components a =>
  if components.any (fun c => contains c a) then components
  else components ++ [sortLabels (s.atoms.filter fun b => reachable (graph s) a.label b.label)]) []
-- Reuse the proved finite worklist order. Distances accompany the actual FIFO;
-- there is no search-depth limit or extra acceptance condition.
def distanceBody (edges : List Edge) (target : String) (s : SearchState edges)
 (recur : (next : SearchState edges) → (searchOrder edges).rel next s → List Nat → Option Nat)
 (distances : List Nat) : Option Nat :=
 match queue : s.frontier with
 | [] => none
 | held::rest =>
  let d := distances.headD 0
  if seen : has s.visited held = true then
   recur (skipState edges s held rest queue) (skipDecreases edges s held rest queue) distances.tail
  else if Text.equal held target then some d
  else recur (expandState edges s held rest queue) (expandDecreases edges s held rest queue seen)
   (distances.tail ++ List.replicate (outgoingUnvisited edges held (s.visited ++ [held])).length (d+1))
def distanceLoop (edges : List Edge) (target : String) : SearchState edges → List Nat → Option Nat :=
 (searchOrder edges).wf.fix (distanceBody edges target)
theorem distanceLoopEquation (edges : List Edge) (target : String) (s : SearchState edges) :
 distanceLoop edges target s = distanceBody edges target s (fun next _ => distanceLoop edges target next) := by
 unfold distanceLoop
 rw [WellFounded.fix_eq]
inductive Separation where
 | emptyOne
 | count (value : PositiveCount)
 | otherEmptyOne (identity : String)
def shortestDistance (s : State) (left right : HeldLabel) : Except String Separation := do
 if equalLabel left right then return .emptyOne
 match distanceLoop (graph s).edges right.label (initialSearch (graph s).edges left.label) [0] with
 | none => throw "addition sites must belong to one retained source carrier"
 | some n => return .count (← count n)
structure SiteClass where
 sourceComponentOrdinal : PositiveCount
 label : HeldLabel
 separation : Separation
def siteClass (ordinal : PositiveCount) (label : HeldLabel) (separation : Separation) : Except String SiteClass := do
 if !Text.equal label.family "addition-site-class" || !(["same-site","adjacent-sites","non-adjacent-sites"].any (Text.equal label.label)) then
  throw "addition site class lies outside the complete generated family"
 if Text.equal label.label "same-site" then
  match separation with
  | .emptyOne => pure ()
  | .count _ | .otherEmptyOne _ => throw "same-site separation must be structural EmptyOne"
 if Text.equal label.label "adjacent-sites" then
  match separation with
  | .count n => if n.value != 1 then throw "adjacent-site separation must be one retained incidence"
  | .emptyOne | .otherEmptyOne _ => throw "adjacent-site separation must be one retained incidence"
 if Text.equal label.label "non-adjacent-sites" then
  match separation with
  | .count n => if n.value < 2 then throw "non-adjacent sites require a positive path beyond one incidence"
  | .emptyOne | .otherEmptyOne _ => throw "non-adjacent sites require a positive path beyond one incidence"
 return ⟨ordinal,label,separation⟩
end SFT.Chemistry.AdditionGraph
