import verification.TURN_344_ReversibleCompositionDraft
import SFT.Mathematics.ProbabilityIndependence
import SFT.Engine.RegistrationGate
namespace SFT.QuantumComputation.ReversibleObservation
open SFT.QuantumComputation.ReversibleModel
open SFT.Mathematics.DiscreteObjects SFT.InformationScience.EncodingMaps

abbrev Classification := List (Word × String)
abbrev Record := (Word × String) × String

def classificationValid (state : State) (mapping : Classification) : Bool :=
  distinct (mapping.map Prod.fst) &&
    (mapping.map Prod.fst).all (has (support state)) && (support state).all (has (mapping.map Prod.fst))

def recordBranches (mapping : Classification) : List (Word × String) → Option (List Record)
  | [] => some []
  | branch::rest => match lookupFirst mapping branch.1 with
    | none => none
    | some label => match recordBranches mapping rest with
      | none => none
      | some tail => some ((branch,label)::tail)

def retainedRows (record : List Record) (label : String) : List (Word × String) :=
  (record.filter (fun row => decide (row.2 = label))).map Prod.fst

def observe (state : State) (mapping : Classification) (label : String) : Except String (State × List Record) :=
  if classificationValid state mapping then
    match recordBranches mapping state.branches with
    | none => .error "measurement must classify complete state support"
    | some record =>
      let retained := retainedRows record label
      if retained.isEmpty then .error "selected observation class has no generated branch"
      else match makeState retained state.phaseCycle with
        | .error error => .error error
        | .ok selected => .ok (selected,record)
  else .error "measurement must classify complete state support"

def predecessorMerge (state : State) (mapping : Classification) : Except String (List (String × List (Word × String))) :=
  if classificationValid state mapping then
    match recordBranches mapping state.branches with
    | none => .error "interference image must classify every branch exactly once"
    | some record => .ok ((SFT.Engine.sortIdentifiers
        (SFT.Mathematics.ProbabilityIndependence.firstLabels (record.map Prod.snd))).map
          (fun label => (label,retainedRows record label)))
  else .error "interference image must classify every branch exactly once"

def isFactorable (joint : List (String × String)) : Except String Bool :=
  if joint.isEmpty || !distinct joint then .error "joint support must be nonempty and unique"
  else .ok (joint.all (fun left => joint.all (fun right => has joint (left.1,right.2))))

theorem completeRecord (mapping : Classification) (branches : List (Word × String)) (record : List Record)
    (accepted : recordBranches mapping branches = some record) : record.map Prod.fst = branches := by
  induction branches generalizing record with
  | nil => cases accepted; rfl
  | cons branch rest ih =>
    unfold recordBranches at accepted
    cases l : lookupFirst mapping branch.1 with
    | none => rw [l] at accepted; cases accepted
    | some label =>
      rw [l] at accepted
      cases t : recordBranches mapping rest with
      | none => rw [t] at accepted; cases accepted
      | some tail => rw [t] at accepted; cases accepted; exact congrArg (List.cons branch) (ih tail t)

open SFT.Foundation.Count.TraceDerivation

theorem retainedExactly (record : List Record) (label : String) (branch : Word × String) :
    branch ∈ retainedRows record label ↔ (branch,label) ∈ record := by
  constructor
  · intro member
    obtain ⟨row,filtered,equal⟩ := memMapPreimage Prod.fst branch _ member
    have parts := (filterMemberIff _ record row).mp filtered
    have selected : row.2 = label := of_decide_eq_true parts.2
    obtain ⟨original,observed⟩ := row
    dsimp only at equal selected
    cases equal
    cases selected
    exact parts.1
  · intro member
    apply memMap Prod.fst (branch,label) _
    exact (filterMemberIff _ record (branch,label)).mpr ⟨member,decide_eq_true rfl⟩

