import SFT.Physics.RadioactiveDecayProofs
namespace SFT.Physics.RadioactiveEmpiricalWitnesses
open RadioactiveDecay LeptonIntervals
set_option maxRecDepth 20000
def carrierCheck : Bool := primitiveTransitionClasses.length == 3 && (match survivalTrace (.integer 3) with
 | .error _ => false
 | .ok rows => rows == [normalize 1 2 (by decide),normalize 1 4 (by decide),normalize 1 8 (by decide)])
theorem carrierCheckPassed : carrierCheck = true := rfl
end SFT.Physics.RadioactiveEmpiricalWitnesses
