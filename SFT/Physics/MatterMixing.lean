import SFT.Physics.MatterDecay
namespace SFT.Physics.MatterMixing
open SFT.QuantumComputation.ReversibleModel
abbrev Branch := Word × String

def overlap (preparation interaction : Branch → Bool) (state : State) :=
  state.branches.filter (fun branch => preparation branch && interaction branch)

theorem overlapExactly (preparation interaction : Branch → Bool) (state : State) (branch : Branch) :
    branch ∈ overlap preparation interaction state ↔
      branch ∈ state.branches ∧ preparation branch = true ∧ interaction branch = true := by
  have selection (rows : List Branch) :
      branch ∈ rows.filter (fun b => preparation b && interaction b) ↔
        branch ∈ rows ∧ preparation branch = true ∧ interaction branch = true := by
    induction rows with
    | nil => constructor
             · intro h; cases h
             · intro h; cases h.1
    | cons b rest ih =>
      cases hp : preparation b <;> cases hi : interaction b <;> simp only [List.filter,hp,hi,Bool.and]
      all_goals
        constructor
        · intro h
          first
          | have z := ih.mp h; exact ⟨.tail _ z.1,z.2⟩
          | cases h with
            | head => exact ⟨.head _,hp,hi⟩
            | tail _ hm => have z := ih.mp hm; exact ⟨.tail _ z.1,z.2⟩
        · intro h
          cases h.1 with
          | head =>
            first
            | exact .head _
            | exact False.elim (Bool.noConfusion (hp.symm.trans h.2.1))
            | exact False.elim (Bool.noConfusion (hi.symm.trans h.2.2))
          | tail _ hm =>
            first
            | exact ih.mpr ⟨hm,h.2⟩
            | exact .tail _ (ih.mpr ⟨hm,h.2⟩)
  exact selection _

def count (preparation interaction : Branch → Bool) (state : State) := (overlap preparation interaction state).length

theorem overlapBound (preparation interaction : Branch → Bool) (state : State) :
    count preparation interaction state ≤ state.branches.length := by
  have bound (rows : List Branch) : (rows.filter (fun b => preparation b && interaction b)).length ≤ rows.length := by
    induction rows with
    | nil => exact Nat.le_refl _
    | cons b rest ih =>
      cases h : preparation b && interaction b <;> simp only [List.filter,h,List.length_cons]
      · exact Nat.le_trans ih (Nat.le_succ _)
      · exact Nat.succ_le_succ ih
  exact bound _

theorem finiteSpinPreservesConstituents {p : QuantumPhysicalState.Prepared} (action : QuantumPhysicalSpin.Action p) :
    support action.result = support p.state := QuantumPhysicalSpin.wordSupportRetained action

theorem fullCycleRestoresOverlap {p : QuantumPhysicalState.Prepared} (action : QuantumPhysicalSpin.Action p)
    (period : action.orientationTrace.length = p.state.phaseCycle.length)
    (preparation interaction : Branch → Bool) :
    overlap preparation interaction action.result = overlap preparation interaction p.state := by
  have same : action.result = p.state := Except.ok.inj
    (action.generated.symm.trans (QuantumPhysicalSpin.fullOrientationRecurrenceReturns p _ period))
  exact congrArg (overlap preparation interaction) same

theorem fullCycleRestoresCount {p : QuantumPhysicalState.Prepared} (action : QuantumPhysicalSpin.Action p)
    (period : action.orientationTrace.length = p.state.phaseCycle.length)
    (preparation interaction : Branch → Bool) :
    count preparation interaction action.result = count preparation interaction p.state :=
  congrArg List.length (fullCycleRestoresOverlap action period preparation interaction)

theorem exactPhaseResidueDeterminesOverlap {p : QuantumPhysicalState.Prepared}
    (a b : QuantumPhysicalSpin.Action p)
    (same : a.orientationTrace.length % p.state.phaseCycle.length = b.orientationTrace.length % p.state.phaseCycle.length)
    (preparation interaction : Branch → Bool) :
    overlap preparation interaction a.result = overlap preparation interaction b.result := by
  have ha := QuantumPhysicalSpin.cyclicLabelAction a
  have hb := QuantumPhysicalSpin.cyclicLabelAction b
  rw [same] at ha
  have branches := Option.some.inj (ha.symm.trans hb)
  exact congrArg (fun rows => rows.filter (fun branch => preparation branch && interaction branch)) branches

theorem nonalignedWitness (preparation interaction : Branch → Bool) (branch : Branch)
    (different : preparation branch ≠ interaction branch) : preparation ≠ interaction :=
  fun equal => different (congrFun equal branch)

theorem changedOverlapHasChangedReading (preparation interaction : Branch → Bool) (a b : State)
    (different : count preparation interaction a ≠ count preparation interaction b) :
    overlap preparation interaction a ≠ overlap preparation interaction b :=
  fun equal => different (congrArg List.length equal)
end SFT.Physics.MatterMixing
