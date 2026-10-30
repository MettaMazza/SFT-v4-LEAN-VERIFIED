import SFT.Mathematics.GeometryTopology
import SFT.Mathematics.DiscreteComposition
namespace SFT.Computation.InverseProblem
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology

structure Model where
  sources : Collection
  observations : Collection
  forward : Relation
  sourceAdmission : generatedCollection sources = .ok sources
  observationAdmission : generatedCollection observations = .ok observations
  relationAdmission : generatedRelation sources observations forward = .ok forward

def predecessors (model : Model) (observation : Form) : Collection :=
  model.sources.filter (fun source => has model.forward (source,observation))

theorem predecessorExactly (model : Model) (observation source : Form) :
    source ∈ predecessors model observation ↔
      source ∈ model.sources ∧ (source,observation) ∈ model.forward := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

theorem observationRegistered (model : Model) (observation source : Form)
    (member : source ∈ predecessors model observation) : observation ∈ model.observations :=
  (generatedRelationContained model.sources model.observations model.forward model.forward
    model.relationAdmission (source,observation) ((predecessorExactly _ _ _).mp member).2).2

def reconstruct (model : Model) (observation : Form) : Option Form :=
  match predecessors model observation with
  | [source] => some source
  | [] | _ :: _ :: _ => none

theorem reconstructionExactly (model : Model) (observation source : Form) :
    reconstruct model observation = some source ↔ predecessors model observation = [source] := by
  unfold reconstruct
  cases rows : predecessors model observation with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons second tail => constructor <;> intro h <;> cases h

theorem uniqueReconstruction (model : Model) (observation source other : Form)
    (accepted : reconstruct model observation = some source)
    (possible : other ∈ model.sources ∧ (other,observation) ∈ model.forward) : other = source := by
  have member := (predecessorExactly model observation other).mpr possible
  rw [(reconstructionExactly model observation source).mp accepted] at member
  cases member with
  | head => rfl
  | tail _ impossible => cases impossible

theorem ambiguityPreserved (model : Model) (observation left right : Form)
    (leftPossible : left ∈ model.sources ∧ (left,observation) ∈ model.forward)
    (rightPossible : right ∈ model.sources ∧ (right,observation) ∈ model.forward)
    (different : left ≠ right) : reconstruct model observation = none := by
  cases result : reconstruct model observation with
  | none => rfl
  | some source =>
    have l := uniqueReconstruction model observation source left result leftPossible
    have r := uniqueReconstruction model observation source right result rightPossible
    exact False.elim (different (l.trans r.symm))

theorem reconstructedSource (model : Model) (observation source : Form)
    (accepted : reconstruct model observation = some source) :
    source ∈ model.sources ∧ (source,observation) ∈ model.forward := by
  apply (predecessorExactly model observation source).mp
  rw [(reconstructionExactly model observation source).mp accepted]
  exact List.Mem.head []

theorem excludedObservation (model : Model) (observation : Form)
    (outside : ¬ observation ∈ model.observations) : reconstruct model observation = none := by
  cases result : reconstruct model observation with
  | none => rfl
  | some source =>
    have p := reconstructedSource model observation source result
    exact False.elim (outside (observationRegistered model observation source
      ((predecessorExactly model observation source).mpr p)))

structure Exclusions where
  declared : Collection
  applied : Collection
  registered : ∀ source, source ∈ applied → source ∈ declared

def remainingPredecessors (model : Model) (observation : Form) (exclusions : Exclusions) : Collection :=
  (predecessors model observation).filter (fun source => !has exclusions.applied source)

theorem remainingExactly (model : Model) (observation source : Form) (exclusions : Exclusions) :
    source ∈ remainingPredecessors model observation exclusions ↔
      (source ∈ model.sources ∧ (source,observation) ∈ model.forward) ∧ ¬ source ∈ exclusions.applied := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    refine ⟨(predecessorExactly _ _ _).mp p.1,?_⟩
    intro member
    have present := (hasIff _ _).mpr member
    rw [present] at p
    cases p.2
  · intro h
    apply (filterMemberIff _ _ _).mpr
    refine ⟨(predecessorExactly _ _ _).mpr h.1,?_⟩
    cases present : has exclusions.applied source with
    | false => rfl
    | true => exact False.elim (h.2 ((hasIff _ _).mp present))

theorem undeclaredCannotExclude (model : Model) (observation source : Form) (exclusions : Exclusions)
    (possible : source ∈ predecessors model observation) (undeclared : ¬ source ∈ exclusions.declared) :
    source ∈ remainingPredecessors model observation exclusions :=
  (remainingExactly _ _ _ _).mpr ⟨(predecessorExactly _ _ _).mp possible,
    fun removed => undeclared (exclusions.registered source removed)⟩

