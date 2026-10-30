import SFT.Computation.ClassificationPrediction
namespace SFT.Computation.Generalization
open SFT.Computation.ClassificationPrediction
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure Model where
  training : Training
  sealed : Sealed training
  withheld : List String
  targets : List Target
  completeTargets : ∀ input, input ∈ withheld → ∃ t, t ∈ targets ∧ t.input = input
  heldApart : ∀ input, input ∈ withheld → ∀ row, row ∈ training.examples → input ≠ row.1

def targetRows (m : Model) : List Target := m.targets.filter (fun t => has m.withheld t.input)
def passes (m : Model) : Bool := (targetRows m).all (agrees m.training m.sealed)
def failures (m : Model) : List Target := (targetRows m).filter (fun t => !agrees m.training m.sealed t)

theorem targetMeaning (m : Model) (t : Target) : t ∈ targetRows m ↔ t ∈ m.targets ∧ t.input ∈ m.withheld := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

theorem exactPass (m : Model) : passes m = true ↔
    ∀ t, t ∈ targetRows m → predict m.training m.sealed t.input = .ok t.label := by
  constructor
  · intro h t held; exact (agreementMeaning _ _ _).mp (allTrueAtMember _ _ h t held)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun t held => (agreementMeaning _ _ _).mpr (h t held))

theorem everyWithheldChecked (m : Model) (checked : passes m = true) (input : String) (held : input ∈ m.withheld) :
    ∃ t, t ∈ m.targets ∧ t.input = input ∧ predict m.training m.sealed input = .ok t.label := by
  obtain ⟨t,ht,same⟩ := m.completeTargets input held
  have member := (targetMeaning m t).mpr ⟨ht,same.symm ▸ held⟩
  have good := (exactPass m).mp checked t member
  exact ⟨t,ht,same,same ▸ good⟩

theorem failureMeaning (m : Model) (t : Target) : t ∈ failures m ↔ t ∈ targetRows m ∧ agrees m.training m.sealed t = false := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(notTrue _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(notTrue _).mpr h.2⟩

theorem failureRejects (m : Model) (t : Target) (bad : t ∈ failures m) : passes m ≠ true := by
  intro checked; have p := (failureMeaning _ _).mp bad
  have yes := (agreementMeaning _ _ _).mpr ((exactPass m).mp checked t p.1)
  rw [yes] at p; cases p.2

theorem withheldNotTraining (m : Model) (input : String) (held : input ∈ m.withheld) (label : String) :
    (input,label) ∉ m.training.examples := fun bad => m.heldApart input held (input,label) bad rfl

structure StructuralCertificate (training : Training) (sealed : Sealed training) where
  generated : Nat → Target
  base : predict training sealed (generated 0).input = .ok (generated 0).label
  successor : ∀ n, predict training sealed (generated n).input = .ok (generated n).label →
    predict training sealed (generated (n+1)).input = .ok (generated (n+1)).label

theorem structuralFamily (training : Training) (sealed : Sealed training) (certificate : StructuralCertificate training sealed) (n : Nat) :
    predict training sealed (certificate.generated n).input = .ok (certificate.generated n).label := by
  induction n with
  | zero => exact certificate.base
  | succ n ih => exact certificate.successor n ih

theorem structuralCoversTargets (m : Model) (certificate : StructuralCertificate m.training m.sealed)
    (covers : ∀ t, t ∈ targetRows m → ∃ n, certificate.generated n = t) : passes m = true := by
  apply (exactPass m).mpr
  intro t held
  obtain ⟨n,same⟩ := covers t held
  exact same ▸ structuralFamily m.training m.sealed certificate n

structure Extension (first second : Model) : Prop where
  withheld : ∀ x, x ∈ first.withheld → x ∈ second.withheld
  targets : ∀ t, t ∈ first.targets → t ∈ second.targets
  predictions : ∀ input, predict second.training second.sealed input = predict first.training first.sealed input

theorem targetExtension (first second : Model) (inc : Extension first second) (t : Target) (held : t ∈ targetRows first) : t ∈ targetRows second := by
  have p := (targetMeaning _ _).mp held
  exact (targetMeaning _ _).mpr ⟨inc.targets _ p.1,inc.withheld _ p.2⟩

theorem failureExtension (first second : Model) (inc : Extension first second) (t : Target) (held : t ∈ failures first) : t ∈ failures second := by
  have p := (failureMeaning _ _).mp held
  have same : agrees second.training second.sealed t = agrees first.training first.sealed t := by
    unfold agrees
    rw [inc.predictions]
  exact (failureMeaning _ _).mpr ⟨targetExtension _ _ inc _ p.1,same.trans p.2⟩

theorem checkedOldTargets (first second : Model) (inc : Extension first second) (checked : passes second = true) (t : Target)
    (held : t ∈ targetRows first) : predict first.training first.sealed t.input = .ok t.label :=
  (inc.predictions t.input).symm.trans ((exactPass second).mp checked t (targetExtension _ _ inc _ held))

end SFT.Computation.Generalization
