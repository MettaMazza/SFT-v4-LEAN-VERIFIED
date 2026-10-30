import SFT.Physics.ElectroweakTerminalDomain
import SFT.Mathematics.DiscreteComplement
namespace SFT.Physics.ElectroweakChannels
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000

def positions : Nat → List Nat
 | 0 => []
 | n+1 => positions n ++ [n+1]

theorem positionsCount (n : Nat) : (positions n).length=n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change (positions n ++ [n+1]).length=n+1
  rw [appendLength,ih]
  rfl

theorem positionBound (n x : Nat) (h : x ∈ positions n) : 0<x ∧ x≤n := by
 induction n with
 | zero => cases h
 | succ n ih =>
  cases memAppendCases x (positions n) [n+1] h with
  | inl h => exact ⟨(ih h).1,Nat.le_trans (ih h).2 (Nat.le_succ _)⟩
  | inr h => cases h with
    | head => exact ⟨Nat.zero_lt_succ _,Nat.le_refl _⟩
    | tail _ h => cases h

theorem allPositions (n x : Nat) (positive : 0<x) (bound : x≤n) : x ∈ positions n := by
 induction n with
 | zero => exact False.elim (Nat.not_lt_of_ge bound positive)
 | succ n ih =>
  cases Nat.eq_or_lt_of_le bound with
  | inl eq => cases eq; exact memAppendRight _ _ _ (List.Mem.head _)
  | inr lt => exact memAppendLeft _ _ _ (ih (Nat.le_of_lt_succ lt))

theorem positionsUnique (n : Nat) : distinct (positions n)=true := by
 induction n with
 | zero => rfl
 | succ n ih =>
  apply freshAppendDistinct _ _ ih
  apply (absentIff _ _).mpr
  intro h
  exact Nat.not_succ_le_self n (positionBound n (n+1) h).2

def product {α β : Type} (xs : List α) (ys : List β) : List (α × β) :=
 xs.flatMap fun x => ys.map fun y => (x,y)

theorem productCount {α β : Type} (xs : List α) (ys : List β) :
 (product xs ys).length=xs.length*ys.length := by
 induction xs with
 | nil => exact (Nat.zero_mul _).symm
 | cons x xs ih =>
  change ((ys.map fun y => (x,y)) ++ product xs ys).length=(xs.length+1)*ys.length
  rw [appendLength,mapLength,ih,Nat.succ_mul,Nat.add_comm]

theorem productMember {α β : Type} (xs : List α) (ys : List β) (x : α) (y : β) :
 (x,y) ∈ product xs ys ↔ x ∈ xs ∧ y ∈ ys := by
 constructor
 · intro h
   obtain ⟨a,ha,hm⟩ := memFlatMapOrigin _ _ _ h
   obtain ⟨b,hb,eq⟩ := memMapPreimage _ _ _ hm
   have hx := congrArg Prod.fst eq
   have hy := congrArg Prod.snd eq
   cases hx; cases hy
   exact ⟨ha,hb⟩
 · intro h
   exact memFlatMap _ _ x _ h.1 (memMap _ y _ h.2)

theorem productUnique {α β : Type} [DecidableEq α] [DecidableEq β]
 (xs : List α) (ys : List β) (hx : distinct xs=true) (hy : distinct ys=true) :
 distinct (product xs ys)=true := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  have parts := (distinctCons x xs).mp hx
  apply appendDistinct
  · exact mapDistinct (fun y => (x,y)) (fun a b eq => congrArg Prod.snd eq) ys hy
  · exact ih parts.2
  · intro pair first other
    obtain ⟨y,_,eq⟩ := memMapPreimage _ _ _ first
    cases eq
    exact (absentIff xs x).mp parts.1 ((productMember xs ys x y).mp other).1

def charged := product (positions 15) (positions 15)
def neutral := product (positions 4) (product (positions 14) (positions 14))

theorem chargedCount : charged.length=225 := by
 unfold charged
 rw [productCount,positionsCount]

theorem neutralCount : neutral.length=784 := by
 unfold neutral
 rw [productCount,productCount,positionsCount,positionsCount]

theorem chargedUnique : distinct charged=true := productUnique _ _ (positionsUnique 15) (positionsUnique 15)
theorem neutralUnique : distinct neutral=true := productUnique _ _ (positionsUnique 4)
 (productUnique _ _ (positionsUnique 14) (positionsUnique 14))

theorem sourceChannelCounts : ElectroweakTerminalSupport.channelCounts=.ok (charged.length,neutral.length) := by
 rw [chargedCount,neutralCount,ElectroweakTerminalSupport.channelCountsExact]

#print axioms positions
#print axioms positionsCount
#print axioms positionBound
#print axioms allPositions
#print axioms positionsUnique
#print axioms product
#print axioms productCount
#print axioms productMember
#print axioms productUnique
#print axioms charged
#print axioms neutral
#print axioms chargedCount
#print axioms neutralCount
#print axioms chargedUnique
#print axioms neutralUnique
#print axioms sourceChannelCounts
end SFT.Physics.ElectroweakChannels
