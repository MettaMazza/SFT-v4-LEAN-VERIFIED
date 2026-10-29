import SFT.Computation.ConcurrencySchedules
namespace SFT.Computation.CausalProvenance
open CausalClosure CausalOperations
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

-- Keep the original process-order and message rows as distinct source ledgers.
structure Source where
  events : List String
  processOrder : List Edge
  messages : List Edge

def edges (source : Source) : List Edge := source.processOrder ++ source.messages

def execute (source : Source) : Except String (List Edge) := causalClosure source.events (edges source)

inductive Provenance (source : Source) : String → String → Prop where
 | process (left right : String) (held : (left,right) ∈ source.processOrder) : Provenance source left right
 | message (left right : String) (held : (left,right) ∈ source.messages) : Provenance source left right
 | join (left middle right : String) (first : Provenance source left middle)
     (second : Provenance source middle right) : Provenance source left right

theorem provenancePath (source : Source) (left right : String) :
    Provenance source left right ↔ Path (edges source) left right := by
  constructor
  · intro proof
    induction proof with
    | process left right held => exact .edge _ _ (memAppendLeft _ _ _ held)
    | message left right held => exact .edge _ _ (memAppendRight _ _ _ held)
    | join left middle right first second ihFirst ihSecond => exact .join _ _ _ ihFirst ihSecond
  · intro path
    induction path with
    | edge left right held =>
      cases memAppendCases (left,right) source.processOrder source.messages held with
      | inl h => exact .process _ _ h
      | inr h => exact .message _ _ h
    | join left middle right first second ihFirst ihSecond => exact .join _ _ _ ihFirst ihSecond

theorem nativeProvenance (source : Source) (result : List Edge)
    (passed : execute source = .ok result) (left right : String) :
    (left,right) ∈ result ↔ Provenance source left right :=
  ⟨fun held => (provenancePath _ _ _).mpr ((nativeSourceResult _ _ _ passed _ _).mp held),
   fun proof => (nativeSourceResult _ _ _ passed _ _).mpr ((provenancePath _ _ _).mp proof)⟩

theorem processRetained (source : Source) (result : List Edge)
    (passed : execute source = .ok result) (left right : String)
    (held : (left,right) ∈ source.processOrder) : (left,right) ∈ result :=
  (nativeProvenance _ _ passed _ _).mpr (.process _ _ held)

theorem messageRetained (source : Source) (result : List Edge)
    (passed : execute source = .ok result) (left right : String)
    (held : (left,right) ∈ source.messages) : (left,right) ∈ result :=
  (nativeProvenance _ _ passed _ _).mpr (.message _ _ held)

theorem transitiveResult (source : Source) (result : List Edge)
    (passed : execute source = .ok result) : Closed result := by
  intro left middle right first second
  exact (nativeProvenance _ _ passed _ _).mpr (.join _ _ _
    ((nativeProvenance _ _ passed _ _).mp first) ((nativeProvenance _ _ passed _ _).mp second))

theorem noSelfPredecessor (source : Source) (result : List Edge)
    (passed : execute source = .ok result) (event : String) : ¬ (event,event) ∈ result :=
  fun held => nativeAcyclic _ _ _ passed event ((nativeSourceResult _ _ _ passed _ _).mp held)

theorem noReversePredecessor (source : Source) (result : List Edge)
    (passed : execute source = .ok result) (left right : String)
    (forward : (left,right) ∈ result) : ¬ (right,left) ∈ result :=
  fun backward => noSelfPredecessor _ _ passed left (transitiveResult _ _ passed _ _ _ forward backward)

def incomparable (rows : List Edge) (left right : String) : Bool :=
  !has rows (left,right) && !has rows (right,left)

