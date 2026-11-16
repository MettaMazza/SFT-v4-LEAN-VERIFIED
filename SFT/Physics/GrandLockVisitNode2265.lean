import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockTraceFoldStep
import SFT.Physics.GrandLockVisitUnfold533
import SFT.Physics.GrandLockVisitHits28
import SFT.Physics.GrandLockVisitNode2264
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
noncomputable def step2265 (state : Complete) (dep : String) : Except String Complete := visit sourceDictionary534 532 (put visitedNode12995 "SFT-PHYS-MATTER-BARYON-PHOTON-003" ()) state dep
theorem children2265_3 : recordFold step2265 after2264 [] = .ok after2264 := rfl
theorem children2265_2 : recordFold step2265 before2264 ["SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok after2264 := sourceFoldCall step2265 before2264 after2264 after2264 "SFT-PHYS-COSMO-COMPLETE-BUDGET-001" [] visitCall2264 children2265_3
theorem children2265_1 : recordFold step2265 before2141 ["SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok after2264 := sourceFoldCall step2265 before2141 after2141 after2264 "SFT-PHYS-NEUTRINO-CP-PHASE-002" ["SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] visitCall2141 children2265_2
theorem children2265_0 : recordFold step2265 before2140 ["SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok after2264 := sourceFoldCall step2265 before2140 after2140 after2264 "SFT-PHYS-MATTER-CKM-PHYSICAL-003" ["SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] visitCall2140 children2265_1
theorem visitCall2265 : visit sourceDictionary534 533 visitedNode12995 before2265 "SFT-PHYS-MATTER-BARYON-PHOTON-003" = .ok after2265 :=
 visitCallFromFold533 sourceDictionary534 visitedNode12995 before2265 after2264 "SFT-PHYS-MATTER-BARYON-PHOTON-003" ["SFT-PHYS-MATTER-CKM-PHYSICAL-003","SFT-PHYS-NEUTRINO-CP-PHASE-002","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] (by rfl) (by rfl) (by rfl) children2265_0
#print axioms visitCall2265
end SFT.Physics.GrandLockDependencyTrace
