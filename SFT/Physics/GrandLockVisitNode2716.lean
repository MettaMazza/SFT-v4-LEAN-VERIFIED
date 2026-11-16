import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockVisitTraceData
import SFT.Physics.GrandLockVisitNode2616
import SFT.Physics.GrandLockVisitHits34
import SFT.Physics.GrandLockVisitNode2656
import SFT.Physics.GrandLockVisitHits35
import SFT.Physics.GrandLockVisitNode2712
import SFT.Physics.GrandLockVisitHits36
namespace SFT.Physics.GrandLockDependencyTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem children2716_9 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2715 [] = .ok after2715 := rfl
theorem children2716_8 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2715 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2715 "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done []) = _
 rewrite [visitCall2715]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2715 [] = _
 exact children2716_9
theorem children2716_7 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2714 ["SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2714 "SFT-MATH-COMBINATORICS-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [visitCall2714]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2714 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact children2716_8
theorem children2716_6 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2713 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2713 "SFT-MATH-EXACT-ARITHMETIC-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done ["SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [visitCall2713]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2713 ["SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact children2716_7
theorem children2716_5 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2712 ["SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2712 "SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [visitCall2712]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2712 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact children2716_6
theorem children2716_4 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2658 ["SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2658 "SFT-PHYS-FIELD-INVERSE-SQUARE-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done ["SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [visitCall2658]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2658 ["SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact children2716_5
theorem children2716_3 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2657 ["SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2657 "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done ["SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [visitCall2657]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2657 ["SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact children2716_4
theorem children2716_2 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2656 ["SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2656 "SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done ["SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [visitCall2656]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2656 ["SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact children2716_3
theorem children2716_1 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2617 ["SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2617 "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done ["SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [visitCall2617]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2617 ["SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact children2716_2
theorem children2716_0 : recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2616 ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = .ok after2715 := by
 change (visit sourceDictionary534 531 visitedNode16155 before2616 "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003" >>= fun done => recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) done ["SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]) = _
 rewrite [visitCall2616]
 change recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) after2616 ["SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"] = _
 exact children2716_1
theorem visitCall2716 : visit sourceDictionary534 532 visitedNode15920 before2716 "SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061" = .ok after2716 := by
 change (do let done ← recordFold (fun done dep => visit sourceDictionary534 531 visitedNode16155 done dep) before2616 ["SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003","SFT-PHYS-MATTER-CONFINEMENT-LIFT-003","SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051","SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001","SFT-PHYS-FIELD-INVERSE-SQUARE-001","SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]; pure (put done.1 "SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061" (),done.2+1)) = _
 rewrite [children2716_0]
 rfl
#print axioms visitCall2716
end SFT.Physics.GrandLockDependencyTrace
