import SFT.Materials.MaterialIdentity
namespace SFT.Materials.MaterialRetention
open MaterialIdentity SFT.Chemistry

theorem finiteConstituentRetention (a : Record) (es : List Extension)
 (c : EntityIdentity.Record) (held : c ∈ a.constituents) :
 c ∈ (extendMany a es).constituents := by
 induction es generalizing a with
 | nil => exact held
 | cons e es ih => exact ih (extend a e) (extensionRetainsConstituent a e c held)

theorem finiteBondRetention (a : Record) (es : List Extension)
 (r : String × String × String) (held : r ∈ a.bonding) :
 r ∈ (extendMany a es).bonding := by
 induction es generalizing a with
 | nil => exact held
 | cons e es ih => exact ih (extend a e) (extensionRetainsBond a e r held)

theorem finiteObservationRetention (a : Record) (es : List Extension)
 (o : String × String) (held : o ∈ a.observations) :
 o ∈ (extendMany a es).observations := by
 induction es generalizing a with
 | nil => exact held
 | cons e es ih => exact ih (extend a e) (extensionRetainsObservation a e o held)

-- Recover the complete prior record, not only its carrier size or labels.
def recoverHistory : List Extension → Record → Record
 | [], a => a
 | e :: es, a => prior (recoverHistory es a) e

theorem historyRecovery (a : Record) (es : List Extension) :
 recoverHistory es (extendMany a es) = a := by
 induction es generalizing a with
 | nil => rfl
 | cons e es ih =>
   change prior (recoverHistory es (extendMany (extend a e) es)) e = a
   rw [ih]
   exact priorExact a e

theorem completeConstituentIdentity (a : Record) (es : List Extension)
 (c : EntityIdentity.Record) (held : c ∈ a.constituents) :
 ∃ retained ∈ (extendMany a es).constituents,
 retained.constitution = c.constitution ∧ retained.isotope = c.isotope ∧
 retained.context = c.context :=
 ⟨c,finiteConstituentRetention a es c held,rfl,rfl,rfl⟩

theorem boundaryDistinguished (a b : Record) (different : a.boundary ≠ b.boundary) :
 ¬ sameIdentity a b := fun h => different (congrArg Record.boundary h)

theorem bondingDistinguished (a b : Record) (different : a.bonding ≠ b.bonding) :
 ¬ sameIdentity a b := fun h => different (congrArg Record.bonding h)

theorem constituentDistinguished (a b : Record)
 (different : a.constituents ≠ b.constituents) :
 ¬ sameIdentity a b := fun h => different (congrArg Record.constituents h)

theorem observationDistinguished (a b : Record)
 (different : a.observations ≠ b.observations) :
 ¬ sameIdentity a b := fun h => different (congrArg Record.observations h)
end SFT.Materials.MaterialRetention