theorem factorClosure (joint : List (String × String)) :
    joint.all (fun left => joint.all (fun right => has joint (left.1,right.2))) = true ↔
      ∀ left, left ∈ joint → ∀ right, right ∈ joint → (left.1,right.2) ∈ joint := by
  constructor
  · intro accepted left leftHeld right rightHeld
    have leftAll := (allTrueIffMembers _ _).mp accepted left leftHeld
    exact (hasIff _ _).mp ((allTrueIffMembers _ _).mp leftAll right rightHeld)
  · intro closed
    apply (allTrueIffMembers _ _).mpr
    intro left leftHeld
    apply (allTrueIffMembers _ _).mpr
    intro right rightHeld
    exact (hasIff _ _).mpr (closed left leftHeld right rightHeld)

theorem recordMembership (mapping : Classification) (branches : List (Word × String)) (record : List Record)
    (accepted : recordBranches mapping branches = some record) (branch : Word × String) (label : String) :
    (branch,label) ∈ record ↔ branch ∈ branches ∧ lookupFirst mapping branch.1 = some label := by
  induction branches generalizing record with
  | nil =>
    cases accepted
    constructor
    · intro member; cases member
    · intro parts; cases parts.1
  | cons first rest ih =>
    unfold recordBranches at accepted
    cases l : lookupFirst mapping first.1 with
    | none => rw [l] at accepted; cases accepted
    | some observed =>
      rw [l] at accepted
      cases t : recordBranches mapping rest with
      | none => rw [t] at accepted; cases accepted
      | some tail =>
        rw [t] at accepted
        cases accepted
        constructor
        · intro member
          cases member with
          | head => exact ⟨.head _,l⟩
          | tail _ member =>
            have parts := (ih tail t).mp member
            exact ⟨.tail _ parts.1,parts.2⟩
        · intro ⟨held,lookup⟩
          cases held with
          | head => rw [l] at lookup; cases lookup; exact .head _
          | tail _ held => exact .tail _ ((ih tail t).mpr ⟨held,lookup⟩)

theorem recordExists (mapping : Classification) (branches : List (Word × String))
    (covered : ∀ branch, branch ∈ branches → branch.1 ∈ mapping.map Prod.fst) :
    ∃ record, recordBranches mapping branches = some record := by
  induction branches with
  | nil => exact ⟨[],rfl⟩
  | cons first rest ih =>
    obtain ⟨label,lookup⟩ := (lookupDefined mapping first.1).mpr (covered _ (.head _))
    obtain ⟨tail,t⟩ := ih (fun branch member => covered branch (.tail _ member))
    refine ⟨(first,label)::tail,?_⟩
    unfold recordBranches
    rw [lookup,t]

theorem admittedRecordExists (state : State) (mapping : Classification)
    (admitted : classificationValid state mapping = true) :
    ∃ record, recordBranches mapping state.branches = some record := by
  have all := ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp admitted).2
  apply recordExists
  intro branch member
  exact (hasIff _ _).mp ((allTrueIffMembers _ _).mp all branch.1
    (memMap Prod.fst branch state.branches member))

theorem recordCount (mapping : Classification) (branches : List (Word × String)) (record : List Record)
    (accepted : recordBranches mapping branches = some record) : record.length = branches.length :=
  (SFT.Foundation.CommonRefinement.mapLength Prod.fst record).symm.trans
    (congrArg List.length (completeRecord mapping branches record accepted))

