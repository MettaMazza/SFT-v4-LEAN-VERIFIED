import SFT.Physics.ThermalHistoryTransport
import SFT.Physics.FreePhase
namespace SFT.Physics.ThermalHistoryHorizon
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar
open ThermalHistory ThermalHistoryTransport GravitySourceProofs
set_option maxHeartbeats 100000000
-- A pair retains the exact duration and speed of one original source segment.
def segmentValue (p : PositiveFraction × PositiveFraction) : PositiveFraction :=
 BoundaryGrowth.multiply p.1 p.2

theorem originalSegments (pairs : List (PositiveFraction × PositiveFraction)) :
 horizonSegments (pairs.map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.1))
  (pairs.map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.2)) =
 .ok (pairs.map (fun p => BoundaryGrowth.asFraction (segmentValue p))) := by
 induction pairs with
 | nil => rfl
 | cons p ps ih =>
   rw [List.map_cons,List.map_cons,horizonSegments,admittedPositive,admittedPositive]
   dsimp only [Bind.bind,Except.bind]
   rw [ih,sourceProduct]
   rfl

theorem originalPositiveSum (first : PositiveFraction) (rest : List PositiveFraction) :
 (rest.map BoundaryGrowth.asFraction).foldl LeptonIntervals.add (BoundaryGrowth.asFraction first) =
 BoundaryGrowth.asFraction (rest.foldl sumMagnitude first) := by
 induction rest generalizing first with
 | nil => rfl
 | cons x xs ih =>
   rw [List.map_cons,List.foldl_cons,FreePhase.positiveSumRepresentation]
   exact ih _

theorem originalFiniteHorizon (first : PositiveFraction × PositiveFraction)
 (rest : List (PositiveFraction × PositiveFraction)) :
 finiteSoundHorizon ((first::rest).map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.1))
  ((first::rest).map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.2)) =
 .ok (BoundaryGrowth.asFraction ((rest.map segmentValue).foldl sumMagnitude (segmentValue first))) := by
 have self (n : Nat) : (n == n)=true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 have guard : (((first::rest).map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.1)).isEmpty ||
   ((first::rest).map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.1)).length !=
   ((first::rest).map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.2)).length)=false := by
  rw [SFT.Foundation.CommonRefinement.mapLength,SFT.Foundation.CommonRefinement.mapLength]
  change (!( (first::rest).length == (first::rest).length))=false
  rw [self]
  rfl
 unfold finiteSoundHorizon
 rw [guard]
 change (do
   let segments ← horizonSegments ((first::rest).map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.1))
     ((first::rest).map (fun (p : PositiveFraction × PositiveFraction) => BoundaryGrowth.asFraction p.2))
   match segments with
   | [] => throw "sound-horizon segments must be nonempty and paired"
   | x::xs => pure (xs.foldl LeptonIntervals.add x)) = _
 rw [originalSegments]
 dsimp only [Bind.bind,Except.bind]
 rw [List.map_cons]
 have h := originalPositiveSum (segmentValue first) (rest.map segmentValue)
 rw [VacuumLedgerProofs.mapComposition] at h
 exact congrArg Except.ok h
end SFT.Physics.ThermalHistoryHorizon
