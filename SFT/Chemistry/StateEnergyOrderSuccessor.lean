import SFT.Chemistry.StateEnergyOrderDerivation
namespace SFT.Chemistry.StateEnergyOrder
open SFT.Host SFT.Physics.CapabilityValues
theorem buildRowsAppend (carrier : HeldLabel) (labels more : List String) (index : Nat) :
 buildRows carrier index (labels++more) = (do
  let prior ← buildRows carrier index labels
  let added ← buildRows carrier (index+labels.length) more
  pure (prior++added)) := by
 induction labels generalizing index with
 | nil =>
  cases h : buildRows carrier index more <;> (repeat rw [List.nil_append]) <;> (repeat rw [buildRows.eq_1]) <;> (repeat rw [Nat.add_zero]) <;> (repeat rw [h]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl
 | cons label labels ih =>
  cases state : heldLabel "molecular-electronic-state" label with
  | error e => (repeat rw [List.cons_append]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [state]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl
  | ok held =>
   cases zero : (index==0) with
   | false =>
    have notZero : ¬((index==0)=true) := fun h=>Bool.noConfusion (zero.symm.trans h)
    cases number : count index with
    | error e => (repeat rw [List.cons_append]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [state]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [ite_eq_right notZero]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [number]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl
    | ok n =>
     cases support : heldLabel "molecular-support" (Text.append label "-support") with
     | error e => (repeat rw [List.cons_append]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [state]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [ite_eq_right notZero]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [number]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [support]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl
     | ok heldSupport =>
      cases row : validState ⟨carrier,held,.count n,heldSupport⟩ with
      | error e => (repeat rw [List.cons_append]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [state]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [ite_eq_right notZero]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [number]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [support]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [row]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl
      | ok first =>
       have tail := ih (index+1)
       have nextIndex : index+1+labels.length = index+(labels.length+1) := by rw [Nat.add_right_comm, Nat.add_assoc]
       rw [nextIndex] at tail
       cases prior : buildRows carrier (index+1) labels <;> cases added : buildRows carrier (index+(labels.length+1)) more <;>
        (repeat rw [prior] at tail) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at tail) <;> (repeat rw [added] at tail) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at tail) <;>
        (repeat rw [List.cons_append]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [state]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [ite_eq_right notZero]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [number]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [support]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [row]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [tail]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [prior]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [List.length_cons]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [added]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl
   | true =>
    cases support : heldLabel "molecular-support" (Text.append label "-support") with
    | error e => (repeat rw [List.cons_append]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [state]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [ite_eq_left zero]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [support]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl
    | ok heldSupport =>
     cases row : validState ⟨carrier,held,.emptyOne "empty-One",heldSupport⟩ with
     | error e => (repeat rw [List.cons_append]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [state]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [ite_eq_left zero]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [support]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [row]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl
     | ok first =>
      have tail := ih (index+1)
      have nextIndex : index+1+labels.length = index+(labels.length+1) := by rw [Nat.add_right_comm, Nat.add_assoc]
      rw [nextIndex] at tail
      cases prior : buildRows carrier (index+1) labels <;> cases added : buildRows carrier (index+(labels.length+1)) more <;>
       (repeat rw [prior] at tail) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at tail) <;> (repeat rw [added] at tail) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at tail) <;>
       (repeat rw [List.cons_append]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [buildRows.eq_2]) <;> (repeat rw [state]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [ite_eq_left zero]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [support]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [row]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [tail]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [prior]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [List.length_cons]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> (repeat rw [added]) <;> (try dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]) <;> rfl

theorem successfulAppendRetainsRecords (carrier : HeldLabel) (labels more : List String) (index : Nat)
 (prior added : List OrderedMolecularState)
 (priorBuilt : buildRows carrier index labels = .ok prior)
 (addedBuilt : buildRows carrier (index+labels.length) more = .ok added) :
 buildRows carrier index (labels++more) = .ok (prior++added) := by
 rw [buildRowsAppend,priorBuilt]
 change (do let added ← buildRows carrier (index+labels.length) more; pure (prior++added)) = _
 rw [addedBuilt]
 rfl

#print axioms successfulAppendRetainsRecords
#print axioms buildRowsAppend
end SFT.Chemistry.StateEnergyOrder
