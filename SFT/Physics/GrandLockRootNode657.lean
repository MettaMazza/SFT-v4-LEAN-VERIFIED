import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits4
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents657_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_7 [] = .ok state657_7 := rfl
theorem parents657_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_6 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state657_7 := rfl
theorem parents657_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_5 ["SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state657_7 := rfl
theorem parents657_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_4 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state657_7 := rfl
theorem parents657_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_3 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state657_7 := rfl
theorem parents657_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_2 ["SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state657_7 := rfl
theorem parents657_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_1 ["SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009","SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state657_7 := rfl
theorem parents657_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_0 ["SFT-PHYS-STELLAR-GALACTIC-TIDAL-TERMINAL-067","SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009","SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state657_7 := by
 change (reachesOne sourceDictionary534 534 memoNode10664 "SFT-PHYS-STELLAR-GALACTIC-TIDAL-TERMINAL-067" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009","SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall656]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_1 ["SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009","SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents657_1
theorem rootCall657 : reachesOne sourceDictionary534 535 memoNode10664 "SFT-PHYS-VALIDATION-STELLAR-GALACTIC-TIDAL-068" = .ok result657 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state657_0 ["SFT-PHYS-STELLAR-GALACTIC-TIDAL-TERMINAL-067","SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009","SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-VALIDATION-STELLAR-GALACTIC-TIDAL-068" result.1)) = _
 rewrite [parents657_0]
 rfl
#print axioms rootCall657
end SFT.Physics.GrandLockRootTrace
