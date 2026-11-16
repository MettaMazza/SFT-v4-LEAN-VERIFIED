import SFT.Physics.GrandLockDictionaryData
import SFT.Physics.GrandLockRootTraceData
import SFT.Physics.GrandLockRootNode355
namespace SFT.Physics.GrandLockRootTrace
open SFT.Physics.GrandLockDependency SFT.Physics.GrandLockDependencyProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem parents356_3 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state356_3 [] = .ok state356_3 := rfl
theorem parents356_2 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state356_2 ["SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002"] = .ok state356_3 := rfl
theorem parents356_1 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state356_1 ["SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002"] = .ok state356_3 := rfl
theorem parents356_0 : recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state356_0 ["SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002"] = .ok state356_3 := by
 change (reachesOne sourceDictionary534 534 memoNode5643 "SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003" >>= fun next => recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) next ["SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002"]) = _
 rewrite [rootCall355]
 change recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state356_1 ["SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002"] = _
 exact parents356_1
theorem rootCall356 : reachesOne sourceDictionary534 535 memoNode5643 "SFT-PHYS-NEUTRINO-MAJORANA-003" = .ok result356 := by
 change (do let result ← recordFold (fun ((found,cache) : Bool × Dictionary Bool) dep => if found then pure (found,cache) else reachesOne sourceDictionary534 534 cache dep) state356_0 ["SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003","SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001","SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002"]; pure (result.1,put result.2 "SFT-PHYS-NEUTRINO-MAJORANA-003" result.1)) = _
 rewrite [parents356_0]
 rfl
#print axioms rootCall356
end SFT.Physics.GrandLockRootTrace
