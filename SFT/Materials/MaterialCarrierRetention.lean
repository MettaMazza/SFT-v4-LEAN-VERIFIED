import SFT.Materials.MaterialCarrier
namespace SFT.Materials.MaterialCarrierRetention
open MaterialCarrier SFT.Chemistry
variable {C : Type}

theorem finiteConstituentRetention (a : Record C) (es : List (Extension C))
 (c : Constituent C) (held : c ∈ a.constituents) :
 c ∈ (extendMany a es).constituents := by
 induction es generalizing a with
 | nil => exact held
 | cons e es ih => exact ih (extend a e) (extensionRetainsConstituent a e c held)

theorem finiteBondRetention (a : Record C) (es : List (Extension C))
 (r : String × String × String) (held : r ∈ a.bonding) :
 r ∈ (extendMany a es).bonding := by
 induction es generalizing a with
 | nil => exact held
 | cons e es ih => exact ih (extend a e) (extensionRetainsBond a e r held)

theorem finiteObservationRetention (a : Record C) (es : List (Extension C))
 (o : String × String) (held : o ∈ a.observations) :
 o ∈ (extendMany a es).observations := by
 induction es generalizing a with
 | nil => exact held
 | cons e es ih => exact ih (extend a e) (extensionRetainsObservation a e o held)

-- Recover the complete prior record, not only its carrier size or labels.
def recoverHistory : List (Extension C) → Record C → Record C
 | [], a => a
 | e :: es, a => prior (recoverHistory es a) e

theorem historyRecovery (a : Record C) (es : List (Extension C)) :
 recoverHistory es (extendMany a es) = a := by
 induction es generalizing a with
 | nil => rfl
 | cons e es ih =>
   change prior (recoverHistory es (extendMany (extend a e) es)) e = a
   rw [ih]
   exact priorExact a e

theorem completeConstituentIdentity (a : Record C) (es : List (Extension C))
 (c : Constituent C) (held : c ∈ a.constituents) :
 ∃ retained ∈ (extendMany a es).constituents,
 retained.identity = c.identity ∧ retained.composition = c.composition :=
 ⟨c,finiteConstituentRetention a es c held,rfl,rfl⟩

theorem boundaryDistinguished (a b : Record C) (different : a.boundary ≠ b.boundary) :
 ¬ sameIdentity a b := fun h => different (congrArg Record.boundary h)

theorem bondingDistinguished (a b : Record C) (different : a.bonding ≠ b.bonding) :
 ¬ sameIdentity a b := fun h => different (congrArg Record.bonding h)

theorem constituentDistinguished (a b : Record C)
 (different : a.constituents ≠ b.constituents) :
 ¬ sameIdentity a b := fun h => different (congrArg Record.constituents h)

theorem observationDistinguished (a b : Record C)
 (different : a.observations ≠ b.observations) :
 ¬ sameIdentity a b := fun h => different (congrArg Record.observations h)
theorem substanceConstituentIdentity (c : SubstanceIdentity.Constituent C) :
 (fromSubstance c).identity = c.entity.record ∧
 (fromSubstance c).composition = c.composition := ⟨rfl,rfl⟩

theorem constituentFieldsExactly (a b : Constituent C) : a = b ↔
 a.identity = b.identity ∧ a.composition = b.composition := by
 constructor
 · intro h; cases h; exact ⟨rfl,rfl⟩
 · cases a; cases b; intro ⟨h1,h2⟩; cases h1; cases h2; rfl

-- Different constituent compositions do not invalidate a material carrier.
theorem heterogeneousExtensionAdmitted (a : Record C) (c : Constituent C)
 (h : admitted a) : admitted (extend a (.constituent c)) :=
 extensionAdmitted a (.constituent c) h

end SFT.Materials.MaterialCarrierRetention
