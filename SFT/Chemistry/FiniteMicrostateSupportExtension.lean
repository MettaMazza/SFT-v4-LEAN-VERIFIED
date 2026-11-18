import SFT.Chemistry.FiniteMicrostateSupport
namespace SFT.Chemistry.FiniteMicrostateSupportExtension
open SFT.Physics.CapabilityValues SFT.Chemistry.FiniteMicrostateSupport
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- These local equations expose the existing constructor's exact typed tuples.
private theorem readStatesLoop (states : List ChemicalMicrostate) (acc : List ChemicalMicrostate) (message : String) :
 List.mapM.loop (m:=Except String)
  (fun value : StateInput => match value with | .state state => pure state | .other => throw message)
  (states.map StateInput.state) acc = .ok (List.reverseAux acc states) := by
 induction states generalizing acc with
 | nil => rfl
 | cons state rest ih => exact ih (state::acc)
private theorem readStatesComplete (states : List ChemicalMicrostate) (message : String) :
 readStates (states.map StateInput.state) message=.ok states := readStatesLoop states [] message
private theorem readFibresLoop (fibres : List MacroObservationFibre) (acc : List MacroObservationFibre) :
 List.mapM.loop (m:=Except String)
  (fun value : FibreInput => match value with
   | .fibre fibre => pure fibre
   | .other => throw "'NoneType' object has no attribute 'macrostate_id'")
  (fibres.map FibreInput.fibre) acc=.ok (List.reverseAux acc fibres) := by
 induction fibres generalizing acc with
 | nil => rfl
 | cons fibre rest ih => exact ih (fibre::acc)
private theorem readFibresComplete (fibres : List MacroObservationFibre) :
 (fibres.map FibreInput.fibre).mapM (fun value => match value with
  | .fibre fibre => pure fibre
  | .other => throw "'NoneType' object has no attribute 'macrostate_id'") =
 (Except.ok fibres : Except String (List MacroObservationFibre)) := readFibresLoop fibres []
-- Successful FiniteChemicalSupport construction returns precisely the supplied
-- states and fibres, after the original uniqueness and partition guards.
theorem acceptedSupportRetainsTuples (states : List ChemicalMicrostate) (fibres : List MacroObservationFibre)
 (result : FiniteChemicalSupport)
 (accepted : makeSupport (.tuple (states.map StateInput.state)) (.tuple (fibres.map FibreInput.fibre))=.ok result) :
 result=⟨states,fibres⟩ := by
 cases states with
 | nil => cases accepted
 | cons first rest =>
  dsimp only [makeSupport,List.map,Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
  have read := readStatesComplete (first::rest) "chemical support contains a non-chemical state"
  dsimp only [List.map] at read
  rw [read] at accepted
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
  split at accepted <;> try { cases accepted }
  cases fibres with
  | nil => cases accepted
  | cons firstFibre restFibres =>
   dsimp only [List.map,Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
   have read := readFibresComplete (firstFibre::restFibres)
   dsimp only [List.map,Pure.pure,Except.pure] at read
   erw [read] at accepted
   dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
   split at accepted <;> try { cases accepted }
   split at accepted <;> try { cases accepted }
   exact (Except.ok.inj accepted).symm
-- These four fields are exactly the records inspected by the source's
-- finite_successor_preserves_prior_assignments, for arbitrary finite supports.
private theorem appendLength {α : Type} (xs : List α) (last : α) :
 (xs++[last]).length=xs.length+1 := by
 induction xs with
 | nil => rfl
 | cons first rest ih => exact congrArg Nat.succ ih
private theorem appendPrefix {α : Type} (xs : List α) (last : α) :
 (xs++[last]).take xs.length=xs := by
 induction xs with
 | nil => rfl
 | cons first rest ih => exact congrArg (List.cons first) ih
private theorem appendLast {α : Type} (xs : List α) (last : α) :
 (xs++[last]).getLast?=some last := by
 induction xs with
 | nil => rfl
 | cons first rest ih =>
  cases rest with
  | nil => rfl
  | cons next tail => exact ih
-- The source calls its unchanged support constructor on these appended tuples.
-- Its successful construction, rather than a replacement state transformation,
-- supplies all four original preservation observations.
theorem appendedSupportRetainsPriorAssignments (support : FiniteChemicalSupport)
 (state : ChemicalMicrostate) (macrostate : HeldLabel) (result : FiniteChemicalSupport)
 (accepted : makeSupport (.tuple ((support.microstates++[state]).map StateInput.state))
  (.tuple ((support.fibres++[(⟨macrostate,[state]⟩ : MacroObservationFibre)]).map FibreInput.fibre))=.ok result) :
 result.microstates.take (result.microstates.length-1)=support.microstates ∧
 result.fibres.take (result.fibres.length-1)=support.fibres ∧
 result.microstates.getLast?=some state ∧
 (result.fibres.getLast?).map MacroObservationFibre.microstates=some [state] := by
 have retained := acceptedSupportRetainsTuples (support.microstates++[state])
  (support.fibres++[(⟨macrostate,[state]⟩ : MacroObservationFibre)]) result accepted
 subst result
 refine ⟨?_,?_,?_,?_⟩
 · dsimp only
   rw [appendLength]
   exact appendPrefix _ _
 · dsimp only
   rw [appendLength]
   exact appendPrefix _ _
 · exact appendLast _ _
 · dsimp only
   rw [appendLast]
   rfl
private theorem taggedAppend {α β : Type} (tag : α → β) (xs : List α) (last : α) :
 (xs++[last]).map tag=xs.map tag++[tag last] := by
 induction xs with
 | nil => rfl
 | cons first rest ih => exact congrArg (List.cons (tag first)) ih
-- The accepted source successor itself supplies the appended constructor call.
-- All original duplicate-state, duplicate-class and held-class checks remain
-- inside appendGeneratedMicrostate; no new scientific condition is assumed.
theorem successfulGeneratedSuccessorPreservesAssignments (support : FiniteChemicalSupport)
 (state : ChemicalMicrostate) (macrostate : HeldLabel) (result : FiniteChemicalSupport)
 (accepted : appendGeneratedMicrostate support (.state state) (.held macrostate)=.ok result) :
 result.microstates.take (result.microstates.length-1)=support.microstates ∧
 result.fibres.take (result.fibres.length-1)=support.fibres ∧
 result.microstates.getLast?=some state ∧
 (result.fibres.getLast?).map MacroObservationFibre.microstates=some [state] := by
 cases hnew : support.microstates.any (equalState state) <;>
  cases hoccupied : support.fibres.any (fun f => DihedralTorsion.equalLabel f.macrostateId macrostate) <;>
   cases hfamily : SFT.Host.Text.equal macrostate.family "chemical-macrostate"
 all_goals
  dsimp (config := { instances := true }) only [appendGeneratedMicrostate,makeFibre,
   readStates,List.mapM,List.mapM.loop,Bind.bind,Pure.pure,Except.bind,Except.pure,
   distinctStates,List.any,List.reverse,List.reverseAux] at accepted
 all_goals
  erw [hnew] at accepted
  try erw [hoccupied] at accepted
  try erw [hfamily] at accepted
  try dsimp (config := { instances := true }) only [Bind.bind,Pure.pure,Except.bind,Except.pure,readStates,List.mapM,List.mapM.loop,distinctStates,List.any,List.reverse,List.reverseAux] at accepted
 all_goals try { cases accepted }
 rw [← taggedAppend StateInput.state support.microstates state] at accepted
 exact appendedSupportRetainsPriorAssignments support state macrostate result accepted
end SFT.Chemistry.FiniteMicrostateSupportExtension
