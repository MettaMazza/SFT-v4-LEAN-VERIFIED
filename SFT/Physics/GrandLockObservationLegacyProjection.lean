import SFT.Physics.GrandLockObservationProofOriginal
import SFT.Physics.GrandLockRecordSteps
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical GrandLockDependency GrandLockObservationAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceMapIgnore {α β γ : Type} (f : α → Except String β) (g : α → γ)
 (rows : List α) (values : List β) (h : recordMap f rows = .ok values) :
 recordMap (fun row => do let _ ← f row; pure (g row)) rows = .ok (rows.map g) := by
 induction rows generalizing values with
 | nil => rfl
 | cons x xs ih =>
   change (do let y ← f x; let ys ← recordMap f xs; pure (y::ys)) = .ok values at h
   cases hx : f x with
   | error e =>
     rewrite [hx] at h
     cases h
   | ok y =>
     rewrite [hx] at h
     cases ht : recordMap f xs with
     | error e =>
       rewrite [ht] at h
       cases h
     | ok ys =>
       have tail := ih ys ht
       exact sourceMapCall (fun row => do let _ ← f row; pure (g row)) x xs (g x) (xs.map g)
         (by rewrite [hx]; rfl) tail
#print axioms sourceMapIgnore
end SFT.Physics.GrandLockObservationAnalysisProofs
