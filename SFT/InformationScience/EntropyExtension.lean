import SFT.InformationScience.EntropyPairs
namespace SFT.InformationScience.EntropyExtension
open EntropyPartition EntropyLedger
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

theorem oldImage (observation : Observation) (fresh state value : String) (different : fresh ≠ state) :
    image (observation ++ [(fresh,value)]) state = image observation state := by
  induction observation with
  | nil => change (if fresh = state then some value else none) = none; rw [ite_eq_right different]
  | cons row rest ih =>
    cases row with
    | mk key held =>
      change (match image (rest ++ [(fresh,value)]) state with | some result => some result | none => if key = state then some held else none) = _
      rw [ih]; rfl

theorem fibreSuccessor (support : List String) (observation : Observation) (fresh value label : String)
    (new : ¬ fresh ∈ support) :
    fibre (support ++ [fresh]) (observation ++ [(fresh,value)]) label =
      fibre support observation label ++ (if value = label then [fresh] else []) := by
  induction support with
  | nil =>
    change (match belongs (observation ++ [(fresh,value)]) label fresh with | true => [fresh] | false => []) = _
    unfold belongs
    rw [imageLastWins]
    change (match decide (value = label) with | true => [fresh] | false => []) = [] ++ (if value = label then [fresh] else [])
    by_cases eq : value = label
    · rw [ite_eq_left eq,decide_eq_true eq]; rfl
    · rw [ite_eq_right eq,decide_eq_false eq]; rfl
  | cons state rest ih =>
    have different : fresh ≠ state := by intro eq; cases eq; exact new (List.Mem.head _)
    have tail : ¬ fresh ∈ rest := fun hm => new (List.Mem.tail state hm)
    have same : belongs (observation ++ [(fresh,value)]) label state = belongs observation label state := by
      unfold belongs; rw [oldImage _ _ _ _ different]
    change (match belongs (observation ++ [(fresh,value)]) label state with
      | true => state :: fibre (rest ++ [fresh]) (observation ++ [(fresh,value)]) label
      | false => fibre (rest ++ [fresh]) (observation ++ [(fresh,value)]) label) = _
    rw [same,ih tail]
    change (match belongs observation label state with
      | true => state :: (fibre rest observation label ++ (if value = label then [fresh] else []))
      | false => fibre rest observation label ++ (if value = label then [fresh] else [])) =
      (match belongs observation label state with | true => state :: fibre rest observation label | false => fibre rest observation label) ++ (if value = label then [fresh] else [])
    cases belongs observation label state <;> rfl

theorem observedSuccessor (support : List String) (observation : Observation) (fresh value : String)
    (new : ¬ fresh ∈ support) :
    observedValues (observation ++ [(fresh,value)]) (support ++ [fresh]) = observedValues observation support ++ [value] := by
  induction support with
  | nil => change (match image (observation ++ [(fresh,value)]) fresh with | none => [] | some label => [label]) = [value]
           rw [imageLastWins]
  | cons state rest ih =>
    have different : fresh ≠ state := by intro eq; cases eq; exact new (List.Mem.head _)
    have tail : ¬ fresh ∈ rest := fun hm => new (List.Mem.tail state hm)
    change (match image (observation ++ [(fresh,value)]) state with
      | none => observedValues (observation ++ [(fresh,value)]) (rest ++ [fresh])
      | some label => label :: observedValues (observation ++ [(fresh,value)]) (rest ++ [fresh])) = _
    rw [oldImage _ _ _ _ different,ih tail]
    cases hi : image observation state <;> change _ = (match image observation state with | none => observedValues observation rest | some label => label :: observedValues observation rest) ++ [value]
    all_goals rw [hi]
    all_goals rfl

theorem freshDistinct (items : List String) (fresh : String) (unique : distinct items = true)
    (new : ¬ fresh ∈ items) : distinct (items ++ [fresh]) = true := by
  apply appendDistinct _ _ unique
  · rfl
  · intro item old added
    cases added with
    | head => exact new old
    | tail _ h => cases h

