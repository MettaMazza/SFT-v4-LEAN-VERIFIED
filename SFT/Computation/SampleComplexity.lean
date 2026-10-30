import SFT.Computation.Inference
namespace SFT.Computation.SampleComplexity
open SFT.Computation.Inference
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure Model where
  hypotheses : List Hypothesis
  examples : List Evidence
  sample : List Evidence

def sampleSupported (m : Model) : Bool := m.sample.all (has m.examples)
def ambiguity (m : Model) : List (Hypothesis × Hypothesis) := uncertainty m.sample m.hypotheses

def teaches (m : Model) (target : Hypothesis) : Bool :=
  sampleSupported m && has m.hypotheses target && compatible m.sample target &&
  m.hypotheses.all (fun h => if compatible m.sample h then decide (h.1 = target.1) else true)

theorem exactTeaching (m : Model) (target : Hypothesis) : teaches m target = true ↔
    (∀ e, e ∈ m.sample → e ∈ m.examples) ∧ target ∈ m.hypotheses ∧
    (∀ e, e ∈ m.sample → e ∈ target.2) ∧
    ∀ h, h ∈ retained m.sample m.hypotheses → h.1 = target.1 := by
  constructor
  · intro checked
    have a := (andTrue _ _).mp checked; have b := (andTrue _ _).mp a.1; have c := (andTrue _ _).mp b.1
    refine ⟨fun e held => (hasIff _ _).mp (allTrueAtMember _ _ c.1 e held),(hasIff _ _).mp c.2,(compatibilityMeaning _ _).mp b.2,?_⟩
    intro h held; have p := (retainedMeaning _ _ _).mp held
    have q := allTrueAtMember _ _ a.2 h p.1
    rw [(compatibilityMeaning _ _).mpr p.2] at q
    exact of_decide_eq_true q
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨?_,(hasIff _ _).mpr h.2.1⟩,(compatibilityMeaning _ _).mpr h.2.2.1⟩,?_⟩
    · exact (allTrueIffMembers _ _).mpr (fun e held => (hasIff _ _).mpr (h.1 e held))
    · apply (allTrueIffMembers _ _).mpr
      intro row held
      cases test : compatible m.sample row with
      | false => rfl
      | true => exact decide_eq_true (h.2.2.2 row ((retainedMeaning _ _ _).mpr ⟨held,(compatibilityMeaning _ _).mp test⟩))

theorem teachingClosesAmbiguity (m : Model) (target : Hypothesis) (checked : teaches m target = true) (a b : Hypothesis) :
    (a,b) ∉ ambiguity m := by
  intro held; have p := (uncertaintyMeaning _ _ _ _).mp held
  have unique := ((exactTeaching _ _).mp checked).2.2.2
  exact p.2.2 ((unique a p.1).trans (unique b p.2.1).symm)

theorem incompatibleWitness (sample : List Evidence) (h : Hypothesis) (bad : compatible sample h = false) :
    ∃ e, e ∈ sample ∧ e ∉ h.2 := by
  induction sample with
  | nil => cases bad
  | cons e es ih =>
    cases first : has h.2 e with
    | false =>
      refine ⟨e,.head _,?_⟩
      intro held; have yes := (hasIff _ _).mpr held; rw [first] at yes; cases yes
    | true =>
      have tail : compatible es h = false := by
        change (has h.2 e && compatible es h) = false at bad
        rw [first] at bad; exact bad
      obtain ⟨x,held,absent⟩ := ih tail
      exact ⟨x,.tail _ held,absent⟩

theorem teachingWitness (m : Model) (target alternative : Hypothesis) (checked : teaches m target = true)
    (held : alternative ∈ m.hypotheses) (different : alternative.1 ≠ target.1) :
    ∃ e, e ∈ m.sample ∧ e ∈ target.2 ∧ e ∉ alternative.2 := by
  have p := (exactTeaching _ _).mp checked
  have rejected : compatible m.sample alternative = false := by
    cases test : compatible m.sample alternative with
    | false => rfl
    | true => exact False.elim (different (p.2.2.2 alternative ((retainedMeaning _ _ _).mpr ⟨held,(compatibilityMeaning _ _).mp test⟩)))
  obtain ⟨e,member,absent⟩ := incompatibleWitness m.sample alternative rejected
  exact ⟨e,member,p.2.2.1 e member,absent⟩

structure TeachingCertificate (m : Model) where
  target : Hypothesis
  checked : teaches m target = true

def resourceLedger (m : Model) : List (Evidence × Nat) := m.sample.map (fun e => (e,1))
def sampleSize (m : Model) : Nat := m.sample.length

theorem sampleExtension (first second : Model) (target : Hypothesis)
    (hypotheses : first.hypotheses = second.hypotheses)
    (more : ∀ e, e ∈ first.sample → e ∈ second.sample)
    (supported : ∀ e, e ∈ second.sample → e ∈ second.examples)
    (targetFits : ∀ e, e ∈ second.sample → e ∈ target.2)
    (checked : teaches first target = true) : teaches second target = true := by
  have p := (exactTeaching _ _).mp checked
  apply (exactTeaching _ _).mpr
  refine ⟨supported,hypotheses ▸ p.2.1,targetFits,?_⟩
  intro h held
  have old : h ∈ retained first.sample first.hypotheses := by
    rw [hypotheses]
    exact moreEvidence first.sample second.sample second.hypotheses more h held
  exact p.2.2.2 h old

end SFT.Computation.SampleComplexity
