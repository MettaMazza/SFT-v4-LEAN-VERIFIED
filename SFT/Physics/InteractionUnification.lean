import SFT.Physics.RunningConvergence
import SFT.Mathematics.LimitComputations
namespace SFT.Physics.InteractionUnification
open GeneratorOperations LeptonIntervals
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := normalize 1 1 (by decide)
def half : Rat := normalize 1 2 (by decide)
def primeSectors : List Nat := [2,3,5,7]
def standingModes : CountInput → Except String (List Rat)
 | .boolean _ => .error "standing modes require a generated sector count"
 | .integer (.negSucc _) => .error "standing modes require a generated sector count"
 | .integer (.ofNat 0) => .error "standing modes require a generated sector count"
 | .integer (.ofNat 1) => .error "standing modes require a generated sector count"
 | .integer (.ofNat (k+2)) => .ok ((List.range k).map (fun i => normalize (.ofNat (i+1)) (k+1) (Nat.zero_lt_succ _)))
def commonHalfOneSectors : Except String (List Nat) := do
 let rows ← primeSectors.mapM fun m => do
  let modes ← standingModes (.integer (.ofNat m))
  pure (m,modes.any (equalRat half))
 pure ((rows.filter Prod.snd).map Prod.fst)
structure SectorTable where
 sector : Nat
 coupling : Rat
 mixingShare : Rat
 massShortfall : Rat
 mediatorCount : Nat
 standingModes : List Rat
 halfOneStanding : Bool
def baseSectorTable (sector : CountInput) : Except String SectorTable := do
 let m ← (SectorInventory.chargeKindCount sector).mapError (fun _ => "the terminal interaction table uses the complete forced prime-sector ladder")
 let modes ← standingModes sector
 let coupling ← LeptonRatios.divide (normalize (.ofNat (m-1)) 1 (by decide)) (normalize (.ofNat m) 1 (by decide))
 let mixing ← LeptonRatios.divide one (normalize (.ofNat (m-1)) 1 (by decide))
 let mass ← LeptonRatios.divide one (normalize (.ofNat m) 1 (by decide))
 pure ⟨m,coupling,mixing,mass,m*m-1,modes,modes.any (equalRat half)⟩
def runningShare (sector support : CountInput) : Except String Rat :=
 (SectorInventory.runningCoupling sector support).mapError (fun _ => "running share requires a forced sector and positive support")
def runningShortfall (sector support : CountInput) : Except String Rat := do
 let share ← runningShare sector support
 pure (subtract one share)
def runningGap (lower upper support : CountInput) : Except String Rat := do
 let error := "running gap requires ordered forced sectors"
 let _ ← (SectorInventory.chargeKindCount lower).mapError (fun _ => error)
 let _ ← (SectorInventory.chargeKindCount upper).mapError (fun _ => error)
 if SectorInventory.countValue lower < SectorInventory.countValue upper then
  let high ← runningShare upper support
  let low ← runningShare lower support
  pure (subtract high low)
 else .error error
def foldPart (value : Rat) : Rat :=
 let doubled := add value value
 if one.blt doubled then subtract doubled one else doubled
/-- The original first-return relation retains each Fold before comparing it with the source. -/
inductive PeriodRun (source : Rat) : Rat → Nat → Prop where
 | returned (current : Rat) (same : foldPart current=source) : PeriodRun source current 1
 | advanced (current : Rat) (count : Nat) (different : foldPart current≠source)
  (tail : PeriodRun source (foldPart current) count) : PeriodRun source current (count+1)
def strictFrom (previous : Rat) : List Rat → Bool
 | [] => true
 | next::xs => previous.blt next && strictFrom next xs
def strictShares : List Rat → Bool
 | [] => true
 | a::xs => strictFrom a xs
def distinctShares : List Rat → Bool
 | [] => true
 | a::xs => !(xs.any (equalRat a)) && distinctShares xs
