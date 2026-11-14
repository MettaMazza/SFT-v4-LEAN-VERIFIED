import SFT.Physics.LatticeCurvature
namespace SFT.Physics.GravitySelfSource
open SFT.Foundation.ExactOperations SFT.Foundation.ExactPartCarrier LeptonIntervals VacuumLedgerProofs
structure Result where
 source : Rat
 coupling : Rat
 linearField : Rat
 fieldEnergy : Rat
 selfSourceCorrection : Rat

def nonlinearGravity : Except String Result := do
 let source : Rat := ⟨1,3,by decide,by decide⟩
 let binary ← AlphaCovers.binaryCount
 let coupling ← LeptonRatios.divide (asFraction one) (wholeRatio binary)
 let linear := multiply source coupling
 let energy := multiply linear linear
 let correction := multiply energy coupling
 let expected : Rat := ⟨1,72,by decide,by decide⟩
 if !correction.blt expected && !expected.blt correction then
  pure ⟨source,coupling,linear,energy,correction⟩
 else throw "gravity self-source correction did not close"

def originalRecord : Result := ⟨⟨1,3,by decide,by decide⟩,⟨1,2,by decide,by decide⟩,
 ⟨1,6,by decide,by decide⟩,⟨1,36,by decide,by decide⟩,⟨1,72,by decide,by decide⟩⟩

theorem completeSourceRecord : nonlinearGravity=.ok originalRecord := by
 unfold nonlinearGravity
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem retainedEnergySquare : originalRecord.fieldEnergy=multiply originalRecord.linearField originalRecord.linearField := rfl

theorem retainedSourceReentry : originalRecord.selfSourceCorrection=multiply originalRecord.fieldEnergy originalRecord.coupling := rfl
end SFT.Physics.GravitySelfSource
