import SFT.Physics.QuantityCarrier
namespace SFT.Physics.QuantityClasses
open SFT.Physics.QuantityCarrier
-- Source: measurement_laws.py QUANTITY_CARRIER, pinned V3.
-- Membership uses the existing source reference relation; records stay separate.
theorem overlapConnects {C : Type} (r : ReferenceEquivalence C)
    (a b : C) (o : Observation C)
    (ha : quantityMember r a o) (hb : quantityMember r b o) :
    r.relates a b :=
  r.transitive a o.carrier b ha (r.symmetric b o.carrier hb)

theorem overlapSameClass {C : Type} (r : ReferenceEquivalence C)
    (a b : C) (o : Observation C)
    (ha : quantityMember r a o) (hb : quantityMember r b o)
    (x : Observation C) :
    quantityMember r a x ↔ quantityMember r b x :=
  connectedAnchorsSameClass r a b (overlapConnects r a b o ha hb) x

theorem disconnectedDisjoint {C : Type} (r : ReferenceEquivalence C)
    (a b : C) (h : ¬ r.relates a b) (o : Observation C) :
    ¬ (quantityMember r a o ∧ quantityMember r b o) :=
  fun pair => h (overlapConnects r a b o pair.1 pair.2)

theorem everyObservationCovered {C : Type} (r : ReferenceEquivalence C)
    (o : Observation C) : quantityMember r o.carrier o :=
  r.reflexive o.carrier

theorem sameClassConnects {C : Type} (r : ReferenceEquivalence C)
    (a b : C)
    (same : ∀ o : Observation C, quantityMember r a o ↔ quantityMember r b o)
    (record : SFT.Host.Canonical.Value) : r.relates a b :=
  (same ⟨b,record⟩).mpr (r.reflexive b)

theorem classIdentityIff {C : Type} (r : ReferenceEquivalence C)
    (a b : C) (record : SFT.Host.Canonical.Value) :
    (∀ o : Observation C, quantityMember r a o ↔ quantityMember r b o) ↔
      r.relates a b :=
  ⟨fun h => sameClassConnects r a b h record,
   fun h o => connectedAnchorsSameClass r a b h o⟩

theorem memberPairPreservesKind {C : Type} (r : ReferenceEquivalence C)
    (a : C) (x y : Observation C)
    (hx : quantityMember r a x) (hy : quantityMember r a y) :
    r.kind x.carrier = r.kind y.carrier :=
  (classPreservesKind r a x hx).symm.trans (classPreservesKind r a y hy)

theorem recordReplacementPreservesClass {C : Type} (r : ReferenceEquivalence C)
    (a : C) (o : Observation C) (newRecord : SFT.Host.Canonical.Value) :
    quantityMember r a {o with record := newRecord} ↔ quantityMember r a o :=
  ⟨fun h => h,fun h => h⟩
end SFT.Physics.QuantityClasses
