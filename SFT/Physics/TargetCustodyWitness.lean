import SFT.Physics.TargetCustody
import SFT.Foundation.DerivationTrace
namespace SFT.Physics.TargetCustodyEvidence
open SFT.Host.Canonical SFT.Physics.TargetCustody

theorem textSelf (s : String) : SFT.Host.Text.equal s s = true := by
 unfold SFT.Host.Text.equal
 exact SFT.Foundation.DerivationTrace.identityBytesReflexive _
theorem namesSelf : sameNames ((sortTargets [("target",Value.text "withheld-record")]).map Prod.fst) ((sortTargets [("target",Value.text "withheld-record")]).map Prod.fst) = true := rfl

def witnessRun (env ph th sh : String) : Bool :=
 match createVault "formal-custody-witness" "target-custodian" [("target",.text "withheld-record")]
     "custodian-held" env with
 | .error _ => false
 | .ok vault => match release vault ⟨"formal-custody-witness",ph,th,env,sh⟩ with
   | .error _ => false
   | .ok (_,released) => match verify vault.commitment released ⟨"formal-custody-witness",ph,th,env,sh⟩ with
     | .error _ => false
     | .ok _ => SFT.Host.Text.equal released.predictionSealHash sh

set_option maxRecDepth 20000 in
theorem witnessRunPassed (env ph th sh : String) (valid : SFT.Engine.isSha256Identity env = true) :
    witnessRun env ph th sh = true := by
  unfold witnessRun createVault
  change (match (if !SFT.Engine.isSha256Identity env then (Except.error "CustodyHalt: target vault requires the preregistered prediction-envelope identity" : Except String Vault) else _) with
    | .error _ => false | .ok vault => _) = true
  rw [valid]
  simp only [Bool.not_true, if_neg (by decide : ¬ false = true)]
  unfold release
  simp only [Bool.not_true, if_neg (by decide : ¬ false = true)]
  rw [textSelf,textSelf]
  simp only [Bool.not_true, if_neg (by decide : ¬ false = true)]
  unfold verify violations
  simp only [Bool.not_true, if_neg (by decide : ¬ false = true)]
  repeat rw [textSelf]
  rw [namesSelf]
  unfold releasePayload
  repeat rw [textSelf]
  rfl
end SFT.Physics.TargetCustodyEvidence
