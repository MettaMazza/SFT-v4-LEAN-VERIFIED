import SFT.Computation.SecurityPartition
namespace SFT.Computation.Inference
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation
abbrev Evidence := String × String
abbrev Hypothesis := String × List Evidence

def compatible (examples : List Evidence) (h : Hypothesis) : Bool := examples.all (fun e => has h.2 e)
def retained (examples : List Evidence) (hypotheses : List Hypothesis) : List Hypothesis := hypotheses.filter (compatible examples)
def eliminated (examples : List Evidence) (hypotheses : List Hypothesis) : List Hypothesis := hypotheses.filter (fun h => !compatible examples h)
def consistentHypotheses (examples : List Evidence) (hypotheses : List Hypothesis) : Except String (List String) :=
  if !distinct (hypotheses.map Prod.fst) then .error "ValueError: hypotheses must contain unique generated identities"
  else if examples.isEmpty || hypotheses.isEmpty then .error "ValueError: learning support requires generated examples and hypotheses"
  else .ok ((retained examples hypotheses).map Prod.fst)

theorem compatibilityMeaning (examples : List Evidence) (h : Hypothesis) : compatible examples h = true ↔ ∀ e, e ∈ examples → e ∈ h.2 := by
  constructor
  · intro checked e held; exact (hasIff _ _).mp (allTrueAtMember _ _ checked e held)
  · intro checked; exact (allTrueIffMembers _ _).mpr (fun e held => (hasIff _ _).mpr (checked e held))

theorem retainedMeaning (examples : List Evidence) (hypotheses : List Hypothesis) (h : Hypothesis) : h ∈ retained examples hypotheses ↔
    h ∈ hypotheses ∧ ∀ e, e ∈ examples → e ∈ h.2 := by
  constructor
  · intro held; have p := (filterMemberIff _ _ _).mp held; exact ⟨p.1,(compatibilityMeaning _ _).mp p.2⟩
  · intro held; exact (filterMemberIff _ _ _).mpr ⟨held.1,(compatibilityMeaning _ _).mpr held.2⟩

theorem eliminatedMeaning (examples : List Evidence) (hypotheses : List Hypothesis) (h : Hypothesis) : h ∈ eliminated examples hypotheses ↔
    h ∈ hypotheses ∧ compatible examples h = false := by
  constructor
  · intro held; have p := (filterMemberIff _ _ _).mp held; exact ⟨p.1,(notTrue _).mp p.2⟩
  · intro held; exact (filterMemberIff _ _ _).mpr ⟨held.1,(notTrue _).mpr held.2⟩

theorem exhaustive (examples : List Evidence) (hypotheses : List Hypothesis) (h : Hypothesis) (held : h ∈ hypotheses) :
    h ∈ retained examples hypotheses ∨ h ∈ eliminated examples hypotheses := by
  cases checked : compatible examples h with
  | false => exact .inr ((eliminatedMeaning _ _ _).mpr ⟨held,checked⟩)
  | true => exact .inl ((retainedMeaning _ _ _).mpr ⟨held,(compatibilityMeaning _ _).mp checked⟩)

theorem disjoint (examples : List Evidence) (hypotheses : List Hypothesis) (h : Hypothesis) (yes : h ∈ retained examples hypotheses) :
    h ∉ eliminated examples hypotheses := by
  intro no; have a := (compatibilityMeaning _ _).mpr ((retainedMeaning _ _ _).mp yes).2
  have b := ((eliminatedMeaning _ _ _).mp no).2; rw [a] at b; cases b

theorem moreEvidence (old new : List Evidence) (hypotheses : List Hypothesis)
    (inc : ∀ e, e ∈ old → e ∈ new) (h : Hypothesis) (held : h ∈ retained new hypotheses) : h ∈ retained old hypotheses := by
  have p := (retainedMeaning _ _ _).mp held
  exact (retainedMeaning _ _ _).mpr ⟨p.1,fun e he => p.2 e (inc e he)⟩

