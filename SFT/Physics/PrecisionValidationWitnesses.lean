import SFT.Physics.PrecisionValidationOperations
namespace SFT.Physics.PrecisionValidationWitnesses
open PrecisionValidationOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def electroweak : Except String (Bool × Bool × Bool) := do
 let weak ← interval "0.22342" "0.00009"
 let z ← interval "91.1880" "0.0020"
 let allW ← interval "80.395" "0.012"
 let compatibleW ← interval "80.3692" "0.0133"
 let result ← electroweakComparison weak z allW compatibleW
 pure (result.2.2.2.2.1,result.2.2.2.2.2.1,result.2.2.2.2.2.2)

def hierarchy : Except String Bool := do
 let planck ← interval "2.176 434 e-8" "0.000 024 e-8"
 let proton ← interval "1.672 621 925 95 e-27" "0.000 000 000 52 e-27"
 hierarchyComparison planck proton

theorem completeElectroweakVector : electroweak=.ok (true,true,false) := rfl
theorem completeHierarchyInterval : hierarchy=.ok true := rfl
end SFT.Physics.PrecisionValidationWitnesses
