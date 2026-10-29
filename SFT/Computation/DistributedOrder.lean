import SFT.Computation.CausalProvenance
namespace SFT.Computation.DistributedOrder
open CausalClosure CausalOperations CausalProvenance ConcurrencySchedules
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects

-- The reflexive ledger is retained separately from strict causal precedence.
def identities (events : List String) : List Edge := events.map (fun e => (e,e))
def relation (events : List String) (strict : List Edge) : List Edge := identities events ++ strict

structure Ledger where
  source : Source
  strict : List Edge
  reflexive : List Edge
  incomparable : List Edge
  extensions : List (List String)

def makeLedger (source : Source) (strict : List Edge) : Ledger :=
  ⟨source,strict,identities source.events,
   incomparablePairs source.events (relation source.events strict),allSchedules source.events strict⟩

def execute (source : Source) : Except String Ledger :=
  match CausalProvenance.execute source with
  | .error e => .error e
  | .ok strict => .ok (makeLedger source strict)

theorem identityMeaning (events : List String) (a b : String) :
    (a,b) ∈ identities events ↔ a ∈ events ∧ a = b := by
  constructor
  · intro h
    obtain ⟨e,he,eq⟩ := memMapPreimage (fun e => (e,e)) (a,b) events h
    have ea : e = a := congrArg Prod.fst eq
    have eb : e = b := congrArg Prod.snd eq
    exact ⟨ea ▸ he,ea.symm.trans eb⟩
  · intro ⟨ha,eq⟩; cases eq; exact memMap (fun e => (e,e)) a events ha

theorem relationMeaning (events : List String) (strict : List Edge) (a b : String) :
    (a,b) ∈ relation events strict ↔ (a ∈ events ∧ a = b) ∨ (a,b) ∈ strict := by
  constructor
  · intro h
    cases memAppendCases _ _ _ h with
    | inl hi => exact Or.inl ((identityMeaning _ _ _).mp hi)
    | inr hs => exact Or.inr hs
  · intro h
    cases h with
    | inl hi => exact memAppendLeft _ _ _ ((identityMeaning _ _ _).mpr hi)
    | inr hs => exact memAppendRight _ _ _ hs

theorem reflexive (events : List String) (strict : List Edge) (a : String) (held : a ∈ events) :
    (a,a) ∈ relation events strict := (relationMeaning _ _ _ _).mpr (Or.inl ⟨held,rfl⟩)

theorem antisymmetric (source : Source) (strict : List Edge)
    (passed : CausalProvenance.execute source = .ok strict) (a b : String)
    (ab : (a,b) ∈ relation source.events strict) (ba : (b,a) ∈ relation source.events strict) : a = b := by
  cases (relationMeaning _ _ _ _).mp ab with
  | inl id => exact id.2
  | inr forward =>
    cases (relationMeaning _ _ _ _).mp ba with
    | inl id => exact id.2.symm
    | inr backward => exact False.elim (noReversePredecessor _ _ passed _ _ forward backward)

theorem transitive (source : Source) (strict : List Edge)
    (passed : CausalProvenance.execute source = .ok strict) (a b c : String)
    (ab : (a,b) ∈ relation source.events strict) (bc : (b,c) ∈ relation source.events strict) :
    (a,c) ∈ relation source.events strict := by
  cases (relationMeaning _ _ _ _).mp ab with
  | inl id => cases id.2; exact bc
  | inr first =>
    cases (relationMeaning _ _ _ _).mp bc with
    | inl id => cases id.2; exact ab
    | inr second => exact (relationMeaning _ _ _ _).mpr (Or.inr (transitiveResult _ _ passed _ _ _ first second))

theorem exactProvenance (source : Source) (strict : List Edge)
    (passed : CausalProvenance.execute source = .ok strict) (a b : String) :
    (a,b) ∈ relation source.events strict ↔
    (a ∈ source.events ∧ a = b) ∨ Provenance source a b := by
  constructor
  · intro h
    cases (relationMeaning _ _ _ _).mp h with
    | inl id => exact Or.inl id
    | inr strictRow => exact Or.inr ((nativeProvenance _ _ passed _ _).mp strictRow)
  · intro h
    cases h with
    | inl id => exact (relationMeaning _ _ _ _).mpr (Or.inl id)
    | inr proof => exact (relationMeaning _ _ _ _).mpr (Or.inr ((nativeProvenance _ _ passed _ _).mpr proof))

theorem incomparableMeaning (source : Source) (strict : List Edge) (a b : String) :
    (a,b) ∈ (makeLedger source strict).incomparable ↔
    a ∈ source.events ∧ b ∈ source.events ∧
    ¬ (a,b) ∈ relation source.events strict ∧ ¬ (b,a) ∈ relation source.events strict := by
  constructor
  · intro h
    have q := (incomparablePairsMeaning _ _ _ _).mp h
    exact ⟨q.1,q.2.1,(CausalProvenance.incomparableMeaning _ _ _).mp q.2.2⟩
  · intro h
    exact (incomparablePairsMeaning _ _ _ _).mpr
      ⟨h.1,h.2.1,(CausalProvenance.incomparableMeaning _ _ _).mpr h.2.2⟩

theorem incomparableDistinct (source : Source) (strict : List Edge) (a b : String)
    (held : (a,b) ∈ (makeLedger source strict).incomparable) : a ≠ b := by
  intro eq; cases eq
  have h := (incomparableMeaning _ _ _ _).mp held
  exact h.2.2.1 (reflexive _ _ _ h.1)

theorem completeLinearExtensions (source : Source) (strict : List Edge)
    (unique : distinct source.events = true) (schedule : List String) :
    schedule ∈ (makeLedger source strict).extensions ↔
    List.Perm schedule source.events ∧ ∀ edge, edge ∈ strict → Before edge.1 edge.2 schedule :=
  allSchedulesComplete _ _ _ unique

theorem earlierRelation (first second : Source) (before after : List Edge)
    (old : CausalProvenance.execute first = .ok before)
    (new : CausalProvenance.execute (appendSource first second) = .ok after)
    (a b : String) (held : (a,b) ∈ relation first.events before) :
    (a,b) ∈ relation (appendSource first second).events after := by
  cases (relationMeaning _ _ _ _).mp held with
  | inl id => exact (relationMeaning _ _ _ _).mpr (Or.inl ⟨memAppendLeft _ _ _ id.1,id.2⟩)
  | inr strictRow => exact (relationMeaning _ _ _ _).mpr (Or.inr (earlierNativeRow _ _ _ _ old new _ _ strictRow))

theorem identityBase (event : String) : identities [event] = [(event,event)] := rfl

theorem noInventedTotalOrder :
    ["a","b"] ∈ (makeLedger ⟨["a","b"],[],[]⟩ []).extensions ∧
    ["b","a"] ∈ (makeLedger ⟨["a","b"],[],[]⟩ []).extensions := by
  constructor
  · exact (completeLinearExtensions _ _ rfl _).mpr ⟨.refl _,fun edge h => nomatch h⟩
  · exact (completeLinearExtensions _ _ rfl _).mpr ⟨.swap _ _ _,fun edge h => nomatch h⟩

end SFT.Computation.DistributedOrder
