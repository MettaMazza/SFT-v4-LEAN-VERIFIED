import SFT.Chemistry.Functional
namespace SFT.Chemistry.ReactionFamily
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects
abbrev HeldLabel := ReactionIdentity.HeldLabel

-- Input and output states occupy distinct ordered positions in each local row.
structure BondRow where
 label : HeldLabel
 before : String
 after : String

def changed (row : BondRow) : Bool := decide (row.before≠row.after)
def minimal (rows : List BondRow) := rows.filter changed

def fromChange (row : ReactionIdentity.RelationChange) : BondRow := ⟨row.label,row.before,row.after⟩
def sourceChanges (reaction : ReactionIdentity.Reaction) :=
 (reaction.firstChange::reaction.furtherChanges).map fromChange

structure Map where
 reaction : ReactionIdentity.Reaction
 completeRows : List BondRow
 completeChanges : minimal completeRows=sourceChanges reaction
 conditions : SFT.Host.Canonical.Value
 source : SFT.Host.Canonical.Value
 mechanism : SFT.Host.Canonical.Value

def pattern (m : Map) := minimal m.completeRows

theorem minimalExactlyChanged (rows : List BondRow) (row : BondRow) :
 row∈minimal rows ↔ row∈rows ∧ row.before≠row.after := by
 constructor
 · intro h
   have parts := (filterMemberIff _ _ _).mp h
   exact ⟨parts.1,of_decide_eq_true parts.2⟩
 · intro h
   exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem unchangedExcluded (rows : List BondRow) (row : BondRow)
 (same : row.before=row.after) : ¬row∈minimal rows :=
 fun h => ((minimalExactlyChanged rows row).mp h).2 same

theorem omissionLosesChangedRow (rows proposed : List BondRow) (row : BondRow)
 (held : row∈rows) (different : row.before≠row.after) (omitted : ¬row∈proposed) :
 ¬(∀ x∈minimal rows, x∈proposed) :=
 fun covers => omitted (covers row ((minimalExactlyChanged rows row).mpr ⟨held,different⟩))

theorem patternBoundToGeneratedChanges (m : Map) : pattern m=sourceChanges m.reaction := m.completeChanges

theorem patternHasNoIdentityRows (m : Map) : ∀ row∈pattern m, row.before≠row.after :=
 fun row held => ((minimalExactlyChanged _ _).mp held).2

theorem patternLabelsComplete (m : Map) : (pattern m).map BondRow.label=m.reaction.trace.raw.changedRelations := by
 rw [patternBoundToGeneratedChanges]
 have commute : ∀ xs : List ReactionIdentity.RelationChange,
  (xs.map fromChange).map BondRow.label=xs.map ReactionIdentity.RelationChange.label := by
   intro xs
   induction xs with
   | nil => rfl
   | cons x xs ih => exact congrArg (List.cons x.label) ih
 exact (commute _).trans m.reaction.allChanges

def SamePattern (a b : Map) : Prop :=
 (∀ row∈pattern a, row∈pattern b) ∧ (∀ row∈pattern b, row∈pattern a)

theorem samePatternRefl (a : Map) : SamePattern a a := ⟨fun _ h => h,fun _ h => h⟩
theorem samePatternSymm (a b : Map) (same : SamePattern a b) : SamePattern b a := ⟨same.2,same.1⟩
theorem samePatternTrans (a b c : Map) (ab : SamePattern a b) (bc : SamePattern b c) : SamePattern a c :=
 ⟨fun row held => bc.1 row (ab.1 row held),fun row held => ab.2 row (bc.2 row held)⟩

def classOf (support : List Map) (representative member : Map) : Prop := member∈support ∧ SamePattern representative member

theorem classMembershipExact (support : List Map) (a b : Map) :
 classOf support a b ↔ b∈support ∧ SamePattern a b := ⟨fun h => h,fun h => h⟩

theorem equalClassesOnSupport (support : List Map) (a b : Map) (same : SamePattern a b) :
 ∀ member, classOf support a member ↔ classOf support b member := by
 intro member
 constructor
 · intro h; exact ⟨h.1,samePatternTrans b a member (samePatternSymm a b same) h.2⟩
 · intro h; exact ⟨h.1,samePatternTrans a b member same h.2⟩

structure Family where
 first : Map
 second : Map
 different : first≠second
 same : SamePattern first second
 further : List Map
 allMatch : ∀ m∈further, SamePattern first m

def members (f : Family) := f.first::f.second::f.further

def base (first second : Map) (different : first≠second) (same : SamePattern first second) : Family :=
 ⟨first,second,different,same,[],by intro m h; cases h⟩

def append (f : Family) (next : Map) (same : SamePattern f.first next) : Family where
 first := f.first
 second := f.second
 different := f.different
 same := f.same
 further := f.further++[next]
 allMatch := by
  intro m held
  cases memAppendCases m f.further [next] held with
  | inl old => exact f.allMatch m old
  | inr added => cases added with
    | head => exact same
    | tail _ impossible => cases impossible

theorem completeFamilyMatch (f : Family) (m : Map) (held : m∈members f) : SamePattern f.first m := by
 cases held with
 | head => exact samePatternRefl _
 | tail _ held => cases held with
   | head => exact f.same
   | tail _ held => exact f.allMatch m held

theorem appendHistory (f : Family) (next : Map) (same : SamePattern f.first next) :
 members (append f next same)=members f++[next] := rfl

theorem nonmatchingOpensDistinctClass (f : Family) (next : Map) (different : ¬SamePattern f.first next) :
 ∀ m∈members f, ¬SamePattern m next := by
 intro m held same
 exact different (samePatternTrans f.first m next (completeFamilyMatch f m held) same)

