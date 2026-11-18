import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MassIsotopeFragmentGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "mass-peaks-without-molecule"
  | .admitted => "held-molecular-parent-and-ion-carriers"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "nominal-mass-only"
  | .admitted => "held-isotope-and-charge-composition"

inductive Coordinate where
  | rejected | admitted

def coordinateName : Coordinate → String
  | .rejected => "floating-mass-to-charge"
  | .admitted => "exact-positive-mass-charge-ratio"

inductive Fragmentation where
  | rejected | admitted

def fragmentationName : Fragmentation → String
  | .rejected => "peak-without-fragment-path"
  | .admitted => "held-parent-fragment-transition-path"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "normalized-major-peak-only"
  | .admitted => "exact-event-over-reference-event-ratio"

inductive Condition where
  | rejected | admitted

def conditionName : Condition → String
  | .rejected => "unconditioned-ionization"
  | .admitted => "held-ionization-and-acquisition-condition"

inductive Custody where
  | rejected | admitted

def custodyName : Custody → String
  | .rejected => "selected-diagnostic-peaks"
  | .admitted => "complete-peak-isotope-error-absence-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refitted-added-fragment"
  | .admitted => "successor-retains-and-appends-complete-fragments"

structure Candidate where
  carrier : Carrier
  composition : Composition
  coordinate : Coordinate
  fragmentation : Fragmentation
  response : Response
  condition : Condition
  custody : Custody
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, compositionName c.composition, coordinateName c.coordinate, fragmentationName c.fragmentation, responseName c.response, conditionName c.condition, custodyName c.custody, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "coordinate=" (coordinateName c.coordinate), SFT.Host.Text.append "fragmentation=" (fragmentationName c.fragmentation), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "condition=" (conditionName c.condition), SFT.Host.Text.append "custody=" (custodyName c.custody), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-molecular-parent-and-ion-carriers__held-isotope-and-charge-composition__exact-positive-mass-charge-ratio__held-parent-fragment-transition-path__exact-event-over-reference-event-ratio__held-ionization-and-acquisition-condition__complete-peak-isotope-error-absence-custody__successor-retains-and-appends-complete-fragments"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "held-molecular-parent-and-ion-carriers" &&
  SFT.Host.Text.equal (compositionName c.composition) "held-isotope-and-charge-composition" &&
  SFT.Host.Text.equal (coordinateName c.coordinate) "exact-positive-mass-charge-ratio" &&
  SFT.Host.Text.equal (fragmentationName c.fragmentation) "held-parent-fragment-transition-path" &&
  SFT.Host.Text.equal (responseName c.response) "exact-event-over-reference-event-ratio" &&
  SFT.Host.Text.equal (conditionName c.condition) "held-ionization-and-acquisition-condition" &&
  SFT.Host.Text.equal (custodyName c.custody) "complete-peak-isotope-error-absence-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-appends-complete-fragments"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "held-molecular-parent-and-ion-carriers") then "Peaks alone lose molecular identity." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "held-isotope-and-charge-composition") then "Nominal mass loses isotope composition." else
  if !(SFT.Host.Text.equal (coordinateName c.coordinate) "exact-positive-mass-charge-ratio") then "A float is not native exact support." else
  if !(SFT.Host.Text.equal (fragmentationName c.fragmentation) "held-parent-fragment-transition-path") then "A peak alone loses its parent path." else
  if !(SFT.Host.Text.equal (responseName c.response) "exact-event-over-reference-event-ratio") then "Major-only normalization erases weak events." else
  if !(SFT.Host.Text.equal (conditionName c.condition) "held-ionization-and-acquisition-condition") then "Ionization and instrument boundary affect fragmentation." else
  if !(SFT.Host.Text.equal (custodyName c.custody) "complete-peak-isotope-error-absence-custody") then "Selection erases weak, isotope and unresolved rows." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-appends-complete-fragments") then "Refitting changes prior event ratios." else
  "held-molecular-parent-and-ion-carriers__held-isotope-and-charge-composition__exact-positive-mass-charge-ratio__held-parent-fragment-transition-path__exact-event-over-reference-event-ratio__held-ionization-and-acquisition-condition__complete-peak-isotope-error-absence-custody__successor-retains-and-appends-complete-fragments"

