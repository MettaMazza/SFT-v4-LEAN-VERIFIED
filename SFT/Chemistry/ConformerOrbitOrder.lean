import SFT.Chemistry.ConformerCensus
namespace SFT.Chemistry.ConformerOrbitOrder
open ConformerAssignments ConformerCensus

-- conformer_census orders every orbit by the original assignment positions.
-- Filtering the ordered carrier retains exactly that order, without sorting
-- labels or selecting a new scientific ordering.
theorem orbitOrderRetained (carrier orbit : List Assignment) :
 (carrier.filter (containsAssignment orbit)).Sublist carrier := by
 induction carrier with
 | nil => exact List.Sublist.slnil
 | cons first rest ih =>
  change (match containsAssignment orbit first with | true => first::rest.filter (containsAssignment orbit) | false => rest.filter (containsAssignment orbit)).Sublist (first::rest)
  cases selected : containsAssignment orbit first with
  | false => exact List.Sublist.cons first ih
  | true => exact List.Sublist.cons_cons first ih

theorem orbitMembersExact (carrier orbit : List Assignment) (row : Assignment) :
 row ∈ carrier.filter (containsAssignment orbit) ↔
 row ∈ carrier ∧ containsAssignment orbit row = true := by
 induction carrier with
 | nil =>
  constructor
  · intro impossible; cases impossible
  · intro h; cases h.1
 | cons first rest ih =>
  cases selected : containsAssignment orbit first with
  | false =>
   have filtered : (first::rest).filter (containsAssignment orbit) = rest.filter (containsAssignment orbit) := by
    change (match containsAssignment orbit first with | true => _ | false => _) = _
    rw [selected]
   rw [filtered]
   constructor
   · intro member
     obtain ⟨present,kept⟩ := ih.mp member
     exact ⟨List.Mem.tail first present,kept⟩
   · intro ⟨present,kept⟩
     cases present with
     | head => rw [selected] at kept; cases kept
     | tail _ member => exact ih.mpr ⟨member,kept⟩
  | true =>
   have filtered : (first::rest).filter (containsAssignment orbit) = first::rest.filter (containsAssignment orbit) := by
    change (match containsAssignment orbit first with | true => _ | false => _) = _
    rw [selected]
   rw [filtered]
   constructor
   · intro member
     cases member with
     | head => exact ⟨List.Mem.head rest,selected⟩
     | tail _ member =>
      obtain ⟨present,kept⟩ := ih.mp member
      exact ⟨List.Mem.tail first present,kept⟩
   · intro ⟨present,kept⟩
     cases present with
     | head => exact List.Mem.head _
     | tail _ member => exact List.Mem.tail first (ih.mpr ⟨member,kept⟩)

-- The first remaining element in the retained generation order is the
-- source's min(remaining, key=assignment_order.__getitem__).
theorem firstRemaining (carrier remaining : List Assignment) :
 (carrier.filter (containsAssignment remaining)).head? =
 carrier.find? (containsAssignment remaining) := by
 induction carrier with
 | nil => rfl
 | cons first rest ih =>
  change (match containsAssignment remaining first with | true => first::rest.filter (containsAssignment remaining) | false => rest.filter (containsAssignment remaining)).head? =
   (match containsAssignment remaining first with | true => some first | false => rest.find? (containsAssignment remaining))
  cases selected : containsAssignment remaining first with
  | false => exact ih
  | true => rfl

-- Difference update retains every not-yet-removed assignment in the same order.
theorem removalOrderRetained (remaining orbit : List Assignment) :
 (remaining.filter fun row => !containsAssignment orbit row).Sublist remaining := by
 induction remaining with
 | nil => exact List.Sublist.slnil
 | cons first rest ih =>
  change (match !containsAssignment orbit first with | true => first::rest.filter (fun row => !containsAssignment orbit row) | false => rest.filter (fun row => !containsAssignment orbit row)).Sublist (first::rest)
  cases selected : containsAssignment orbit first with
  | false => exact List.Sublist.cons_cons first ih
  | true => exact List.Sublist.cons first ih
-- A retained prefix decomposition identifies the exact earliest surviving
-- generation position, not merely an arbitrary surviving representative.
theorem firstRemainingDecomposition (carrier remaining : List Assignment) (row : Assignment)
 (found : carrier.find? (containsAssignment remaining) = some row) :
 ∃ before after, carrier = before ++ row::after ∧
 before.all (fun candidate => !containsAssignment remaining candidate) = true ∧
 containsAssignment remaining row = true := by
 induction carrier with
 | nil => cases found
 | cons first rest ih =>
  change (match containsAssignment remaining first with | true => some first | false => rest.find? (containsAssignment remaining)) = some row at found
  cases selected : containsAssignment remaining first with
  | true =>
   rw [selected] at found
   have same : first = row := Option.some.inj found
   cases same
   exact ⟨[],rest,rfl,rfl,selected⟩
  | false =>
   rw [selected] at found
   obtain ⟨before,after,split,excluded,retained⟩ := ih found
   refine ⟨first::before,after,?_,?_,retained⟩
   · exact congrArg (List.cons first) split
   · change (!containsAssignment remaining first &&
      before.all (fun candidate => !containsAssignment remaining candidate)) = true
     rw [selected,excluded]
     rfl
end SFT.Chemistry.ConformerOrbitOrder
