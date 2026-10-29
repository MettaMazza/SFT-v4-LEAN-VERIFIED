import SFT.Physics.AlphaCovers
import SFT.Foundation.FoldUniformCheck
import SFT.Foundation.PartSelection
namespace SFT.Physics.ElectroweakMixing
open SFT.Foundation ExactPartCarrier ExactOperations FoldDynamics FoldUniformCheck
open AlphaCovers GeneratorOperations
set_option maxRecDepth 20000

def enumerateTo (support : Nat) : (count : Nat) → count ≤ support → List Part
 | 0,_ => []
 | n+1,bound => enumerateTo support n (Nat.le_trans (Nat.le_succ _) bound) ++
   [normalizePart (n+1) support (Nat.zero_lt_succ _) bound]

def supportParts (support : Nat) : List Part := enumerateTo support support (Nat.le_refl _)

theorem appendLength {α : Type} (xs ys : List α) : (xs++ys).length = xs.length+ys.length := by
 induction xs with
 | nil => exact (Nat.zero_add _).symm
 | cons x xs ih =>
   change (xs++ys).length+1 = (xs.length+1)+ys.length
   rw [ih,Nat.add_right_comm]

theorem enumerationCount (support count : Nat) (bound : count ≤ support) :
 (enumerateTo support count bound).length = count := by
 induction count with
 | zero => rfl
 | succ n ih =>
   change (enumerateTo support n _ ++ [_]).length = n+1
   rw [appendLength,ih]
   rfl

def returning (image : Part) (parts : List Part) : List Part :=
 parts.filter (fun p => samePart (foldPart p) image)

theorem returningIff (image part : Part) (parts : List Part) :
 part ∈ returning image parts ↔ part ∈ parts ∧ foldPart part = image := by
 unfold returning
 induction parts with
 | nil =>
   constructor
   · intro h; cases h
   · intro h; cases h.1
 | cons head tail ih =>
   cases tested : samePart (foldPart head) image with
   | false =>
     rw [List.filter_cons_of_neg (p := fun p => samePart (foldPart p) image) (by rw [tested]; intro h; cases h)]
     constructor
     · intro h; have p := ih.mp h; exact ⟨List.Mem.tail _ p.1,p.2⟩
     · intro h
       cases h.1 with
       | head =>
         have yes := (samePartIff _ _).mpr h.2
         rw [tested] at yes
         cases yes
       | tail _ held => exact ih.mpr ⟨held,h.2⟩
   | true =>
     rw [List.filter_cons_of_pos (p := fun p => samePart (foldPart p) image) tested]
     constructor
     · intro h
       cases h with
       | head => exact ⟨List.Mem.head _,(samePartIff _ _).mp tested⟩
       | tail _ held => have p := ih.mp held; exact ⟨List.Mem.tail _ p.1,p.2⟩
     · intro h
       cases h.1 with
       | head => exact List.Mem.head _
       | tail _ held => exact List.Mem.tail _ (ih.mpr ⟨held,h.2⟩)

def validDepth : CountInput → Bool
 | .integer n => decide (0 < n)
 | .boolean b => b

def foldPreimages (image : Rat) (depth : CountInput) : Except String (List Part) :=
 match admitFraction image with
 | none => .error "ValueError: preimage enumeration requires an exact Fold part and positive depth"
 | some image =>
   if validDepth depth then do
     let binary ← binaryCount
     let support ← positivePower (.integer (.ofNat binary)) depth
     .ok (returning image (supportParts support))
   else .error "ValueError: preimage enumeration requires an exact Fold part and positive depth"

def halfOne : Except String Part := do
 let binary ← binaryCount
 fromPair 1 (.ofNat binary)

def halfOnePreimages : Except String (List Part) := do
 let image ← halfOne
 let binary ← binaryCount
 let preimages ← foldPreimages (asFraction image) (.integer (.ofNat binary))
 if preimages.length == binary then .ok preimages
 else .error "ValueError: the half-One fibre did not close with two preimages"

structure Mixing where
 unified : Part
 sinSquared : Part
 cosSquared : Part

def mixing : Except String Mixing := do
 let preimages ← halfOnePreimages
 match preimages with
 | [] => .error "ValueError: not enough values to unpack (expected 2, got 0)"
 | lower::rest => match rest with
   | [] => .error "ValueError: not enough values to unpack (expected 2, got 1)"
   | upper::rest => match rest with
     | _::_ => .error "ValueError: too many values to unpack (expected 2)"
     | [] =>
       let sum := sumParts lower upper
       if sum.numerator == sum.denominator then do
         let unified ← halfOne
         .ok ⟨unified,lower,upper⟩
       else .error "ValueError: the two Fold preimages did not partition the One"

def quarter : Part := normalizePart 1 4 (by decide) (by decide)
def threeQuarters : Part := normalizePart 3 4 (by decide) (by decide)

theorem nativeHalf : halfOne = .ok HalfOneDerivation.halfOne := by
 unfold halfOne
 rw [binaryCountTwo]
 rfl

theorem completeDepthTwo : supportParts 4 = [quarter,HalfOneDerivation.halfOne,threeQuarters,ExactOperations.one] := rfl

theorem nativeFibre : halfOnePreimages = .ok [quarter,threeQuarters] := by
 unfold halfOnePreimages
 rw [nativeHalf,binaryCountTwo]
 rfl

theorem quarterReturn : foldPart quarter = HalfOneDerivation.halfOne := by apply partEquality <;> rfl

theorem threeQuarterReturn : foldPart threeQuarters = HalfOneDerivation.halfOne := by apply partEquality <;> rfl

theorem partitionOne : (sumParts quarter threeQuarters).numerator = (sumParts quarter threeQuarters).denominator := rfl

theorem distinctChannels : quarter ≠ threeQuarters := by
 intro same
 have impossible : (1 : Nat) = 3 := congrArg Part.numerator same
 exact Nat.noConfusion (Nat.succ.inj impossible)

theorem completeFibre : returning HalfOneDerivation.halfOne (supportParts 4) = [quarter,threeQuarters] := rfl

theorem noOtherDepthTwoPreimage (p : Part) (member : p ∈ supportParts 4)
 (returns : foldPart p = HalfOneDerivation.halfOne) : p = quarter ∨ p = threeQuarters := by
 have held := (returningIff HalfOneDerivation.halfOne p (supportParts 4)).mpr ⟨member,returns⟩
 rw [completeFibre] at held
 cases held with
 | head => exact Or.inl rfl
 | tail _ held => cases held with
   | head => exact Or.inr rfl
   | tail _ impossible => cases impossible

theorem nativeMixing : mixing = .ok ⟨HalfOneDerivation.halfOne,quarter,threeQuarters⟩ := by
 unfold mixing
 rw [nativeFibre]
 rfl

theorem zeroDepthRejected (image : Rat) : foldPreimages image (.integer 0) =
 .error "ValueError: preimage enumeration requires an exact Fold part and positive depth" := by
 unfold foldPreimages
 cases admitFraction image <;> rfl

theorem trueDepthRejected : foldPreimages (asFraction HalfOneDerivation.halfOne) (.boolean true) =
 .error "ValueError: positive power requires positive exact counts" := by
 unfold foldPreimages
 change (do
   let binary ← binaryCount
   let support ← positivePower (.integer (.ofNat binary)) (.boolean true)
   Except.ok (returning HalfOneDerivation.halfOne (supportParts support))) = _
 rw [binaryCountTwo]
 rfl

end SFT.Physics.ElectroweakMixing
