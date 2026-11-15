import SFT.Physics.SymmetryActionClasses
import SFT.Mathematics.OrbitLoopCompletion
namespace SFT.Physics.SymmetryActionClassCompleteness
open SymmetryActionClasses SymmetryActionIndexArrangements
open SFT.Mathematics SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalIndexSupportDistinct (n : Nat) : distinct (List.range n)=true := by
 induction n with
 | zero => rfl
 | succ n ih =>
  rw [OrbitLoopCompletion.rangeSuccessor]
  apply appendDistinct
  · exact ih
  · rfl
  · intro x member singleton
    cases singleton with
    | head => exact Nat.lt_irrefl n ((OrbitCyclotomic.rangeMember n n).mp member)
    | tail _ impossible => cases impossible
theorem originalEveryIndexBijection (n : Nat) (form : List Nat) :
 form∈arrangementsCore (List.range (n+1)) ↔ List.Perm form (List.range (n+1)) := by
 apply arrangementMembershipIff
 · intro empty
   have member := (OrbitCyclotomic.rangeMember (n+1) 0).mpr (Nat.zero_lt_succ n)
   rw [empty] at member
   cases member
 · exact originalIndexSupportDistinct _
theorem originalIndexCensusUnique (n : Nat) : distinct (arrangementsCore (List.range n))=true :=
 arrangementFamilyDistinct _ (originalIndexSupportDistinct n)
theorem originalSelectedCharges (charges : List String) (inputs : List (List Nat)) (output : List (List Int))
 (executed : selectCharges charges inputs=.ok output) (p : List Int) :
 p∈output ↔ ∃ q, q∈inputs ∧ q.map Int.ofNat=p ∧ symmetryPreservesCharge p charges=.ok true := by
 induction inputs generalizing output with
 | nil =>
  cases executed
  constructor
  · intro impossible; cases impossible
  · intro h; obtain ⟨q,impossible,_,_⟩ := h; cases impossible
 | cons q qs ih =>
  unfold selectCharges at executed
  dsimp only at executed
  cases checked : symmetryPreservesCharge (q.map Int.ofNat) charges with
  | error e => rw [checked] at executed; cases executed
  | ok keep =>
   rw [checked] at executed
   dsimp only [Except.bind,Bind.bind] at executed
   cases later : selectCharges charges qs with
   | error e => rw [later] at executed; cases executed
   | ok tail =>
    rw [later] at executed
    dsimp only [Except.bind,Bind.bind] at executed
    cases keep with
    | false =>
     cases executed
     constructor
     · intro held
       obtain ⟨a,member,same,passed⟩ := (ih tail later).mp held
       exact ⟨a,List.Mem.tail _ member,same,passed⟩
     · intro h
       obtain ⟨a,member,same,passed⟩ := h
       cases member with
       | head => rw [←same,checked] at passed; cases passed
       | tail _ member => exact (ih tail later).mpr ⟨a,member,same,passed⟩
    | true =>
     cases executed
     constructor
     · intro held
       cases held with
       | head => exact ⟨q,List.Mem.head _,rfl,checked⟩
       | tail _ held =>
        obtain ⟨a,member,same,passed⟩ := (ih tail later).mp held
        exact ⟨a,List.Mem.tail _ member,same,passed⟩
     · intro h
       obtain ⟨a,member,same,passed⟩ := h
       cases member with
       | head => rw [←same]; exact List.Mem.head _
       | tail _ member => exact List.Mem.tail _ ((ih tail later).mpr ⟨a,member,same,passed⟩)
theorem originalSelectedEdges (edges : List Edge) (inputs output : List (List Int))
 (executed : selectEdges edges inputs=.ok output) (p : List Int) :
 p∈output ↔ p∈inputs ∧ preservesEdgesAndCarriers p edges=.ok true := by
 induction inputs generalizing output with
 | nil =>
  cases executed
  constructor
  · intro impossible; cases impossible
  · intro h; cases h.1
 | cons q qs ih =>
  unfold selectEdges at executed
  cases checked : preservesEdgesAndCarriers q edges with
  | error e => rw [checked] at executed; cases executed
  | ok keep =>
   rw [checked] at executed
   dsimp only [Except.bind,Bind.bind] at executed
   cases later : selectEdges edges qs with
   | error e => rw [later] at executed; cases executed
   | ok tail =>
    rw [later] at executed
    dsimp only [Except.bind,Bind.bind] at executed
    cases keep with
    | false =>
     cases executed
     constructor
     · intro held
       have h := (ih tail later).mp held
       exact ⟨List.Mem.tail _ h.1,h.2⟩
     · intro h
       cases h.1 with
       | head => rw [checked] at h; cases h.2
       | tail _ member => exact (ih tail later).mpr ⟨member,h.2⟩
    | true =>
     cases executed
     constructor
     · intro held
       cases held with
       | head => exact ⟨List.Mem.head _,checked⟩
       | tail _ held =>
        have h := (ih tail later).mp held
        exact ⟨List.Mem.tail _ h.1,h.2⟩
     · intro h
       cases h.1 with
       | head => exact List.Mem.head _
       | tail _ member => exact List.Mem.tail _ ((ih tail later).mpr ⟨member,h.2⟩)
theorem originalChargeClassComplete (charge : String) (charges : List String)
 (output : List (List Int)) (executed : chargePreservingBijections (charge::charges)=.ok output)
 (p : List Int) : p∈output ↔ ∃ q, List.Perm q (List.range (charges.length+1)) ∧
 q.map Int.ofNat=p ∧ symmetryPreservesCharge p (charge::charges)=.ok true := by
 change selectCharges (charge::charges) (arrangementsCore (List.range (charges.length+1)))=.ok output at executed
 have filtered := originalSelectedCharges (charge::charges) _ output executed p
 constructor
 · intro member
   obtain ⟨q,held,same,passed⟩ := filtered.mp member
   exact ⟨q,(originalEveryIndexBijection charges.length q).mp held,same,passed⟩
 · intro member
   obtain ⟨q,held,same,passed⟩ := member
   exact filtered.mpr ⟨q,(originalEveryIndexBijection charges.length q).mpr held,same,passed⟩
theorem originalCompleteSymmetryClass (charge : String) (charges : List String) (edges : List Edge)
 (output : List (List Int)) (executed : completeSymmetryClass (charge::charges) edges=.ok output)
 (p : List Int) : p∈output ↔ (∃ q, List.Perm q (List.range (charges.length+1)) ∧
 q.map Int.ofNat=p ∧ symmetryPreservesCharge p (charge::charges)=.ok true) ∧
 preservesEdgesAndCarriers p edges=.ok true := by
 unfold completeSymmetryClass at executed
 cases generated : chargePreservingBijections (charge::charges) with
 | error e => rw [generated] at executed; cases executed
 | ok candidates =>
  rw [generated] at executed
  dsimp only [Except.bind,Bind.bind] at executed
  have filtered := originalSelectedEdges edges candidates output executed p
  have chargeClass := originalChargeClassComplete charge charges candidates generated p
  constructor
  · intro member
    have result := filtered.mp member
    exact ⟨chargeClass.mp result.1,result.2⟩
  · intro member
    exact filtered.mpr ⟨chargeClass.mpr member.1,member.2⟩
end SFT.Physics.SymmetryActionClassCompleteness
