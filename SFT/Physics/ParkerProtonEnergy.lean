import SFT.Physics.AlphaRatio
import SFT.Physics.SectorInventory
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.ParkerProtonEnergy
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := wholeRatio 1
def alphaAtStage (stage : String) : Except String Rat := do
 let inverse ← if SFT.Host.Text.equal stage "leading" then AlphaRatio.inverseFineStructure (some (.integer 1))
  else if SFT.Host.Text.equal stage "terminal" then AlphaRatio.inverseFineStructure none
  else .error "alpha stage must be a generated promotion boundary"
 let value ← LeptonRatios.divide one (BoundaryGrowth.asFraction inverse)
 if !zero.blt value || !value.blt one then .error "alpha must remain a positive exact part of the One" else .ok value
def colourChannelCount : Except String Nat := do
 let channels ← PrimeSectorLadder.mediatorCount (.integer 3)
 if channels != 8 then .error "colour carrier count changed" else .ok channels
def protonEnergyFraction (stage : String := "terminal") : Except String Rat := do
 let channels ← colourChannelCount
 let a ← alphaAtStage stage
 let value := multiply (wholeRatio channels) (multiply a a)
 if !zero.blt value || !value.blt one then .error "proton energy fraction left the One" else .ok value
def historicalLeadingFraction : Except String Rat := protonEnergyFraction "leading"
def power (a : Rat) : Nat → Rat
 | 0 => one
 | n+1 => multiply (power a n) a
structure FormulaRow where
 sector : Nat
 channels : Nat
 power : Nat
 fraction : Rat
 structurallySelected : Bool
def forcedSectors : List Nat := [2,3,5,7]
def structuralFormulaCensus : Except String (List FormulaRow) := do
 let rows ← forcedSectors.mapM fun sector => do
  let channels ← PrimeSectorLadder.mediatorCount (.integer (.ofNat sector))
  ([1,2,3] : List Nat).mapM fun exponent => do
   let a ← alphaAtStage "terminal"
   pure (⟨sector,channels,exponent,multiply (wholeRatio channels) (power a exponent),sector==3 && exponent==2⟩ : FormulaRow)
 pure rows.flatten
theorem originalColourChannels : colourChannelCount=.ok 8 := rfl
theorem originalLeadingFraction : historicalLeadingFraction=.ok (normalize 500000 1173679081 (by decide)) := rfl
theorem originalTerminalFraction : protonEnergyFraction=.ok (normalize 108147617771025486368 253861190227103943729961 (by decide)) := rfl
theorem originalFormulaCoordinates : structuralFormulaCensus.map (fun rows => rows.map (fun r => (r.sector,r.power)))=
 .ok [(2,1),(2,2),(2,3),(3,1),(3,2),(3,3),(5,1),(5,2),(5,3),(7,1),(7,2),(7,3)] := rfl
theorem originalSelectedFormula : structuralFormulaCensus.map (fun rows => (rows.filter FormulaRow.structurallySelected).map (fun r => (r.sector,r.channels,r.power,r.fraction)))=
 .ok [(3,8,2,normalize 108147617771025486368 253861190227103943729961 (by decide))] := rfl
end SFT.Physics.ParkerProtonEnergy
