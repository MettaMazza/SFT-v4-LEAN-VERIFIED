import SFT.Materials.AcousticModes
import SFT.Materials.RotationTotient
import SFT.Host.Canonical
namespace SFT.Materials.PhononThermalLimits
open SFT.Host SFT.Materials.RotationTotient

def rankThreeModeCount (width : PositiveCount) : PositiveCount :=
 ⟨width.val * width.val * width.val, Nat.mul_pos (Nat.mul_pos width.property width.property) width.property⟩

theorem rankThreeCubeEquation (width : PositiveCount) :
 (rankThreeModeCount width).val = width.val * width.val * width.val := rfl

def sampleWidths : List PositiveCount := [⟨1,by decide⟩,⟨2,by decide⟩,⟨3,by decide⟩,⟨4,by decide⟩]
def sampleCubeCounts : List Nat := sampleWidths.map (fun width => (rankThreeModeCount width).val)

def displacementModeCertificate : Canonical.Value := .object [
 ("uniform_shared_restoring_support",.object [("family",.text "support"),("label",.text "structural-absence")]),
 ("acoustic_class",.object [("family",.text "basis-displacement"),("label",.text "shared")]),
 ("optical_class",.object [("family",.text "basis-displacement"),("label",.text "opposed")]),
 ("directions_per_site",.object [("value",.integer 3)]),
 ("low_support_exponent",.object [("value",.integer 3)]),
 ("sample_cube_counts",.array (sampleCubeCounts.map (fun n => .integer (.ofNat n))))]

def modeSupportWitness : Bool := sampleCubeCounts == [1,8,27,64]
theorem modeSupportWitnessPassed : modeSupportWitness = true := rfl
-- The already established orientation census supplies the same three directions.
theorem directionsMatchRetainedCensus : AcousticModes.branches.length = 3 := AcousticModes.exactThreeBranches
#print axioms rankThreeModeCount
#print axioms rankThreeCubeEquation
#print axioms sampleWidths
#print axioms sampleCubeCounts
#print axioms displacementModeCertificate
#print axioms modeSupportWitness
#print axioms modeSupportWitnessPassed
#print axioms directionsMatchRetainedCensus
end SFT.Materials.PhononThermalLimits
