import SFT.Physics.GrandLockCertificate
namespace SFT.Physics.GrandLockCertificateEquality
open SFT.Host SFT.Host.Canonical
private theorem natSelf : (n : Nat) → (n == n) = true
 | 0 => rfl
 | n+1 => natSelf n
private theorem listSelf : (xs : List Nat) → (xs == xs) = true
 | [] => rfl
 | x::xs => by
   change ((x == x) && (xs == xs)) = true
   rewrite [natSelf x, listSelf xs]
   rfl
theorem sameValueSelf (v : Value) : RunningConvergenceMeasurement.sameValue v v = true := by
 unfold RunningConvergenceMeasurement.sameValue Text.equal
 exact listSelf _
#print axioms sameValueSelf
end SFT.Physics.GrandLockCertificateEquality
