import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootHits3
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents468_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_7 [] = .ok state468_7 := rfl
theorem parents468_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_6 ["SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state468_7 := rfl
theorem parents468_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_5 ["SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state468_7 := rfl
theorem parents468_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_4 ["SFT-PHYS-MATTER-SCATTERING-001","SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state468_7 := rfl
theorem parents468_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_3 ["SFT-INFO-CLASSICAL-PROBABILISTIC-001","SFT-PHYS-MATTER-SCATTERING-001","SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state468_7 := rfl
theorem parents468_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_2 ["SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001","SFT-PHYS-MATTER-SCATTERING-001","SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state468_7 := rfl
theorem parents468_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_1 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001","SFT-PHYS-MATTER-SCATTERING-001","SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state468_7 := rfl
theorem parents468_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_0 ["SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001","SFT-PHYS-MATTER-SCATTERING-001","SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"] = .ok state468_7 := by
 change (reachesOne sourceDictionary534 534 memoNode7327 "SFT-FOUNDATION-FOLD-DYNAMICS-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001","SFT-PHYS-MATTER-SCATTERING-001","SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"]) = _
 rewrite [rootCall467]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_1 ["SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001","SFT-PHYS-MATTER-SCATTERING-001","SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"] = _
 exact parents468_1
theorem rootCall468 : reachesOne sourceDictionary534 535 memoNode7327 "SFT-PHYS-SCATTERING-PARTITION-PATH-TERMINAL-017" = .ok result468 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state468_0 ["SFT-FOUNDATION-FOLD-DYNAMICS-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001","SFT-PHYS-MATTER-SCATTERING-001","SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006","SFT-MATH-EXACT-ARITHMETIC-001"]; pure (result.1,put result.2 "SFT-PHYS-SCATTERING-PARTITION-PATH-TERMINAL-017" result.1)) = _
 rewrite [parents468_0]
 rfl
#print axioms rootCall468
end SFT.Physics.GrandLockRootTrace
