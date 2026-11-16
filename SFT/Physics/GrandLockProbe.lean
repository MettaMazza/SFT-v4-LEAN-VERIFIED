import SFT.Physics.GrandLockHeadline
namespace SFT.Physics.GrandLockProbe
open UnifiedConstantsFoundation GrandLockVector SFT.Host
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def changedNames (original successor : Fields) : List String :=
 (original.filter fun (name,value)=>match lookup successor name with
  | none=>true
  | some other=> !fieldEqual value other).map Prod.fst
def sourceProbe : Except String (List String × List String) := do
 let original ← generatorValueVector (.integer 3)
 let successor ← generatorValueVector (.integer 4)
 pure (changedNames original successor,original.map Prod.fst)
theorem originalCompletePerturbation : sourceProbe.map (fun (changed,all)=>changed==all) = .ok true := rfl
#print axioms changedNames
#print axioms sourceProbe
#print axioms originalCompletePerturbation
end SFT.Physics.GrandLockProbe