def reconstructRemaining (model : Model) (observation : Form) (exclusions : Exclusions) : Option Form :=
  match remainingPredecessors model observation exclusions with
  | [source] => some source
  | [] | _ :: _ :: _ => none

theorem remainingReconstructionExactly (model : Model) (observation source : Form) (exclusions : Exclusions) :
    reconstructRemaining model observation exclusions = some source ↔
      remainingPredecessors model observation exclusions = [source] := by
  unfold reconstructRemaining
  cases rows : remainingPredecessors model observation exclusions with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons second tail => constructor <;> intro h <;> cases h

theorem exclusionReconstructionCertificate (model : Model) (observation source : Form) (exclusions : Exclusions)
    (accepted : reconstructRemaining model observation exclusions = some source) :
    (source ∈ model.sources ∧ (source,observation) ∈ model.forward) ∧
      ¬ source ∈ exclusions.applied ∧
      ∀ other, other ∈ remainingPredecessors model observation exclusions → other = source := by
  have singleton := (remainingReconstructionExactly _ _ _ _).mp accepted
  have member : source ∈ remainingPredecessors model observation exclusions := by
    rw [singleton]; exact List.Mem.head []
  have facts := (remainingExactly _ _ _ _).mp member
  refine ⟨facts.1,facts.2,?_⟩
  intro other retained
  rw [singleton] at retained
  cases retained with
  | head => rfl
  | tail _ impossible => cases impossible

theorem relationalComposition (first second : Relation) (source observation : Form) :
    (source,observation) ∈ composeRelations first second ↔
      ∃ middle, (source,middle) ∈ first ∧ (middle,observation) ∈ second := by
  constructor
  · intro member
    obtain ⟨p,hp,q,hq,linked,equal⟩ := compositionMemberOrigin first second _ member
    have left := congrArg Prod.fst equal
    have right := congrArg Prod.snd equal
    dsimp only at left right
    refine ⟨p.2,?_,?_⟩
    · rw [left]; exact hp
    · rw [right,← linked]; exact hq
  · intro ⟨middle,left,right⟩
    exact compositionRetainsLinkedPair first second (source,middle) (middle,observation) left right rfl

theorem predecessorRetention (original extended : Model)
    (sources : ∀ source, source ∈ original.sources → source ∈ extended.sources)
    (relations : ∀ pair, pair ∈ original.forward → pair ∈ extended.forward)
    (observation source : Form) (possible : source ∈ predecessors original observation) :
    source ∈ predecessors extended observation := by
  have p := (predecessorExactly _ _ _).mp possible
  exact (predecessorExactly _ _ _).mpr ⟨sources source p.1,relations _ p.2⟩

theorem singletonSource (model : Model) (source observation : Form)
    (one : model.sources = [source]) (edge : (source,observation) ∈ model.forward) :
    reconstruct model observation = some source := by
  apply (reconstructionExactly _ _ _).mpr
  unfold predecessors
  rw [one]
  have held := (hasIff _ _).mpr edge
  rw [List.filter_cons_of_pos (p := fun source => has model.forward (source,observation)) held]
  rfl

theorem filterAgrees (left right : Form → Bool) (source : Collection)
    (same : ∀ item, item ∈ source → left item = right item) :
    source.filter left = source.filter right := by
  induction source with
  | nil => rfl
  | cons head tail ih =>
    have first := same head (List.Mem.head tail)
    have rest := ih (fun item member => same item (List.Mem.tail head member))
    cases value : left head with
    | false =>
      have other := first.symm.trans value
      rw [List.filter_cons_of_neg (by rw [value]; intro h; cases h),
        List.filter_cons_of_neg (by rw [other]; intro h; cases h),rest]
    | true =>
      have other := first.symm.trans value
      rw [List.filter_cons_of_pos value,List.filter_cons_of_pos other,rest]

theorem predecessorSuccessor (original extended : Model) (fresh observation : Form)
    (sourceExtension : extended.sources = original.sources ++ [fresh])
    (oldRows : ∀ source, source ∈ original.sources →
      has extended.forward (source,observation) = has original.forward (source,observation)) :
    predecessors extended observation = predecessors original observation ++
      (if has extended.forward (fresh,observation) then [fresh] else []) := by
  unfold predecessors
  rw [sourceExtension,filterAppendExact,filterAgrees _ _ original.sources oldRows]
  cases freshRow : has extended.forward (fresh,observation) with
  | false =>
    rw [List.filter_cons_of_neg (by rw [freshRow]; intro h; cases h)]
    rfl
  | true =>
    rw [List.filter_cons_of_pos (p := fun source => has extended.forward (source,observation)) freshRow]
    rfl

end SFT.Computation.InverseProblem
