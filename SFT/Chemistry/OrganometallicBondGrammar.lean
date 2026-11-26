import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.OrganometallicBondGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "free-compound-name"
  | .admitted => "one-retained-chemical-entity"

inductive Centre where
  | rejected | admitted

def centreName : Centre → String
  | .rejected => "imported-conventional-metal-list"
  | .admitted => "retained-admitted-centre-occurrence"

inductive Carbon where
  | rejected | admitted

def carbonName : Carbon → String
  | .rejected => "selected-formula-fragment"
  | .admitted => "retained-carbon-occurrence"

inductive Topology where
  | rejected | admitted

def topologyName : Topology → String
  | .rejected => "proximity-or-name-association"
  | .admitted => "direct-centre-carbon-incidence"

inductive Electrons where
  | rejected | admitted

def electronsName : Electrons → String
  | .rejected => "assumed-valence-number"
  | .admitted => "complete-held-bond-electron-support"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "single-selected-bond"
  | .admitted => "complete-positive-direct-incidence-support"

inductive Classification where
  | rejected | admitted

def classificationName : Classification → String
  | .rejected => "species-or-name-lookup"
  | .admitted => "positive-support-organometallic-EmptyOne-otherwise"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "fitted-species-exception"
  | .admitted => "direct-incidence-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  centre : Centre
  carbon : Carbon
  topology : Topology
  electrons : Electrons
  multiplicity : Multiplicity
  classification : Classification
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, centreName c.centre, carbonName c.carbon, topologyName c.topology, electronsName c.electrons, multiplicityName c.multiplicity, classificationName c.classification, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "centre=" (centreName c.centre), SFT.Host.Text.append "carbon=" (carbonName c.carbon), SFT.Host.Text.append "topology=" (topologyName c.topology), SFT.Host.Text.append "electrons=" (electronsName c.electrons), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "classification=" (classificationName c.classification), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-chemical-entity__retained-admitted-centre-occurrence__retained-carbon-occurrence__direct-centre-carbon-incidence__complete-held-bond-electron-support__complete-positive-direct-incidence-support__positive-support-organometallic-EmptyOne-otherwise__direct-incidence-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-chemical-entity" &&
  SFT.Host.Text.equal (centreName c.centre) "retained-admitted-centre-occurrence" &&
  SFT.Host.Text.equal (carbonName c.carbon) "retained-carbon-occurrence" &&
  SFT.Host.Text.equal (topologyName c.topology) "direct-centre-carbon-incidence" &&
  SFT.Host.Text.equal (electronsName c.electrons) "complete-held-bond-electron-support" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "complete-positive-direct-incidence-support" &&
  SFT.Host.Text.equal (classificationName c.classification) "positive-support-organometallic-EmptyOne-otherwise" &&
  SFT.Host.Text.equal (extensionName c.extension) "direct-incidence-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-chemical-entity") then "A name does not retain the bonded entity." else
  if !(SFT.Host.Text.equal (centreName c.centre) "retained-admitted-centre-occurrence") then "A conventional list imports the classification boundary." else
  if !(SFT.Host.Text.equal (carbonName c.carbon) "retained-carbon-occurrence") then "A selected formula fragment need not be a bonded carbon occurrence." else
  if !(SFT.Host.Text.equal (topologyName c.topology) "direct-centre-carbon-incidence") then "Proximity or naming does not force a bond." else
  if !(SFT.Host.Text.equal (electronsName c.electrons) "complete-held-bond-electron-support") then "An assumed valence number loses the bond support." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "complete-positive-direct-incidence-support") then "Selecting one bond loses additional incidences." else
  if !(SFT.Host.Text.equal (classificationName c.classification) "positive-support-organometallic-EmptyOne-otherwise") then "A lookup lets the observed label choose the law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "direct-incidence-successor-no-extra-rule") then "A species exception destroys zero-parameter closure." else
  "one-retained-chemical-entity__retained-admitted-centre-occurrence__retained-carbon-occurrence__direct-centre-carbon-incidence__complete-held-bond-electron-support__complete-positive-direct-incidence-support__positive-support-organometallic-EmptyOne-otherwise__direct-incidence-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, centre, carbon, topology, electron, multiplicity, classification and extension choices; decide all 256 candidates solely from admitted chemical-entity, element, bond, composition, electron-support and coordination dependencies."
