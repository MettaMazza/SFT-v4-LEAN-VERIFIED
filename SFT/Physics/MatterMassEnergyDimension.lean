import SFT.Physics.MatterMassEnergy
namespace SFT.Physics.MatterMassEnergyDimension
open DimensionComposition

-- Independent kind labels express the already derived mass/length/time dimensions.
def repeatedConversion : Nat → Path
  | 0 => .kind "mass"
  | n+1 => .product (repeatedConversion n) (.quotient (.kind "length") (.kind "time"))

theorem lengthCount (n : Nat) : counts (repeatedConversion n) "length" = (n,0) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    change ((counts (repeatedConversion n) "length").1+1,
      (counts (repeatedConversion n) "length").2+0) = (n+1,0)
    rw [ih]

theorem lengthDimension (n : Nat) : formAt (repeatedConversion n) "length" = (n,0) := by
  unfold formAt
  rw [lengthCount]
  exact numeratorOnly n

theorem energyDimensionForcesExactlyTwoTransfers (n : Nat)
    (same : SameDimension (repeatedConversion n)
      (MechanicalWorkEnergy.energyDimension (.kind "mass") (.kind "length") (.kind "time"))) : n = 2 := by
  have h := same "length"
  rw [lengthDimension] at h
  change (n,0) = (2,0) at h
  exact congrArg Prod.fst h

theorem twoTransfersHaveTheRequiredDimension :
    SameDimension (repeatedConversion 2)
      (MechanicalWorkEnergy.energyDimension (.kind "mass") (.kind "length") (.kind "time")) := by
  intro kind
  unfold formAt
  apply congrArg (fun pair : Nat × Nat => reduced pair.1 pair.2)
  change counts (.product (.product (.kind "mass") (.quotient (.kind "length") (.kind "time")))
      (.quotient (.kind "length") (.kind "time"))) kind = _
  have h := MatterMassEnergy.exactEnergyDimension (.kind "mass") (.kind "length") (.kind "time") kind
  simp only [MatterMassEnergy.conversionDimension,counts] at h ⊢
  simp only [Nat.add_assoc] at h ⊢
  exact h
end SFT.Physics.MatterMassEnergyDimension