theorem keysSuccessor (support : List String) (observation : Observation) (fresh value : String)
    (keys : keysMatch support observation = true) : keysMatch (support ++ [fresh]) (observation ++ [(fresh,value)]) = true := by
  have original := (keysMatchMeaning _ _).mp keys
  apply (keysMatchMeaning _ _).mpr
  have keysEq : (observation ++ [(fresh,value)]).map Prod.fst = observation.map Prod.fst ++ [fresh] :=
    SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
  rw [keysEq]
  constructor
  · intro state hm
    cases memAppendCases _ _ _ hm with
    | inl old => exact memAppendLeft _ _ _ (original.1 state old)
    | inr added => exact memAppendRight _ _ _ added
  · intro state hm
    cases memAppendCases _ _ _ hm with
    | inl old => exact memAppendLeft _ _ _ (original.2 state old)
    | inr added => exact memAppendRight _ _ _ added

theorem validSuccessor (support : List String) (observation : Observation) (fresh value : String)
    (valid : partitionValid support observation = true) (new : ¬ fresh ∈ support) :
    partitionValid (support ++ [fresh]) (observation ++ [(fresh,value)]) = true := by
  have p := (validityMeaning _ _).mp valid
  apply (validityMeaning _ _).mpr
  refine ⟨?_,freshDistinct _ _ p.2.1 new,?_,keysSuccessor _ _ _ _ p.2.2.2⟩
  · cases support <;> rfl
  · have keysEq : (observation ++ [(fresh,value)]).map Prod.fst = observation.map Prod.fst ++ [fresh] :=
      SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
    rw [keysEq]
    apply freshDistinct _ _ p.2.2.1
    intro hm
    exact new (((keysMatchMeaning _ _).mp p.2.2.2).1 fresh hm)

theorem changedClass (support : List String) (observation : Observation) (fresh value : String)
    (new : ¬ fresh ∈ support) :
    fibre (support ++ [fresh]) (observation ++ [(fresh,value)]) value = fibre support observation value ++ [fresh] := by
  rw [fibreSuccessor _ _ _ _ _ new,ite_eq_left rfl]

theorem otherClass (support : List String) (observation : Observation) (fresh value label : String)
    (new : ¬ fresh ∈ support) (different : value ≠ label) :
    fibre (support ++ [fresh]) (observation ++ [(fresh,value)]) label = fibre support observation label := by
  rw [fibreSuccessor _ _ _ _ _ new,ite_eq_right different,SymbolExtension.appendNil]

def extendedPairs (fresh : String) : List String → List EntropyPartition.Pair
  | [] => []
  | left :: rest => (rest.map (fun right => (left,right)) ++ [(left,fresh)]) ++ extendedPairs fresh rest

theorem pairSuccessorOrder (members : List String) (fresh : String) :
    EncodingLoss.sourcePairs (members ++ [fresh]) = extendedPairs fresh members := by
  induction members with
  | nil => rfl
  | cons first rest ih =>
    change (rest ++ [fresh]).map (fun right => (first,right)) ++ EncodingLoss.sourcePairs (rest ++ [fresh]) = _
    rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,ih]; rfl

theorem pairSuccessorMembership (members : List String) (fresh : String) (pair : EntropyPartition.Pair) :
    pair ∈ extendedPairs fresh members ↔ pair ∈ EncodingLoss.sourcePairs members ∨ ∃ old, old ∈ members ∧ pair = (old,fresh) := by
  induction members with
  | nil => constructor; intro h; cases h; intro h; cases h with
    | inl h => cases h
    | inr h => obtain ⟨_,h,_⟩ := h; cases h
  | cons first rest ih =>
    constructor
    · intro h
      cases memAppendCases _ _ _ h with
      | inl head =>
        cases memAppendCases _ _ _ head with
        | inl prior => exact Or.inl (memAppendLeft _ _ _ prior)
        | inr added => cases added with
          | head => exact Or.inr ⟨first,List.Mem.head _,rfl⟩
          | tail _ h => cases h
      | inr tail =>
        cases ih.mp tail with
        | inl prior => exact Or.inl (memAppendRight _ _ _ prior)
        | inr added => obtain ⟨old,ho,eq⟩ := added; exact Or.inr ⟨old,List.Mem.tail first ho,eq⟩
    · intro h
      cases h with
      | inl prior =>
        cases memAppendCases _ _ _ prior with
        | inl head => exact memAppendLeft _ _ _ (memAppendLeft _ _ _ head)
        | inr tail => exact memAppendRight _ _ _ (ih.mpr (Or.inl tail))
      | inr added =>
        obtain ⟨old,ho,eq⟩ := added
        cases ho with
        | head => cases eq; exact memAppendLeft _ _ _ (memAppendRight _ _ _ (List.Mem.head []))
        | tail _ member => exact memAppendRight _ _ _ (ih.mpr (Or.inr ⟨old,member,eq⟩))

