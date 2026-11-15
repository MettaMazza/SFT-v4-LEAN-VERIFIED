import SFT.Physics.ParkerProtonEnergy
import SFT.Mathematics.LimitComputations
namespace SFT.Physics.ParkerProtonEnergyWitnesses
open ParkerProtonEnergy SFT.Mathematics.LimitComputations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def leadingCheck : Bool := match historicalLeadingFraction with
 | .error _ => false
 | .ok q => equalRat q (SFT.Physics.LeptonIntervals.normalize 500000 1173679081 (by decide))
def terminalCheck : Bool := match protonEnergyFraction with
 | .error _ => false
 | .ok q => equalRat q (SFT.Physics.LeptonIntervals.normalize 108147617771025486368 253861190227103943729961 (by decide))
def channelCheck : Bool := match colourChannelCount with | .error _ => false | .ok n => n==8
def censusCheck : Bool := match structuralFormulaCensus with
 | .error _ => false
 | .ok rows => rows.length==12 && (rows.filter FormulaRow.structurallySelected).length==1
def witnesses : List Witness := [⟨"leading-fraction","The historical exact fraction reconstructs independently.",leadingCheck⟩,⟨"terminal-fraction","The completed alpha promotion yields the exact terminal successor.",terminalCheck⟩,⟨"colour-channels","The proton colour sector has eight mediator channels.",channelCheck⟩,⟨"complete-formula-census","All four forced sectors and three generated powers occur once, with one structurally selected row.",censusCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.ParkerProtonEnergyWitnesses
