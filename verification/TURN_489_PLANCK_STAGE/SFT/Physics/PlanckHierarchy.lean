import SFT.Physics.AlphaRatio
import SFT.Physics.LeptonTake
namespace SFT.Physics.PlanckHierarchy
open SFT.Foundation.ExactOperations
open AlphaCovers AlphaBlocks AlphaRatio GeneratorOperations FoldFirstReturn
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000

def upperCoverDepth : Except String Nat := do
 let c ← generatorPeriod
 let volume ← positivePower (.integer (.ofNat c)) (.integer (.ofNat (c+1)))
 minimalBinaryCover (.integer (.ofNat volume))

theorem forcedUpperDepth : upperCoverDepth = .ok 7 := by
 unfold upperCoverDepth
 rw [generatorPeriodThree]
 rfl

def massiveStateCount : Except String Nat := do
 let b ← binaryCount
 let depth ← upperCoverDepth
 let support ← positivePower (.integer (.ofNat b)) (.integer (.ofNat depth))
 positivePredecessor (.integer (.ofNat support))

theorem massivePositions : massiveStateCount = .ok 127 := by
 unfold massiveStateCount
 rw [binaryCountTwo,forcedUpperDepth]
 rfl

def squaredHierarchy : Except String Nat := do
 let b ← binaryCount
 let count ← massiveStateCount
 positivePower (.integer (.ofNat b)) (.integer (.ofNat count))

theorem squaredHierarchyExact : squaredHierarchy = .ok (2^127) := by
 unfold squaredHierarchy
 rw [binaryCountTwo,massivePositions]
 exact positivePowerValue 1 126

theorem leastCompleteCover : 81 ≤ 2^7 ∧ ∀ k, 0 < k → k < 7 → 2^k < 81 := upMinimal

theorem massivePredecessorUnique : positivePredecessor (.integer 128) = .ok 127 ∧
 ∀ earlier, earlier < 127 → earlier+1 ≠ 128 :=
 firstPredecessorWitness 128 127 (by decide) rfl

def terminalAlpha : Except String PositiveFraction := do
 let inverse ← inverseFineStructure none
 let value := AlphaRatio.reciprocal inverse
 if value.numerator < value.denominator then .ok value
 else .error "terminal alpha must be a strict positive part of the One"

theorem terminalAlphaExact : terminalAlpha.map (fun a => (a.numerator,a.denominator)) =
 .ok (3676744786,503846395469) := rfl

/-- Source colour coupling b/c, retained as a typed positive share. -/
def colourShare : Except String PositiveFraction :=
 match hb : fineStructureBlocks with
 | .error e => .error e
 | .ok b =>
  have same : b = ⟨2,3,5,7,128,9,250⟩ := Except.ok.inj (hb.symm.trans forcedBlocks)
  .ok (normalizePositive b.binary b.generator
    (by rw [same]; decide) (by rw [same]; decide))

def terminalTransport : Except String PositiveFraction := do
 let colour ← colourShare
 let alpha ← terminalAlpha
 let removed := BoundaryGrowth.multiply colour alpha
 match SFT.Physics.LeptonTake.positiveTake (BoundaryGrowth.asFraction AlphaRatio.one)
   (BoundaryGrowth.asFraction removed) with
 | .error _ => .error "charged-colour transport must retain a strict positive part"
 | .ok retained =>
  if retained.numerator < retained.denominator then .ok retained
  else .error "charged-colour transport must retain a strict positive part"

def terminalSquaredHierarchy : Except String PositiveFraction :=
 match hh : squaredHierarchy with
 | .error e => .error e
 | .ok h =>
  have hp : 0 < h := by
   have same := Except.ok.inj (hh.symm.trans squaredHierarchyExact)
   rw [same]
   exact Nat.pow_pos (by decide)
  do
   let transport ← terminalTransport
   .ok (BoundaryGrowth.multiply (AlphaRatio.whole h hp) transport)

theorem exactTerminalHierarchy : terminalSquaredHierarchy.map (fun p => (p.numerator,p.denominator)) =
 .ok (255923934603817488008405160690199418432572494970880,1511539186407) := rfl

def pair (p : PositiveFraction) := (p.numerator,p.denominator)

theorem terminalTransportStrict (p : PositiveFraction) (h : terminalTransport = .ok p) :
 p.numerator < p.denominator := by
 unfold terminalTransport at h
 cases hc : colourShare with
 | error e => rw [hc] at h; cases h
 | ok c =>
  rw [hc] at h
  cases ha : terminalAlpha with
  | error e => rw [ha] at h; cases h
  | ok a =>
   rw [ha] at h
   change (match LeptonTake.positiveTake (BoundaryGrowth.asFraction AlphaRatio.one)
      (BoundaryGrowth.asFraction (BoundaryGrowth.multiply c a)) with
    | .error _ => Except.error "charged-colour transport must retain a strict positive part"
    | .ok retained => if retained.numerator < retained.denominator then Except.ok retained
      else Except.error "charged-colour transport must retain a strict positive part") = Except.ok p at h
   split at h
   next e he => cases h
   next retained hr =>
    split at h
    next positive => cases h; exact positive
    next nonpositive => cases h
def unsquaredExponent : Except String PositiveFraction :=
 match hc : massiveStateCount with
 | .error e => .error e
 | .ok count =>
  have cp : 0 < count := by
   have same := Except.ok.inj (hc.symm.trans massivePositions)
   rw [same]; decide
  .ok (normalizePositive count 2 cp (by decide))

theorem retainedUnsquaredExponent : unsquaredExponent.map pair = .ok (127,2) := rfl
end SFT.Physics.PlanckHierarchy
