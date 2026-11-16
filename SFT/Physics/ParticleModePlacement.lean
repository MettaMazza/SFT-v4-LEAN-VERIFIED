import SFT.Physics.ParticleModeCover
import SFT.Physics.StationarySpectrum
import SFT.Host.Canonical
namespace SFT.Physics.ParticleModePlacement
open GeneratorOperations LeptonIntervals VacuumLedgerProofs SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def invalidClasses : String := "particle modes require a nonempty finite set of unique recurrent trace classes"
def unhashable : List Value → Option String
 | [] => none
 | .array _::_ => some "unhashable type: 'list'"
 | .object _::_ => some "unhashable type: 'dict'"
 | .text _::xs => unhashable xs
 | .integer _::xs => unhashable xs
 | .boolean _::xs => unhashable xs
 | .null::xs => unhashable xs

def classText : Value → Except String String
 | .text s => if s=="" then .error invalidClasses else .ok s
 | .integer _ => .error invalidClasses
 | .boolean _ => .error invalidClasses
 | .null => .error invalidClasses
 | .array _ => .error invalidClasses
 | .object _ => .error invalidClasses

def placementValue (depth index : Nat) : Except String Rat :=
 LeptonRatios.divide (wholeRatio (2*(index+1)-1)) (wholeRatio (2^(depth+1)))
structure Placement where
 traceCount : Nat
 depth : Nat
 capacity : Nat
 placements : List (String × Rat)
 complete : Bool
 injective : Bool
 internalDepthNotSpatialDimension : Bool

def placeRecurrentParticleModes (traceClasses : List Value) : Except String Placement := do
 if traceClasses.isEmpty then throw invalidClasses
 match unhashable traceClasses with
 | some e => throw e
 | none => pure ()
 let classes ← traceClasses.mapM classText
 if classes.eraseDups.length != classes.length then throw invalidClasses
 let depth := AlphaCovers.coverDepth classes.length
 let capacity := 2^depth
 let modes ← ParticleModeFibres.mapExact (placementValue depth) (List.range classes.length)
 let rows := classes.zip modes
 pure ⟨classes.length,depth,capacity,rows,rows.length==classes.length,
  (rows.map Prod.snd).eraseDups.length==classes.length,true⟩

theorem originalPlacementValue (depth index : Nat) : placementValue depth index=
 .ok (BoundaryGrowth.asFraction (VacuumSpectrum.level (2^depth) index (Nat.pow_pos (by decide)))) := by
 unfold placementValue
 rw [MassRatioFamily.wholeDivision _ _ (Nat.pow_pos (by decide))]
 apply congrArg Except.ok
 rw [VacuumSpectrum.sourceNumerator,VacuumScaleProofs.positiveCarrierRepresentation]
 apply natRatioCongruence
 change (2*index+1)*((VacuumSpectrum.level (2^depth) index _).denominator)=
  (VacuumSpectrum.level (2^depth) index _).numerator*(2^(depth+1))
 rw [Nat.pow_succ]
 exact VacuumSpectrum.levelExactValue _ _ _

theorem originalPlacementDistinct (depth i j : Nat)
 (same : VacuumSpectrum.level (2^depth) i (Nat.pow_pos (by decide))=
  VacuumSpectrum.level (2^depth) j (Nat.pow_pos (by decide))) : i=j :=
 VacuumSpectrum.levelInjective _ _ _ _ same

theorem originalPlacementWithinOne (count index : Nat) (inside : index<count) :
 (VacuumSpectrum.level (2^(AlphaCovers.coverDepth count)) index (Nat.pow_pos (by decide))).numerator≤
 (VacuumSpectrum.level (2^(AlphaCovers.coverDepth count)) index (Nat.pow_pos (by decide))).denominator :=
 VacuumSpectrum.everyLevelIsPart _ _ _ (Nat.lt_of_lt_of_le inside (AlphaCovers.leastPositiveCover count).2.1)

theorem originalPlacementIndexCount (count : Nat) : (List.range count).length=count :=
 (VacuumSpectrum.rangeLoopLength count []).trans (Nat.add_zero _)
theorem originalPlacementIndexSuccessor (count : Nat) : List.range (count+1)=List.range count++[count] :=
 rangeSuccessor count
#print axioms placeRecurrentParticleModes
#print axioms originalPlacementValue
#print axioms originalPlacementDistinct
#print axioms originalPlacementWithinOne
#print axioms originalPlacementIndexCount
#print axioms originalPlacementIndexSuccessor
end SFT.Physics.ParticleModePlacement