def changeMechanism (m : Map) (record : SFT.Host.Canonical.Value) : Map := {m with mechanism:=record}

theorem mechanismDoesNotSelectPattern (m : Map) (record : SFT.Host.Canonical.Value) :
 pattern (changeMechanism m record)=pattern m := rfl

theorem mechanismDoesNotSelectClass (a b : Map) (left right : SFT.Host.Canonical.Value) :
 SamePattern (changeMechanism a left) (changeMechanism b right) ↔ SamePattern a b :=
 ⟨fun h => h,fun h => h⟩

theorem everyMemberBalanced (f : Family) (m : Map) (_held : m∈members f)
 (test : HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (ReactionIdentity.flows m.reaction.placements)=
 SFT.Physics.MatterConservedLabels.outputCount test (ReactionIdentity.flows m.reaction.placements) :=
 ReactionIdentity.noCarrierLoss _ test


def rowEqual (a b : BondRow) : Bool := decide
 (a.label.family=b.label.family ∧ a.label.label=b.label.label ∧ a.before=b.before ∧ a.after=b.after)

theorem labelFieldsEqual (a b : HeldLabel) (family : a.family=b.family) (label : a.label=b.label) : a=b := by
 cases a with
 | mk af al ah ap => cases b with
   | mk bf bl bh bp =>
     change af=bf at family
     change al=bl at label
     cases family
     cases label
     rfl

theorem rowEqualExactly (a b : BondRow) : rowEqual a b=true ↔ a=b := by
 constructor
 · intro h
   have parts := of_decide_eq_true h
   have labels := labelFieldsEqual a.label b.label parts.1 parts.2.1
   cases a with
   | mk al ab aa => cases b with
     | mk bl bb ba =>
       change al=bl at labels
       have before : ab=bb := parts.2.2.1
       have after : aa=ba := parts.2.2.2
       cases labels
       cases before
       cases after
       rfl
 · intro h
   cases h
   exact decide_eq_true ⟨rfl,rfl,rfl,rfl⟩

def containsRow (rows : List BondRow) (row : BondRow) : Bool := rows.any (rowEqual row)

theorem containsRowExactly (rows : List BondRow) (row : BondRow) : containsRow rows row=true ↔ row∈rows := by
 constructor
 · intro h
   obtain ⟨other,held,equal⟩ := (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mp h
   have same := (rowEqualExactly row other).mp equal
   exact same.symm ▸ held
 · intro held
   exact (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mpr ⟨row,held,(rowEqualExactly _ _).mpr rfl⟩

def matchPattern (a b : Map) : Bool :=
 (pattern a).all (containsRow (pattern b)) && (pattern b).all (containsRow (pattern a))

theorem matchPatternExactly (a b : Map) : matchPattern a b=true ↔ SamePattern a b := by
 constructor
 · intro h
   have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
   exact ⟨fun row held => (containsRowExactly _ _).mp
     (SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ both.1 row held),
    fun row held => (containsRowExactly _ _).mp
     (SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ both.2 row held)⟩
 · intro h
   exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
    ⟨(allTrueIffMembers _ _).mpr (fun row held => (containsRowExactly _ _).mpr (h.1 row held)),
     (allTrueIffMembers _ _).mpr (fun row held => (containsRowExactly _ _).mpr (h.2 row held))⟩

def decisionTrace (support : List Map) := support.flatMap
 (fun a => support.map (fun b => (a,b,matchPattern a b)))

theorem completePairDecision (support : List Map) (a b : Map) (ha : a∈support) (hb : b∈support) :
 (a,b,matchPattern a b)∈decisionTrace support := by
 exact SFT.Foundation.CommonRefinement.memFlatMap _ _ _ _ ha (memMap _ _ _ hb)


theorem generatedChangesAlreadyMinimal (rows : List ReactionIdentity.RelationChange) :
 minimal (rows.map fromChange)=rows.map fromChange := by
 induction rows with
 | nil => rfl
 | cons row rest ih =>
   change (fromChange row::rest.map fromChange).filter changed=fromChange row::rest.map fromChange
   rw [List.filter_cons_of_pos (show changed (fromChange row)=true from decide_eq_true row.changed)]
   exact congrArg (List.cons (fromChange row)) ih

def fromReaction (reaction : ReactionIdentity.Reaction)
 (conditions source mechanism : SFT.Host.Canonical.Value) : Map where
 reaction := reaction
 completeRows := sourceChanges reaction
 completeChanges := generatedChangesAlreadyMinimal _
 conditions := conditions
 source := source
 mechanism := mechanism

theorem constructedPattern (reaction : ReactionIdentity.Reaction)
 (conditions source mechanism : SFT.Host.Canonical.Value) :
 pattern (fromReaction reaction conditions source mechanism)=sourceChanges reaction :=
 patternBoundToGeneratedChanges _

theorem constructedMapRetainsCompleteCarriers (reaction : ReactionIdentity.Reaction)
 (conditions source mechanism : SFT.Host.Canonical.Value) :
 (fromReaction reaction conditions source mechanism).reaction.placements=reaction.placements := rfl

theorem directionalChangeCannotBeItsReverse (row : BondRow) (different : row.before≠row.after) :
 row≠BondRow.mk row.label row.after row.before := by
 intro same
 exact different (congrArg BondRow.before same)

theorem baseHasTwoMembers (first second : Map) (different : first≠second)
 (same : SamePattern first second) : members (base first second different same)=[first,second] := rfl

end SFT.Chemistry.ReactionFamily
