import SFT.Computation.CausalClosure
namespace SFT.Computation.CausalTermination
open CausalClosure SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology

-- Counts track only unfilled cells of the finite original pair support.
theorem filterMonotone {α : Type} (items : List α) (small large : α → Bool)
    (contained : ∀ item, item ∈ items → small item = true → large item = true) :
    (items.filter small).length ≤ (items.filter large).length := by
  induction items with
  | nil => exact Nat.le_refl _
  | cons item rest ih =>
    have tail := ih (fun x held => contained x (List.Mem.tail _ held))
    have head := contained item (List.Mem.head rest)
    change (match small item with | true => item :: rest.filter small | false => rest.filter small).length ≤
      (match large item with | true => item :: rest.filter large | false => rest.filter large).length
    cases a : small item <;> cases b : large item
    · exact tail
    · exact Nat.le_trans tail (Nat.le_succ _)
    · have impossible := head a; rw [b] at impossible; cases impossible
    · exact Nat.succ_le_succ tail

theorem filterStrict {α : Type} (items : List α) (small large : α → Bool)
    (contained : ∀ item, item ∈ items → small item = true → large item = true)
    (witness : ∃ item, item ∈ items ∧ small item = false ∧ large item = true) :
    (items.filter small).length < (items.filter large).length := by
  induction items with
  | nil => obtain ⟨item,held,a,b⟩ := witness; cases held
  | cons item rest ih =>
    have tailContained := fun x held => contained x (List.Mem.tail _ held)
    obtain ⟨held,member,smallFalse,largeTrue⟩ := witness
    cases member with
    | head =>
      change (match small item with | true => item :: rest.filter small | false => rest.filter small).length <
        (match large item with | true => item :: rest.filter large | false => rest.filter large).length
      rw [smallFalse,largeTrue]
      exact Nat.lt_succ_of_le (filterMonotone rest small large tailContained)
    | tail _ member =>
      have tail := ih tailContained ⟨held,member,smallFalse,largeTrue⟩
      change (match small item with | true => item :: rest.filter small | false => rest.filter small).length <
        (match large item with | true => item :: rest.filter large | false => rest.filter large).length
      cases a : small item <;> cases b : large item
      · exact tail
      · exact Nat.lt_trans tail (Nat.lt_succ_self _)
      · have impossible := contained item (List.Mem.head rest) a; rw [b] at impossible; cases impossible
      · exact Nat.succ_lt_succ tail

def missing (pairSupport rows : List Edge) : List Edge := pairSupport.filter (fun edge => !has rows edge)
def grows (pairSupport rows : List Edge) : Bool :=
  pairSupport.any (fun edge => linked rows edge && !has rows edge)

theorem growsMeaning (pairSupport rows : List Edge) : grows pairSupport rows = true ↔
    ∃ edge, edge ∈ pairSupport ∧ linked rows edge = true ∧ has rows edge = false := by
  constructor
  · intro h
    obtain ⟨edge,held,checked⟩ := (anyTrueIff _ _).mp h
    have p := (andTrue _ _).mp checked
    refine ⟨edge,held,p.1,?_⟩
    cases test : has rows edge with
    | false => rfl
    | true => rw [test] at p; cases p.2
  · intro ⟨edge,held,linked,absent⟩
    apply (anyTrueIff _ _).mpr
    refine ⟨edge,held,?_⟩
    rw [linked,absent]; rfl

theorem missingDecreases (pairSupport rows : List Edge) (growth : grows pairSupport rows = true) :
    (missing pairSupport (expand pairSupport rows)).length < (missing pairSupport rows).length := by
  apply filterStrict
  · intro edge held absent
    cases old : has rows edge with
    | false => rfl
    | true =>
      have new := (hasIff _ _).mpr (preservesOriginal _ _ _ held ((hasIff _ _).mp old))
      rw [new] at absent; cases absent
  · obtain ⟨edge,held,joined,absent⟩ := (growsMeaning _ _).mp growth
    have new := (hasIff _ _).mpr ((expansionMeaning _ _ _).mpr ⟨held,Or.inr joined⟩)
    exact ⟨edge,held,by rw [new]; rfl,by rw [absent]; rfl⟩

