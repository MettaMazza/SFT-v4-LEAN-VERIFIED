import SFT.Physics.NuclearBindingMeasurement
import SFT.Physics.NuclearBindingPeakClosure
namespace SFT.Physics.NuclearBindingEmpiricalWitnesses
def carrierCheck : Bool :=
 let p := NuclearBindingPeakClosure.originalCertificate
 p.massNumber==62 && p.chargeCount==28 && p.neutronCount==34
theorem carrierCheckPassed : carrierCheck = true := rfl
theorem sourceCoordinate : NuclearBindingPeak.bindingPeakWithin 7 4 = .ok (some NuclearBindingPeakClosure.originalCertificate) := NuclearBindingPeakClosure.completePeak
end SFT.Physics.NuclearBindingEmpiricalWitnesses
