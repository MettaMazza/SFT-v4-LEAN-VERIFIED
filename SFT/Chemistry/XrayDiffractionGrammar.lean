import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.XrayDiffractionGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "pattern-without-crystal"
  | .admitted => "held-crystal-phase-and-composition"

inductive Probe where
  | rejected | admitted

def probeName : Probe → String
  | .rejected => "chemistry-owned-xray-probe"
  | .admitted => "explicit-physics-xray-scattering-handoff"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "line-list-without-reciprocal-support"
  | .admitted => "held-direct-and-reciprocal-support"

inductive Coordinate where
  | rejected | admitted

def coordinateName : Coordinate → String
  | .rejected => "floating-two-theta"
  | .admitted => "exact-positive-spacing-or-held-angle"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "arbitrary-diffraction-intensity"
  | .admitted => "exact-counted-relative-intensity-or-EmptyOne"

inductive Structure where
  | rejected | admitted

def structureName : Structure → String
  | .rejected => "database-structure-label-only"
  | .admitted => "complete-cell-symmetry-site-correspondence"

inductive Custody where
  | rejected | admitted

def custodyName : Custody → String
  | .rejected => "selected-major-reflections"
  | .admitted => "complete-reflection-error-condition-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refined-added-pattern"
  | .admitted => "successor-retains-prior-reflections-and-structure"

structure Candidate where
  carrier : Carrier
  probe : Probe
  support : Support
  coordinate : Coordinate
  response : Response
  «structure» : Structure
  custody : Custody
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, probeName c.probe, supportName c.support, coordinateName c.coordinate, responseName c.response, structureName c.«structure», custodyName c.custody, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "probe=" (probeName c.probe), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "coordinate=" (coordinateName c.coordinate), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "structure=" (structureName c.«structure»), SFT.Host.Text.append "custody=" (custodyName c.custody), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-crystal-phase-and-composition__explicit-physics-xray-scattering-handoff__held-direct-and-reciprocal-support__exact-positive-spacing-or-held-angle__exact-counted-relative-intensity-or-EmptyOne__complete-cell-symmetry-site-correspondence__complete-reflection-error-condition-custody__successor-retains-prior-reflections-and-structure"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "held-crystal-phase-and-composition" &&
  SFT.Host.Text.equal (probeName c.probe) "explicit-physics-xray-scattering-handoff" &&
  SFT.Host.Text.equal (supportName c.support) "held-direct-and-reciprocal-support" &&
  SFT.Host.Text.equal (coordinateName c.coordinate) "exact-positive-spacing-or-held-angle" &&
  SFT.Host.Text.equal (responseName c.response) "exact-counted-relative-intensity-or-EmptyOne" &&
  SFT.Host.Text.equal (structureName c.«structure») "complete-cell-symmetry-site-correspondence" &&
  SFT.Host.Text.equal (custodyName c.custody) "complete-reflection-error-condition-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-prior-reflections-and-structure"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "held-crystal-phase-and-composition") then "A pattern alone loses crystal identity." else
  if !(SFT.Host.Text.equal (probeName c.probe) "explicit-physics-xray-scattering-handoff") then "Probe production belongs to Physics." else
  if !(SFT.Host.Text.equal (supportName c.support) "held-direct-and-reciprocal-support") then "Lines alone lose the generated lattice relation." else
  if !(SFT.Host.Text.equal (coordinateName c.coordinate) "exact-positive-spacing-or-held-angle") then "A float is not native exact support." else
  if !(SFT.Host.Text.equal (responseName c.response) "exact-counted-relative-intensity-or-EmptyOne") then "An arbitrary height loses comparison support." else
  if !(SFT.Host.Text.equal (structureName c.«structure») "complete-cell-symmetry-site-correspondence") then "A label cannot establish structure correspondence." else
  if !(SFT.Host.Text.equal (custodyName c.custody) "complete-reflection-error-condition-custody") then "Selection erases weak and adverse reflections." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-prior-reflections-and-structure") then "Refinement can change prior evidence." else
  "held-crystal-phase-and-composition__explicit-physics-xray-scattering-handoff__held-direct-and-reciprocal-support__exact-positive-spacing-or-held-angle__exact-counted-relative-intensity-or-EmptyOne__complete-cell-symmetry-site-correspondence__complete-reflection-error-condition-custody__successor-retains-prior-reflections-and-structure"