theorem observationSource (state selected : State) (mapping : Classification) (label : String)
    (record : List Record) (accepted : observe state mapping label = .ok (selected,record)) :
    classificationValid state mapping = true ∧ recordBranches mapping state.branches = some record ∧
      selected.branches = retainedRows record label ∧ selected.phaseCycle = state.phaseCycle ∧
      makeState selected.branches selected.phaseCycle = .ok selected := by
  unfold observe at accepted
  split at accepted
  · rename_i valid
    cases t : recordBranches mapping state.branches with
    | none => rw [t] at accepted; cases accepted
    | some rows =>
      rw [t] at accepted
      dsimp only at accepted
      split at accepted
      · cases accepted
      · cases made : makeState (retainedRows rows label) state.phaseCycle with
        | error e => rw [made] at accepted; cases accepted
        | ok result =>
          rw [made] at accepted
          cases accepted
          have source := makeStateSource _ _ _ made
          have branches := congrArg State.branches source
          have cycle := congrArg State.phaseCycle source
          refine ⟨valid,rfl,branches,cycle,?_⟩
          rw [branches,cycle]
          exact made
  · cases accepted

theorem observationMembership (state selected : State) (mapping : Classification) (label : String)
    (record : List Record) (accepted : observe state mapping label = .ok (selected,record))
    (branch : Word × String) : branch ∈ selected.branches ↔
      branch ∈ state.branches ∧ lookupFirst mapping branch.1 = some label := by
  have source := observationSource state selected mapping label record accepted
  rw [source.2.2.1]
  exact (retainedExactly record label branch).trans
    (recordMembership mapping state.branches record source.2.1 branch label)

theorem observationReconstruction (state selected : State) (mapping : Classification) (label : String)
    (record : List Record) (accepted : observe state mapping label = .ok (selected,record)) :
    record.map Prod.fst = state.branches ∧ record.length = state.branches.length := by
  have source := observationSource state selected mapping label record accepted
  exact ⟨completeRecord _ _ _ source.2.1,recordCount _ _ _ source.2.1⟩

theorem insertedMembership (inserted : String) (items : List String) (label : String) :
    label ∈ SFT.Engine.insertIdentifier inserted items ↔ label = inserted ∨ label ∈ items := by
  induction items with
  | nil =>
    constructor
    · intro h; cases h with
      | head => exact .inl rfl
      | tail _ h => cases h
    · intro h; cases h with
      | inl h => cases h; exact .head _
      | inr h => cases h
  | cons first rest ih =>
    unfold SFT.Engine.insertIdentifier
    split
    · constructor
      · intro h; cases h with
        | head => exact .inl rfl
        | tail _ h => exact .inr h
      · intro h; cases h with
        | inl h => cases h; exact .head _
        | inr h => exact .tail _ h
    · constructor
      · intro h; cases h with
        | head => exact .inr (.head _)
        | tail _ h =>
          cases ih.mp h with
          | inl h => exact .inl h
          | inr h => exact .inr (.tail _ h)
      · intro h; cases h with
        | inl h => exact .tail _ (ih.mpr (.inl h))
        | inr h => cases h with
          | head => exact .head _
          | tail _ h => exact .tail _ (ih.mpr (.inr h))

theorem sortedMembership (items : List String) (label : String) :
    label ∈ SFT.Engine.sortIdentifiers items ↔ label ∈ items := by
  induction items with
  | nil => exact ⟨fun h => h,fun h => h⟩
  | cons first rest ih =>
    constructor
    · intro member
      cases (insertedMembership first (SFT.Engine.sortIdentifiers rest) label).mp member with
      | inl same => cases same; exact .head _
      | inr held => exact .tail _ (ih.mp held)
    · intro member
      apply (insertedMembership first (SFT.Engine.sortIdentifiers rest) label).mpr
      cases member with
      | head => exact .inl rfl
      | tail _ held => exact .inr (ih.mpr held)

def groupedRecord (record : List Record) : List (String × List (Word × String)) :=
  (SFT.Engine.sortIdentifiers
    (SFT.Mathematics.ProbabilityIndependence.firstLabels (record.map Prod.snd))).map
      (fun label => (label,retainedRows record label))

