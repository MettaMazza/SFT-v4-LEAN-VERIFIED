import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitHits28
import SFT.Physics.GrandLockVisitNode2167
import SFT.Physics.GrandLockVisitNode2189
import SFT.Physics.GrandLockVisitNode2211
import SFT.Physics.GrandLockVisitNode2219
import SFT.Physics.GrandLockVisitNode2255
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children2256_6 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) after2255 [] = .ok after2255 := rfl
theorem children2256_5 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) before2255 ["SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok after2255 := by
 change (visit sourceDictionary534 529 visitedNode13141 before2255 "SFT-PHYS-COSMO-STRUCTURE-GROWTH-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) done []) = _
 rewrite [visitCall2255]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) after2255 [] = _
 exact children2256_6
theorem children2256_4 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) before2219 ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok after2255 := by
 change (visit sourceDictionary534 529 visitedNode13141 before2219 "SFT-PHYS-GRAVITY-HORIZON-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) done ["SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"]) = _
 rewrite [visitCall2219]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) after2219 ["SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = _
 exact children2256_5
theorem children2256_3 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) before2211 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok after2255 := by
 change (visit sourceDictionary534 529 visitedNode13141 before2211 "SFT-PHYS-GRAVITY-WAVE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) done ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"]) = _
 rewrite [visitCall2211]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) after2211 ["SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = _
 exact children2256_4
theorem children2256_2 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) before2189 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok after2255 := by
 change (visit sourceDictionary534 529 visitedNode13141 before2189 "SFT-PHYS-GRAVITY-CURVATURE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) done ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"]) = _
 rewrite [visitCall2189]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) after2189 ["SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = _
 exact children2256_3
theorem children2256_1 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) before2167 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok after2255 := by
 change (visit sourceDictionary534 529 visitedNode13141 before2167 "SFT-PHYS-SPACETIME-CLOCK-RATE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) done ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"]) = _
 rewrite [visitCall2167]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) after2167 ["SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = _
 exact children2256_2
theorem children2256_0 : recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) before2159 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = .ok after2255 := by
 change (visit sourceDictionary534 529 visitedNode13141 before2159 "SFT-PHYS-SPACETIME-CAUSAL-ORDER-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) done ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"]) = _
 rewrite [visitCall2159]
 change recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) after2159 ["SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"] = _
 exact children2256_1
theorem visitCall2256 : visit sourceDictionary534 530 visitedNode13120 before2256 "SFT-PHYS-COSMO-BRANCH-BOUNDARY-001" = .ok after2256 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 529 visitedNode13141 done dep) before2159 ["SFT-PHYS-SPACETIME-CAUSAL-ORDER-001","SFT-PHYS-SPACETIME-CLOCK-RATE-001","SFT-PHYS-GRAVITY-CURVATURE-001","SFT-PHYS-GRAVITY-WAVE-001","SFT-PHYS-GRAVITY-HORIZON-001","SFT-PHYS-COSMO-STRUCTURE-GROWTH-001"]; pure (put done.1 "SFT-PHYS-COSMO-BRANCH-BOUNDARY-001" (),done.2+1)) = _
 rewrite [children2256_0]
 rfl
#print axioms visitCall2256
end SFT.Physics.GrandLockDependencyTrace
