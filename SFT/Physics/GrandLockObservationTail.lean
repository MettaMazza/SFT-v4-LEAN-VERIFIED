import SFT.Physics.GrandLockObservationProofOriginal
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical GrandLockDependency GrandLockObservationAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceMapTail {α β : Type} (f : α → Except String β) (x : α) (xs : List α) (y : β) (ys : List β)
 (head : f x = .ok y) (whole : recordMap f (x::xs) = .ok (y::ys)) : recordMap f xs = .ok ys := by
 change (do let b ← f x; let bs ← recordMap f xs; pure (b::bs)) = .ok (y::ys) at whole
 rewrite [head] at whole
 cases rest : recordMap f xs with
 | error e =>
   rewrite [rest] at whole
   cases whole
 | ok bs =>
   rewrite [rest] at whole
   have eq : bs = ys := congrArg List.tail (Except.ok.inj whole)
   cases eq
   rfl
theorem originalRowsCons : original_rows = original_rows.headD .null :: original_rows.tail := rfl
theorem originalIdsCons : original_ids = original_ids.headD "" :: original_ids.tail := rfl
theorem originalMeasurementsCons : original_measurements = original_measurements.headD false :: original_measurements.tail := rfl
#print axioms sourceMapTail
end SFT.Physics.GrandLockObservationAnalysisProofs
