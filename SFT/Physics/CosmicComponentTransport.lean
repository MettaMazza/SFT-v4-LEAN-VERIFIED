import SFT.Physics.LeptonRatios
import SFT.Physics.CosmoCompleteBudget
import SFT.Physics.BoundaryGrowth
namespace SFT.Physics.CosmicComponentTransport
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

-- Fraction(value) is the exact host-input conversion. Its resulting rational
-- carrier is admitted here without imposing a Fraction-only type restriction.
def requirePositiveExact (value : Rat) : Except String Rat :=
 if zero.blt value then .ok value
 else .error "cosmic transport requires a positive exact Fold stretch"
def matterToday := normalize 5 16 (by decide)
def vacuumToday := normalize 11 16 (by decide)
def threeSpace : Nat := 3
def radiationPower : Nat := threeSpace+1

def matterTransport (stretch : Rat) : Except String Rat := do
 let r ← requirePositiveExact stretch
 .ok (multiply (multiply r r) r)
def radiationTransport (stretch : Rat) : Except String Rat := do
 let r ← requirePositiveExact stretch
 .ok (multiply (multiply (multiply r r) r) r)
def vacuumTransport (stretch : Rat) : Except String Rat := do
 let _ ← requirePositiveExact stretch
 .ok (normalize 1 1 (by decide))
def lateSquaredExpansion (stretch : Rat) : Except String Rat := do
 let r ← requirePositiveExact stretch
 let transported ← matterTransport r
 .ok (add vacuumToday (multiply matterToday transported))
def matterFraction (stretch : Rat) : Except String Rat := do
 let r ← requirePositiveExact stretch
 let transported ← matterTransport r
 let matter := multiply matterToday transported
 LeptonRatios.divide matter (add vacuumToday matter)
def vacuumFraction (stretch : Rat) : Except String Rat := do
 let r ← requirePositiveExact stretch
 let total ← lateSquaredExpansion r
 LeptonRatios.divide vacuumToday total

def matterVacuumEqualityCube := LeptonRatios.divide vacuumToday matterToday
def accelerationOnsetCube := LeptonRatios.divide (multiply (normalize 2 1 (by decide)) vacuumToday) matterToday
def presentAccelerationMagnitude : Except String Rat := do
 let halfMatter ← LeptonRatios.divide matterToday (normalize 2 1 (by decide))
 .ok (subtract vacuumToday halfMatter)

inductive PressureOrientation where
 | emptyPressureOneForm | outwardThirdOne | tensionOne
inductive TransportPower where
 | positive (count : Nat) (nonzero : 0<count)
 | emptyDilutionOneForm
structure ComponentLaw where
 component : String
 transportPower : TransportPower
 pressureOrientation : PressureOrientation
 conventionalCorrespondence : String

def componentLaws : List ComponentLaw := [
 ⟨"matter",.positive threeSpace (by decide),.emptyPressureOneForm,"w=0 and forward dilution a^-3"⟩,
 ⟨"radiation",.positive radiationPower (by decide),.outwardThirdOne,"w=1/3 and forward dilution a^-4"⟩,
 ⟨"vacuum",.emptyDilutionOneForm,.tensionOne,"w=-1 and forward dilution a^0"⟩]

theorem generatedBudgetCoefficients : CosmoCompleteBudget.cosmicBudgetStructure.map (fun b => (b.matter,b.vacuum))=
 .ok (matterToday,vacuumToday) := rfl
theorem generatedSpatialCount : FoldFirstReturn.generatorPeriod=.ok threeSpace := FoldFirstReturn.generatorPeriodThree

theorem rejectedNonpositive (value : Rat) (rejected : zero.blt value=false) :
 requirePositiveExact value=.error "cosmic transport requires a positive exact Fold stretch" := by
 unfold requirePositiveExact
 rw [rejected]
 rfl

theorem presentClosure : lateSquaredExpansion (normalize 1 1 (by decide))=.ok (normalize 1 1 (by decide)) := rfl

theorem equalityCube : matterVacuumEqualityCube.map (fun r => (r.num,r.den))=.ok (11,5) := rfl

theorem onsetCube : accelerationOnsetCube.map (fun r => (r.num,r.den))=.ok (22,5) := rfl

theorem presentAcceleration : presentAccelerationMagnitude.map (fun r => (r.num,r.den))=.ok (17,32) := rfl

theorem originalComponentTableComplete : componentLaws.length=3 := rfl
end SFT.Physics.CosmicComponentTransport
