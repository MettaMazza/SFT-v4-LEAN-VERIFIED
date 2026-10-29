import SFT.Physics.AlphaRatio
import SFT.Physics.LeptonInvariants
import SFT.Physics.LeptonLedger
namespace SFT.Physics.LeptonTerminal
open SFT.Foundation.ExactOperations AlphaRatio AlphaBlocks BoundaryGrowth FoldFirstReturn
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

theorem colourPositive (colour : Nat) (source : generatorPeriod = .ok colour) : 0 < colour := by
 have same : colour = 3 := Except.ok.inj (source.symm.trans generatorPeriodThree)
 cases same
 decide

theorem depthsPositive (blocks : Blocks) (source : fineStructureBlocks = .ok blocks) :
 0 < blocks.down ∧ 0 < blocks.up := by
 have same : blocks = ⟨2,3,5,7,128,9,250⟩ := Except.ok.inj (source.symm.trans forcedBlocks)
 cases same
 exact ⟨by decide,by decide⟩

def positivePower (base : PositiveFraction) : Nat → PositiveFraction
 | 0 => AlphaRatio.one
 | n+1 => multiply (positivePower base n) base

theorem powerBase (base : PositiveFraction) : positivePower base 0 = AlphaRatio.one := rfl

theorem powerSuccessor (base : PositiveFraction) (n : Nat) :
 positivePower base (n+1) = multiply (positivePower base n) base := rfl

def correction : Except String PositiveFraction :=
 match hc : generatorPeriod with
 | .error e => .error e
 | .ok colour => match hb : fineStructureBlocks with
   | .error e => .error e
   | .ok blocks => do
     let inverse ← inverseFineStructure none
     let alpha := reciprocal inverse
     let volume := whole (colour^colour) (Nat.pow_pos (colourPositive colour hc))
     let down := whole blocks.down (depthsPositive blocks hb).1
     let up := whole blocks.up (depthsPositive blocks hb).2
     let channels := whole colour (colourPositive colour hc)
     let depthCarrier := add down (multiply (divide up channels) alpha)
     .ok (divide (multiply (positivePower alpha colour) depthCarrier) volume)

def admittedProduct : PositiveFraction := normalizePositive 3 1454 (by decide) (by decide)

def terminalProduct : Except String PositiveFraction := do
 let held ← correction
 LeptonTake.positiveTake (asFraction admittedProduct) (asFraction held)

def correctionPair : Except String (Nat × Nat) := outputPair correction

def terminalPair : Except String (Nat × Nat) := outputPair terminalProduct

theorem exactCorrection : correctionPair = .ok (376926193013708290190758164816402371555272,5220085816185270244432584276275384668628413983201) := rfl

theorem exactTerminal : terminalPair = .ok (15659709397871168801443815466454510956837000584115,7590004776733382935404977537704409308185713931574254) := rfl

theorem smallerThanAdmitted :
 match correction with
 | .error _ => False
 | .ok held => held.numerator*admittedProduct.denominator <
   admittedProduct.numerator*held.denominator := by
 change 376926193013708290190758164816402371555272*1454 < 3*5220085816185270244432584276275384668628413983201
 decide

theorem retainsPositiveProduct :
 match terminalProduct with
 | .error _ => False
 | .ok result => 0 < result.numerator := by
 change 0 < 15659709397871168801443815466454510956837000584115
 decide

theorem nativeDepths : fineStructureBlocks = .ok ⟨2,3,5,7,128,9,250⟩ := forcedBlocks

theorem generatorSupport : (LeptonSupport.colourSupport 3).length = 27 :=
 LeptonSupport.colourSupportCount 3

def coupleRoots (alpha : PositiveFraction) : List LeptonLedger.Position → PositiveFraction
 | [] => AlphaRatio.one
 | _ :: tail => multiply (coupleRoots alpha tail) alpha

theorem coupleEveryRoot (alpha : PositiveFraction) (roots : List LeptonLedger.Position) :
 coupleRoots alpha roots = positivePower alpha roots.length := by
 induction roots with
 | nil => rfl
 | cons root tail ih => exact congrArg (fun value => multiply value alpha) ih

theorem threeRootCoupling (alpha : PositiveFraction) :
 coupleRoots alpha [.first,.second,.third] = positivePower alpha 3 :=
 coupleEveryRoot alpha [.first,.second,.third]

theorem heldCorrectionReassembly (held : PositiveFraction) (source : correction = .ok held)
 (smaller : held.numerator*admittedProduct.denominator < admittedProduct.numerator*held.denominator) :
 (admittedProduct.numerator*held.denominator-held.numerator*admittedProduct.denominator) +
 held.numerator*admittedProduct.denominator = admittedProduct.numerator*held.denominator :=
 LeptonTake.heldPartReassembles admittedProduct held smaller

end SFT.Physics.LeptonTerminal