def gapsFrom (support : CountInput) (previous : Nat) : List Nat → Except String (List Rat)
 | [] => .ok []
 | next::xs => do
  let gap ← runningGap (.integer (.ofNat previous)) (.integer (.ofNat next)) support
  let tail ← gapsFrom support next xs
  pure (gap::tail)
def adjacentGaps (support : CountInput) : List Nat → Except String (List Rat)
 | [] => .ok []
 | a::xs => gapsFrom support a xs
def allDepthOrderAndNoncoincidence : CountInput → Except String Bool
 | .boolean _ => .error "common-support order requires positive depth"
 | .integer (.negSucc _) => .error "common-support order requires positive depth"
 | .integer (.ofNat 0) => .error "common-support order requires positive depth"
 | .integer (.ofNat (k+1)) => do
  let support := CountInput.integer (.ofNat (2^k))
  let shares ← primeSectors.mapM (fun m => runningShare (.integer (.ofNat m)) support)
  let gaps ← adjacentGaps support primeSectors
  pure (strictShares shares && distinctShares shares && gaps.all (fun g => zero.blt g))
def priorFlatSlopeBundleIsConsistent : Bool :=
 let formulaAtTwo := 2-1
 let assertedAtTwo := 0
 Nat.beq formulaAtTwo assertedAtTwo
theorem originalForcedSectors : PrimeSectorLadder.primeSectorLadder=.ok primeSectors :=
 PrimeSectorLadder.completeLadder
theorem originalStandingEnumeration (k : Nat) : standingModes (.integer (.ofNat (k+2)))=
 .ok ((List.range k).map (fun i => normalize (.ofNat (i+1)) (k+1) (Nat.zero_lt_succ _))) := rfl
theorem originalCommonHalf : commonHalfOneSectors=.ok [3,5,7] := rfl
theorem originalTwoSectorEmpty : standingModes (.integer 2)=.ok [] := rfl
theorem originalAdverseSlope : priorFlatSlopeBundleIsConsistent=false := rfl
structure PeriodDictionary where
 gravity : Nat
 electromagnetic : Nat
 strong : Nat
 joint : Nat
def periodDictionary : Except String PeriodDictionary := do
 let gravityTrace ← FoldFirstReturn.firstReturn (SFT.Foundation.ExactOperations.normalizePart 1 1 (by decide) (by decide))
 let electromagneticTrace ← FoldFirstReturn.firstReturn (SFT.Foundation.ExactOperations.normalizePart 1 3 (by decide) (by decide))
 let strongTrace ← FoldFirstReturn.firstReturn (SFT.Foundation.ExactOperations.normalizePart 1 7 (by decide) (by decide))
 let g := gravityTrace.length
 let e := electromagneticTrace.length
 let s := strongTrace.length
 pure ⟨g,e,s,g*e*s/Nat.gcd g (Nat.gcd e s)⟩
theorem originalPeriodDictionary : periodDictionary=.ok ⟨1,2,3,6⟩ := rfl
theorem originalGravityPeriod : PeriodRun one one 1 := .returned one rfl
theorem originalElectromagneticPeriod :
 PeriodRun (normalize 1 3 (by decide)) (normalize 1 3 (by decide)) 2 := by
 apply PeriodRun.advanced _ 1
 · intro h
   have eq := congrArg Rat.num h
   change (2:Int)=1 at eq
   exact (by decide : (2:Nat)≠1) (congrArg Int.toNat eq)
 · exact .returned _ rfl
theorem originalStrongPeriod :
 PeriodRun (normalize 1 7 (by decide)) (normalize 1 7 (by decide)) 3 := by
 apply PeriodRun.advanced _ 2
 · intro h
   have eq := congrArg Rat.num h
   change (2:Int)=1 at eq
   exact (by decide : (2:Nat)≠1) (congrArg Int.toNat eq)
 · apply PeriodRun.advanced _ 1
   · intro h
     have eq := congrArg Rat.num h
     change (4:Int)=1 at eq
     exact (by decide : (4:Nat)≠1) (congrArg Int.toNat eq)
   · exact .returned _ rfl

end SFT.Physics.InteractionUnification
