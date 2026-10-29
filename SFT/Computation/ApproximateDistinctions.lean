import SFT.InformationScience.ConservationExtension
namespace SFT.Computation.ApproximateDistinctions
open SFT.InformationScience ConservationLedger ConservationComposition
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.GeometryTopology SFT.Mathematics.DiscreteObjects

-- Exact objective distinctions are the input ledger, rather than all pairs of
-- feasible identities (which may already have equal objectives).
def lost (feasible : List String) (exact approximate : Observation) : List Pair :=
  (retained feasible exact).filter (fun pair => decide (image approximate pair.1 = image approximate pair.2))

def kept (feasible : List String) (exact approximate : Observation) : List Pair :=
  (retained feasible exact).filter (fun pair => decide (image approximate pair.1 ≠ image approximate pair.2))

theorem lossMeaning (feasible : List String) (exact approximate : Observation) (pair : Pair) :
    pair ∈ lost feasible exact approximate ↔
      pair ∈ retained feasible exact ∧ image approximate pair.1 = image approximate pair.2 := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem keptMeaning (feasible : List String) (exact approximate : Observation) (pair : Pair) :
    pair ∈ kept feasible exact approximate ↔
      pair ∈ retained feasible exact ∧ image approximate pair.1 ≠ image approximate pair.2 := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem completeLedger (feasible : List String) (exact approximate : Observation) (pair : Pair)
    (member : pair ∈ retained feasible exact) :
    pair ∈ lost feasible exact approximate ∨ pair ∈ kept feasible exact approximate := by
  by_cases same : image approximate pair.1 = image approximate pair.2
  · exact Or.inl ((lossMeaning _ _ _ _).mpr ⟨member,same⟩)
  · exact Or.inr ((keptMeaning _ _ _ _).mpr ⟨member,same⟩)

theorem disjointLedger (feasible : List String) (exact approximate : Observation) (pair : Pair)
    (loss : pair ∈ lost feasible exact approximate) (keep : pair ∈ kept feasible exact approximate) : False :=
  ((keptMeaning _ _ _ _).mp keep).2 (((lossMeaning _ _ _ _).mp loss).2)

theorem lossIsOriginalDifference (feasible : List String) (exact approximate : Observation) (pair : Pair)
    (loss : pair ∈ lost feasible exact approximate) :
    image exact pair.1 ≠ image exact pair.2 ∧ image approximate pair.1 = image approximate pair.2 := by
  have h := (lossMeaning _ _ _ _).mp loss
  exact ⟨((retainedMeaning _ _ _).mp h.1).2,h.2⟩

theorem unchangedHasNoLoss (feasible : List String) (exact : Observation) (pair : Pair) :
    ¬ pair ∈ lost feasible exact exact := by
  intro h
  have p := lossIsOriginalDifference _ _ _ _ h
  exact p.1 p.2

theorem lossPersists (feasible : List String) (exact approximate next : Observation) (pair : Pair)
    (loss : pair ∈ lost feasible exact approximate) :
    pair ∈ lost feasible exact (composedRows feasible approximate next) := by
  have p := (lossMeaning _ _ _ _).mp loss
  have source := ((retainedMeaning _ _ _).mp p.1).1
  have closedBefore := (closedMeaning _ _ _).mpr ⟨source,p.2⟩
  exact (lossMeaning _ _ _ _).mpr ⟨p.1,((closedMeaning _ _ _).mp (closedPersists _ _ _ _ closedBefore)).2⟩

theorem keptAfterComposition (feasible : List String) (exact approximate next : Observation) (pair : Pair)
    (keep : pair ∈ kept feasible exact (composedRows feasible approximate next)) :
    pair ∈ kept feasible exact approximate := by
  have p := (keptMeaning _ _ _ _).mp keep
  apply (keptMeaning _ _ _ _).mpr
  refine ⟨p.1,?_⟩
  intro same
  exact disjointLedger _ _ _ _ (lossPersists _ _ _ _ _ ((lossMeaning _ _ _ _).mpr ⟨p.1,same⟩)) keep

theorem extensionPreservesLoss (feasible extended : List String) (exact approximate exactNext approximateNext : Observation)
    (pair : Pair) (source : pair ∈ lost feasible exact approximate)
    (retain : pair ∈ retained feasible exact → pair ∈ retained extended exactNext)
    (left : image approximateNext pair.1 = image approximate pair.1)
    (right : image approximateNext pair.2 = image approximate pair.2) :
    pair ∈ lost extended exactNext approximateNext := by
  have p := (lossMeaning _ _ _ _).mp source
  exact (lossMeaning _ _ _ _).mpr ⟨retain p.1,left.trans (p.2.trans right.symm)⟩

theorem extensionPreservesKept (feasible extended : List String) (exact approximate exactNext approximateNext : Observation)
    (pair : Pair) (source : pair ∈ kept feasible exact approximate)
    (retain : pair ∈ retained feasible exact → pair ∈ retained extended exactNext)
    (left : image approximateNext pair.1 = image approximate pair.1)
    (right : image approximateNext pair.2 = image approximate pair.2) :
    pair ∈ kept extended exactNext approximateNext := by
  have p := (keptMeaning _ _ _ _).mp source
  apply (keptMeaning _ _ _ _).mpr
  refine ⟨retain p.1,?_⟩
  intro same
  exact p.2 (left.symm.trans (same.trans right))

end SFT.Computation.ApproximateDistinctions
