import SFT.Chemistry.SubstanceIdentity
import SFT.Physics.ObservationCarrier
namespace SFT.Materials.MaterialCarrier
open SFT.Chemistry
-- obligations.py MATERIALS_OBLIGATIONS[0]; derivation.py _blueprint.
-- Composition is the exact record type supplied by the source dependency.
-- The proofs quantify over its representation; no scientific value is fitted.
structure Constituent (Composition : Type) where
 identity : EntityIdentity.Record
 composition : Composition

-- Retain the actual constituent composition; no uniform-composition premise.
def fromSubstance {C : Type} (row : SubstanceIdentity.Constituent C) : Constituent C :=
 ⟨row.entity.record,row.composition⟩

structure Record (Composition : Type) where
 constituents : List (Constituent Composition)
 bonding : List (String × String × String)
 boundary : String
 observations : List (String × String)

variable {C : Type}

def sameIdentity (a b : Record C) : Prop := a = b

def admitted (a : Record C) : Prop := a.constituents ≠ []

theorem identityExactly (a b : Record C) : sameIdentity a b ↔
 a.constituents = b.constituents ∧ a.bonding = b.bonding ∧
 a.boundary = b.boundary ∧ a.observations = b.observations := by
 constructor
 · intro h; cases h; exact ⟨rfl,rfl,rfl,rfl⟩
 · cases a; cases b
   intro ⟨hc,hr,hb,ho⟩; cases hc; cases hr; cases hb; cases ho; rfl

theorem leastRequiredIdentity (relation : Record C → Record C → Prop)
 (retains : ∀ a b, relation a b → a.constituents = b.constituents ∧
 a.bonding = b.bonding ∧ a.boundary = b.boundary ∧ a.observations = b.observations)
 (a b : Record C) (h : relation a b) : sameIdentity a b :=
 (identityExactly a b).mpr (retains a b h)

theorem noExtraIdentityRule (a b : Record C)
 (h : a.constituents = b.constituents ∧ a.bonding = b.bonding ∧
 a.boundary = b.boundary ∧ a.observations = b.observations) : sameIdentity a b :=
 (identityExactly a b).mpr h

def initial (c : Constituent C) (rs : List (String × String × String))
 (boundary : String) (observations : List (String × String)) : Record C :=
 ⟨[c],rs,boundary,observations⟩

theorem initialAdmitted (c : Constituent C) (rs : List (String × String × String))
 (boundary : String) (observations : List (String × String)) :
 admitted (initial c rs boundary observations) := by
 intro h; cases h

inductive Extension (Composition : Type) where
 | constituent (record : Constituent Composition)
 | relation (record : String × String × String)
 | observation (record : String × String)

def extend (a : Record C) : Extension C → Record C
 | .constituent c => { a with constituents := a.constituents ++ [c] }
 | .relation r => { a with bonding := a.bonding ++ [r] }
 | .observation o => { a with observations := a.observations ++ [o] }

def prior (a : Record C) : Extension C → Record C
 | .constituent _ => { a with constituents := EntityIdentity.priorCoordinates a.constituents }
 | .relation _ => { a with bonding := EntityIdentity.priorCoordinates a.bonding }
 | .observation _ => { a with observations := EntityIdentity.priorCoordinates a.observations }

theorem priorExact (a : Record C) (e : Extension C) : prior (extend a e) e = a := by
 cases a with
 | mk cs rs b os =>
   cases e with
   | constituent c =>
     change Record.mk (EntityIdentity.priorCoordinates (cs ++ [c])) rs b os = _
     rw [EntityIdentity.priorCoordinatesExact]
   | relation r =>
     change Record.mk cs (EntityIdentity.priorCoordinates (rs ++ [r])) b os = _
     rw [EntityIdentity.priorCoordinatesExact]
   | observation o =>
     change Record.mk cs rs b (EntityIdentity.priorCoordinates (os ++ [o])) = _
     rw [EntityIdentity.priorCoordinatesExact]

