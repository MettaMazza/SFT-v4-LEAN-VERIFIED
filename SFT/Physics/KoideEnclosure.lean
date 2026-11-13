import SFT.Physics.LeptonSource
import Init.Data.Nat.Sqrt.Basic
namespace SFT.Physics.KoideEnclosure
open LeptonIntervals LeptonRatios
set_option maxRecDepth 20000

-- Original positive_sqrt_interval: integer seed followed by the two exact
-- correction loops. Proofs use the loop guards, not library sqrt axioms.
def squareScaled (k d : Nat) := k*k*d

theorem squareDominates (k d : Nat) (hd : 0 < d) : k+1 ≤ squareScaled (k+1) d := by
 have one : 1 ≤ k+1 := Nat.succ_le_succ (Nat.zero_le k)
 have a : k+1 ≤ (k+1)*(k+1) := by
  have h := Nat.mul_le_mul_left (k+1) one
  rw [Nat.mul_one] at h
  exact h
 have b : (k+1)*(k+1) ≤ ((k+1)*(k+1))*d := by
  have h := Nat.mul_le_mul_left ((k+1)*(k+1)) hd
  rw [Nat.mul_one] at h
  exact h
 exact Nat.le_trans a b

def adjustUp (n d : Nat) : Nat → Nat → Nat
 | 0,k => k
 | fuel+1,k => if squareScaled (k+1) d ≤ n then adjustUp n d fuel (k+1) else k

def adjustDown (n d : Nat) : Nat → Nat
 | 0 => 0
 | k+1 => if n < squareScaled (k+1) d then adjustDown n d k else k+1

theorem upUpper (n d : Nat) (hd : 0 < d) (fuel k : Nat)
 (enough : n < k+fuel) : n < squareScaled (adjustUp n d fuel k+1) d := by
 induction fuel generalizing k with
 | zero =>
   rw [Nat.add_zero] at enough
   exact Nat.lt_of_lt_of_le (Nat.lt_trans enough (Nat.lt_succ_self k)) (squareDominates k d hd)
 | succ fuel ih =>
   change n < squareScaled ((if squareScaled (k+1) d ≤ n then adjustUp n d fuel (k+1) else k)+1) d
   split
   · apply ih
     have equal : k+(fuel+1) = (k+1)+fuel := by
       rw [Nat.add_assoc, Nat.add_comm 1 fuel]
     rw [equal] at enough
     exact enough
   · exact Nat.lt_of_not_ge (by assumption)

theorem downLower (n d k : Nat) : squareScaled (adjustDown n d k) d ≤ n := by
 induction k with
 | zero =>
   change 0*0*d ≤ n
   rw [Nat.zero_mul]
   exact Nat.zero_le n
 | succ k ih =>
   change squareScaled (if n < squareScaled (k+1) d then adjustDown n d k else k+1) d ≤ n
   split
   · exact ih
   · exact Nat.le_of_not_gt (by assumption)

theorem downUpper (n d k : Nat) (upper : n < squareScaled (k+1) d) :
 n < squareScaled (adjustDown n d k+1) d := by
 induction k with
 | zero => exact upper
 | succ k ih =>
   change n < squareScaled ((if n < squareScaled (k+1) d then adjustDown n d k else k+1)+1) d
   split
   · exact ih (by assumption)
   · exact upper

def upward (n d k : Nat) : Nat :=
 if squareScaled (k+1) d ≤ n then adjustUp n d (n+1) (k+1) else k

theorem upwardUpper (n d : Nat) (hd : 0 < d) (k : Nat) :
 n < squareScaled (upward n d k+1) d := by
 unfold upward
 split
 · exact upUpper n d hd (n+1) (k+1)
    (Nat.lt_of_lt_of_le (Nat.lt_succ_self n) (Nat.le_add_left _ _))
 · exact Nat.lt_of_not_ge (by assumption)

def downward (n d : Nat) (k : Nat) : Nat :=
 match k with
 | 0 => 0
 | k+1 => if n < squareScaled (k+1) d then adjustDown n d k else k+1

