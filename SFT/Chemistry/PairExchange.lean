import SFT.Chemistry.StateSymmetry
import SFT.Physics.SpinStatisticsCondensation
namespace SFT.Chemistry.PairExchange
open SFT.Host SFT.Physics.CapabilityValues
open StateSymmetry (labelEqual)
def preserving : HeldLabel := ⟨"exchange-class","preserving-exchange",by rfl,by rfl⟩
def alternating : HeldLabel := ⟨"exchange-class","alternating-exchange",by rfl,by rfl⟩
def sameCellAdmitted : HeldLabel := ⟨"same-cell-status","same-cell-admitted",by rfl,by rfl⟩
def sameCellExcluded : HeldLabel := ⟨"same-cell-status","same-cell-excluded",by rfl,by rfl⟩
def exchangeProduct (left right : HeldLabel) : Except String HeldLabel :=
 if !(labelEqual left preserving || labelEqual left alternating) ||
    !(labelEqual right preserving || labelEqual right alternating) then
  .error "exchange composition requires one of the two generated held fibres"
 else .ok (if labelEqual left right then preserving else alternating)
structure PairState where
 molecularCarrier : HeldLabel
 stateIdentity : HeldLabel
 multiplicity : PositiveCount
 spinExchange : HeldLabel
 spatialExchange : HeldLabel
 totalExchange : HeldLabel
 sameCellStatus : HeldLabel

def validate (s : PairState) : Except String PairState := do
 if !Text.equal s.molecularCarrier.family "molecular-carrier" then
  throw "electron-pair state requires one molecular carrier"
 if !Text.equal s.stateIdentity.family "molecular-electronic-state" then
  throw "electron-pair state requires a retained molecular-state identity"
 if s.multiplicity.value != 1 && s.multiplicity.value != 3 then
  throw "a two-electron spin support has exactly the generated One or threefold sector"
 let requiredSpin := if s.multiplicity.value==1 then alternating else preserving
 let requiredSpatial := if s.multiplicity.value==1 then preserving else alternating
 if !labelEqual s.spinExchange requiredSpin || !labelEqual s.spatialExchange requiredSpatial then
  throw "spin and spatial exchange fibres must be complementary"
 if !labelEqual (← exchangeProduct s.spinExchange s.spatialExchange) alternating then
  throw "the total identical-electron word must remain alternating"
 if !labelEqual s.totalExchange alternating then
  throw "the declared total exchange class differs from the forced composition"
 let requiredSameCell := if labelEqual s.spatialExchange preserving then sameCellAdmitted else sameCellExcluded
 if !labelEqual s.sameCellStatus requiredSameCell then
  throw "same-cell support is fixed by the spatial exchange fibre"
 return s

def fromMultiplicity (molecule state : String) (multiplicity : PositiveCount) : Except String PairState := do
 let (spin,spatial,cell) ←
  if multiplicity.value==1 then pure (alternating,preserving,sameCellAdmitted)
  else if multiplicity.value==3 then pure (preserving,alternating,sameCellExcluded)
  else throw "two-electron pair multiplicity is outside the complete four-word spin census"
 validate ⟨← heldLabel "molecular-carrier" molecule,← heldLabel "molecular-electronic-state" state,
  multiplicity,spin,spatial,alternating,cell⟩

def occupancyCompatible (state : PairState) (occupancy : PositiveCount) : Except String Bool :=
 if occupancy.value==1 then .ok true
 else if occupancy.value==2 then .ok (labelEqual state.sameCellStatus sameCellAdmitted)
 else .error "one orbital support cannot retain a third identical-electron occurrence"
structure SameSupportPair where
 molecularCarrier : HeldLabel
 supportIdentity : HeldLabel
 singlet : PairState
 triplet : PairState

def validateSameSupport (pair : SameSupportPair) : Except String SameSupportPair := do
 if !Text.equal pair.molecularCarrier.family "molecular-carrier" then
  throw "exchange pair requires one molecular carrier"
 if !Text.equal pair.supportIdentity.family "molecular-orbital-support" then
  throw "exchange pair requires one retained orbital support"
 if !labelEqual pair.singlet.molecularCarrier pair.molecularCarrier ||
    !labelEqual pair.triplet.molecularCarrier pair.molecularCarrier then
  throw "exchange-paired states must retain one molecular carrier"
 if pair.singlet.multiplicity.value != 1 then
  throw "the One-width member must be the alternating spin sector"
 if pair.triplet.multiplicity.value != 3 then
  throw "the three-width member must be the preserving spin sector"
 if labelEqual pair.singlet.stateIdentity pair.triplet.stateIdentity then
  throw "complementary exchange sectors require distinct retained state identities"
 if labelEqual pair.singlet.spatialExchange pair.triplet.spatialExchange then
  throw "same-support exchange partners must retain complementary spatial fibres"
 return pair

def buildSameSupport (molecule support singlet triplet : String) : Except String SameSupportPair := do
 let carrier ← heldLabel "molecular-carrier" molecule
 let support ← heldLabel "molecular-orbital-support" support
 let one ← fromMultiplicity molecule singlet ⟨1,by decide⟩
 let three ← fromMultiplicity molecule triplet ⟨3,by decide⟩
 validateSameSupport ⟨carrier,support,one,three⟩

-- The already verified dependency supplies the complete four-word spin census.
theorem originalSpinSectorWidths :
 SFT.Physics.SpinStatisticsCondensation.exchangeSpinCensus.preserving.length = 3 ∧
 SFT.Physics.SpinStatisticsCondensation.exchangeSpinCensus.alternating.length = 1 := ⟨rfl,rfl⟩
theorem preservingPreserving : exchangeProduct preserving preserving = .ok preserving := rfl
theorem preservingAlternating : exchangeProduct preserving alternating = .ok alternating := rfl
theorem alternatingPreserving : exchangeProduct alternating preserving = .ok alternating := rfl
theorem alternatingAlternating : exchangeProduct alternating alternating = .ok preserving := rfl

#print axioms preserving
#print axioms alternating
#print axioms sameCellAdmitted
#print axioms sameCellExcluded
#print axioms exchangeProduct
#print axioms validate
#print axioms fromMultiplicity
#print axioms occupancyCompatible
#print axioms validateSameSupport
#print axioms buildSameSupport
#print axioms originalSpinSectorWidths
#print axioms preservingPreserving
#print axioms preservingAlternating
#print axioms alternatingPreserving
#print axioms alternatingAlternating
end SFT.Chemistry.PairExchange
