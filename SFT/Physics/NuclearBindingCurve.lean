import SFT.Physics.NuclearResidualForce
import SFT.Physics.RunningConvergence
namespace SFT.Physics.NuclearBindingCurve
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
local instance : BEq Int := ⟨fun a b => @decide (a=b) (Int.decEq a b)⟩
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
-- Original nuclear_binding_curve_successor_laws_v1.py, exact count arguments.
def surfaceDeficitShare : Except String Rat := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let binary ← AlphaCovers.binaryCount
 let generator ← FoldFirstReturn.generatorPeriod
 if blocks.down != binary+generator then throw "surface interface carrier did not cross-lock"
 LeptonRatios.divide (wholeRatio 1) (wholeRatio blocks.down)
def electromagneticShare : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure
 LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
def asymmetryShare := NuclearResidualForce.residualBoundarySupport
def pairingShare := NuclearResidualForce.residualBoundarySupport
def neutronCount : CountInput → CountInput → Except String Nat
 | .boolean _,_ => .error "nuclear counts must be exact positive counts"
 | .integer _,.boolean _ => .error "nuclear counts must be exact positive counts"
 | .integer a,.integer z => do
   if a ≤ 1 || z < 1 || z ≥ a then throw "a nucleus requires positive proton and neutron support"
   let retained ← RunningConvergence.positiveTake (normalize a 1 (by decide)) (normalize z 1 (by decide))
   if retained.den != 1 then throw "neutron count did not remain whole"
   pure retained.num.toNat
def orderedChargePaths : CountInput → Except String (Option Nat)
 | .boolean _ => .error "charge support must be a positive exact count"
 | .integer z => do
   if z < 1 then throw "charge support must be a positive exact count"
   if z == 1 then pure none else
    let previous ← positivePredecessor (.integer z)
    pure (some (z.toNat*previous))
def unmatchedLabelCount (a z : CountInput) : Except String (Option Nat) := do
 let neutrons ← neutronCount a z
 match z with
 | .boolean _ => throw "nuclear counts must be exact positive counts"
 | .integer charge =>
   if Int.ofNat neutrons == charge then pure none else
    let n := wholeRatio neutrons
    let q := normalize charge 1 (by decide)
    let retained ← if charge < Int.ofNat neutrons then RunningConvergence.positiveTake n q
                    else RunningConvergence.positiveTake q n
    pure (some retained.num.toNat)
def pairingClass (a z : CountInput) : Except String String := do
 let neutrons ← neutronCount a z
 let binary ← AlphaCovers.binaryCount
 match z with
 | .boolean _ => throw "nuclear counts must be exact positive counts"
 | .integer charge =>
   let protonEven := charge % Int.ofNat binary == 0
   let neutronEven := neutrons % binary == 0
   if protonEven && neutronEven then pure "paired-gain"
   else if !protonEven && !neutronEven then pure "unpaired-loss"
   else pure "mixed-empty"
-- Option.none retains V3's empty tuple, not a numerical-zero contribution.
structure Ledger where
 massNumber : Int
 chargeCount : Int
 neutronCount : Nat
 bulkSupport : Rat
 surfaceRadialLoss : Rat
 orderedChargePaths : Option Nat
 coulombRadialLoss : Option Rat
 asymmetryLoss : Option Rat
 pairingRadialPart : Rat
 pairingClass : String
def bindingLedger (a z : CountInput) : Except String Ledger := do
 let neutrons ← neutronCount a z
 let paths ← orderedChargePaths z
 let unmatched ← unmatchedLabelCount a z
 match a,z with
 | .integer mass,.integer charge =>
   let alpha ← electromagneticShare
   let asymmetry ← asymmetryShare
   let pair ← pairingShare
   let coulomb ← match paths with
    | none => pure none
    | some p => do
      let ratio ← LeptonRatios.divide (wholeRatio p) (normalize mass 1 (by decide))
      pure (some (multiply alpha ratio))
   let asym ← match unmatched with
    | none => pure none
    | some u => do
      let ratio ← LeptonRatios.divide (wholeRatio (u*u)) (normalize (mass*mass) 1 (by decide))
      pure (some (multiply asymmetry ratio))
   let pairing ← LeptonRatios.divide pair (normalize mass 1 (by decide))
   let surface ← surfaceDeficitShare
   let cls ← pairingClass a z
   pure ⟨mass,charge,neutrons,wholeRatio 1,surface,paths,coulomb,asym,pairing,cls⟩
 | .boolean _,.integer _ => throw "nuclear counts must be exact positive counts"
 | .integer _,.boolean _ => throw "nuclear counts must be exact positive counts"
 | .boolean _,.boolean _ => throw "nuclear counts must be exact positive counts"
def netRadialLoss (a z : CountInput) : Except String Rat := do
 let ledger ← bindingLedger a z
 let loss := match ledger.coulombRadialLoss with
  | none => ledger.surfaceRadialLoss
  | some value => add ledger.surfaceRadialLoss value
 if ledger.pairingClass == "paired-gain" then RunningConvergence.positiveTake loss ledger.pairingRadialPart
 else if ledger.pairingClass == "unpaired-loss" then pure (add loss ledger.pairingRadialPart)
 else pure loss
def nonradialRetention (a z : CountInput) : Except String Rat := do
 let ledger ← bindingLedger a z
 match ledger.asymmetryLoss with
 | none => pure (wholeRatio 1)
 | some value => RunningConvergence.positiveTake (wholeRatio 1) value

theorem surfaceForced : surfaceDeficitShare = .ok (normalize 1 5 (by decide)) := rfl
theorem asymmetryForced : asymmetryShare = .ok (normalize 1 4 (by decide)) := rfl
theorem pairingForced : pairingShare = .ok (normalize 1 4 (by decide)) := rfl
theorem singleChargeEmpty : orderedChargePaths (.integer 1) = .ok none := rfl
theorem pairedOriginal : pairingClass (.integer 62) (.integer 28) = .ok "paired-gain" := rfl
theorem unpairedOriginal : pairingClass (.integer 2) (.integer 1) = .ok "unpaired-loss" := rfl
theorem mixedOriginal : pairingClass (.integer 3) (.integer 1) = .ok "mixed-empty" := rfl
end SFT.Physics.NuclearBindingCurve