def generationRule : String := "Generate the literal product of the eight frozen ANAL-016 custody decisions."
def grammarBoundary : String := "Eight binary dimensions exhaust the registered ANAL-016 carrier, relation, exact-support, condition, custody and extension forms; 2^8 = 256 generated candidates."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Probe.rejected,Probe.admitted]).flatMap fun probe =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Coordinate.rejected,Coordinate.admitted]).flatMap fun coordinate =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Structure.rejected,Structure.admitted]).flatMap fun «structure» =>
  ([Custody.rejected,Custody.admitted]).flatMap fun custody =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,probe,support,coordinate,response,«structure»,custody,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier probe support coordinate response «structure» custody extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprobe : probe ∈ [Probe.rejected,Probe.admitted] := by
      cases probe <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoordinate : coordinate ∈ [Coordinate.rejected,Coordinate.admitted] := by
      cases coordinate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstructure : «structure» ∈ [Structure.rejected,Structure.admitted] := by
      cases «structure» <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcustody : custody ∈ [Custody.rejected,Custody.admitted] := by
      cases custody <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ probe _ hprobe
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ coordinate _ hcoordinate
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ «structure» _ hstructure
    apply CommonRefinement.memFlatMap _ _ custody _ hcustody
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (response : Response) («structure» : Structure) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,response,«structure»,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,response,«structure»,custody,extension⟩ := by
 cases response <;> cases «structure» <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier probe support coordinate response «structure» custody extension =>
  cases carrier <;> cases probe <;> cases support <;> cases coordinate
  · exact sourceDecisionBlock0000 response «structure» custody extension
  · exact sourceDecisionBlock0001 response «structure» custody extension
  · exact sourceDecisionBlock0010 response «structure» custody extension
  · exact sourceDecisionBlock0011 response «structure» custody extension
  · exact sourceDecisionBlock0100 response «structure» custody extension
  · exact sourceDecisionBlock0101 response «structure» custody extension
  · exact sourceDecisionBlock0110 response «structure» custody extension
  · exact sourceDecisionBlock0111 response «structure» custody extension
  · exact sourceDecisionBlock1000 response «structure» custody extension
  · exact sourceDecisionBlock1001 response «structure» custody extension
  · exact sourceDecisionBlock1010 response «structure» custody extension
  · exact sourceDecisionBlock1011 response «structure» custody extension
  · exact sourceDecisionBlock1100 response «structure» custody extension
  · exact sourceDecisionBlock1101 response «structure» custody extension
  · exact sourceDecisionBlock1110 response «structure» custody extension
  · exact sourceDecisionBlock1111 response «structure» custody extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "held-crystal-phase-and-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem probeCriterion (value : Probe) : SFT.Host.Text.equal (probeName value) "explicit-physics-xray-scattering-handoff" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "held-direct-and-reciprocal-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem coordinateCriterion (value : Coordinate) : SFT.Host.Text.equal (coordinateName value) "exact-positive-spacing-or-held-angle" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem responseCriterion (value : Response) : SFT.Host.Text.equal (responseName value) "exact-counted-relative-intensity-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem structureCriterion (value : Structure) : SFT.Host.Text.equal (structureName value) "complete-cell-symmetry-site-correspondence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem custodyCriterion (value : Custody) : SFT.Host.Text.equal (custodyName value) "complete-reflection-error-condition-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-prior-reflections-and-structure" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, probeCriterion, supportCriterion, coordinateCriterion, responseCriterion, structureCriterion, custodyCriterion, extensionCriterion]
  cases c with
  | mk carrier probe support coordinate response «structure» custody extension =>
    cases carrier <;> cases probe <;> cases support <;> cases coordinate <;> cases response <;> cases «structure» <;> cases custody <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.probe = .admitted ∧ c.support = .admitted ∧ c.coordinate = .admitted ∧ c.response = .admitted ∧ c.«structure» = .admitted ∧ c.custody = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier probe support coordinate response «structure» custody extension =>
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

theorem probe_rejected_rejected (c : Candidate) (h : c.probe = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.probe eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem coordinate_rejected_rejected (c : Candidate) (h : c.coordinate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coordinate eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
    rw [h] at field
    cases field

theorem structure_rejected_rejected (c : Candidate) (h : c.«structure» = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.«structure» eq
    rw [h] at field
    cases field

theorem custody_rejected_rejected (c : Candidate) (h : c.custody = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.custody eq
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

end SFT.Chemistry.XrayDiffractionGrammar