def generationRule : String := "Generate the literal product of the eight frozen ANAL-014 custody decisions."
def grammarBoundary : String := "Eight binary dimensions exhaust the registered ANAL-014 carrier, relation, exact-support, condition, custody and extension forms; 2^8 = 256 generated candidates."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Coordinate.rejected,Coordinate.admitted]).flatMap fun coordinate =>
  ([Fragmentation.rejected,Fragmentation.admitted]).flatMap fun fragmentation =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Condition.rejected,Condition.admitted]).flatMap fun condition =>
  ([Custody.rejected,Custody.admitted]).flatMap fun custody =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,composition,coordinate,fragmentation,response,condition,custody,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier composition coordinate fragmentation response condition custody extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoordinate : coordinate ∈ [Coordinate.rejected,Coordinate.admitted] := by
      cases coordinate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfragmentation : fragmentation ∈ [Fragmentation.rejected,Fragmentation.admitted] := by
      cases fragmentation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcondition : condition ∈ [Condition.rejected,Condition.admitted] := by
      cases condition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcustody : custody ∈ [Custody.rejected,Custody.admitted] := by
      cases custody <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ coordinate _ hcoordinate
    apply CommonRefinement.memFlatMap _ _ fragmentation _ hfragmentation
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ condition _ hcondition
    apply CommonRefinement.memFlatMap _ _ custody _ hcustody
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,response,condition,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,response,condition,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,response,condition,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,response,condition,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,response,condition,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,response,condition,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,response,condition,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,response,condition,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,response,condition,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,response,condition,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,response,condition,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,response,condition,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,response,condition,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,response,condition,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,response,condition,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (response : Response) (condition : Condition) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,response,condition,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,response,condition,custody,extension⟩ := by
 cases response <;> cases condition <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier composition coordinate fragmentation response condition custody extension =>
  cases carrier <;> cases composition <;> cases coordinate <;> cases fragmentation
  · exact sourceDecisionBlock0000 response condition custody extension
  · exact sourceDecisionBlock0001 response condition custody extension
  · exact sourceDecisionBlock0010 response condition custody extension
  · exact sourceDecisionBlock0011 response condition custody extension
  · exact sourceDecisionBlock0100 response condition custody extension
  · exact sourceDecisionBlock0101 response condition custody extension
  · exact sourceDecisionBlock0110 response condition custody extension
  · exact sourceDecisionBlock0111 response condition custody extension
  · exact sourceDecisionBlock1000 response condition custody extension
  · exact sourceDecisionBlock1001 response condition custody extension
  · exact sourceDecisionBlock1010 response condition custody extension
  · exact sourceDecisionBlock1011 response condition custody extension
  · exact sourceDecisionBlock1100 response condition custody extension
  · exact sourceDecisionBlock1101 response condition custody extension
  · exact sourceDecisionBlock1110 response condition custody extension
  · exact sourceDecisionBlock1111 response condition custody extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "held-molecular-parent-and-ion-carriers" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "held-isotope-and-charge-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem coordinateCriterion (value : Coordinate) : SFT.Host.Text.equal (coordinateName value) "exact-positive-mass-charge-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem fragmentationCriterion (value : Fragmentation) : SFT.Host.Text.equal (fragmentationName value) "held-parent-fragment-transition-path" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem responseCriterion (value : Response) : SFT.Host.Text.equal (responseName value) "exact-event-over-reference-event-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem conditionCriterion (value : Condition) : SFT.Host.Text.equal (conditionName value) "held-ionization-and-acquisition-condition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem custodyCriterion (value : Custody) : SFT.Host.Text.equal (custodyName value) "complete-peak-isotope-error-absence-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-and-appends-complete-fragments" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, compositionCriterion, coordinateCriterion, fragmentationCriterion, responseCriterion, conditionCriterion, custodyCriterion, extensionCriterion]
  cases c with
  | mk carrier composition coordinate fragmentation response condition custody extension =>
    cases carrier <;> cases composition <;> cases coordinate <;> cases fragmentation <;> cases response <;> cases condition <;> cases custody <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.composition = .admitted ∧ c.coordinate = .admitted ∧ c.fragmentation = .admitted ∧ c.response = .admitted ∧ c.condition = .admitted ∧ c.custody = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier composition coordinate fragmentation response condition custody extension =>
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

theorem fragmentation_rejected_rejected (c : Candidate) (h : c.fragmentation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fragmentation eq
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

theorem condition_rejected_rejected (c : Candidate) (h : c.condition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.condition eq
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

end SFT.Chemistry.MassIsotopeFragmentGrammar