theorem groupedMembership (record : List Record) (label : String) (rows : List (Word × String)) :
    (label,rows) ∈ groupedRecord record ↔ label ∈ record.map Prod.snd ∧ rows = retainedRows record label := by
  constructor
  · intro member
    obtain ⟨key,held,equal⟩ := memMapPreimage _ _ _ member
    have keyEqual := congrArg Prod.fst equal
    have rowsEqual := congrArg Prod.snd equal
    dsimp only at keyEqual rowsEqual
    cases keyEqual
    exact ⟨(SFT.Mathematics.ProbabilityIndependence.firstLabelsMembership _ _).mp
      ((sortedMembership _ _).mp held),rowsEqual.symm⟩
  · intro parts
    have held := (sortedMembership _ _).mpr
      ((SFT.Mathematics.ProbabilityIndependence.firstLabelsMembership _ _).mpr parts.1)
    have member := memMap (fun label => (label,retainedRows record label)) label _ held
    rw [← parts.2] at member
    exact member

theorem predecessorSource (state : State) (mapping : Classification) (groups : List (String × List (Word × String)))
    (accepted : predecessorMerge state mapping = .ok groups) :
    ∃ record, recordBranches mapping state.branches = some record ∧ groups = groupedRecord record := by
  unfold predecessorMerge at accepted
  split at accepted
  · cases t : recordBranches mapping state.branches with
    | none => rw [t] at accepted; cases accepted
    | some record => rw [t] at accepted; cases accepted; exact ⟨record,rfl,rfl⟩
  · cases accepted

theorem predecessorRecordPreserved (state : State) (mapping : Classification)
    (groups : List (String × List (Word × String))) (accepted : predecessorMerge state mapping = .ok groups)
    (branch : Word × String) (held : branch ∈ state.branches) (label : String)
    (lookup : lookupFirst mapping branch.1 = some label) :
    ∃ rows, (label,rows) ∈ groups ∧ branch ∈ rows := by
  obtain ⟨record,source,equal⟩ := predecessorSource state mapping groups accepted
  have member := (recordMembership mapping state.branches record source branch label).mpr ⟨held,lookup⟩
  refine ⟨retainedRows record label,?_,(retainedExactly record label branch).mpr member⟩
  rw [equal]
  exact (groupedMembership record label _).mpr ⟨memMap Prod.snd (branch,label) record member,rfl⟩

def matchesLabel (mapping : Classification) (label : String) (branch : Word × String) : Bool :=
  match lookupFirst mapping branch.1 with
  | none => false
  | some observed => decide (observed = label)

theorem retainedOrder (mapping : Classification) (branches : List (Word × String)) (record : List Record)
    (accepted : recordBranches mapping branches = some record) (label : String) :
    retainedRows record label = branches.filter (matchesLabel mapping label) := by
  induction branches generalizing record with
  | nil => cases accepted; rfl
  | cons first rest ih =>
    unfold recordBranches at accepted
    cases l : lookupFirst mapping first.1 with
    | none => rw [l] at accepted; cases accepted
    | some observed =>
      rw [l] at accepted
      cases t : recordBranches mapping rest with
      | none => rw [t] at accepted; cases accepted
      | some tail =>
        rw [t] at accepted
        cases accepted
        by_cases same : observed = label
        · have matching : matchesLabel mapping label first = true := by
            unfold matchesLabel; rw [l]; exact decide_eq_true same
          unfold retainedRows
          rw [List.filter_cons_of_pos (p := fun row : Record => decide (row.2 = label)) (decide_eq_true same),
            List.filter_cons_of_pos matching]
          exact congrArg (List.cons first) (ih tail t)
        · have matching : matchesLabel mapping label first ≠ true := by
            unfold matchesLabel; rw [l]; exact fun h => same (of_decide_eq_true h)
          unfold retainedRows
          rw [List.filter_cons_of_neg (p := fun row : Record => decide (row.2 = label))
              (fun h => same (of_decide_eq_true h)),List.filter_cons_of_neg matching]
          exact ih tail t

