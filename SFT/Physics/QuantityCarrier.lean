import SFT.Physics.ObservationCarrier
namespace SFT.Physics.QuantityCarrier
-- measurement_laws.py QUANTITY_CARRIER: an equivalence class under the
-- generated kind-preserving reference relation, with records held separately.
-- These fields spell out 'kind-preserving reference equivalence'; they do not
-- add a selected relation, unit, scale or measured numerical parameter.
structure ReferenceEquivalence (Carrier : Type) where
  kind : Carrier → String
  relates : Carrier → Carrier → Prop
  reflexive : ∀ a, relates a a
  symmetric : ∀ a b, relates a b → relates b a
  transitive : ∀ a b c, relates a b → relates b c → relates a c
  preservesKind : ∀ a b, relates a b → kind a = kind b

structure Observation (Carrier : Type) where
  carrier : Carrier
  record : SFT.Host.Canonical.Value

def quantityMember {Carrier : Type} (reference : ReferenceEquivalence Carrier)
    (anchor : Carrier) (observation : Observation Carrier) : Prop :=
  reference.relates anchor observation.carrier

theorem anchorBelongs {Carrier : Type} (reference : ReferenceEquivalence Carrier)
    (anchor : Carrier) (record : SFT.Host.Canonical.Value) :
    quantityMember reference anchor ⟨anchor,record⟩ := reference.reflexive anchor

theorem classPreservesKind {Carrier : Type} (reference : ReferenceEquivalence Carrier)
    (anchor : Carrier) (observation : Observation Carrier)
    (member : quantityMember reference anchor observation) :
    reference.kind anchor = reference.kind observation.carrier :=
  reference.preservesKind anchor observation.carrier member

theorem connectedAnchorsSameClass {Carrier : Type} (reference : ReferenceEquivalence Carrier)
    (a b : Carrier) (connected : reference.relates a b) (observation : Observation Carrier) :
    quantityMember reference a observation ↔ quantityMember reference b observation :=
  ⟨fun member => reference.transitive b a observation.carrier (reference.symmetric a b connected) member,
   fun member => reference.transitive a b observation.carrier connected member⟩

theorem differentKindsExcluded {Carrier : Type} (reference : ReferenceEquivalence Carrier)
    (anchor : Carrier) (observation : Observation Carrier)
    (different : reference.kind anchor ≠ reference.kind observation.carrier) :
    ¬quantityMember reference anchor observation :=
  fun member => different (classPreservesKind reference anchor observation member)

theorem recordDoesNotSelectQuantity {Carrier : Type} (reference : ReferenceEquivalence Carrier)
    (anchor carrier : Carrier) (first second : SFT.Host.Canonical.Value) :
    quantityMember reference anchor ⟨carrier,first⟩ ↔ quantityMember reference anchor ⟨carrier,second⟩ :=
  ⟨fun member => member,fun member => member⟩

theorem distinctRecordsRetained {Carrier : Type} (carrier : Carrier)
    (first second : SFT.Host.Canonical.Value) (different : first ≠ second) :
    (⟨carrier,first⟩ : Observation Carrier) ≠ ⟨carrier,second⟩ :=
  fun equal => different (congrArg Observation.record equal)
end SFT.Physics.QuantityCarrier
