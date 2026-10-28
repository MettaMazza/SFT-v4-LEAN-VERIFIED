import SFT.InformationScience.ConservationLedger
namespace SFT.InformationScience.ConservationComposition
open ConservationLedger MutualObservation
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

-- The default is unreachable in admitted source compositions; valueExact proves this.
def value (mapping : Observation) (state : String) : String := (image mapping state).getD ""

def composedRows (source : List String) (first second : Observation) : Observation :=
  source.map (fun state => (state,value second (value first state)))

def compose (source : List String) (first second : Observation) : Except String Observation :=
  match validateTransformation source first with
  | .error e => Except.error e
  | .ok firstImages => match validateTransformation (labels source firstImages) second with
    | .error e => Except.error e
    | .ok secondImages => Except.ok (composedRows source firstImages secondImages)

def contents : PairLedger → List Pair
  | .emptyOne => []
  | .pairs pairs => pairs

def pairHas (pairs : List Pair) (pair : Pair) : Bool :=
  pairs.any (fun held => decide (pair = held))

theorem pairHasMeaning (pairs : List Pair) (pair : Pair) : pairHas pairs pair = true ↔ pair ∈ pairs := by
  induction pairs with
  | nil => constructor <;> intro h <;> cases h
  | cons head rest ih =>
    change (decide (pair = head) || pairHas rest pair) = true ↔ _
    constructor
    · intro h
      cases (SFT.Foundation.Count.Representation.orTrue _ _).mp h with
      | inl eq => have e := of_decide_eq_true eq; cases e; exact List.Mem.head _
      | inr tail => exact List.Mem.tail head (ih.mp tail)
    · intro h
      apply (SFT.Foundation.Count.Representation.orTrue _ _).mpr
      cases h with
      | head => exact Or.inl (decide_eq_true rfl)
      | tail _ hm => exact Or.inr (ih.mpr hm)

def downstreamRetentionLaw (source : List String) (first second : Observation) : Except String Bool :=
  match transformationLedger source first with
  | .error e => Except.error e
  | .ok firstLedger => match compose source first second with
    | .error e => Except.error e
    | .ok composite => match transformationLedger source composite with
      | .error e => Except.error e
      | .ok compositeLedger => Except.ok ((contents compositeLedger.retainedDistinctions).all
          (fun pair => pairHas (contents firstLedger.retainedDistinctions) pair))

theorem valueExact (mapping : Observation) (state label : String) (h : image mapping state = some label) :
    value mapping state = label := by unfold value; rw [h]; rfl

theorem keysRows (source : List String) (f : String → String) :
    (source.map (fun state => (state,f state))).map Prod.fst = source := by
  induction source with
  | nil => rfl
  | cons state rest ih => exact congrArg (List.cons state) ih

theorem imageRows (source : List String) (f : String → String) (state : String) :
    image (source.map (fun s => (s,f s))) state = if has source state then some (f state) else none := by
  induction source with
  | nil => rfl
  | cons head rest ih =>
    change (match image (rest.map (fun s => (s,f s))) state with
      | some v => some v | none => if head = state then some (f head) else none) = _
    rw [ih]
    by_cases hb : has rest state = true
    · have hm := (hasIff rest state).mp hb
      rw [ite_eq_left ((hasIff _ _).mpr hm)]
      exact (ite_eq_left ((hasIff _ _).mpr (List.Mem.tail head hm))).symm
    · have hm : ¬ state ∈ rest := fun h => hb ((hasIff _ _).mpr h)
      rw [ite_eq_right (fun h => hm ((hasIff _ _).mp h))]
      by_cases eq : head = state
      · cases eq
        rw [ite_eq_left rfl]
        exact (ite_eq_left ((hasIff _ _).mpr (List.Mem.head rest))).symm
      · have no : ¬ state ∈ head :: rest := by
          intro h
          cases h with
          | head => exact eq rfl
          | tail _ h => exact hm h
        rw [ite_eq_right eq]
        exact (ite_eq_right (fun h => no ((hasIff _ _).mp h))).symm

theorem composedImage (source : List String) (first second : Observation) (state : String) (hm : state ∈ source) :
    image (composedRows source first second) state = some (value second (value first state)) := by
  unfold composedRows
  rw [imageRows,ite_eq_left ((hasIff _ _).mpr hm)]

