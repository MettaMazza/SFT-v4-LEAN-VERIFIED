import SFT.Physics.MixingCorrespondence
namespace SFT.Physics.GenerationDepth
open LeptonIntervals VacuumLedgerProofs
structure Result where
 sites : List Rat
 sharedWaypoint : List Rat
 home : List Rat
 generatorSteps : Nat

def foldPart (value : Rat) : Except String Rat :=
 if !zero.blt value || (wholeRatio 1).blt value then
  .error "Fold action requires one exact positive part of the One"
 else
  let doubled := add value value
  .ok (if (wholeRatio 1).blt doubled then subtract doubled (wholeRatio 1) else doubled)
def generationDepth : Except String Result := do
 let sites ← MixingCorrespondence.leptonMassBasis
 let waypoint ← sites.mapM MixingCorrespondence.triplingFold
 let home ← waypoint.mapM foldPart
 let colour ← FoldFirstReturn.generatorPeriod
 if !(waypoint == List.replicate colour (normalize 1 2 (by decide))) ||
    !(home == List.replicate colour (wholeRatio 1)) then
  throw "generation sites did not share the two-stage return"
 let steps ← AlphaCovers.binaryCount
 pure ⟨sites,waypoint,home,steps⟩
def originalRecord : Result := ⟨MixingCorrespondence.originalLeptonBasis,
 List.replicate 3 (normalize 1 2 (by decide)),List.replicate 3 (wholeRatio 1),2⟩
theorem completeSourceRecord : generationDepth=.ok originalRecord := rfl
theorem firstStage : originalRecord.sites.mapM MixingCorrespondence.triplingFold=.ok originalRecord.sharedWaypoint := rfl
theorem secondStage : originalRecord.sharedWaypoint.mapM foldPart=.ok originalRecord.home := rfl
theorem twoStages : originalRecord.generatorSteps=2 := rfl
end SFT.Physics.GenerationDepth
