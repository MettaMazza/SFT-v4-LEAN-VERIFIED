import SFT.Chemistry.ConformerIdentity
import SFT.Chemistry.ConformerReachSet
namespace SFT.Chemistry.ConformerIdentityValues
open SFT.Physics.CapabilityValues ConformerCarrier ConformerReachSet
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

private theorem rangeNext (n : Nat) : List.range (n+1)=List.range n++[n] := by
 have loop (k : Nat) (xs ys : List Nat) : List.range.loop k (xs++ys)=List.range.loop k xs++ys := by
  induction k generalizing xs with
  | zero => rfl
  | succ k ih => exact ih (k::xs)
 exact loop n [] [n]

private theorem rangeLength (n : Nat) : (List.range n).length=n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  rw [rangeNext,appendLength,ih]
  rfl

private theorem mapAppend (f : Nat → PositiveCount) (xs ys : List Nat) :
 (xs++ys).map f=xs.map f++ys.map f := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (f x)) ih

private theorem rangeMemberBound (size index : Nat) (member : index∈List.range size) : index<size := by
 induction size with
 | zero => cases member
 | succ size ih =>
  rw [rangeNext] at member
  cases memAppendCases index (List.range size) [size] member with
  | inl h => exact Nat.lt_trans (ih h) (Nat.lt_succ_self size)
  | inr h =>
   cases h with
   | head => exact Nat.lt_succ_self index
   | tail _ h => cases h

theorem positionWithinSupport (size : Nat) (position : PositiveCount)
 (member : position∈positions size) : position.value≤size := by
 obtain ⟨index,held,equal⟩ := memMapPreimage (fun i => (⟨i+1,Nat.zero_lt_succ i⟩ : PositiveCount)) position (List.range size) member
 cases equal
 exact Nat.succ_le_of_lt (rangeMemberBound size index held)

private theorem appendFresh (xs : List PositiveCount) (x : PositiveCount)
 (unique : xs.Nodup) (fresh : x∉xs) : (xs++[x]).Nodup := by
 induction unique with
 | nil => exact List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
 | @cons first rest separated unique ih =>
  refine List.Pairwise.cons ?_ (ih (fun h => fresh (List.Mem.tail first h)))
  intro y member
  cases memAppendCases y rest [x] member with
  | inl h => exact separated y h
  | inr h =>
   cases h with
   | head => intro equal; cases equal; exact fresh (List.Mem.head rest)
   | tail _ h => cases h

theorem positionsUnique (size : Nat) : (positions size).Nodup := by
 induction size with
 | zero => exact List.Pairwise.nil
 | succ size ih =>
  have next : positions (size+1)=positions size++[⟨size+1,Nat.zero_lt_succ size⟩] := by
   unfold positions
   rw [rangeNext,mapAppend]
   rfl
  rw [next]
  apply appendFresh _ _ ih
  intro held
  have impossible := positionWithinSupport size ⟨size+1,Nat.zero_lt_succ size⟩ held
  exact Nat.not_succ_le_self size impossible

theorem positionsLength (size : Nat) : (positions size).length=size := by
 unfold positions
 rw [mapLength,rangeLength]

theorem identityActionAccepted (size : Nat) : action (positions size)=.ok ⟨positions size⟩ := by
 have coverage : (positions size).all (containsPosition (positions size))=true := by
  have allInside (xs : List PositiveCount) (inside : ∀ x, x∈xs → x∈positions size) :
   xs.all (containsPosition (positions size))=true := by
   induction xs with
   | nil => rfl
   | cons x xs ih =>
    have first := (positionMembership _ x).mpr (inside x (List.Mem.head xs))
    have tail := ih (fun y member => inside y (List.Mem.tail x member))
    change containsPosition (positions size) x && xs.all (containsPosition (positions size))=true
    rw [first,tail]
    rfl
  exact allInside _ (fun _ h => h)
 have notDifferent : (size != size)=false := by
  have reflexive : ∀ k : Nat, (k==k)=true := by
   intro k
   induction k with
   | zero => rfl
   | succ k ih => exact ih
  change (!(size==size))=false
  rw [reflexive]
  rfl
 unfold action
 rw [uniquePositionsOfUnique _ (positionsUnique size),positionsLength,notDifferent,coverage]
 rfl

theorem countRetainsPosition (position : PositiveCount) : count position.value=.ok position := by
 unfold count
 rw [dif_pos position.positive]

theorem reconstructPositions (positions : List PositiveCount) :
 (positions.map PositiveCount.value).mapM count=.ok positions := by
 have loop (pending acc : List PositiveCount) :
  List.mapM.loop (m:=Except String) count (pending.map PositiveCount.value) acc=
   .ok (List.reverseAux acc pending) := by
  induction pending generalizing acc with
  | nil => rfl
  | cons position rest ih =>
   change (do
    let x ← count position.value
    List.mapM.loop (m:=Except String) count (rest.map PositiveCount.value) (x::acc)) =
     .ok (List.reverseAux acc (position::rest))
   rw [countRetainsPosition position]
   exact ih (position::acc)
 exact loop positions []

theorem identityCandidateConstructed (size : Nat) :
 (do
  let values ← ((positions size).map PositiveCount.value).mapM count
  action values) = .ok ⟨positions size⟩ := by
 rw [reconstructPositions]
 exact identityActionAccepted size
end SFT.Chemistry.ConformerIdentityValues
