import SFT.Materials.RotationTotient
open SFT.Materials.RotationTotient
#eval do
 for i in List.range 64 do
  let order : PositiveCount := ⟨i+1,Nat.zero_lt_succ i⟩
  IO.println (toString order.val ++ "\t" ++ toString (totientCount order).val ++ "\t" ++ toString (crystallographicRotationAdmitted order))
