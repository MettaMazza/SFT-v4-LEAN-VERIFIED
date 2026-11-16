import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode35
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents36_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_7 [] = .ok state36_7 := rfl
theorem parents36_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_6 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state36_7 := rfl
theorem parents36_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_5 ["SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state36_7 := rfl
theorem parents36_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_4 ["SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state36_7 := rfl
theorem parents36_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_3 ["SFT-PHYS-THERMO-IRREVERSIBILITY-001","SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state36_7 := rfl
theorem parents36_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_2 ["SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-THERMO-IRREVERSIBILITY-001","SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state36_7 := rfl
theorem parents36_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_1 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-THERMO-IRREVERSIBILITY-001","SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state36_7 := rfl
theorem parents36_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_0 ["SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-THERMO-IRREVERSIBILITY-001","SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state36_7 := by
 change (reachesOne sourceDictionary534 534 memoNode656 "SFT-FOUNDATION-FOLD-DYNAMICS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-THERMO-IRREVERSIBILITY-001","SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall35]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_1 ["SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-THERMO-IRREVERSIBILITY-001","SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents36_1
theorem rootCall36 : reachesOne sourceDictionary534 535 memoNode656 "SFT-PHYS-BARYOGENESIS-DEPENDENCY-TERMINAL-021" = .ok result36 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state36_0 ["SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-THERMO-IRREVERSIBILITY-001","SFT-PHYS-MATTER-CKM-TERMINAL-004","SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-BARYOGENESIS-DEPENDENCY-TERMINAL-021" result.1)) = _
 rewrite [parents36_0]
 rfl
#print axioms rootCall36
end SFT.Physics.GrandLockRootTrace
