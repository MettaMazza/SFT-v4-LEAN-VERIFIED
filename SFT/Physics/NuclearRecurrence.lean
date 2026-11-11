import SFT.Physics.NuclearCompositions
namespace SFT.Physics.NuclearRecurrence
open NuclearCompositions SFT.Foundation.CommonRefinement

def oscillator (n : Nat) := (labelled (filled n)).length

def closure (n : Nat) : Nat :=
 if n+1≤3 then oscillator n else oscillator (n-1)+2*(n+1)

theorem oscillatorSuccessor (n : Nat) :
 oscillator (n+1)=oscillator n+2*(triples (n+1)).length := by
 unfold oscillator
 rw [labelledCount,labelledCount]
 change 2*(filled n ++ triples (n+1)).length=_
 rw [appendLength,Nat.mul_add]

theorem oscillatorNondecreasing (n : Nat) : oscillator n≤oscillator (n+1) := by
 rw [oscillatorSuccessor]
 exact Nat.le_add_right _ _

theorem reorderedValue (n : Nat) : closure (n+3)=oscillator (n+2)+2*(n+4) := by
 unfold closure
 have later : 3<n+3+1 := Nat.lt_of_lt_of_le (by decide : 3<4) (Nat.le_add_left 4 n)
 rw [ite_eq_right (Nat.not_le_of_lt later)]
 rfl

theorem nativeClosureValue (n : Nat) :
 NuclearClosure.nuclearClosure (.integer (.ofNat (n+1)))=.ok (closure n) := by
 cases n with
 | zero => rfl
 | succ n => cases n with
   | zero => rfl
   | succ n => cases n with
     | zero => rfl
     | succ n =>
       rw [NuclearClosure.afterThreshold (n+3)
         (Nat.lt_of_lt_of_le (by decide : 3<4) (Nat.le_add_left 4 n))]
       rw [oscillatorCountsCompleteSupport (n+2),reorderedValue]
       rfl

theorem closureStrictSuccessor (n : Nat) : closure n<closure (n+1) := by
 cases n with
 | zero => decide
 | succ n => cases n with
   | zero => decide
   | succ n => cases n with
     | zero => decide
     | succ n =>
       rw [reorderedValue n,reorderedValue (n+1)]
       have step : 2*(n+4)<2*(n+5) := by
         change 2*(n+4)<2*((n+4)+1)
         rw [Nat.mul_succ]
         exact Nat.lt_of_lt_of_le (Nat.lt_succ_self _) (Nat.le_succ _)
       exact Nat.add_lt_add_of_le_of_lt (oscillatorNondecreasing (n+2)) step

theorem closureStrictLater (a b : Nat) (later : a<b) : closure a<closure b := by
 induction b with
 | zero => cases later
 | succ b ih =>
   cases Nat.eq_or_lt_of_le (Nat.le_of_lt_succ later) with
   | inl eq => cases eq; exact closureStrictSuccessor _
   | inr lt => exact Nat.lt_trans (ih lt) (closureStrictSuccessor b)

theorem noClosureBetween82And126 (n : Nat) : ¬ (82<closure n ∧ closure n<126) := by
 intro h
 by_cases before : n<6
 · have below := closureStrictLater n 6 before
   cases Nat.eq_or_lt_of_le (Nat.le_of_lt_succ before) with
   | inl eq => cases eq; exact Nat.lt_irrefl 82 h.1
   | inr earlier => exact Nat.lt_asymm h.1 (closureStrictLater n 5 earlier)
 · have after := Nat.le_of_not_gt before
   cases Nat.eq_or_lt_of_le after with
   | inl eq => cases eq; exact Nat.lt_irrefl 126 h.2
   | inr later => exact Nat.lt_asymm h.2 (closureStrictLater 6 n later)
theorem exactNextClosures : closure 5=82 ∧ closure 6=126 ∧ closure 7=184 := ⟨rfl,rfl,rfl⟩

theorem noClosureBetween126And184 (n : Nat) : ¬ (126<closure n ∧ closure n<184) := by
 intro h
 by_cases before : n<7
 · cases Nat.eq_or_lt_of_le (Nat.le_of_lt_succ before) with
   | inl eq => cases eq; exact Nat.lt_irrefl 126 h.1
   | inr earlier => exact Nat.lt_asymm h.1 (closureStrictLater n 6 earlier)
 · have after := Nat.le_of_not_gt before
   cases Nat.eq_or_lt_of_le after with
   | inl eq => cases eq; exact Nat.lt_irrefl 184 h.2
   | inr later => exact Nat.lt_asymm h.2 (closureStrictLater 7 n later)

end SFT.Physics.NuclearRecurrence
