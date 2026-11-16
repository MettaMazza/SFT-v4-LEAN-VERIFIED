import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode95
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents96_8 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_8 [] = .ok state96_8 := rfl
theorem parents96_7 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_7 ["SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state96_8 := rfl
theorem parents96_6 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_6 ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state96_8 := rfl
theorem parents96_5 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_5 ["SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state96_8 := rfl
theorem parents96_4 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_4 ["SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state96_8 := rfl
theorem parents96_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_3 ["SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state96_8 := rfl
theorem parents96_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_2 ["SFT-INFO-SYMBOL-DISTINCTION-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state96_8 := rfl
theorem parents96_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_1 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state96_8 := rfl
theorem parents96_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_0 ["SFT-MATH-SELF-SIMILAR-CONVERGENCE-002","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = .ok state96_8 := by
 change (reachesOne sourceDictionary534 533 memoNode1669 "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) next ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]) = _
 rewrite [rootCall95]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_1 ["SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"] = _
 exact parents96_1
theorem rootCall96 : reachesOne sourceDictionary534 534 memoNode1669 "SFT-PHYS-LYAPUNOV-KS-CORRESPONDENCE-TERMINAL-008" = .ok result96 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 533 cache dep) state96_0 ["SFT-MATH-SELF-SIMILAR-CONVERGENCE-002","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-FOUNDATION-FOLD-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-PHYS-MEAS-TARGET-CUSTODY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]; pure (result.1,put result.2 "SFT-PHYS-LYAPUNOV-KS-CORRESPONDENCE-TERMINAL-008" result.1)) = _
 rewrite [parents96_0]
 rfl
#print axioms rootCall96
end SFT.Physics.GrandLockRootTrace