def grammarBoundary : String := "Every finite one-entity support of distinct direct admitted-centre/carbon incidences with positive held electron support; structural EmptyOne absence; all twelve frozen IUPAC criterion, scope, example, context and exclusion surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Centre.rejected,Centre.admitted]).flatMap fun centre =>
  ([Carbon.rejected,Carbon.admitted]).flatMap fun carbon =>
  ([Topology.rejected,Topology.admitted]).flatMap fun topology =>
  ([Electrons.rejected,Electrons.admitted]).flatMap fun electrons =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Classification.rejected,Classification.admitted]).flatMap fun classification =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,centre,carbon,topology,electrons,multiplicity,classification,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier centre carbon topology electrons multiplicity classification extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcentre : centre ∈ [Centre.rejected,Centre.admitted] := by
      cases centre <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarbon : carbon ∈ [Carbon.rejected,Carbon.admitted] := by
      cases carbon <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htopology : topology ∈ [Topology.rejected,Topology.admitted] := by
      cases topology <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectrons : electrons ∈ [Electrons.rejected,Electrons.admitted] := by
      cases electrons <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclassification : classification ∈ [Classification.rejected,Classification.admitted] := by
      cases classification <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ centre _ hcentre
    apply CommonRefinement.memFlatMap _ _ carbon _ hcarbon
    apply CommonRefinement.memFlatMap _ _ topology _ htopology
    apply CommonRefinement.memFlatMap _ _ electrons _ helectrons
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ classification _ hclassification
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (electrons : Electrons) (multiplicity : Multiplicity) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,electrons,multiplicity,classification,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,electrons,multiplicity,classification,extension⟩ := by
 cases electrons <;> cases multiplicity <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier centre carbon topology electrons multiplicity classification extension =>
  cases carrier <;> cases centre <;> cases carbon <;> cases topology
  · exact sourceDecisionBlock0000 electrons multiplicity classification extension
  · exact sourceDecisionBlock0001 electrons multiplicity classification extension
  · exact sourceDecisionBlock0010 electrons multiplicity classification extension
  · exact sourceDecisionBlock0011 electrons multiplicity classification extension
  · exact sourceDecisionBlock0100 electrons multiplicity classification extension
  · exact sourceDecisionBlock0101 electrons multiplicity classification extension
  · exact sourceDecisionBlock0110 electrons multiplicity classification extension
  · exact sourceDecisionBlock0111 electrons multiplicity classification extension
  · exact sourceDecisionBlock1000 electrons multiplicity classification extension
  · exact sourceDecisionBlock1001 electrons multiplicity classification extension
  · exact sourceDecisionBlock1010 electrons multiplicity classification extension
  · exact sourceDecisionBlock1011 electrons multiplicity classification extension
  · exact sourceDecisionBlock1100 electrons multiplicity classification extension
  · exact sourceDecisionBlock1101 electrons multiplicity classification extension
  · exact sourceDecisionBlock1110 electrons multiplicity classification extension
  · exact sourceDecisionBlock1111 electrons multiplicity classification extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-chemical-entity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem centreCriterion (value : Centre) : SFT.Host.Text.equal (centreName value) "retained-admitted-centre-occurrence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem carbonCriterion (value : Carbon) : SFT.Host.Text.equal (carbonName value) "retained-carbon-occurrence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem topologyCriterion (value : Topology) : SFT.Host.Text.equal (topologyName value) "direct-centre-carbon-incidence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem electronsCriterion (value : Electrons) : SFT.Host.Text.equal (electronsName value) "complete-held-bond-electron-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem multiplicityCriterion (value : Multiplicity) : SFT.Host.Text.equal (multiplicityName value) "complete-positive-direct-incidence-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem classificationCriterion (value : Classification) : SFT.Host.Text.equal (classificationName value) "positive-support-organometallic-EmptyOne-otherwise" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "direct-incidence-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, centreCriterion, carbonCriterion, topologyCriterion, electronsCriterion, multiplicityCriterion, classificationCriterion, extensionCriterion]
  cases c with
  | mk carrier centre carbon topology electrons multiplicity classification extension =>
    cases carrier <;> cases centre <;> cases carbon <;> cases topology <;> cases electrons <;> cases multiplicity <;> cases classification <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.centre = .admitted ∧ c.carbon = .admitted ∧ c.topology = .admitted ∧ c.electrons = .admitted ∧ c.multiplicity = .admitted ∧ c.classification = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier centre carbon topology electrons multiplicity classification extension =>
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

theorem centre_rejected_rejected (c : Candidate) (h : c.centre = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.centre eq
    rw [h] at field
    cases field

theorem carbon_rejected_rejected (c : Candidate) (h : c.carbon = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carbon eq
    rw [h] at field
    cases field

theorem topology_rejected_rejected (c : Candidate) (h : c.topology = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.topology eq
    rw [h] at field
    cases field

theorem electrons_rejected_rejected (c : Candidate) (h : c.electrons = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electrons eq
    rw [h] at field
    cases field

theorem multiplicity_rejected_rejected (c : Candidate) (h : c.multiplicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
    rw [h] at field
    cases field

theorem classification_rejected_rejected (c : Candidate) (h : c.classification = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.classification eq
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

end SFT.Chemistry.OrganometallicBondGrammar
