import SFT.InformationScience.ConservationCardinality
namespace SFT.InformationScience.ConservationExtension
open ConservationLedger
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

theorem validSuccessor (source : List String) (mapping : Observation) (fresh label : String)
    (valid : validateTransformation source mapping = .ok mapping) (new : ¬ fresh ∈ source) :
    validateTransformation (source ++ [fresh]) (mapping ++ [(fresh,label)]) = .ok (mapping ++ [(fresh,label)]) :=
  (ConservationLedger.validationMeaning _ _ _).mpr
    ((MutualObservation.validationMeaning _ _ _).mp
      (MutualExtension.validSuccessor _ _ _ _ (observationAdmitted _ _ valid) new))

theorem fibreSuccessor (source : List String) (mapping : Observation) (fresh value label : String)
    (new : ¬ fresh ∈ source) :
    fibre (source ++ [fresh]) (mapping ++ [(fresh,value)]) label =
      fibre source mapping label ++ (if value = label then [fresh] else []) :=
  EntropyExtension.fibreSuccessor _ _ _ _ _ new

theorem pairSuccessorOrder (source : List String) (fresh : String) :
    EncodingLoss.sourcePairs (source ++ [fresh]) = EntropyExtension.extendedPairs fresh source :=
  EntropyExtension.pairSuccessorOrder _ _

theorem pairSuccessorMembership (source : List String) (fresh : String) (pair : Pair) :
    pair ∈ EncodingLoss.sourcePairs (source ++ [fresh]) ↔
      pair ∈ EncodingLoss.sourcePairs source ∨ ∃ old, old ∈ source ∧ pair = (old,fresh) := by
  rw [pairSuccessorOrder]
  exact EntropyExtension.pairSuccessorMembership _ _ _

theorem oldImage (source : List String) (mapping : Observation) (fresh value state : String)
    (new : ¬ fresh ∈ source) (old : state ∈ source) :
    image (mapping ++ [(fresh,value)]) state = image mapping state :=
  EntropyExtension.oldImage _ _ _ _ (fun eq => new (eq ▸ old))

theorem retainedSuccessor (source : List String) (mapping : Observation) (fresh value : String)
    (new : ¬ fresh ∈ source) (pair : Pair) :
    pair ∈ retained (source ++ [fresh]) (mapping ++ [(fresh,value)]) ↔
      pair ∈ retained source mapping ∨ ∃ old, old ∈ source ∧ pair = (old,fresh) ∧ image mapping old ≠ some value := by
  constructor
  · intro h
    have p := (retainedMeaning _ _ _).mp h
    cases (pairSuccessorMembership _ _ _).mp p.1 with
    | inl prior =>
      have endpoints := EncodingLoss.pairSources _ _ _ prior
      have relation := p.2
      rw [oldImage _ _ _ _ _ new endpoints.1,oldImage _ _ _ _ _ new endpoints.2] at relation
      exact Or.inl ((retainedMeaning _ _ _).mpr ⟨prior,relation⟩)
    | inr added =>
      obtain ⟨old,ho,eq⟩ := added
      cases eq
      have relation := p.2
      change image (mapping ++ [(fresh,value)]) old ≠ image (mapping ++ [(fresh,value)]) fresh at relation
      rw [oldImage _ _ _ _ _ new ho,imageLastWins] at relation
      exact Or.inr ⟨old,ho,rfl,relation⟩
  · intro h
    apply (retainedMeaning _ _ _).mpr
    cases h with
    | inl prior =>
      have p := (retainedMeaning _ _ _).mp prior
      have endpoints := EncodingLoss.pairSources _ _ _ p.1
      refine ⟨(pairSuccessorMembership _ _ _).mpr (Or.inl p.1),?_⟩
      rw [oldImage _ _ _ _ _ new endpoints.1,oldImage _ _ _ _ _ new endpoints.2]
      exact p.2
    | inr added =>
      obtain ⟨old,ho,eq,relation⟩ := added
      cases eq
      refine ⟨(pairSuccessorMembership _ _ _).mpr (Or.inr ⟨old,ho,rfl⟩),?_⟩
      change image (mapping ++ [(fresh,value)]) old ≠ image (mapping ++ [(fresh,value)]) fresh
      rw [oldImage _ _ _ _ _ new ho,imageLastWins]
      exact relation

theorem closedSuccessor (source : List String) (mapping : Observation) (fresh value : String)
    (new : ¬ fresh ∈ source) (pair : Pair) :
    pair ∈ closed (source ++ [fresh]) (mapping ++ [(fresh,value)]) ↔
      pair ∈ closed source mapping ∨ ∃ old, old ∈ source ∧ pair = (old,fresh) ∧ image mapping old = some value := by
  constructor
  · intro h
    have p := (closedMeaning _ _ _).mp h
    cases (pairSuccessorMembership _ _ _).mp p.1 with
    | inl prior =>
      have endpoints := EncodingLoss.pairSources _ _ _ prior
      have relation := p.2
      rw [oldImage _ _ _ _ _ new endpoints.1,oldImage _ _ _ _ _ new endpoints.2] at relation
      exact Or.inl ((closedMeaning _ _ _).mpr ⟨prior,relation⟩)
    | inr added =>
      obtain ⟨old,ho,eq⟩ := added
      cases eq
      have relation := p.2
      change image (mapping ++ [(fresh,value)]) old = image (mapping ++ [(fresh,value)]) fresh at relation
      rw [oldImage _ _ _ _ _ new ho,imageLastWins] at relation
      exact Or.inr ⟨old,ho,rfl,relation⟩
  · intro h
    apply (closedMeaning _ _ _).mpr
    cases h with
    | inl prior =>
      have p := (closedMeaning _ _ _).mp prior
      have endpoints := EncodingLoss.pairSources _ _ _ p.1
      refine ⟨(pairSuccessorMembership _ _ _).mpr (Or.inl p.1),?_⟩
      rw [oldImage _ _ _ _ _ new endpoints.1,oldImage _ _ _ _ _ new endpoints.2]
      exact p.2
    | inr added =>
      obtain ⟨old,ho,eq,relation⟩ := added
      cases eq
      refine ⟨(pairSuccessorMembership _ _ _).mpr (Or.inr ⟨old,ho,rfl⟩),?_⟩
      change image (mapping ++ [(fresh,value)]) old = image (mapping ++ [(fresh,value)]) fresh
      rw [oldImage _ _ _ _ _ new ho,imageLastWins]
      exact relation

theorem singletonValid (state label : String) : validateTransformation [state] [(state,label)] = .ok [(state,label)] :=
  (ConservationLedger.validationMeaning _ _ _).mpr
    ((MutualObservation.validationMeaning _ _ _).mp (MutualExtension.singletonValid _ _))

theorem singletonBase (state label : String) :
    transformationLedger [state] [(state,label)] = .ok ⟨[state],[label],.emptyOne,.emptyOne,[(label,[state])]⟩ := by
  rw [ledgerAdmitted _ _ (singletonValid _ _)]
  unfold makeLedger
  rw [EntropyExtension.singletonClasses]
  rfl

end SFT.InformationScience.ConservationExtension
