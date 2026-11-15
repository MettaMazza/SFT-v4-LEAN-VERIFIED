import SFT.Physics.SymmetryAction
import SFT.Physics.LeptonIntervals
import SFT.Mathematics.LimitComputations
import SFT.Host.Text
namespace SFT.Physics.LandauerDemonLedger
open LeptonIntervals
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def quarterOne : Rat := normalize 1 4 (by decide)
def halfOne : Rat := normalize 1 2 (by decide)
def threeQuarterOne : Rat := normalize 3 4 (by decide)
def foldPart (value : FoldFirstReturn.Input) : Except String Rat :=
 (SymmetryAction.foldPart value).mapError (fun _ => "Fold requires one exact positive part")
def resetPreimages : Except String (Rat × Rat) := do
 let lowerImage ← foldPart (.fraction quarterOne)
 let upperImage ← foldPart (.fraction threeQuarterOne)
 if equalRat lowerImage halfOne && equalRat upperImage halfOne then .ok (quarterOne,threeQuarterOne)
 else .error "the reset fibre did not merge at half-One"
def erasedDistinctionCount : Except String Nat := do
 let preimages ← resetPreimages
 let distinctLabels := if equalRat preimages.1 preimages.2 then 1 else 2
 if distinctLabels != 2 then .error "reset requires the complete two-label fibre" else pure (distinctLabels-1)
def minimumThrow : Except String Rat := do
 let preimages ← resetPreimages
 pure (subtract preimages.2 preimages.1)
def reversibleResetLabels : List String := ["lower-preimage","upper-preimage"]
def resetIsReversibleWithRecord (record : String) : Bool :=
 reversibleResetLabels.any (fun label => SFT.Host.Text.equal record label)
structure CycleLedger where
 sortingGain : List String
 memorySupport : List String
 resetImage : List String
 erasedDistinctions : Nat
 environmentRecord : List String
 complete : Bool
def demonCycleLedger : Except String CycleLedger := do
 let gained := ["gas-speed-class"]
 let memory := ["lower-preimage","upper-preimage"]
 let exported := ["environment-reverse-label"]
 let erased ← erasedDistinctionCount
 let checked ← erasedDistinctionCount
 pure ⟨gained,memory,["ready-half-One"],erased,exported,gained.length==exported.length && exported.length==checked⟩
theorem originalTwoPreimages : resetPreimages=.ok (quarterOne,threeQuarterOne) := rfl
theorem originalBothImages : foldPart (.fraction quarterOne)=.ok halfOne ∧ foldPart (.fraction threeQuarterOne)=.ok halfOne := ⟨rfl,rfl⟩
theorem originalOneDistinction : erasedDistinctionCount=.ok 1 := rfl
theorem originalHalfOneThrow : minimumThrow=.ok halfOne := rfl
theorem originalCompleteLedger : demonCycleLedger=.ok ⟨["gas-speed-class"],["lower-preimage","upper-preimage"],["ready-half-One"],1,["environment-reverse-label"],true⟩ := rfl
end SFT.Physics.LandauerDemonLedger
