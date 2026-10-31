import SFT.Physics.SectorInventory
namespace SFT.Physics.SectorInventoryWitnesses
open SectorInventory PrimeSectorLadder
local instance : BEq Int := ⟨fun a b => @decide (a=b) (Int.decEq a b)⟩
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := (completeChargeKindsCheck && mediatorCheck && couplingCheck)
where
 completeChargeKindsCheck := match ([2,3,5,7] : List Nat).mapM (fun p => chargeKindCount (.integer (.ofNat p))) with | .error _ => false | .ok ps => ps == [2,3,5,7]
 mediatorCheck := match mediatorRecord with | .error _ => false | .ok ps => ps == [3,8,24,48]
 couplingCheck := match couplingRecord with | .error _ => false | .ok ps => ps == [(1,2),(2,3),(4,5),(6,7)]
def check1 : Bool := match diagonalRecord with | .error _ => false | .ok ps => ps.drop 2 == [(14,15),(20,21)]
def check2 : Bool := match electronRatioRecord with | .error _ => false | .ok ps => ps.drop 2 == [(2,5),(2,7)]
def check3 : Bool := match gapRecord 8 with
 | .error _ => false
 | .ok ps => ps == orderedPairs.map (fun p =>
   let q := LeptonIntervals.normalize (.ofNat (p.2-p.1)) ((p.1+8)*(p.2+8))
     (Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _))
   (q.num,q.den))
def check4 : Bool := match gaugeCarrierTotal with
 | .error _ => false
 | .ok g => match undiscoveredGaugeCarrierCount with
   | .error _ => false
   | .ok u => match completeNamedParticleCount with
     | .error _ => false
     | .ok n => g == 83 && u == 72 && smithionKindCount == 12 && n == 98
def witnesses : List Witness := [⟨"sector-table","Every sector count, coupling and mediator count reconstructs exactly.",check0⟩,⟨"new-sector-mixing","Penta and hepta diagonal shares are 14/15 and 20/21.",check1⟩,⟨"new-sector-masses","Penta and hepta mass-parts are 2/5 and 2/7 of the electron carrier.",check2⟩,⟨"running-gap","Every ordered sector pair retains the exact positive closed-form gap at generated support.",check3⟩,⟨"finite-inventory","The complete counts terminate at 83 gauge carriers, 72 predicted new carriers, 12 Smithions and 98 named particles.",check4⟩]
theorem check0Passed : check0 = true := by
 unfold check0 check0.completeChargeKindsCheck check0.mediatorCheck check0.couplingCheck
 rw [completeChargeKinds,exactMediators,exactCouplings]
 rfl
theorem check1Passed : check1 = true := by unfold check1; rw [exactDiagonalRecord]; rfl
theorem check2Passed : check2 = true := by unfold check2; rw [exactElectronRatioRecord]; rfl
theorem check3Passed : check3 = true := by unfold check3; rw [exactGapRecord]; rfl
theorem check4Passed : check4 = true := by
 unfold check4
 rw [exactGaugeTotal,exactNewCarriers,exactNamedCount]
 rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && check3 && check4 && true) = true
 rw [check0Passed,check1Passed,check2Passed,check3Passed,check4Passed]
 rfl
end SFT.Physics.SectorInventoryWitnesses
