import SFT.Physics.LeptonRatios
import SFT.Physics.UnifiedConstantsHelpers
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.UnifiedConstantsFoundation
open UnifiedConstantsHelpers LeptonIntervals
abbrev CountInput := GeneratorOperations.CountInput
set_option maxRecDepth 100000
set_option maxHeartbeats 8000000

def count (n : Nat) : CountInput := .integer (.ofNat n)
def fraction (n d : Nat) : Except String Rat :=
 if hd : 0<d then .ok (normalize (.ofNat n) d hd)
 else .error "Fraction denominator cannot be zero"

structure OrderVector where
 binaryFibreCount : Nat
 generatorCount : Nat
 spatialRank : Nat
 boundaryRank : Nat
 downCoverDepth : Nat
 upCoverDepth : Nat
 inverseFineStructureLeading : Rat
 chargedLeptonLeadingProduct : Rat
 downCoverConjugate : Rat
 upCoverProduct : Rat
 darkToBaryonLeading : Rat
 darkShareLeading : Rat
 hubbleLeading : Rat
 planckHierarchyExponent : Rat
 localVacuumEnergyFloor : Rat
 halfOne : Rat

def foundationOrderVector : CountInput → Except String OrderVector
 | .boolean _ => .error "the dependency probe requires generator three or its successor"
 | .integer (.negSucc _) => .error "the dependency probe requires generator three or its successor"
 | .integer (.ofNat generator) =>
  if generator<3 then .error "the dependency probe requires generator three or its successor"
  else do
   let binary := 2
   let spatialRank := 3
   let volume ← positivePower (count generator) (count spatialRank)
   let down ← minimalBinaryCover (count volume) (count binary)
   let upVolume ← positivePower (count generator) (count (spatialRank+1))
   let up ← minimalBinaryCover (count upVolume) (count binary)
   let downSupport ← positivePower (count binary) (count down)
   let upSupport ← positivePower (count binary) (count up)
   let downPower ← positivePower (count down) (count generator)
   let cover := binary*downPower
   let boundary ← positivePower (count generator) (count binary)
   let alphaWhole ← fraction upSupport 1
   let alphaPart ← fraction (boundary*(cover+1)) cover
   let inverseAlpha := add alphaWhole alphaPart
   let generatorPower ← positivePower (count generator) (count down)
   let leptonDenominator ← positivePredecessor (count (binary*generatorPower))
   let leptonProduct ← fraction 1 leptonDenominator
   let downDenominator ← positivePredecessor (count (generator*downSupport))
   let downConjugate ← fraction 1 downDenominator
   let upDenominator ← positivePredecessor (count (generator*upSupport))
   let upProduct ← fraction 1 upDenominator
   let vacuumShare ← fraction (generator-1) generator
   let hubbleCover ← positivePower (count binary) (count spatialRank)
   let hubbleCover ← fraction hubbleCover 1
   let hubblePart ← LeptonRatios.divide vacuumShare hubbleCover
   let hubble := add (normalize 1 1 (by decide)) hubblePart
   let planckMassive ← positivePredecessor (count upSupport)
   let exponent ← fraction planckMassive binary
   let floorDenominator ← positivePower (count binary) (count (4*down))
   let floor ← fraction 1 floorDenominator
   let darkRatio ← fraction volume down
   let darkShare ← fraction volume downSupport
   let half ← fraction 1 binary
   .ok ⟨binary,generator,spatialRank,2,down,up,inverseAlpha,leptonProduct,downConjugate,upProduct,
     darkRatio,darkShare,hubble,exponent,floor,half⟩

inductive FieldValue where
 | count (value : Nat)
 | fraction (value : Rat)

def fieldEqual : FieldValue → FieldValue → Bool
 | .count x,y => match y with
   | .count y => x==y
   | .fraction _ => false
 | .fraction x,y => match y with
   | .count _ => false
   | .fraction y => (@decide (x.num=y.num) (Int.decEq x.num y.num)) && x.den==y.den
abbrev Fields := List (String × FieldValue)
def orderFields (v : OrderVector) : Fields := [
 ("binary_fibre_count",.count v.binaryFibreCount),("generator_count",.count v.generatorCount),
 ("spatial_rank",.count v.spatialRank),("boundary_rank",.count v.boundaryRank),
 ("down_cover_depth",.count v.downCoverDepth),("up_cover_depth",.count v.upCoverDepth),
 ("inverse_fine_structure_leading",.fraction v.inverseFineStructureLeading),
 ("charged_lepton_leading_product",.fraction v.chargedLeptonLeadingProduct),
 ("down_cover_conjugate",.fraction v.downCoverConjugate),("up_cover_product",.fraction v.upCoverProduct),
 ("dark_to_baryon_leading",.fraction v.darkToBaryonLeading),("dark_share_leading",.fraction v.darkShareLeading),
 ("hubble_leading",.fraction v.hubbleLeading),("planck_hierarchy_exponent",.fraction v.planckHierarchyExponent),
 ("local_vacuum_energy_floor",.fraction v.localVacuumEnergyFloor),("half_One",.fraction v.halfOne)]

theorem completeFoundationFields (v : OrderVector) : (orderFields v).length=16 := rfl

def heldFields : List String := ["binary_fibre_count","spatial_rank","boundary_rank","half_One"]
def dependentFields (v : OrderVector) : List String :=
 ((orderFields v).map Prod.fst).filter fun k => !(heldFields.any (SFT.Host.Text.equal k))
def lookup (fields : Fields) (key : String) : Option FieldValue :=
 (fields.find? (fun row => SFT.Host.Text.equal row.1 key)).map Prod.snd
def sameFields (keys : List String) (a b : Fields) : Bool := keys.all fun key =>
 match lookup a key with
 | none => false
 | some x => match lookup b key with
   | none => false
   | some y => fieldEqual x y
def changedFields (keys : List String) (a b : Fields) : Bool := keys.all fun key =>
 match lookup a key with
 | none => false
 | some x => match lookup b key with
   | none => false
   | some y => !(fieldEqual x y)

def sourceProbe : Except String (Bool × Bool) := do
 let generator ← FoldFirstReturn.generatorPeriod
 let leading ← foundationOrderVector (count generator)
 let successor ← foundationOrderVector (count (generator+1))
 .ok (changedFields (dependentFields leading) (orderFields leading) (orderFields successor),
      sameFields heldFields (orderFields leading) (orderFields successor))

theorem allTwelveDependents (v : OrderVector) : (dependentFields v).length=12 := rfl

theorem originalGenerator : (foundationOrderVector (count 3)).map (fun v => (orderFields v).length)=.ok 16 := rfl

theorem originalSuccessor : (foundationOrderVector (count 4)).map (fun v => (orderFields v).length)=.ok 16 := rfl

theorem originalGeneratorChangeAndHeldControls : sourceProbe=.ok (true,true) := rfl
end SFT.Physics.UnifiedConstantsFoundation
