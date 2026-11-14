import SFT.Physics.MixingCorrespondence
namespace SFT.Physics.ConfinementLift
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
structure Products where
 down : Rat
 up : Rat

def sharpenedProduct (colour binary depth : Nat) : Except String Rat := do
 let power ← AlphaCovers.positivePower (.integer (.ofNat colour)) (.integer (.ofNat depth))
 let interior ← positivePredecessor (.integer (.ofNat (binary*power)))
 let heldChannel ← LeptonRatios.divide (wholeRatio 1) (wholeRatio colour)
 LeptonRatios.divide (wholeRatio 1) (subtract (wholeRatio interior) heldChannel)
def sharpenedQuarkProducts : Except String Products := do
 let colour ← FoldFirstReturn.generatorPeriod
 let binary ← AlphaCovers.binaryCount
 let down ← sharpenedProduct colour binary 5
 let up ← sharpenedProduct colour binary 7
 pure ⟨down,up⟩
structure Result where
 downSharpenedProduct : Rat
 upSharpenedProduct : Rat
 lightestCarrierLift : Nat
 actedCarrier : String
 retainedCarriers : List String
def confinementLift : Except String Result := do
 let products ← sharpenedQuarkProducts
 let binary ← AlphaCovers.binaryCount
 pure ⟨products.down,products.up,binary,"lightest-unclosed-generation",["central","heavy"]⟩
def originalProducts : Products := ⟨normalize 3 1454 (by decide),normalize 3 13118 (by decide)⟩
def originalRecord : Result := ⟨originalProducts.down,originalProducts.up,2,"lightest-unclosed-generation",["central","heavy"]⟩
theorem bothProducts : sharpenedQuarkProducts=.ok originalProducts := rfl
theorem completeSourceRecord : confinementLift=.ok originalRecord := rfl
theorem completeCarrierSelection : originalRecord.actedCarrier="lightest-unclosed-generation" ∧
 originalRecord.retainedCarriers=["central","heavy"] ∧ originalRecord.lightestCarrierLift=2 := ⟨rfl,rfl,rfl⟩
end SFT.Physics.ConfinementLift