theorem filteredWordsDistinct (predicate : (Word × String) → Bool) (branches : List (Word × String))
    (unique : distinct (branches.map Prod.fst) = true) :
    distinct ((branches.filter predicate).map Prod.fst) = true := by
  induction branches with
  | nil => rfl
  | cons first rest ih =>
    have original := (distinctCons _ _).mp unique
    cases selected : predicate first with
    | false =>
      rw [List.filter_cons_of_neg (by rw [selected]; intro h; cases h)]
      exact ih original.2
    | true =>
      rw [List.filter_cons_of_pos selected]
      apply (distinctCons _ _).mpr
      refine ⟨(absentIff _ _).mpr ?_,ih original.2⟩
      intro member
      obtain ⟨row,filtered,equal⟩ := memMapPreimage Prod.fst first.1 _ member
      have held := (filterMemberIff predicate rest row).mp filtered
      have raw := memMap Prod.fst row rest held.1
      rw [equal] at raw
      exact (absentIff _ _).mp original.1 raw

theorem observationDecision (state : State) (mapping : Classification) (label : String)
    (stateAdmitted : makeState state.branches state.phaseCycle = .ok state)
    (mappingAdmitted : classificationValid state mapping = true) :
    ∃ record, recordBranches mapping state.branches = some record ∧
      observe state mapping label =
        if (retainedRows record label).isEmpty then .error "selected observation class has no generated branch"
        else .ok (⟨retainedRows record label,state.phaseCycle⟩,record) := by
  obtain ⟨record,generated⟩ := admittedRecordExists state mapping mappingAdmitted
  refine ⟨record,generated,?_⟩
  unfold observe
  rw [mappingAdmitted,generated]
  dsimp only
  cases empty : (retainedRows record label).isEmpty with
  | true => rfl
  | false =>
    have properties := admittedPhaseCycle state stateAdmitted
    have unique : distinct ((retainedRows record label).map Prod.fst) = true := by
      rw [retainedOrder _ _ _ generated]
      exact filteredWordsDistinct _ _ (admittedStateSupport state stateAdmitted)
    have phases : ∀ branch, branch ∈ retainedRows record label → branch.2 ∈ state.phaseCycle := by
      intro branch member
      have row := (retainedExactly record label branch).mp member
      have held := (recordMembership mapping state.branches record generated branch label).mp row
      exact admittedPhaseMember state stateAdmitted branch held.1
    have cycleBound : decide (state.phaseCycle.length < 2) = false :=
      decide_eq_false (Nat.not_lt_of_ge properties.2.2)
    have clean := noOutsidePhases _ _ phases
    have made : makeState (retainedRows record label) state.phaseCycle =
        .ok ⟨retainedRows record label,state.phaseCycle⟩ := by
      unfold makeState
      rw [empty,properties.2.1,cycleBound,unique,clean]
      rfl
    rw [made]
    rfl

theorem predecessorAdmitted (state : State) (mapping : Classification)
    (admitted : classificationValid state mapping = true) :
    ∃ record, recordBranches mapping state.branches = some record ∧
      predecessorMerge state mapping = .ok (groupedRecord record) := by
  obtain ⟨record,generated⟩ := admittedRecordExists state mapping admitted
  refine ⟨record,generated,?_⟩
  unfold predecessorMerge
  rw [admitted,generated]
  rfl

theorem factorableMeaning (joint : List (String × String))
    (nonempty : joint.isEmpty = false) (unique : distinct joint = true) :
    isFactorable joint = .ok true ↔
      ∀ left, left ∈ joint → ∀ right, right ∈ joint → (left.1,right.2) ∈ joint := by
  unfold isFactorable
  rw [nonempty,unique]
  constructor
  · intro accepted
    exact (factorClosure joint).mp (Except.ok.inj accepted)
  · intro closed
    exact congrArg Except.ok ((factorClosure joint).mpr closed)

end SFT.QuantumComputation.ReversibleObservation
