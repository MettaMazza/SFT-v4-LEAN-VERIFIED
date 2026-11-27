import SFT.Chemistry.ConformerPopulationDerivation
namespace SFT.Chemistry.ConformerPopulationClosure
open ConformerPopulation
open SFT.Physics.CapabilityValues

theorem censusClosure (conformers : ConformerCensus.Census) (observed : Observation)
 (rows : List Row) (out : PopulationCensus) (accepted : construct conformers observed rows=.ok out) :
 rows.length=conformers.equivalenceClasses.length ∧
 sameClasses (rows.map Row.equivalenceClass) conformers.equivalenceClasses=true ∧
 observed.trace.all (ConformerCensus.containsAssignment conformers.generatedAssignments)=true ∧
 (rows.map (fun r => occurrenceNat r.occurrence)).foldl Nat.add 0=observed.boundary.value := by
 change (if rows.length != conformers.equivalenceClasses.length then Except.error "population census requires every conformer class exactly once"
  else if !sameClasses (rows.map Row.equivalenceClass) conformers.equivalenceClasses then Except.error "population rows changed or reordered the conformer quotient"
  else if !(observed.trace.all (ConformerCensus.containsAssignment conformers.generatedAssignments)) then Except.error "observation trace contains an ungenerated conformer assignment"
  else if (rows.map (fun r => occurrenceNat r.occurrence)).foldl Nat.add 0 != observed.boundary.value then Except.error "population counts do not exhaust the complete observation boundary"
  else (rows.forM (fun r => validateCount (occurrences r.equivalenceClass observed.trace) observed.boundary r) >>= fun _ => Except.ok (PopulationCensus.mk conformers observed rows)))=Except.ok out at accepted
 split at accepted
 · cases accepted
 · rename_i lengthOK
   split at accepted
   · cases accepted
   · rename_i classesOK
     split at accepted
     · cases accepted
     · rename_i traceOK
       split at accepted
       · cases accepted
       · rename_i totalOK
         have lengthEq : rows.length=conformers.equivalenceClasses.length := by
          cases h : (rows.length==conformers.equivalenceClasses.length) with
          | true => exact Nat.eq_of_beq_eq_true h
          | false => exact False.elim (lengthOK (by change (!(rows.length==conformers.equivalenceClasses.length))=true; rw [h]; rfl))
         have classesEq : sameClasses (rows.map Row.equivalenceClass) conformers.equivalenceClasses=true := by
          cases h : sameClasses (rows.map Row.equivalenceClass) conformers.equivalenceClasses with
          | true => rfl
          | false => exact False.elim (classesOK (by rw [h]; rfl))
         have traceEq : observed.trace.all (ConformerCensus.containsAssignment conformers.generatedAssignments)=true := by
          cases h : observed.trace.all (ConformerCensus.containsAssignment conformers.generatedAssignments) with
          | true => rfl
          | false => exact False.elim (traceOK (by rw [h]; rfl))
         have totalEq : (rows.map (fun r => occurrenceNat r.occurrence)).foldl Nat.add 0=observed.boundary.value := by
          cases h : ((rows.map (fun r => occurrenceNat r.occurrence)).foldl Nat.add 0==observed.boundary.value) with
          | true => exact Nat.eq_of_beq_eq_true h
          | false => exact False.elim (totalOK (by change (!((rows.map (fun r => occurrenceNat r.occurrence)).foldl Nat.add 0==observed.boundary.value))=true; rw [h]; rfl))
         exact ⟨lengthEq,classesEq,traceEq,totalEq⟩

theorem everyRowChecked (observed : Observation) (rows : List Row)
 (checked : rows.forM (fun r => validateCount (occurrences r.equivalenceClass observed.trace) observed.boundary r)=Except.ok ()) :
 ∀ r, r∈rows → validateCount (occurrences r.equivalenceClass observed.trace) observed.boundary r=Except.ok () := by
 induction rows with
 | nil => intro r member; cases member
 | cons first rest ih =>
  unfold List.forM at checked
  cases h : validateCount (occurrences first.equivalenceClass observed.trace) observed.boundary first with
  | error e => rw [h] at checked; cases checked
  | ok unit =>
   cases unit
   rw [h] at checked
   intro r member
   cases member with
   | head => exact h
   | tail _ mem => exact ih checked r mem

theorem constructedRowsRetained (conformers : ConformerCensus.Census) (observed : Observation)
 (rows : List Row) (out : PopulationCensus) (accepted : construct conformers observed rows=.ok out) :
 out=PopulationCensus.mk conformers observed rows ∧
 ∀ r, r∈rows → validateCount (occurrences r.equivalenceClass observed.trace) observed.boundary r=Except.ok () := by
 change (if rows.length != conformers.equivalenceClasses.length then Except.error "population census requires every conformer class exactly once"
  else if !sameClasses (rows.map Row.equivalenceClass) conformers.equivalenceClasses then Except.error "population rows changed or reordered the conformer quotient"
  else if !(observed.trace.all (ConformerCensus.containsAssignment conformers.generatedAssignments)) then Except.error "observation trace contains an ungenerated conformer assignment"
  else if (rows.map (fun r => occurrenceNat r.occurrence)).foldl Nat.add 0 != observed.boundary.value then Except.error "population counts do not exhaust the complete observation boundary"
  else (rows.forM (fun r => validateCount (occurrences r.equivalenceClass observed.trace) observed.boundary r) >>= fun _ => Except.ok (PopulationCensus.mk conformers observed rows)))=Except.ok out at accepted
 split at accepted <;> try cases accepted
 split at accepted <;> try cases accepted
 split at accepted <;> try cases accepted
 split at accepted <;> try cases accepted
 cases checked : rows.forM (fun r => validateCount (occurrences r.equivalenceClass observed.trace) observed.boundary r) with
 | error e => rw [checked] at accepted; cases accepted
 | ok unit =>
  cases unit
  rw [checked] at accepted
  cases accepted
  exact ⟨rfl,everyRowChecked observed rows checked⟩
end SFT.Chemistry.ConformerPopulationClosure
