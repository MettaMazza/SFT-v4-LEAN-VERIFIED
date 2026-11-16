import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockTraceFoldStep
import SFT.Physics.GrandLockVisitUnfold534
import SFT.Physics.GrandLockVisitHits28
import SFT.Physics.GrandLockVisitNode2265
import SFT.Physics.GrandLockVisitHits30
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option Elab.async false
noncomputable def step2267 (state : Complete) (dep : String) : Except String Complete := visit sourceDictionary534 533 (put visitedNode12057 "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004" ()) state dep
theorem children2267_3 : recordFold step2267 after2266 [] = .ok after2266 := rfl
theorem children2267_2 : recordFold step2267 before2266 ["SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok after2266 := sourceFoldCall step2267 before2266 after2266 after2266 "SFT-PHYS-COSMO-COMPLETE-BUDGET-001" [] visitCall2266 children2267_3
theorem children2267_1 : recordFold step2267 before2265 ["SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok after2266 := sourceFoldCall step2267 before2265 after2265 after2266 "SFT-PHYS-MATTER-BARYON-PHOTON-003" ["SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] visitCall2265 children2267_2
theorem children2267_0 : recordFold step2267 before2139 ["SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] = .ok after2266 := sourceFoldCall step2267 before2139 after2139 after2266 "SFT-PHYS-MATTER-CKM-TERMINAL-004" ["SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] visitCall2139 children2267_1
theorem visitCall2267 : visit sourceDictionary534 534 visitedNode12057 before2267 "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004" = .ok after2267 :=
 visitCallFromFold534 sourceDictionary534 visitedNode12057 before2267 after2266 "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004" ["SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-003","SFT-PHYS-COSMO-COMPLETE-BUDGET-001"] (by rfl) (by rfl) (by rfl) children2267_0
#print axioms visitCall2267
end SFT.Physics.GrandLockDependencyTrace
