import SFT.Physics.StrongFieldHorizon
import SFT.QuantumComputation.Measurement
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Physics.HorizonInformation
open LeptonIntervals VacuumLedgerProofs

def boundaryRecords (count : Nat) : List (String × Nat) :=
 (List.range count).map (fun n => ("boundary-cell",n+1))

structure Result where
 locallyClosedPredecessor : List Unit
 retainedBoundaryRecords : List (String × Nat)
 reconstructibleWithCompleteInverseRecord : Bool

def horizonInformationLedger : Except String Result := do
 let horizon ← StrongFieldHorizon.strongFieldHorizon
 let entropy := horizon.entropyCells
 if entropy.den != 1 then throw "horizon entropy support must be a whole positive count"
 let records := boundaryRecords entropy.num.toNat
 let count := wholeRatio records.length
 if !count.blt entropy && !entropy.blt count then
  pure ⟨[],records,true⟩
 else throw "horizon boundary record count changed"

theorem completeSourceRecord : horizonInformationLedger=.ok ⟨[],boundaryRecords 8,true⟩ := by
 unfold horizonInformationLedger
 rw [StrongFieldHorizon.completeSourceRecord]
 rfl

theorem boundarySuccessor (n : Nat) : boundaryRecords (n+1)=boundaryRecords n++[("boundary-cell",n+1)] := by
 unfold boundaryRecords
 rw [rangeSuccessor,SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 rfl

theorem boundaryCardinality (n : Nat) : (boundaryRecords n).length=n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  rw [boundarySuccessor,SFT.Foundation.CommonRefinement.appendLength,ih]
  rfl

theorem completeInverseReconstruction
 (state selected : SFT.QuantumComputation.ReversibleModel.State)
 (mapping : SFT.QuantumComputation.ReversibleObservation.Classification) (label : String)
 (record : List SFT.QuantumComputation.ReversibleObservation.Record)
 (observed : SFT.QuantumComputation.ReversibleObservation.observe state mapping label=.ok (selected,record)) :
 (⟨record.map Prod.fst,selected.phaseCycle⟩ : SFT.QuantumComputation.ReversibleModel.State)=state :=
 SFT.QuantumComputation.Measurement.reconstructEntireState state selected mapping label record observed
end SFT.Physics.HorizonInformation
