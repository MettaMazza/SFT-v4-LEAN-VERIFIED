import SFT.Chemistry.EntityIdentity
import SFT.Physics.ObservationCarrier
namespace SFT.Materials.MaterialIdentity
open SFT.Chemistry
-- obligations.py MATERIALS_OBLIGATIONS[0]; derivation.py _blueprint.
-- These are retained source records, not fitted scientific coefficients.
structure Record where
 constituents : List EntityIdentity.Record
 bonding : List (String × String × String)
 boundary : String
 observations : List (String × String)

def sameIdentity (a b : Record) : Prop := a = b

def admitted (a : Record) : Prop := a.constituents ≠ []

theorem identityExactly (a b : Record) : sameIdentity a b ↔
 a.constituents = b.constituents ∧ a.bonding = b.bonding ∧
 a.boundary = b.boundary ∧ a.observations = b.observations := by
 constructor
 · intro h; cases h; exact ⟨rfl,rfl,rfl,rfl⟩
 · cases a; cases b
   intro ⟨hc,hr,hb,ho⟩; cases hc; cases hr; cases hb; cases ho; rfl

theorem leastRequiredIdentity (relation : Record → Record → Prop)
 (retains : ∀ a b, relation a b → a.constituents = b.constituents ∧
 a.bonding = b.bonding ∧ a.boundary = b.boundary ∧ a.observations = b.observations)
 (a b : Record) (h : relation a b) : sameIdentity a b :=
 (identityExactly a b).mpr (retains a b h)

theorem noExtraIdentityRule (a b : Record)
 (h : a.constituents = b.constituents ∧ a.bonding = b.bonding ∧
 a.boundary = b.boundary ∧ a.observations = b.observations) : sameIdentity a b :=
 (identityExactly a b).mpr h

def initial (c : EntityIdentity.Record) (rs : List (String × String × String))
 (boundary : String) (observations : List (String × String)) : Record :=
 ⟨[c],rs,boundary,observations⟩

theorem initialAdmitted (c : EntityIdentity.Record) (rs : List (String × String × String))
 (boundary : String) (observations : List (String × String)) :
 admitted (initial c rs boundary observations) := by
 intro h; cases h

inductive Extension where
 | constituent (record : EntityIdentity.Record)
 | relation (record : String × String × String)
 | observation (record : String × String)

def extend (a : Record) : Extension → Record
 | .constituent c => { a with constituents := a.constituents ++ [c] }
 | .relation r => { a with bonding := a.bonding ++ [r] }
 | .observation o => { a with observations := a.observations ++ [o] }

def prior (a : Record) : Extension → Record
 | .constituent _ => { a with constituents := EntityIdentity.priorCoordinates a.constituents }
 | .relation _ => { a with bonding := EntityIdentity.priorCoordinates a.bonding }
 | .observation _ => { a with observations := EntityIdentity.priorCoordinates a.observations }

theorem priorExact (a : Record) (e : Extension) : prior (extend a e) e = a := by
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

theorem extensionInjective (a b : Record) (e : Extension)
 (same : sameIdentity (extend a e) (extend b e)) : sameIdentity a b :=
 (priorExact a e).symm.trans ((congrArg (fun r => prior r e) same).trans (priorExact b e))

theorem extensionRetainsDistinctions (a b : Record) (e : Extension)
 (different : ¬ sameIdentity a b) : ¬ sameIdentity (extend a e) (extend b e) :=
 fun h => different (extensionInjective a b e h)

theorem extensionRetainsConstituent (a : Record) (e : Extension)
 (c : EntityIdentity.Record) (held : c ∈ a.constituents) : c ∈ (extend a e).constituents := by
 cases e with
 | constituent _ => exact List.mem_append_left _ held
 | relation _ => exact held
 | observation _ => exact held

theorem extensionRetainsBond (a : Record) (e : Extension)
 (r : String × String × String) (held : r ∈ a.bonding) : r ∈ (extend a e).bonding := by
 cases e with
 | constituent _ => exact held
 | relation _ => exact List.mem_append_left _ held
 | observation _ => exact held

theorem extensionRetainsObservation (a : Record) (e : Extension)
 (o : String × String) (held : o ∈ a.observations) : o ∈ (extend a e).observations := by
 cases e with
 | constituent _ => exact held
 | relation _ => exact held
 | observation _ => exact List.mem_append_left _ held

theorem extensionBoundary (a : Record) (e : Extension) :
 (extend a e).boundary = a.boundary := by cases e <;> rfl

theorem extensionAdmitted (a : Record) (e : Extension) (h : admitted a) :
 admitted (extend a e) := by
 cases e with
 | constituent c =>
   cases hc : a.constituents with
   | nil => exact False.elim (h hc)
   | cons first rest => intro bad; change a.constituents ++ [c] = [] at bad; rw [hc] at bad; cases bad
 | relation r => exact h
 | observation o => exact h

def extendMany : Record → List Extension → Record
 | a, [] => a
 | a, e :: es => extendMany (extend a e) es

theorem finiteExtensionAdmitted (a : Record) (es : List Extension) (h : admitted a) :
 admitted (extendMany a es) := by
 induction es generalizing a with
 | nil => exact h
 | cons e es ih => exact ih (extend a e) (extensionAdmitted a e h)

theorem finiteExtensionBoundary (a : Record) (es : List Extension) :
 (extendMany a es).boundary = a.boundary := by
 induction es generalizing a with
 | nil => rfl
 | cons e es ih => exact (ih (extend a e)).trans (extensionBoundary a e)

theorem finiteExtensionInjective (a b : Record) (es : List Extension)
 (same : sameIdentity (extendMany a es) (extendMany b es)) : sameIdentity a b := by
 induction es generalizing a b with
 | nil => exact same
 | cons e es ih => exact extensionInjective a b e (ih (extend a e) (extend b e) same)

theorem finiteExtensionRetainsDistinctions (a b : Record) (es : List Extension)
 (different : ¬ sameIdentity a b) : ¬ sameIdentity (extendMany a es) (extendMany b es) :=
 fun h => different (finiteExtensionInjective a b es h)

theorem erasedIdentityCannotRecover {Output : Type} (encode : Record → Output)
 (recover : Output → Record) (a b : Record) (different : ¬ sameIdentity a b)
 (collapsed : encode a = encode b) (left : recover (encode a) = a)
 (right : recover (encode b) = b) : False :=
 different (left.symm.trans ((congrArg recover collapsed).trans right))

-- The source observation pairing is reused exactly.
theorem observationSuccessor (a : Record) (o r : String) :
 (extend a (.observation (o,r))).observations =
 SFT.Physics.ObservationCarrier.appendPair a.observations o r := rfl
end SFT.Materials.MaterialIdentity