theorem composedAdmitted (source : List String) (first second : Observation)
    (hs : supportValid source = true) :
    validateTransformation source (composedRows source first second) = .ok (composedRows source first second) := by
  apply (ConservationLedger.validationMeaning _ _ _).mpr
  refine ⟨hs,?_,rfl⟩
  apply (mapMeaning _ _).mpr
  have keys : (composedRows source first second).map Prod.fst = source := keysRows _ _
  constructor
  · rw [keys]; exact ((supportMeaning _).mp hs).2
  · apply (keysMatchMeaning _ _).mpr
    rw [keys]
    exact ⟨fun _ h => h,fun _ h => h⟩

theorem composeAdmitted (source : List String) (first second : Observation)
    (hf : validateTransformation source first = .ok first)
    (hs : validateTransformation (labels source first) second = .ok second) :
    compose source first second = .ok (composedRows source first second) := by
  unfold compose; rw [hf]
  change (match validateTransformation (labels source first) second with | .error e => Except.error e | .ok images => Except.ok (composedRows source first images)) = _
  rw [hs]

theorem sourceValue (source : List String) (mapping : Observation)
    (valid : validateTransformation source mapping = .ok mapping) (state : String) (hm : state ∈ source) :
    image mapping state = some (value mapping state) := by
  have keys := ((mapMeaning _ _).mp ((ConservationLedger.validationMeaning _ _ _).mp valid).2.1).2
  obtain ⟨label,hi⟩ := admittedImage source mapping keys state hm
  rw [valueExact _ _ _ hi]; exact hi

theorem exactComposition (source : List String) (first second : Observation)
    (hf : validateTransformation source first = .ok first)
    (hs : validateTransformation (labels source first) second = .ok second)
    (state : String) (hm : state ∈ source) :
    image (composedRows source first second) state = image second (value first state) := by
  have middle : value first state ∈ labels source first :=
    (labelsMeaning _ _ _).mpr ⟨state,hm,sourceValue _ _ hf _ hm⟩
  rw [composedImage _ _ _ _ hm,sourceValue _ _ hs _ middle]

theorem closedPersists (source : List String) (first second : Observation) (pair : Pair)
    (hc : pair ∈ closed source first) : pair ∈ closed source (composedRows source first second) := by
  have p := (closedMeaning _ _ _).mp hc
  have endpoints := EncodingLoss.pairSources source pair.1 pair.2 p.1
  apply (closedMeaning _ _ _).mpr
  refine ⟨p.1,?_⟩
  rw [composedImage _ _ _ _ endpoints.1,composedImage _ _ _ _ endpoints.2]
  have same : value first pair.1 = value first pair.2 := congrArg (fun o : Option String => o.getD "") p.2
  rw [same]

theorem retainedSubset (source : List String) (first second : Observation) (pair : Pair)
    (hr : pair ∈ retained source (composedRows source first second)) : pair ∈ retained source first := by
  have p := (retainedMeaning _ _ _).mp hr
  apply (retainedMeaning _ _ _).mpr
  refine ⟨p.1,?_⟩
  intro eq
  exact pairDisjoint _ _ _ hr (closedPersists _ _ _ _ ((closedMeaning _ _ _).mpr ⟨p.1,eq⟩))

theorem contentsPresent (pairs : List Pair) : contents (presentPairs pairs) = pairs := by
  cases pairs <;> rfl

theorem downstreamTrue (source : List String) (first second : Observation)
    (hf : validateTransformation source first = .ok first)
    (hs : validateTransformation (labels source first) second = .ok second) :
    downstreamRetentionLaw source first second = .ok true := by
  unfold downstreamRetentionLaw
  rw [ledgerAdmitted _ _ hf,composeAdmitted _ _ _ hf hs]
  change (match transformationLedger source (composedRows source first second) with
    | .error e => Except.error e
    | .ok ledger => Except.ok ((contents ledger.retainedDistinctions).all
      (fun pair => pairHas (contents (makeLedger source first).retainedDistinctions) pair))) = _
  rw [ledgerAdmitted _ _ (composedAdmitted _ _ _ ((ConservationLedger.validationMeaning _ _ _).mp hf).1)]
  change Except.ok ((contents (presentPairs (retained source (composedRows source first second)))).all
    (fun pair => pairHas (contents (presentPairs (retained source first))) pair)) = Except.ok true
  rw [contentsPresent,contentsPresent]
  apply congrArg Except.ok
  exact (MutualDecisions.allMeaning _ _).mpr (fun pair hm => (pairHasMeaning _ _).mpr (retainedSubset _ _ _ _ hm))

end SFT.InformationScience.ConservationComposition
