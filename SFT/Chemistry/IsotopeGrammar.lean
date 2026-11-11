import SFT.Chemistry.IsotopeFamily
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.IsotopeGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "atom-label-without-nucleus"
  | .admitted => "nuclide-carriers"

inductive Element where
  | rejected | admitted

def elementName : Element → String
  | .rejected => "mixed-atomic-numbers"
  | .admitted => "element-identity-retained"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "mass-number-erased"
  | .admitted => "mass-number-distinction"

inductive Neutron where
  | rejected | admitted

def neutronName : Neutron → String
  | .rejected => "unrecorded-nuclear-difference"
  | .admitted => "complementary-nuclear-count-held"

inductive Chemistry where
  | rejected | admitted

def chemistryName : Chemistry → String
  | .rejected => "different-element-chemistry"
  | .admitted => "common-element-chemistry-boundary"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "always-indistinguishable"
  | .admitted => "resolution-bounded-distinction"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "isotope-name-only"
  | .admitted => "complete-nuclide-family-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-isotope-equivalence"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  element : Element
  mass : Mass
  neutron : Neutron
  chemistry : Chemistry
  observation : Observation
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, elementName c.element, massName c.mass, neutronName c.neutron, chemistryName c.chemistry, observationName c.observation, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "element=" (elementName c.element), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "neutron=" (neutronName c.neutron), SFT.Host.Text.append "chemistry=" (chemistryName c.chemistry), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "nuclide-carriers__element-identity-retained__mass-number-distinction__complementary-nuclear-count-held__common-element-chemistry-boundary__resolution-bounded-distinction__complete-nuclide-family-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "nuclide-carriers" &&
  SFT.Host.Text.equal (elementName c.element) "element-identity-retained" &&
  SFT.Host.Text.equal (massName c.mass) "mass-number-distinction" &&
  SFT.Host.Text.equal (neutronName c.neutron) "complementary-nuclear-count-held" &&
  SFT.Host.Text.equal (chemistryName c.chemistry) "common-element-chemistry-boundary" &&
  SFT.Host.Text.equal (observationName c.observation) "resolution-bounded-distinction" &&
  SFT.Host.Text.equal (recordName c.record) "complete-nuclide-family-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "nuclide-carriers") then "An atom label alone does not establish nuclide identity." else
  if !(SFT.Host.Text.equal (elementName c.element) "element-identity-retained") then "Different proton counts are different elements, not isotopes." else
  if !(SFT.Host.Text.equal (massName c.mass) "mass-number-distinction") then "Erasing mass number merges distinct nuclides." else
  if !(SFT.Host.Text.equal (neutronName c.neutron) "complementary-nuclear-count-held") then "The source of mass-number distinction cannot remain anonymous." else
  if !(SFT.Host.Text.equal (chemistryName c.chemistry) "common-element-chemistry-boundary") then "Changing element identity does not define an isotope relation." else
  if !(SFT.Host.Text.equal (observationName c.observation) "resolution-bounded-distinction") then "Isotopic distinctions are resolvable in registered measurements." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-nuclide-family-trace") then "A name cannot reconstruct proton and mass coordinates." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An arbitrary equivalence can merge different elements or erase mass distinctions." else
  "nuclide-carriers__element-identity-retained__mass-number-distinction"

def generationRule : String := "Generate the literal product of the registered isotope carrier, element, mass, complementary nuclear count, chemistry, observation, record and extension choices."
def grammarBoundary : String := "Every positive-finite family of admitted nuclides sharing one atomic-number identity while retaining each distinct generated mass-number coordinate and complete nuclear record."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Element.rejected,Element.admitted]).flatMap fun element =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Neutron.rejected,Neutron.admitted]).flatMap fun neutron =>
  ([Chemistry.rejected,Chemistry.admitted]).flatMap fun chemistry =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,element,mass,neutron,chemistry,observation,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier element mass neutron chemistry observation record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helement : element ∈ [Element.rejected,Element.admitted] := by
      cases element <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hneutron : neutron ∈ [Neutron.rejected,Neutron.admitted] := by
      cases neutron <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchemistry : chemistry ∈ [Chemistry.rejected,Chemistry.admitted] := by
      cases chemistry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ element _ helement
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ neutron _ hneutron
    apply CommonRefinement.memFlatMap _ _ chemistry _ hchemistry
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier element mass neutron chemistry observation record extension =>
    cases carrier <;> cases element <;> cases mass <;> cases neutron <;> cases chemistry <;> cases observation <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier element mass neutron chemistry observation record extension =>
    cases carrier <;> cases element <;> cases mass <;> cases neutron <;> cases chemistry <;> cases observation <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.element = .admitted ∧ c.mass = .admitted ∧ c.neutron = .admitted ∧ c.chemistry = .admitted ∧ c.observation = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier element mass neutron chemistry observation record extension =>
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

theorem element_rejected_rejected (c : Candidate) (h : c.element = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.element eq
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

theorem neutron_rejected_rejected (c : Candidate) (h : c.neutron = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.neutron eq
    rw [h] at field
    cases field

theorem chemistry_rejected_rejected (c : Candidate) (h : c.chemistry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.chemistry eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
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

end SFT.Chemistry.IsotopeGrammar
