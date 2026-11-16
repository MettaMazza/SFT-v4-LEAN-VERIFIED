import SFT.Physics.QuantumSupportDepth
import SFT.Mathematics.OrbitOrderIdentity
namespace SFT.Physics.QuantumSupportParity
open QuantumSupportPreparation SFT.Foundation.FractionReduction SFT.Mathematics.OrbitOrderIdentity
set_option maxHeartbeats 100000000
-- The Boolean records the returned orientation of the original count, not a signed scalar.
def phaseBit (point mode : Word) : Bool :=
 (((point.zip mode).filter (fun (a,b) => a==returned && b==returned)).length%2==1)
private theorem successorRemainder (n : Nat) : (n+1)%2=(n%2+1)%2 := by
 have split := remainderQuotient n 2 (by decide)
 calc
  (n+1)%2 = (n%2+2*(n/2)+1)%2 := congrArg (fun x => (x+1)%2) split.symm
  _ = (n%2+1+2*(n/2))%2 := by rw [Nat.add_right_comm]
  _ = (n%2+1)%2 := moduloAddMultiple _ _ _ (by decide)
private theorem successorBit (n : Nat) : ((n+1)%2==1)=(!(n%2==1)) := by
 rw [successorRemainder]
 have bound := Nat.mod_lt n (by decide : 0<2)
 cases h : n%2 with
 | zero => rfl
 | succ k =>
   cases k with
   | zero => rfl
   | succ k => rw [h] at bound; exact False.elim (Nat.not_lt_of_ge (Nat.succ_le_succ (Nat.succ_le_succ (Nat.zero_le k))) bound)

theorem originalHeldHeld (point mode : Word) :
 phaseBit (held::point) (held::mode)=phaseBit point mode := rfl
theorem originalHeldReturned (point mode : Word) :
 phaseBit (held::point) (returned::mode)=phaseBit point mode := rfl
theorem originalReturnedHeld (point mode : Word) :
 phaseBit (returned::point) (held::mode)=phaseBit point mode := rfl
theorem originalReturnedReturned (point mode : Word) :
 phaseBit (returned::point) (returned::mode)=(!(phaseBit point mode)) := by
 change ((((point.zip mode).filter (fun (a,b) => a==returned && b==returned)).length+1)%2==1) = _
 exact successorBit _
private theorem complementRemainder (n : Nat) : (n%2==0)=(!(n%2==1)) := by
 have bound := Nat.mod_lt n (by decide : 0<2)
 cases h : n%2 with
 | zero => rfl
 | succ k =>
   cases k with
   | zero => rfl
   | succ k => rw [h] at bound; exact False.elim (Nat.not_lt_of_ge (Nat.succ_le_succ (Nat.succ_le_succ (Nat.zero_le k))) bound)

theorem originalPhaseOperation (point mode : Word) (same : point.length=mode.length)
 (nonempty : point.isEmpty=false) :
 walshPhase point mode=.ok (if phaseBit point mode then returned else held) := by
 unfold walshPhase
 have eq := SFT.Foundation.CommonRefinement.naturalEqualityReflexive mode.length
 have guard : (point.length != mode.length)=false := by
  rw [same]
  change (!(mode.length==mode.length))=false
  rw [eq];rfl
 rw [guard,nonempty]
 change Except.ok (ε := String) (if (((point.zip mode).filter (fun (a,b) => a==returned && b==returned)).length%2==0) then held else returned)=_
 rw [complementRemainder]
 change Except.ok (ε := String) (if !phaseBit point mode then held else returned)=_
 cases phaseBit point mode <;> rfl
end SFT.Physics.QuantumSupportParity