theorem classPairSuccessor (support : List String) (observation : Observation) (fresh value : String)
    (new : ¬ fresh ∈ support) :
    uncertaintyPairs (unresolvedPairs (fibre (support ++ [fresh]) (observation ++ [(fresh,value)]) value)) =
      extendedPairs fresh (fibre support observation value) := by
  rw [unresolvedContents,changedClass _ _ _ _ new,pairSuccessorOrder]

theorem successorPartValue (support : List String) (observation : Observation) (fresh value : String)
    (records : List Record) (h : entropyLedger (support ++ [fresh]) (observation ++ [(fresh,value)]) = .ok records)
    (new : ¬ fresh ∈ support) (record : Record) (member : record ∈ records) :
    (fibre support observation record.observation ++ (if value = record.observation then [fresh] else [])).length *
      record.exactSupportPart.denominator = record.exactSupportPart.numerator * (support.length+1) := by
  have classRow := recordClass _ _ _ h record member
  have members := ((rowMembership _ _ _ _).mp classRow).2
  have ratio := rowExactPart _ _ _ h record member
  rw [members,fibreSuccessor _ _ _ _ _ new] at ratio
  rw [appendLength support [fresh]] at ratio
  exact ratio

theorem singletonClasses (state label : String) :
    classRows [state] [(state,label)] = [(label,[state])] := by
  have obs := observedSuccessor [] [] state label (by intro h; cases h)
  have fib := fibreSuccessor [] [] state label label (by intro h; cases h)
  change observedValues [(state,label)] [state] = [label] at obs
  change fibre [state] [(state,label)] label = [] ++ (if label = label then [state] else []) at fib
  rw [ite_eq_left rfl] at fib
  unfold classRows
  rw [obs]
  change [(label,fibre [state] [(state,label)] label)] = _
  rw [fib]
  rfl

theorem singletonValid (state label : String) : partitionValid [state] [(state,label)] = true := by
  apply (validityMeaning _ _).mpr
  refine ⟨rfl,rfl,rfl,?_⟩
  apply (keysMatchMeaning _ _).mpr
  exact ⟨fun _ h => h,fun _ h => h⟩

theorem singletonBase (state label : String) :
    exactPartition [state] [(state,label)] = .ok [(label,[state])] := by
  unfold exactPartition
  rw [singletonValid]
  change Except.ok (classRows [state] [(state,label)]) = _
  rw [singletonClasses]

theorem singletonWholePart (state label : String) :
    (makeRecord [state] (Nat.zero_lt_succ 0) (label,[state]) (Nat.zero_lt_succ 0)).exactSupportPart.numerator = 1 ∧
    (makeRecord [state] (Nat.zero_lt_succ 0) (label,[state]) (Nat.zero_lt_succ 0)).exactSupportPart.denominator = 1 ∧
    (makeRecord [state] (Nat.zero_lt_succ 0) (label,[state]) (Nat.zero_lt_succ 0)).unresolvedDistinctions = .emptyOne := by
  have whole := (SFT.Foundation.ExactOperations.normalizationOneIff 1 1 (Nat.zero_lt_succ 0) (Nat.zero_lt_succ 0)).mpr rfl
  exact ⟨whole.1,whole.2,rfl⟩

end SFT.InformationScience.EntropyExtension
