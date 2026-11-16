import SFT.Physics.GrandLockDependencyOriginalData
namespace SFT.Physics.GrandLockDependencyProofs
open SFT.Host.Canonical SFT.Physics.GrandLockDependency SFT.Physics RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
theorem originalOmission : (originalPhysics.all (contains (nameSet originalPhysics)) && originalPhysics.all (contains (nameSet originalPhysics))) = true := rfl
#print axioms originalOmission
end SFT.Physics.GrandLockDependencyProofs
