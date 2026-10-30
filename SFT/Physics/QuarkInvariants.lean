import SFT.Physics.AlphaRatio
namespace SFT.Physics.QuarkInvariants
open SFT.Foundation.ExactOperations
open AlphaRatio AlphaBlocks AlphaCovers FoldFirstReturn
set_option maxRecDepth 20000

structure Channels where
 upPairSum : PositiveFraction
 downPairSum : PositiveFraction
 upDepth : Nat
 downDepth : Nat

def channelInvariants : Except String Channels :=
 match hb : fineStructureBlocks with
 | .error e => .error e
 | .ok blocks =>
  have be : blocks = ⟨2,3,5,7,128,9,250⟩ := Except.ok.inj (hb.symm.trans forcedBlocks)
  let b := blocks.binary
  let c := blocks.generator
  have upPositive : 0 < b*(c+c) := by dsimp [b,c]; rw [be]; decide
  have downPositive : 0 < b*(c+1) := by dsimp [b,c]; rw [be]; decide
  have bp : 0 < b := by dsimp [b]; rw [be]; decide
  have cp : 0 < c := by dsimp [c]; rw [be]; decide
  let lowerHand := normalizePositive 1 (b*b) (by decide) (Nat.mul_pos bp bp)
  let up := normalizePositive 1 (b*(c+c)) (by decide) upPositive
  let down := normalizePositive 1 (b*(c+1)) (by decide) downPositive
  let upStructural := BoundaryGrowth.multiply lowerHand (normalizePositive 1 c (by decide) cp)
  let downStructural := BoundaryGrowth.multiply lowerHand (normalizePositive 1 b (by decide) bp)
  if up.numerator*upStructural.denominator != upStructural.numerator*up.denominator ||
     down.numerator*downStructural.denominator != downStructural.numerator*down.denominator then
   .error "quark invariant routes disagree"
  else if blocks.up != coverDepth (c^(c+1)) then .error "up cover did not close"
  else if blocks.down != coverDepth (c^c) then .error "down cover did not close"
  else .ok ⟨up,down,blocks.up,blocks.down⟩

def channelRecord (cs : Channels) :=
 ((cs.upPairSum.numerator,cs.upPairSum.denominator),
 (cs.downPairSum.numerator,cs.downPairSum.denominator),cs.upDepth,cs.downDepth)

theorem exactChannels : channelInvariants.map channelRecord = .ok ((1,12),(1,8),7,5) := rfl

structure Cubics where
 down : PositiveFraction × PositiveFraction × PositiveFraction
 up : PositiveFraction × PositiveFraction × PositiveFraction

def cubicInvariants : Except String Cubics :=
 match hc : channelInvariants with
 | .error e => .error e
 | .ok channels =>
  have depths : channels.upDepth = 7 := by
   have h := congrArg (fun r => r.map channelRecord) hc
   rw [exactChannels] at h
   exact congrArg (fun r => r.2.2.1) (Except.ok.inj h).symm
  match hb : fineStructureBlocks with
  | .error e => .error e
  | .ok blocks =>
   have be : blocks = ⟨2,3,5,7,128,9,250⟩ := Except.ok.inj (hb.symm.trans forcedBlocks)
   let b := blocks.binary
   let c := blocks.generator
   let downReach := channels.upDepth
   let upReach := downReach+c
   let downDenominator := c*b^downReach-1
   let upDenominator := c*b^upReach-1
   have dp : 0 < downDenominator := by dsimp [downDenominator,downReach,b,c]; rw [depths,be]; decide
   have up : 0 < upDenominator := by dsimp [upDenominator,upReach,downReach,b,c]; rw [depths,be]; decide
   .ok ⟨(AlphaRatio.one,channels.downPairSum,normalizePositive 1 downDenominator (by decide) dp),
    (AlphaRatio.one,channels.upPairSum,normalizePositive 1 upDenominator (by decide) up)⟩

def fractionPair (x : PositiveFraction) := (x.numerator,x.denominator)
def cubicRecord (c : Cubics) :=
 ((fractionPair c.down.1,fractionPair c.down.2.1,fractionPair c.down.2.2),
 (fractionPair c.up.1,fractionPair c.up.2.1,fractionPair c.up.2.2))

theorem exactCubics : cubicInvariants.map cubicRecord = .ok
 (((1,1),(1,8),(1,383)),((1,1),(1,12),(1,3071))) := rfl
end SFT.Physics.QuarkInvariants