theorem hypothesisExtension (examples : List Evidence) (old new : List Hypothesis)
    (inc : ∀ h, h ∈ old → h ∈ new) (h : Hypothesis) (held : h ∈ retained examples old) : h ∈ retained examples new := by
  have p := (retainedMeaning _ _ _).mp held
  exact (retainedMeaning _ _ _).mpr ⟨inc h p.1,p.2⟩

structure ProofTrace (examples : List Evidence) (hypotheses : List Hypothesis) where
  hypothesis : Hypothesis
  source : hypothesis ∈ hypotheses
  rows : ∀ e, e ∈ examples → e ∈ hypothesis.2

def traceOfRetained (examples : List Evidence) (hypotheses : List Hypothesis) (h : Hypothesis)
    (held : h ∈ retained examples hypotheses) : ProofTrace examples hypotheses :=
  ⟨h,((retainedMeaning _ _ _).mp held).1,((retainedMeaning _ _ _).mp held).2⟩

theorem traceRetained (examples : List Evidence) (hypotheses : List Hypothesis) (trace : ProofTrace examples hypotheses) :
    trace.hypothesis ∈ retained examples hypotheses := (retainedMeaning _ _ _).mpr ⟨trace.source,trace.rows⟩

def uncertainty (examples : List Evidence) (hypotheses : List Hypothesis) : List (Hypothesis × Hypothesis) :=
  (retained examples hypotheses).flatMap (fun a => ((retained examples hypotheses).filter (fun b => decide (a.1 ≠ b.1))).map (fun b => (a,b)))

theorem uncertaintyMeaning (examples : List Evidence) (hypotheses : List Hypothesis) (a b : Hypothesis) :
    (a,b) ∈ uncertainty examples hypotheses ↔ a ∈ retained examples hypotheses ∧ b ∈ retained examples hypotheses ∧ a.1 ≠ b.1 := by
  constructor
  · intro h
    obtain ⟨x,hx,hy⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ h
    obtain ⟨y,held,same⟩ := memMapPreimage _ _ _ hy
    cases same; have p := (filterMemberIff _ _ _).mp held
    exact ⟨hx,p.1,of_decide_eq_true p.2⟩
  · intro h; exact SFT.Foundation.CommonRefinement.memFlatMap _ _ a (a,b) h.1
      (memMap _ b _ ((filterMemberIff _ _ _).mpr ⟨h.2.1,decide_eq_true h.2.2⟩))

theorem executableOutput (examples : List Evidence) (hypotheses : List Hypothesis)
    (unique : distinct (hypotheses.map Prod.fst) = true)
    (nonempty : (examples.isEmpty || hypotheses.isEmpty) = false) :
    consistentHypotheses examples hypotheses = .ok ((retained examples hypotheses).map Prod.fst) := by
  unfold consistentHypotheses
  rw [unique]; dsimp; rw [nonempty]; rfl

theorem outputNameMeaning (examples : List Evidence) (hypotheses : List Hypothesis) (name : String) :
    name ∈ (retained examples hypotheses).map Prod.fst ↔
      ∃ h, h ∈ hypotheses ∧ h.1 = name ∧ ∀ e, e ∈ examples → e ∈ h.2 := by
  constructor
  · intro h; obtain ⟨row,held,same⟩ := memMapPreimage _ _ _ h
    have p := (retainedMeaning _ _ _).mp held
    exact ⟨row,p.1,same,p.2⟩
  · intro ⟨row,held,same,compatible⟩
    have h := memMap Prod.fst row _ ((retainedMeaning _ _ _).mpr ⟨held,compatible⟩)
    exact same ▸ h

theorem duplicateNamesRejected (examples : List Evidence) (hypotheses : List Hypothesis)
    (duplicates : distinct (hypotheses.map Prod.fst) = false) :
    consistentHypotheses examples hypotheses = .error "ValueError: hypotheses must contain unique generated identities" := by
  unfold consistentHypotheses; rw [duplicates]; rfl

end SFT.Computation.Inference