theorem roundsAppend (pairSupport first middle last : List Edge)
    (left : Rounds pairSupport first middle) (right : Rounds pairSupport middle last) :
    Rounds pairSupport first last := by
  induction right with
  | base => exact left
  | next rows prior ih => exact .next _ ih

-- The recursive result carries its complete derivation and fixed-point proof.
-- Projections avoid an extensional rewrite of a well-founded recursion equation.
def closeCertified (pairSupport rows : List Edge) :
    { result : List Edge // Rounds pairSupport rows result ∧ ¬ grows pairSupport result = true } :=
  if growth : grows pairSupport rows = true then
    let next := closeCertified pairSupport (expand pairSupport rows)
    ⟨next.val,roundsAppend _ _ _ _ (.next rows .base) next.property.1,next.property.2⟩
  else ⟨rows,.base,growth⟩
termination_by (missing pairSupport rows).length
decreasing_by exact missingDecreases _ _ growth

def closeRows (pairSupport rows : List Edge) : List Edge := (closeCertified pairSupport rows).val

theorem nativeRounds (pairSupport rows : List Edge) : Rounds pairSupport rows (closeRows pairSupport rows) :=
  (closeCertified pairSupport rows).property.1

theorem nativeStable (pairSupport rows : List Edge) : ¬ grows pairSupport (closeRows pairSupport rows) = true :=
  (closeCertified pairSupport rows).property.2

theorem stableClosed (pairSupport rows : List Edge)
    (support : ∀ left middle right, (left,middle) ∈ rows → (middle,right) ∈ rows → (left,right) ∈ pairSupport)
    (stable : ¬ grows pairSupport rows = true) : Closed rows := by
  intro left middle right first second
  cases held : has rows (left,right) with
  | true => exact (hasIff _ _).mp held
  | false =>
    have joined : linked rows (left,right) = true := (linkedMeaning _ _).mpr ⟨(left,middle),(middle,right),first,second,rfl,rfl,rfl⟩
    exact False.elim (stable ((growsMeaning _ _).mpr ⟨(left,right),support _ _ _ first second,joined,held⟩))

def pairCells (events : List String) : List Edge := events.flatMap (fun left => events.map (fun right => (left,right)))

theorem pairCellMember (events : List String) (left right : String)
    (one : left ∈ events) (two : right ∈ events) : (left,right) ∈ pairCells events :=
  SFT.Foundation.CommonRefinement.memFlatMap _ _ left _ one
    (SFT.Foundation.Count.TraceDerivation.memMap _ right events two)

theorem nativeClosed (events : List String) (original : List Edge)
    (supported : ∀ edge, edge ∈ original → edge.1 ∈ events ∧ edge.2 ∈ events) :
    Closed (closeRows (pairCells events) original) := by
  apply stableClosed
  · intro left middle right first second
    have firstPath := roundsSound _ _ _ (nativeRounds _ _) _ first
    have secondPath := roundsSound _ _ _ (nativeRounds _ _) _ second
    exact pairCellMember _ _ _ (pathEndpoints _ _ supported _ _ firstPath).1
      (pathEndpoints _ _ supported _ _ secondPath).2
  · exact nativeStable _ _

theorem nativeExact (events : List String) (original : List Edge)
    (supported : ∀ edge, edge ∈ original → edge.1 ∈ events ∧ edge.2 ∈ events)
    (left right : String) : (left,right) ∈ closeRows (pairCells events) original ↔ Path original left right :=
  exactClosure _ _ _ (nativeRounds _ _) (roundsPreserve _ _ _
    (fun edge held => pairCellMember _ _ _ (supported edge held).1 (supported edge held).2)
    (nativeRounds _ _)) (nativeClosed _ _ supported) _ _

theorem nativeCycleBoundary (events : List String) (original : List Edge)
    (supported : ∀ edge, edge ∈ original → edge.1 ∈ events ∧ edge.2 ∈ events) :
    (∀ state, ¬ (state,state) ∈ closeRows (pairCells events) original) ↔
    ∀ state, ¬ Path original state state := by
  constructor
  · intro absent state path; exact absent state ((nativeExact _ _ supported _ _).mpr path)
  · intro absent state held; exact absent state ((nativeExact _ _ supported _ _).mp held)

end SFT.Computation.CausalTermination
