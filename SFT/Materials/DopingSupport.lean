import SFT.Materials.InterstitialSubstitution
import SFT.Materials.CarrierDuality
namespace SFT.Materials.DopingSupport
open SFT.Mathematics.DiscreteObjects

-- V3 SEMI-DOPING: exact held support differences, with the host relation,
-- source provenance and declared concentration boundary retained.
def gained (before after : Collection) := CarrierDuality.holes after before
def lost (before after : Collection) := CarrierDuality.holes before after
def difference (before after : Collection) := (gained before after,lost before after)

theorem gainedExactly (before after : Collection) (carrier : Form) :
 carrier ∈ gained before after ↔ carrier ∈ after ∧ carrier ∉ before :=
 CarrierDuality.holeExactly after before carrier

theorem lostExactly (before after : Collection) (carrier : Form) :
 carrier ∈ lost before after ↔ carrier ∈ before ∧ carrier ∉ after :=
 CarrierDuality.holeExactly before after carrier

theorem differenceOrientationsDisjoint (before after : Collection) (carrier : Form)
 (gain : carrier ∈ gained before after) : carrier ∉ lost before after := by
 intro loss
 exact ((gainedExactly _ _ _).mp gain).2 ((lostExactly _ _ _).mp loss).1

theorem afterSupportReconstructed (before after : Collection) (carrier : Form) :
 carrier ∈ after ↔ (carrier ∈ before ∧ carrier ∉ lost before after) ∨
 carrier ∈ gained before after := by
 constructor
 · intro held
   cases h : has before carrier with
   | true => exact .inl ⟨(hasIff _ _).mp h,fun loss => ((lostExactly _ _ _).mp loss).2 held⟩
   | false => exact .inr ((gainedExactly _ _ _).mpr ⟨held,(absentIff _ _).mp h⟩)
 · intro h
   cases h with
   | inr gain => exact ((gainedExactly _ _ _).mp gain).1
   | inl retained =>
     cases h : has after carrier with
     | true => exact (hasIff _ _).mp h
     | false => exact False.elim (retained.2 ((lostExactly _ _ _).mpr ⟨retained.1,(absentIff _ _).mp h⟩))

def occupantSupport : Vacancy.Occupant Collection → Collection
 | .emptyOne => []
 | .occupied support => support

def substitution {Organization : Type} (organization : Organization)
 (site : Vacancy.SiteRecord Collection) (dopant : Collection) :=
 (organization,site,InterstitialSubstitution.substitute site dopant,
  difference (occupantSupport site.occupant) dopant)

theorem substitutionRetainsHost {Organization : Type} (organization : Organization)
 (site : Vacancy.SiteRecord Collection) (dopant : Collection) :
 (substitution organization site dopant).1 = organization ∧
 (substitution organization site dopant).2.2.1.site = site.site ∧
 (substitution organization site dopant).2.2.1.referenceOccupant = site.referenceOccupant ∧
 (substitution organization site dopant).2.2.1.provenance = site.provenance ∧
 (substitution organization site dopant).2.2.1.boundary = site.boundary :=
 ⟨rfl,InterstitialSubstitution.substitutionRetainsSite site dopant,
 InterstitialSubstitution.substitutionRetainsReference site dopant,
 (InterstitialSubstitution.substitutionRetainsProvenance site dopant).1,
 (InterstitialSubstitution.substitutionRetainsProvenance site dopant).2⟩

theorem substitutionDifferenceComputed {Organization : Type} (organization : Organization)
 (site : Vacancy.SiteRecord Collection) (dopant : Collection) :
 (substitution organization site dopant).2.2.2 =
 difference (occupantSupport site.occupant)
  (occupantSupport (InterstitialSubstitution.substitute site dopant).occupant) := rfl

def allSupport (rows : List (String × Collection)) := rows.flatMap Prod.snd

def addition {Organization : Type} {reference : List (String × Collection)}
 (organization : Organization) (dopant : InterstitialSubstitution.AddedSite Collection reference) :=
 (organization,dopant,InterstitialSubstitution.insert dopant,
  difference (allSupport reference) (allSupport (InterstitialSubstitution.insert dopant)))

theorem additionRetainsHostRows {Organization : Type} {reference : List (String × Collection)}
 (organization : Organization) (dopant : InterstitialSubstitution.AddedSite Collection reference)
 (row : String × Collection) (held : row ∈ reference) :
 row ∈ (addition organization dopant).2.2.1 :=
 InterstitialSubstitution.referenceRowsRetained dopant row held

theorem additionRetainsOrganizationAndBoundary {Organization : Type} {reference : List (String × Collection)}
 (organization : Organization) (dopant : InterstitialSubstitution.AddedSite Collection reference) :
 (addition organization dopant).1 = organization ∧
 (addition organization dopant).2.1.provenance = dopant.provenance ∧
 (addition organization dopant).2.1.boundary = dopant.boundary := ⟨rfl,rfl,rfl⟩

theorem addedDopantIncluded {Organization : Type} {reference : List (String × Collection)}
 (organization : Organization) (dopant : InterstitialSubstitution.AddedSite Collection reference) :
 (dopant.site,dopant.occupant) ∈ (addition organization dopant).2.2.1 :=
 InterstitialSubstitution.newOccupiedRowRetained dopant
end SFT.Materials.DopingSupport
