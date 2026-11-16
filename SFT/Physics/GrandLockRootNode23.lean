import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode22
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents23_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state23_3 [] = .ok state23_3 := rfl
theorem parents23_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state23_2 ["SFT-PHYS-MATTER-QUARK-CUBICS-003"] = .ok state23_3 := rfl
theorem parents23_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state23_1 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-QUARK-CUBICS-003"] = .ok state23_3 := rfl
theorem parents23_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state23_0 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-QUARK-CUBICS-003"] = .ok state23_3 := by
 change (reachesOne sourceDictionary534 532 memoNode430 "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) next ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-QUARK-CUBICS-003"]) = _
 rewrite [rootCall22]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state23_1 ["SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-QUARK-CUBICS-003"] = _
 exact parents23_1
theorem rootCall23 : reachesOne sourceDictionary534 533 memoNode430 "SFT-PHYS-MATTER-PROTON-ELECTRON-003" = .ok result23 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 532 cache dep) state23_0 ["SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001","SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001","SFT-PHYS-MATTER-QUARK-CUBICS-003"]; pure (result.1,put result.2 "SFT-PHYS-MATTER-PROTON-ELECTRON-003" result.1)) = _
 rewrite [parents23_0]
 rfl
#print axioms rootCall23
end SFT.Physics.GrandLockRootTrace
