import SFT.Chemistry.AtomicWeightPopulation
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AtomicWeightGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "decimal-answer-only"
  | .admitted => "exact-ratio-carrier"

inductive Population where
  | rejected | admitted

def populationName : Population → String
  | .rejected => "single-atom-mass"
  | .admitted => "average-atomic-mass"

inductive Isotopes where
  | rejected | admitted

def isotopesName : Isotopes → String
  | .rejected => "isotope-mixture-erased"
  | .admitted => "isotope-support-retained"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "unbound-mass-labels"
  | .admitted => "isotope-mass-pairs"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "unit-as-derived-law"
  | .admitted => "reference-unit-comparison"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "universal-fixed-composition"
  | .admitted => "source-bounded-population"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "exact-decimal-pretense"
  | .admitted => "measurement-interval-retained"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-weight-adjustment"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  population : Population
  isotopes : Isotopes
  mass : Mass
  reference : Reference
  source : Source
  uncertainty : Uncertainty
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, populationName c.population, isotopesName c.isotopes, massName c.mass, referenceName c.reference, sourceName c.source, uncertaintyName c.uncertainty, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "population=" (populationName c.population), SFT.Host.Text.append "isotopes=" (isotopesName c.isotopes), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "exact-ratio-carrier__average-atomic-mass__isotope-support-retained__isotope-mass-pairs__reference-unit-comparison__source-bounded-population__measurement-interval-retained__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "exact-ratio-carrier" &&
  SFT.Host.Text.equal (populationName c.population) "average-atomic-mass" &&
  SFT.Host.Text.equal (isotopesName c.isotopes) "isotope-support-retained" &&
  SFT.Host.Text.equal (massName c.mass) "isotope-mass-pairs" &&
  SFT.Host.Text.equal (referenceName c.reference) "reference-unit-comparison" &&
  SFT.Host.Text.equal (sourceName c.source) "source-bounded-population" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "measurement-interval-retained" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "exact-ratio-carrier") then "A decimal answer hides population, isotope and reference provenance." else
  if !(SFT.Host.Text.equal (populationName c.population) "average-atomic-mass") then "Atomic weight concerns a population average rather than an arbitrary single atom." else
  if !(SFT.Host.Text.equal (isotopesName c.isotopes) "isotope-support-retained") then "Erasing isotope support loses the source of population variation." else
  if !(SFT.Host.Text.equal (massName c.mass) "isotope-mass-pairs") then "Unbound masses cannot be paired with their isotope parts." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "reference-unit-comparison") then "A conventional unit scale cannot select the structural ratio." else
  if !(SFT.Host.Text.equal (sourceName c.source) "source-bounded-population") then "Natural isotope composition can vary by source." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "measurement-interval-retained") then "A reported decimal must not erase its measurement interval." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An adjustable correction can force a measured target." else
  "exact-ratio-carrier__average-atomic-mass__reference-unit-comparison"

def generationRule : String := "Generate the literal product of the registered atomic-weight carrier, population, isotope support, mass pairs, reference, source, uncertainty and extension choices."
def grammarBoundary : String := "Every finite source-bounded atom population with retained isotope membership, exact positive rational abundance parts, atomic-mass records and a separate unified-reference-unit comparison."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Population.rejected,Population.admitted]).flatMap fun population =>
  ([Isotopes.rejected,Isotopes.admitted]).flatMap fun isotopes =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,population,isotopes,mass,reference,source,uncertainty,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier population isotopes mass reference source uncertainty extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpopulation : population ∈ [Population.rejected,Population.admitted] := by
      cases population <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hisotopes : isotopes ∈ [Isotopes.rejected,Isotopes.admitted] := by
      cases isotopes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ population _ hpopulation
    apply CommonRefinement.memFlatMap _ _ isotopes _ hisotopes
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier population isotopes mass reference source uncertainty extension =>
    cases carrier <;> cases population <;> cases isotopes <;> cases mass <;> cases reference <;> cases source <;> cases uncertainty <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier population isotopes mass reference source uncertainty extension =>
    cases carrier <;> cases population <;> cases isotopes <;> cases mass <;> cases reference <;> cases source <;> cases uncertainty <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.population = .admitted ∧ c.isotopes = .admitted ∧ c.mass = .admitted ∧ c.reference = .admitted ∧ c.source = .admitted ∧ c.uncertainty = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier population isotopes mass reference source uncertainty extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem population_rejected_rejected (c : Candidate) (h : c.population = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.population eq
    rw [h] at field
    cases field

theorem isotopes_rejected_rejected (c : Candidate) (h : c.isotopes = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.isotopes eq
    rw [h] at field
    cases field

theorem mass_rejected_rejected (c : Candidate) (h : c.mass = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mass eq
    rw [h] at field
    cases field

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem uncertainty_rejected_rejected (c : Candidate) (h : c.uncertainty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uncertainty eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.AtomicWeightGrammar
