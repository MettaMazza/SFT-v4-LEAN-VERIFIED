import SFT.Physics.GravityEquivalence
namespace SFT.Physics.GravityCurvature

-- CURVATURE retains source identity on each generated adjacent relation.
structure Edge (Event Source : Type) (first last : Event) where
 source : Source

inductive Path (Event Source : Type) : Event → Event → Type where
 | empty (event : Event) : Path Event Source event event
 | append {a b c : Event} (path : Path Event Source a b) (edge : Edge Event Source b c) : Path Event Source a c

variable {Event Source Orientation : Type}

def transport (step : {first last : Event} → Edge Event Source first last → Orientation → Orientation) {a b : Event} :
 Path Event Source a b → Orientation → Orientation
 | .empty _,o => o
 | .append path edge,o => step edge (transport step path o)

def sources {a b : Event} : Path Event Source a b → List Source
 | .empty _ => []
 | .append path edge => sources path ++ [edge.source]

def nonclosing (step : {first last : Event} → Edge Event Source first last → Orientation → Orientation) {a b : Event}
 (left right : Path Event Source a b) (held : Orientation) : Prop :=
 transport step left held ≠ transport step right held

theorem emptyTransport (step : {first last : Event} → Edge Event Source first last → Orientation → Orientation) (a : Event) (o : Orientation) :
 transport step (.empty a) o=o := rfl

theorem successorRetainsEverySource {a b c : Event} (path : Path Event Source a b)
 (edge : Edge Event Source b c) :
 sources (.append path edge)=sources path ++ [edge.source] := rfl

theorem successorTransportExact (step : {first last : Event} → Edge Event Source first last → Orientation → Orientation)
 {a b c : Event} (path : Path Event Source a b) (edge : Edge Event Source b c) (o : Orientation) :
 transport step (.append path edge) o=step edge (transport step path o) := rfl

theorem onePathCannotWitnessCurvature (step : {first last : Event} → Edge Event Source first last → Orientation → Orientation)
 {a b : Event} (p : Path Event Source a b) (o : Orientation) : ¬ nonclosing step p p o :=
 fun h => h rfl

theorem nonclosingIsPathDistinction (step : {first last : Event} → Edge Event Source first last → Orientation → Orientation)
 {a b : Event} (p q : Path Event Source a b) (o : Orientation) (curved : nonclosing step p q o) : p ≠ q := by
 intro same
 cases same
 exact curved rfl

theorem pathIndependentCannotWitnessCurvature (step : {first last : Event} → Edge Event Source first last → Orientation → Orientation)
 {a b : Event} (p q : Path Event Source a b) (o : Orientation)
 (flat : ∀ (left right : Path Event Source a b), transport step left o=transport step right o) :
 ¬ nonclosing step p q o := fun curved => curved (flat p q)

theorem injectiveOrientationNamesPreserveNonclosure {Label : Type}
 (name : Orientation → Label) (injective : ∀ x y, name x=name y → x=y)
 (step : {first last : Event} → Edge Event Source first last → Orientation → Orientation)
 {a b : Event} (p q : Path Event Source a b) (o : Orientation) :
 name (transport step p o) ≠ name (transport step q o) ↔ nonclosing step p q o := by
 constructor
 · intro h same; exact h (congrArg name same)
 · intro h same; exact h (injective _ _ same)
end SFT.Physics.GravityCurvature
