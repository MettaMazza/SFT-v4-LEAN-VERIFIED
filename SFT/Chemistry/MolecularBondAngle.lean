import SFT.Physics.CapabilityValues
import SFT.Foundation.ExactOperations
namespace SFT.Chemistry.MolecularBondAngle
open SFT.Host SFT.Physics.CapabilityValues SFT.Foundation.ExactOperations
-- bond_angle_law_v1.py:equal_sector_turn_fraction. Wrong input classes retain
-- the original errors; the accepted carrier uses the existing held/count types.
inductive GeometryInput where
 | other
 | held (geometry : HeldLabel)
inductive CountInput where
 | other
 | count (value : PositiveCount)
def expectedCount (geometry : String) : Option Nat :=
 if Text.equal geometry "linear-equal-two-sector" then some 2
 else if Text.equal geometry "trigonal-planar-equal-three-sector" then some 3
 else if Text.equal geometry "square-planar-equal-four-sector" then some 4
 else none
def sectorFraction (count separation : PositiveCount) : PositiveFraction :=
 normalizePositive separation.value count.value separation.positive count.positive
def checkedCounts (expected : Nat) (count separation : CountInput) : Except String PositiveFraction :=
 match count,separation with
 | .count n,.count k =>
  if n.value != expected then .error "geometry and generated sector count do not agree"
  else if k.value+k.value > n.value then
   .error "undirected angle must retain the shorter or opposite generated path"
  else .ok (sectorFraction n k)
 | .other,.other => .error "sector support must use generated positive counts"
 | .other,.count _ => .error "sector support must use generated positive counts"
 | .count _,.other => .error "sector support must use generated positive counts"
def equalSectorTurnFraction (geometry : GeometryInput) (count separation : CountInput) : Except String PositiveFraction :=
 match geometry with
 | .other => .error "bond-angle geometry must be a retained molecular-geometry label"
 | .held label =>
  if !Text.equal label.family "molecular-geometry" then
   .error "bond-angle geometry must be a retained molecular-geometry label"
  else match expectedCount label.label with
  | none => .error "geometry is outside the generated equal-sector boundary"
  | some expected => checkedCounts expected count separation
structure MolecularAngleCarrier where
 targetId : String
 species : HeldLabel
 molecularState : HeldLabel
 geometry : HeldLabel
 coordinate : HeldLabel
 angleRole : HeldLabel
 sectorCount : PositiveCount
 sectorSeparation : PositiveCount
def turnFraction (carrier : MolecularAngleCarrier) : Except String PositiveFraction :=
 equalSectorTurnFraction (.held carrier.geometry) (.count carrier.sectorCount) (.count carrier.sectorSeparation)
-- The normalized fraction retains exactly k/n, with no empirical angle scale.
theorem sectorFractionValue (n k : PositiveCount) :
 k.value * (sectorFraction n k).denominator = (sectorFraction n k).numerator * n.value :=
 normalizedValuePreserved k.value n.value k.positive n.positive
-- One complete turn consists of n copies of the identical unit sector.
theorem equalSectorsExhaustTurn (n : PositiveCount) :
 n.value * (sectorFraction n ⟨1,by decide⟩).numerator =
 (sectorFraction n ⟨1,by decide⟩).denominator := by
 have h := sectorFractionValue n ⟨1,by decide⟩
 rw [Nat.one_mul] at h
 exact (Nat.mul_comm _ _).trans h.symm
-- Any equal-sector positive fraction exhausting One has the same exact ratio.
theorem equalSectorForced (n : PositiveCount) (part : PositiveFraction)
 (exhausts : n.value * part.numerator = part.denominator) :
 part.numerator * (sectorFraction n ⟨1,by decide⟩).denominator =
 (sectorFraction n ⟨1,by decide⟩).numerator * part.denominator := by
 rw [← equalSectorsExhaustTurn n,← exhausts]
 rw [← SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm part.numerator n.value,SFT.Foundation.FractionReduction.mulAssoc,
     Nat.mul_comm part.numerator (sectorFraction n ⟨1,by decide⟩).numerator,
     ← SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm n.value (sectorFraction n ⟨1,by decide⟩).numerator,SFT.Foundation.FractionReduction.mulAssoc]


def molecularAngleVector : List MolecularAngleCarrier := [
⟨"NIST-CCCBDB-BF3-FBF-ADJACENT",⟨"molecular-species","BF3",by decide,by decide⟩,⟨"molecular-state","neutral-experimental-geometry-carrier",by decide,by decide⟩,⟨"molecular-geometry","trigonal-planar-equal-three-sector",by decide,by decide⟩,⟨"internal-coordinate","aFBF",by decide,by decide⟩,⟨"angle-role","adjacent",by decide,by decide⟩,⟨3,by decide⟩,⟨1,by decide⟩⟩,
⟨"NIST-CCCBDB-XEF2-FXEF-OPPOSITE",⟨"molecular-species","XeF2",by decide,by decide⟩,⟨"molecular-state","neutral-experimental-geometry-carrier",by decide,by decide⟩,⟨"molecular-geometry","linear-equal-two-sector",by decide,by decide⟩,⟨"internal-coordinate","aFXeF",by decide,by decide⟩,⟨"angle-role","opposite",by decide,by decide⟩,⟨2,by decide⟩,⟨1,by decide⟩⟩,
⟨"NIST-CCCBDB-XEF4-FXEF-ADJACENT",⟨"molecular-species","XeF4",by decide,by decide⟩,⟨"molecular-state","neutral-experimental-geometry-carrier",by decide,by decide⟩,⟨"molecular-geometry","square-planar-equal-four-sector",by decide,by decide⟩,⟨"internal-coordinate","aFXeF",by decide,by decide⟩,⟨"angle-role","adjacent",by decide,by decide⟩,⟨4,by decide⟩,⟨1,by decide⟩⟩,
⟨"NIST-CCCBDB-XEF4-FXEF-OPPOSITE",⟨"molecular-species","XeF4",by decide,by decide⟩,⟨"molecular-state","neutral-experimental-geometry-carrier",by decide,by decide⟩,⟨"molecular-geometry","square-planar-equal-four-sector",by decide,by decide⟩,⟨"internal-coordinate","aFXeF",by decide,by decide⟩,⟨"angle-role","opposite",by decide,by decide⟩,⟨4,by decide⟩,⟨2,by decide⟩⟩]
def fractionPair (carrier : MolecularAngleCarrier) : Option (Nat × Nat) :=
 (turnFraction carrier).toOption.map (fun value => (value.numerator,value.denominator))
def exactVectorWitness : Bool := molecularAngleVector.map fractionPair == [some (1,3),some (1,2),some (1,4),some (1,2)]
def geometryCountWitness : Bool :=
 match equalSectorTurnFraction (.held ⟨"molecular-geometry","trigonal-planar-equal-three-sector",by decide,by decide⟩)
  (.count ⟨4,by decide⟩) (.count ⟨1,by decide⟩) with
 | .error _ => true
 | .ok _ => false
def continuumBoundaryWitness : Bool :=
 match equalSectorTurnFraction (.held ⟨"molecular-geometry","tetrahedral-continuum-angle",by decide,by decide⟩)
  (.count ⟨4,by decide⟩) (.count ⟨1,by decide⟩) with
 | .error _ => true
 | .ok _ => false
theorem exactVectorPassed : exactVectorWitness = true := rfl
theorem geometryCountPassed : geometryCountWitness = true := rfl
theorem continuumBoundaryPassed : continuumBoundaryWitness = true := rfl
end SFT.Chemistry.MolecularBondAngle
