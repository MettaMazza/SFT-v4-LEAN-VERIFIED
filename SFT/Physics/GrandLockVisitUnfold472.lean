import SFT.Physics.GrandLockDependency
namespace SFT.Physics.GrandLockDependency
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem visitUnfold472 (rows : Dictionary (List String)) (active : Dictionary Unit) (complete : Complete) (name : String) :
 visit rows 472 active complete name =
 (if contains active name then .error "cycle in frozen dependency dictionary"
 else if contains complete.1 name then .ok complete
 else match get rows name with
 | none => .error "orphan dependency in frozen dictionary"
 | some deps => do
   let done ← recordFold (fun done dep => visit rows 471 (put active name ()) done dep) complete deps
   pure (put done.1 name (),done.2+1)) := rfl
#print axioms visitUnfold472
theorem visitCallFromFold472 (rows : Dictionary (List String)) (active : Dictionary Unit) (complete done : Complete) (name : String) (deps : List String)
 (ha : contains active name = false) (hc : contains complete.1 name = false) (hd : get rows name = some deps)
 (hf : recordFold (fun current dep => visit rows 471 (put active name ()) current dep) complete deps = .ok done) :
 visit rows 472 active complete name = .ok (put done.1 name (),done.2+1) := by
 rewrite [visitUnfold472, ha]
 rewrite [ite_eq_right Bool.false_ne_true]
 rewrite [hc]
 rewrite [ite_eq_right Bool.false_ne_true]
 rewrite [hd]
 dsimp only
 rewrite [hf]
 rfl
#print axioms visitCallFromFold472
end SFT.Physics.GrandLockDependency
