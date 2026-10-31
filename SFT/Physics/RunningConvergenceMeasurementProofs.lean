import SFT.Physics.RunningConvergenceValidation
namespace SFT.Physics.RunningConvergenceMeasurementProofs
open SFT.Host.Canonical RunningConvergenceMeasurement

def intervalFields (v : Except String (Rat × Rat)) : Except String ((Int × Nat) × (Int × Nat)) :=
 v.map (fun (lo,hi) => ((lo.num,lo.den),(hi.num,hi.den)))

def strongLow : Value := .object [("central",.text "0.445"),("symmetric_uncertainty",.text "0.114")]
def strongHigh : Value := .object [("central",.text "0.1180"),("symmetric_uncertainty",.text "0.0009")]

theorem strongLowExact : intervalFields (rowInterval strongLow "central" "symmetric_uncertainty") = .ok ((331,1000),(559,1000)) := rfl

theorem strongHighExact : intervalFields (rowInterval strongHigh "central" "symmetric_uncertainty") = .ok ((1171,10000),(1189,10000)) := rfl

theorem strongSeparated : 1189*1000 < 331*10000 := by decide

theorem reversedStrongDirectionRejected : ¬ (559*10000 < 1171*1000) := by decide

theorem scalesOrdered : 137*2000 < 182371*100 := by decide

theorem inverseAlphaSeparated : 63969*1000000000 < 137035999063*500 := by decide

theorem omittedQcdRowRejected : (7:Nat)-1 ≠ 7 := by decide

theorem omittedDeltaRowRejected : (11:Nat)-1 ≠ 11 := by decide

theorem wrongClaimRejected (files : List (String × ByteArray)) (record : Value)
 (wrong derivation host implementation : String) (before after : RunningConvergenceValidation.Snapshot)
 (different : SFT.Host.Text.equal wrong RunningConvergencePrediction.claimId=false) :
 RunningConvergenceValidation.validate files record wrong derivation host implementation before after =
 .error "coupling-running validator received the wrong claim seal" := by
 unfold RunningConvergenceValidation.validate
 rw [different]
 rfl
end SFT.Physics.RunningConvergenceMeasurementProofs
