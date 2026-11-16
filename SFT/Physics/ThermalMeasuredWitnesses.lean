import SFT.Physics.HeliumIsotope
import SFT.Physics.ThermalHistoryCertificate
namespace SFT.Physics.ThermalMeasuredWitnesses
open LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def physicalHelium : Bool := match HeliumIsotope.isotopeClosureLedger with | .error _ => false | .ok l => l.physicalHeliumIsotopeShare == normalize 59 240 (by decide)
def thermalStructure : Bool := match ThermalHistoryCertificate.certificate with | .error _ => false | .ok c => c.temperatureTransport && c.visibility && c.acousticParity
def witnesses : List Witness := [⟨"physical-helium","The formal physical isotope share is exactly 59/240.",physicalHelium⟩,⟨"thermal-structure","Temperature, freezeout, visibility and acoustic witnesses remain closed.",thermalStructure⟩]
theorem physicalHeliumPassed : physicalHelium=true := rfl
theorem thermalStructurePassed : thermalStructure=true := by decide +kernel
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (physicalHelium && (thermalStructure && true)) = true
 rw [physicalHeliumPassed,thermalStructurePassed]
 rfl
end SFT.Physics.ThermalMeasuredWitnesses