theorem extensionInjective (a b : Record C) (e : Extension C)
 (same : sameIdentity (extend a e) (extend b e)) : sameIdentity a b :=
 (priorExact a e).symm.trans ((congrArg (fun r => prior r e) same).trans (priorExact b e))

theorem extensionRetainsDistinctions (a b : Record C) (e : Extension C)
 (different : ¬ sameIdentity a b) : ¬ sameIdentity (extend a e) (extend b e) :=
 fun h => different (extensionInjective a b e h)

theorem extensionRetainsConstituent (a : Record C) (e : Extension C)
 (c : Constituent C) (held : c ∈ a.constituents) : c ∈ (extend a e).constituents := by
 cases e with
 | constituent _ => exact List.mem_append_left _ held
 | relation _ => exact held
 | observation _ => exact held

theorem extensionRetainsBond (a : Record C) (e : Extension C)
 (r : String × String × String) (held : r ∈ a.bonding) : r ∈ (extend a e).bonding := by
 cases e with
 | constituent _ => exact held
 | relation _ => exact List.mem_append_left _ held
 | observation _ => exact held

theorem extensionRetainsObservation (a : Record C) (e : Extension C)
 (o : String × String) (held : o ∈ a.observations) : o ∈ (extend a e).observations := by
 cases e with
 | constituent _ => exact held
 | relation _ => exact held
 | observation _ => exact List.mem_append_left _ held

theorem extensionBoundary (a : Record C) (e : Extension C) :
 (extend a e).boundary = a.boundary := by cases e <;> rfl

theorem extensionAdmitted (a : Record C) (e : Extension C) (h : admitted a) :
 admitted (extend a e) := by
 cases e with
 | constituent c =>
   cases hc : a.constituents with
   | nil => exact False.elim (h hc)
   | cons first rest => intro bad; change a.constituents ++ [c] = [] at bad; rw [hc] at bad; cases bad
 | relation r => exact h
 | observation o => exact h

def extendMany : Record C → List (Extension C) → Record C
 | a, [] => a
 | a, e :: es => extendMany (extend a e) es

theorem finiteExtensionAdmitted (a : Record C) (es : List (Extension C)) (h : admitted a) :
 admitted (extendMany a es) := by
 induction es generalizing a with
 | nil => exact h
 | cons e es ih => exact ih (extend a e) (extensionAdmitted a e h)

theorem finiteExtensionBoundary (a : Record C) (es : List (Extension C)) :
 (extendMany a es).boundary = a.boundary := by
 induction es generalizing a with
 | nil => rfl
 | cons e es ih => exact (ih (extend a e)).trans (extensionBoundary a e)

theorem finiteExtensionInjective (a b : Record C) (es : List (Extension C))
 (same : sameIdentity (extendMany a es) (extendMany b es)) : sameIdentity a b := by
 induction es generalizing a b with
 | nil => exact same
 | cons e es ih => exact extensionInjective a b e (ih (extend a e) (extend b e) same)

theorem finiteExtensionRetainsDistinctions (a b : Record C) (es : List (Extension C))
 (different : ¬ sameIdentity a b) : ¬ sameIdentity (extendMany a es) (extendMany b es) :=
 fun h => different (finiteExtensionInjective a b es h)

theorem erasedIdentityCannotRecover {Output : Type} (encode : Record C → Output)
 (recover : Output → Record C) (a b : Record C) (different : ¬ sameIdentity a b)
 (collapsed : encode a = encode b) (left : recover (encode a) = a)
 (right : recover (encode b) = b) : False :=
 different (left.symm.trans ((congrArg recover collapsed).trans right))

-- The source observation pairing is reused exactly.
theorem observationSuccessor (a : Record C) (o r : String) :
 (extend a (.observation (o,r))).observations =
 SFT.Physics.ObservationCarrier.appendPair a.observations o r := rfl
end SFT.Materials.MaterialCarrier
