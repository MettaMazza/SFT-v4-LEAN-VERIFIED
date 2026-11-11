import SFT.Physics.MatterConservedLabels
namespace SFT.Chemistry.EntityIdentity

-- catalog.py CHEMISTRY_SPECS[0]: one constitution/isotope/context record.
-- Context entries are the registered required distinctions, not fitted values.
structure Record where
 constitution : String
 isotope : String
 context : List (String × String)
 deriving DecidableEq

structure Entity where
 carrier : String
 record : Record

def sameIdentity (a b : Entity) : Prop := a.record = b.record

def extend (entity : Entity) (coordinate : String × String) : Entity :=
 ⟨entity.carrier,⟨entity.record.constitution,entity.record.isotope,
 entity.record.context ++ [coordinate]⟩⟩

theorem recordExactly (a b : Record) : a = b ↔
 a.constitution = b.constitution ∧ a.isotope = b.isotope ∧ a.context = b.context := by
 constructor
 · intro h; cases h; exact ⟨rfl,rfl,rfl⟩
 · cases a; cases b
   intro ⟨hc,hi,hx⟩; cases hc; cases hi; cases hx; rfl

theorem identityExactly (a b : Entity) : sameIdentity a b ↔
 a.record.constitution = b.record.constitution ∧
 a.record.isotope = b.record.isotope ∧ a.record.context = b.record.context :=
 recordExactly a.record b.record

theorem constitutionDistinguished (a b : Entity)
 (different : a.record.constitution ≠ b.record.constitution) : ¬ sameIdentity a b :=
 fun same => different ((identityExactly a b).mp same).1

theorem isotopeDistinguished (a b : Entity)
 (different : a.record.isotope ≠ b.record.isotope) : ¬ sameIdentity a b :=
 fun same => different ((identityExactly a b).mp same).2.1

theorem contextDistinguished (a b : Entity)
 (different : a.record.context ≠ b.record.context) : ¬ sameIdentity a b :=
 fun same => different ((identityExactly a b).mp same).2.2

-- Every identity rule retaining the required observations factors through
-- this record. No extra identity distinction is introduced by the record.
theorem leastRequiredIdentity (relation : Entity → Entity → Prop)
 (retains : ∀ a b, relation a b →
 a.record.constitution = b.record.constitution ∧
 a.record.isotope = b.record.isotope ∧ a.record.context = b.record.context)
 (a b : Entity) (related : relation a b) : sameIdentity a b :=
 (identityExactly a b).mpr (retains a b related)

theorem noExtraIdentityRule (a b : Entity)
 (same : a.record.constitution = b.record.constitution ∧
 a.record.isotope = b.record.isotope ∧ a.record.context = b.record.context) :
 sameIdentity a b := (identityExactly a b).mpr same

theorem extensionCarrier (a : Entity) (coordinate : String × String) :
 (extend a coordinate).carrier = a.carrier := rfl

theorem extensionConstitution (a : Entity) (coordinate : String × String) :
 (extend a coordinate).record.constitution = a.record.constitution := rfl

theorem extensionIsotope (a : Entity) (coordinate : String × String) :
 (extend a coordinate).record.isotope = a.record.isotope := rfl

theorem extensionRetainsCoordinate (a : Entity) (coordinate prior : String × String)
 (held : prior ∈ a.record.context) : prior ∈ (extend a coordinate).record.context :=
 List.mem_append_left _ held

def priorCoordinates {α : Type} : List α → List α
 | [] => []
 | [_] => []
 | x :: y :: rest => x :: priorCoordinates (y :: rest)

theorem priorCoordinatesExact {α : Type} (xs : List α) (x : α) :
 priorCoordinates (xs ++ [x]) = xs := by
 induction xs with
 | nil => rfl
 | cons a rest ih =>
   cases rest with
   | nil => rfl
   | cons b tail => exact congrArg (List.cons a) ih

theorem extensionRetainsDistinctions (a b : Entity) (x y : String × String)
 (different : ¬ sameIdentity a b) : ¬ sameIdentity (extend a x) (extend b y) := by
 intro same
 have fields := (identityExactly _ _).mp same
 have contexts : a.record.context = b.record.context := by
   have equality := congrArg priorCoordinates fields.2.2
   exact (priorCoordinatesExact a.record.context x).symm.trans
     (equality.trans (priorCoordinatesExact b.record.context y))
 exact different ((identityExactly a b).mpr ⟨fields.1,fields.2.1,contexts⟩)

def extendMany : Entity → List (String × String) → Entity
 | entity, [] => entity
 | entity, coordinate :: rest => extendMany (extend entity coordinate) rest

theorem finiteExtensionCarrier (a : Entity) (coordinates : List (String × String)) :
 (extendMany a coordinates).carrier = a.carrier := by
 induction coordinates generalizing a with
 | nil => rfl
 | cons coordinate rest ih => exact ih (extend a coordinate)

theorem finiteExtensionConstitution (a : Entity) (coordinates : List (String × String)) :
 (extendMany a coordinates).record.constitution = a.record.constitution := by
 induction coordinates generalizing a with
 | nil => rfl
 | cons coordinate rest ih => exact ih (extend a coordinate)

theorem finiteExtensionIsotope (a : Entity) (coordinates : List (String × String)) :
 (extendMany a coordinates).record.isotope = a.record.isotope := by
 induction coordinates generalizing a with
 | nil => rfl
 | cons coordinate rest ih => exact ih (extend a coordinate)

theorem finiteExtensionRetainsCoordinate (a : Entity)
 (coordinates : List (String × String)) (prior : String × String)
 (held : prior ∈ a.record.context) : prior ∈ (extendMany a coordinates).record.context := by
 induction coordinates generalizing a with
 | nil => exact held
 | cons coordinate rest ih =>
   exact ih (extend a coordinate) (extensionRetainsCoordinate a coordinate prior held)

theorem erasedIdentityCannotRecover {Output : Type} (encode : Entity → Output)
 (recover : Output → Record) (a b : Entity) (different : ¬ sameIdentity a b)
 (collapsed : encode a = encode b) (left : recover (encode a) = a.record)
 (right : recover (encode b) = b.record) : False :=
 different (left.symm.trans ((congrArg recover collapsed).trans right))

end SFT.Chemistry.EntityIdentity