theorem incomparableMeaning (rows : List Edge) (left right : String) :
    incomparable rows left right = true ↔ ¬ (left,right) ∈ rows ∧ ¬ (right,left) ∈ rows := by
  constructor
  · intro h
    have parts := (andTrue _ _).mp h
    constructor
    · intro held; have yes := (hasIff _ _).mpr held; rw [yes] at parts; cases parts.1
    · intro held; have yes := (hasIff _ _).mpr held; rw [yes] at parts; cases parts.2
  · intro h
    cases first : has rows (left,right) with
    | true => exact False.elim (h.1 ((hasIff _ _).mp first))
    | false =>
      cases second : has rows (right,left) with
      | true => exact False.elim (h.2 ((hasIff _ _).mp second))
      | false => unfold incomparable; rw [first,second]; rfl

theorem incomparableProvenance (source : Source) (result : List Edge)
    (passed : execute source = .ok result) (left right : String) :
    incomparable result left right = true ↔
      ¬ Provenance source left right ∧ ¬ Provenance source right left := by
  constructor
  · intro h
    have p := (incomparableMeaning _ _ _).mp h
    exact ⟨fun proof => p.1 ((nativeProvenance _ _ passed _ _).mpr proof),
      fun proof => p.2 ((nativeProvenance _ _ passed _ _).mpr proof)⟩
  · intro h
    exact (incomparableMeaning _ _ _).mpr
      ⟨fun held => h.1 ((nativeProvenance _ _ passed _ _).mp held),
       fun held => h.2 ((nativeProvenance _ _ passed _ _).mp held)⟩

-- Complete ordered support; the Boolean relation itself does not add a
-- distinctness guard absent from the source operation.
def incomparablePairs (events : List String) (rows : List Edge) : List Edge :=
  (CausalTermination.pairCells events).filter (fun edge => incomparable rows edge.1 edge.2)

theorem incomparablePairsMeaning (events : List String) (rows : List Edge) (left right : String) :
    (left,right) ∈ incomparablePairs events rows ↔
      left ∈ events ∧ right ∈ events ∧ incomparable rows left right = true := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    obtain ⟨a,ha,mapped⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ p.1
    obtain ⟨b,hb,eq⟩ := memMapPreimage _ _ _ mapped
    have ea : a = left := congrArg Prod.fst eq
    have eb : b = right := congrArg Prod.snd eq
    exact ⟨ea ▸ ha,eb ▸ hb,p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr
      ⟨CausalTermination.pairCellMember _ _ _ h.1 h.2.1,h.2.2⟩

def appendSource (first second : Source) : Source :=
  ⟨first.events ++ second.events, first.processOrder ++ second.processOrder, first.messages ++ second.messages⟩

theorem earlierProvenance (first second : Source) (left right : String)
    (proof : Provenance first left right) : Provenance (appendSource first second) left right := by
  induction proof with
  | process left right held => exact .process _ _ (memAppendLeft _ _ _ held)
  | message left right held => exact .message _ _ (memAppendLeft _ _ _ held)
  | join left middle right a b ia ib => exact .join _ _ _ ia ib

theorem laterProvenance (first second : Source) (left right : String)
    (proof : Provenance second left right) : Provenance (appendSource first second) left right := by
  induction proof with
  | process left right held => exact .process _ _ (memAppendRight _ _ _ held)
  | message left right held => exact .message _ _ (memAppendRight _ _ _ held)
  | join left middle right a b ia ib => exact .join _ _ _ ia ib

theorem assemblyInterface (first second : Source) (left middle right : String)
    (a : Provenance first left middle) (b : Provenance second middle right) :
    Provenance (appendSource first second) left right :=
  .join _ _ _ (earlierProvenance _ _ _ _ a) (laterProvenance _ _ _ _ b)

theorem earlierNativeRow (first second : Source) (before after : List Edge)
    (firstPassed : execute first = .ok before)
    (assembledPassed : execute (appendSource first second) = .ok after)
    (left right : String) (held : (left,right) ∈ before) : (left,right) ∈ after :=
  (nativeProvenance _ _ assembledPassed _ _).mpr
    (earlierProvenance _ _ _ _ ((nativeProvenance _ _ firstPassed _ _).mp held))

theorem identityNoPredecessor (events : List String) (left right : String) :
    ¬ Provenance ⟨events,[],[]⟩ left right :=
  fun proof => emptyPathImpossible _ _ ((provenancePath _ _ _).mp proof)

end SFT.Computation.CausalProvenance