theorem downwardBounds (n d k : Nat) (upper : n < squareScaled (k+1) d) :
 squareScaled (downward n d k) d ≤ n ∧ n < squareScaled (downward n d k+1) d := by
 cases k with
 | zero =>
   constructor
   · change 0*0*d ≤ n
     rw [Nat.zero_mul]
     exact Nat.zero_le n
   · exact upper
 | succ k =>
   change squareScaled (if n < squareScaled (k+1) d then adjustDown n d k else k+1) d ≤ n ∧ n < squareScaled ((if n < squareScaled (k+1) d then adjustDown n d k else k+1)+1) d
   split
   · exact ⟨downLower _ _ _,downUpper _ _ _ (by assumption)⟩
   · exact ⟨Nat.le_of_not_gt (by assumption),upper⟩

def floorRoot (n d : Nat) (_hd : 0 < d) : Nat :=
 downward n d (upward n d (Nat.sqrt (n/d)))

theorem floorBounds (n d : Nat) (hd : 0 < d) :
 squareScaled (floorRoot n d hd) d ≤ n ∧ n < squareScaled (floorRoot n d hd+1) d :=
 downwardBounds _ _ _ (upwardUpper _ _ hd _)

theorem boundsUnique (n d a b : Nat)
 (ha : squareScaled a d ≤ n ∧ n < squareScaled (a+1) d)
 (hb : squareScaled b d ≤ n ∧ n < squareScaled (b+1) d) : a = b := by
 apply Nat.le_antisymm
 · apply Nat.le_of_not_gt
   intro h
   have scaled : squareScaled (b+1) d ≤ squareScaled a d :=
    Nat.mul_le_mul_right d (Nat.mul_le_mul h h)
   exact Nat.lt_irrefl n (Nat.lt_of_lt_of_le hb.2 (Nat.le_trans scaled ha.1))
 · apply Nat.le_of_not_gt
   intro h
   have scaled : squareScaled (a+1) d ≤ squareScaled b d :=
    Nat.mul_le_mul_right d (Nat.mul_le_mul h h)
   exact Nat.lt_irrefl n (Nat.lt_of_lt_of_le ha.2 (Nat.le_trans scaled hb.1))

theorem floorUnique (n d : Nat) (hd : 0 < d) (k : Nat)
 (bounds : squareScaled k d ≤ n ∧ n < squareScaled (k+1) d) : floorRoot n d hd = k :=
 boundsUnique n d _ k (floorBounds n d hd) bounds

inductive UpRun (n d : Nat) : Nat → Nat → Prop where
 | stop (k : Nat) (h : ¬ squareScaled (k+1) d ≤ n) : UpRun n d k k
 | next (k result : Nat) (h : squareScaled (k+1) d ≤ n)
   (later : UpRun n d (k+1) result) : UpRun n d k result

theorem upSourceRun (n d : Nat) (hd : 0 < d) (fuel k : Nat)
 (enough : n < k+fuel) : UpRun n d k (adjustUp n d fuel k) := by
 induction fuel generalizing k with
 | zero =>
   exact .stop k (Nat.not_le_of_gt (upUpper n d hd 0 k enough))
 | succ fuel ih =>
   change UpRun n d k (if squareScaled (k+1) d ≤ n then adjustUp n d fuel (k+1) else k)
   split
   · apply UpRun.next k _ (by assumption)
     apply ih
     have equal : k+(fuel+1) = (k+1)+fuel := by
       rw [Nat.add_assoc, Nat.add_comm 1 fuel]
     rw [equal] at enough
     exact enough
   · exact .stop k (by assumption)

def positiveSqrtInterval (value : Rat) (binaryDepth : Int := 160) : Except String (Rat × Rat) :=
 if !zero.blt value || binaryDepth < 1 then
  .error "ValueError: square-root enclosure requires a positive value and depth"
 else
  let scale := 2^binaryDepth.toNat
  let n := value.num.natAbs*scale*scale
  let k := floorRoot n value.den (Nat.pos_of_ne_zero value.den_nz)
  let lower := normalize (Int.ofNat k) scale (Nat.pow_pos (by decide))
  if squareScaled k value.den = n then .ok (lower,lower)
  else .ok (lower,normalize (Int.ofNat (k+1)) scale (Nat.pow_pos (by decide)))
end SFT.Physics.KoideEnclosure
