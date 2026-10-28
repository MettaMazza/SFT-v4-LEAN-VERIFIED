import SFT.InformationScience.MutualExtension
namespace SFT.InformationScience.ConservationLedger
open MutualObservation
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

abbrev Pair := String × String

def validateTransformation (source : List String) (transformation : Observation) : Except String Observation :=
  if supportValid source then
    if mapValid source transformation then .ok transformation
    else .error "ValueError: a transformation must map every source form exactly once"
  else .error "ValueError: a transformation requires complete duplicate-free source support"

def sourcePairs (source : List String) : Except String (List Pair) :=
  if supportValid source then .ok (EncodingLoss.sourcePairs source)
  else .error "ValueError: distinction accounting requires canonical source support"

inductive PairLedger where
  | emptyOne
  | pairs : List Pair → PairLedger
  deriving DecidableEq

def presentPairs : List Pair → PairLedger
  | [] => .emptyOne
  | pair :: rest => .pairs (pair :: rest)

def retained (source : List String) (transformation : Observation) : List Pair :=
  (EncodingLoss.sourcePairs source).filter (fun pair => decide (image transformation pair.1 ≠ image transformation pair.2))

def closed (source : List String) (transformation : Observation) : List Pair :=
  (EncodingLoss.sourcePairs source).filter (fun pair => decide (image transformation pair.1 = image transformation pair.2))

structure Ledger where
  sourceSupport : List String
  imageSupport : List String
  retainedDistinctions : PairLedger
  closedDistinctions : PairLedger
  predecessorFibres : List (String × List String)
  deriving DecidableEq

def makeLedger (source : List String) (transformation : Observation) : Ledger :=
  let fibres := classRows source transformation
  ⟨source,fibres.map Prod.fst,presentPairs (retained source transformation),presentPairs (closed source transformation),fibres⟩

def transformationLedger (source : List String) (transformation : Observation) : Except String Ledger :=
  match validateTransformation source transformation with
  | .error e => .error e
  | .ok images => match sourcePairs source with
    | .error e => .error e
    | .ok _ => .ok (makeLedger source images)

theorem validationMeaning (source : List String) (transformation output : Observation) :
    validateTransformation source transformation = .ok output ↔
      supportValid source = true ∧ mapValid source transformation = true ∧ output = transformation := by
  unfold validateTransformation
  cases hs : supportValid source <;> cases hm : mapValid source transformation
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  · exact ⟨rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem observationAdmitted (source : List String) (transformation : Observation)
    (h : validateTransformation source transformation = .ok transformation) :
    validateObservation source transformation = .ok transformation :=
  (MutualObservation.validationMeaning _ _ _).mpr ((validationMeaning _ _ _).mp h)

theorem pairsAdmitted (source : List String) (valid : supportValid source = true) :
    sourcePairs source = .ok (EncodingLoss.sourcePairs source) := by
  unfold sourcePairs; rw [valid]; rfl

theorem ledgerAdmitted (source : List String) (transformation : Observation)
    (h : validateTransformation source transformation = .ok transformation) :
    transformationLedger source transformation = .ok (makeLedger source transformation) := by
  unfold transformationLedger
  rw [h,pairsAdmitted _ ((validationMeaning _ _ _).mp h).1]

theorem retainedMeaning (source : List String) (transformation : Observation) (pair : Pair) :
    pair ∈ retained source transformation ↔ pair ∈ EncodingLoss.sourcePairs source ∧ image transformation pair.1 ≠ image transformation pair.2 := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem closedMeaning (source : List String) (transformation : Observation) (pair : Pair) :
    pair ∈ closed source transformation ↔ pair ∈ EncodingLoss.sourcePairs source ∧ image transformation pair.1 = image transformation pair.2 := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem pairExhaustion (source : List String) (transformation : Observation) (pair : Pair)
    (member : pair ∈ EncodingLoss.sourcePairs source) :
    pair ∈ retained source transformation ∨ pair ∈ closed source transformation := by
  by_cases eq : image transformation pair.1 = image transformation pair.2
  · exact Or.inr ((closedMeaning _ _ _).mpr ⟨member,eq⟩)
  · exact Or.inl ((retainedMeaning _ _ _).mpr ⟨member,eq⟩)

theorem pairDisjoint (source : List String) (transformation : Observation) (pair : Pair)
    (r : pair ∈ retained source transformation) (c : pair ∈ closed source transformation) : False :=
  ((retainedMeaning _ _ _).mp r).2 (((closedMeaning _ _ _).mp c).2)

theorem presentEmpty (pairs : List Pair) : presentPairs pairs = .emptyOne ↔ pairs = [] := by
  cases pairs with
  | nil => exact ⟨fun _ => rfl,fun _ => rfl⟩
  | cons pair rest => constructor <;> intro h <;> cases h

theorem fibreRows (source : List String) (transformation : Observation) :
    (makeLedger source transformation).predecessorFibres = classRows source transformation := rfl

theorem closedFibre (source : List String) (transformation : Observation) (pair : Pair)
    (valid : validateTransformation source transformation = .ok transformation)
    (member : pair ∈ closed source transformation) :
    ∃ label, pair.1 ∈ fibre source transformation label ∧ pair.2 ∈ fibre source transformation label := by
  have p := (closedMeaning _ _ _).mp member
  have endpoints := EncodingLoss.pairSources source pair.1 pair.2 p.1
  have adm := (MutualObservation.validationMeaning _ _ _).mp (observationAdmitted _ _ valid)
  have keys := ((mapMeaning _ _).mp adm.2.1).2
  obtain ⟨label,hi⟩ := admittedImage source transformation keys pair.1 endpoints.1
  exact ⟨label,(fibreMembership _ _ _ _).mpr ⟨endpoints.1,hi⟩,
    (fibreMembership _ _ _ _).mpr ⟨endpoints.2,p.2.symm.trans hi⟩⟩

theorem fibreCloses (source : List String) (transformation : Observation) (pair : Pair) (label : String)
    (member : pair ∈ EncodingLoss.sourcePairs source)
    (left : pair.1 ∈ fibre source transformation label) (right : pair.2 ∈ fibre source transformation label) :
    pair ∈ closed source transformation := by
  have hl := ((fibreMembership _ _ _ _).mp left).2
  have hr := ((fibreMembership _ _ _ _).mp right).2
  exact (closedMeaning _ _ _).mpr ⟨member,hl.trans hr.symm⟩

end SFT.InformationScience.ConservationLedger
