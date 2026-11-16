import SFT.Physics.SpinStatisticsOccupationEnumeration
namespace SFT.Physics.SpinStatisticsOccupationBounds
open SpinStatisticsCondensation SpinStatisticsOccupationEnumeration
set_option maxHeartbeats 100000000
private theorem sumAccumulator (counts : List Nat) (acc : Nat) :
 counts.foldl Nat.add acc=acc+counts.foldl Nat.add 0 := by
 induction counts generalizing acc with
 | nil => exact (Nat.add_zero acc).symm
 | cons c cs ih =>
   change cs.foldl Nat.add (acc+c)=acc+cs.foldl Nat.add (0+c)
   rw [ih (acc+c),ih (0+c),Nat.zero_add,Nat.add_assoc]
private theorem sumHead (c : Nat) (cs : List Nat) :
 (c::cs).foldl Nat.add 0=c+cs.foldl Nat.add 0 := by
 change cs.foldl Nat.add (0+c)=_
 rw [Nat.zero_add,sumAccumulator]
private theorem elementBound (word : List Nat) (c : Nat) (member : c∈word) : c≤word.foldl Nat.add 0 := by
 induction word with
 | nil => cases member
 | cons a rest ih =>
   rw [sumHead]
   cases member with
   | head => exact Nat.le_add_right _ _
   | tail _ h => exact Nat.le_trans (ih h) (Nat.le_add_left _ _)
-- No additional per-level ceiling: the source's cap N is already forced by sum=N.
theorem originalPreservingComplete (particles levels : Nat) (word : List Nat) :
 word∈walk particles levels [] particles ↔
 word.length=levels+1 ∧ word.foldl Nat.add 0=particles := by
 constructor
 · intro h
   obtain ⟨suffix,eq,length,total,_⟩ := originalWalkSound particles levels [] particles word h
   change word=suffix at eq
   rw [←eq] at length total
   exact ⟨length,total⟩
 · intro h
   apply originalWalkComplete particles levels [] word particles h.1 h.2
   intro c hc
   rw [←h.2]
   exact elementBound word c hc

theorem originalAlternatingComplete (particles levels : Nat) (word : List Nat) :
 word∈walk 1 levels [] particles ↔
 word.length=levels+1 ∧ word.foldl Nat.add 0=particles ∧ ∀ c∈word,c≤1 := by
 constructor
 · intro h
   obtain ⟨suffix,eq,length,total,capped⟩ := originalWalkSound 1 levels [] particles word h
   change word=suffix at eq
   rw [←eq] at length total capped
   exact ⟨length,total,capped⟩
 · intro h
   exact originalWalkComplete 1 levels [] word particles h.1 h.2.1 h.2.2
private theorem oneCellSumBound (word : List Nat) (capped : ∀ c∈word,c≤1) :
 word.foldl Nat.add 0≤word.length := by
 induction word with
 | nil => exact Nat.le_refl _
 | cons c cs ih =>
   rw [sumHead]
   have bound := Nat.add_le_add (capped c (.head cs)) (ih (fun d hd => capped d (.tail c hd)))
   rw [Nat.add_comm 1] at bound
   exact bound

theorem originalOverfullAlternatingEmpty (particles levels : Nat) (over : levels+1<particles) :
 walk 1 levels [] particles=[] := by
 cases eq : walk 1 levels [] particles with
 | nil => rfl
 | cons word rest =>
   have member : word∈walk 1 levels [] particles := by rw [eq];exact .head _
   have h := (originalAlternatingComplete particles levels word).mp member
   have bound := oneCellSumBound word h.2.2
   rw [h.1,h.2.1] at bound
   exact False.elim (Nat.not_le_of_gt over bound)
end SFT.Physics.SpinStatisticsOccupationBounds
