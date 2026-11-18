import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularDipoleMagnitudeGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-dipole-scalar"
  | .admitted => "complete-named-molecular-charge-carrier"

inductive Symmetry where
  | rejected | admitted

def symmetryName : Symmetry → String
  | .rejected => "component-list-selected-after-values"
  | .admitted => "symmetry-forced-component-support"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-direction-as-proof-number"
  | .admitted => "held-orientation-positive-components"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "continuum-vector-premise"
  | .admitted => "finite-distinct-axis-Junction"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "irrational-square-root-or-fitted-norm"
  | .admitted => "exact-squared-magnitude-relation"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "dipole-value-readable-before-seal"
  | .admitted => "value-free-symmetry-and-relation-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favorable-species-or-component-subset"
  | .admitted => "complete-five-species-nine-row-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-coefficient-charge-fit-or-correction"
  | .admitted => "one-structural-law-no-extra-rule"

structure Candidate where
  carrier : Carrier
  symmetry : Symmetry
  orientation : Orientation
  composition : Composition
  magnitude : Magnitude
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, symmetryName c.symmetry, orientationName c.orientation, compositionName c.composition, magnitudeName c.magnitude, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "symmetry=" (symmetryName c.symmetry), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-named-molecular-charge-carrier__symmetry-forced-component-support__held-orientation-positive-components__finite-distinct-axis-Junction__exact-squared-magnitude-relation__value-free-symmetry-and-relation-seal__complete-five-species-nine-row-vector__one-structural-law-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-named-molecular-charge-carrier" &&
  SFT.Host.Text.equal (symmetryName c.symmetry) "symmetry-forced-component-support" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-orientation-positive-components" &&
  SFT.Host.Text.equal (compositionName c.composition) "finite-distinct-axis-Junction" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-squared-magnitude-relation" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-symmetry-and-relation-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-five-species-nine-row-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-structural-law-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-named-molecular-charge-carrier") then "A scalar answer erases species, state, geometry, charge carrier and symmetry." else
  if !(SFT.Host.Text.equal (symmetryName c.symmetry) "symmetry-forced-component-support") then "A value-selected component list cannot establish molecular organization." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-orientation-positive-components") then "A conventional sign imports a negative proof magnitude." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "finite-distinct-axis-Junction") then "A continuum vector space and norm are not generated Fold forms." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-squared-magnitude-relation") then "A square root or fitted norm can leave the exact rational domain." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-symmetry-and-relation-seal") then "A readable component or total could select the relation." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-five-species-nine-row-vector") then "A selected subset can conceal an absent row, extra component or inconsistent total." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-structural-law-no-extra-rule") then "A species coefficient, charge fit or residual correction is a free parameter." else
  "complete-named-molecular-charge-carrier__symmetry-forced-component-support__held-orientation-positive-components__finite-distinct-axis-Junction__exact-squared-magnitude-relation__value-free-symmetry-and-relation-seal__complete-five-species-nine-row-vector__one-structural-law-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, symmetry, orientation, composition, magnitude, prediction, record-completeness and extension forms; decide all 256 forms using only admitted charge, geometry, symmetry, exact arithmetic and measurement-custody laws."
def grammarBoundary : String := "The complete registered H2, D2, H2O, D2O and HDO gas-phase vector: two homonuclear total-absence records and seven water-isotopologue component/total magnitude records, retaining species, molecular state, geometry, charge-distinction carrier, symmetry, axis, magnitude definition, method, condition, source and uncertainty; every numerical inscription is withheld until after relation sealing."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Symmetry.rejected,Symmetry.admitted]).flatMap fun symmetry =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,symmetry,orientation,composition,magnitude,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier symmetry orientation composition magnitude prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsymmetry : symmetry ∈ [Symmetry.rejected,Symmetry.admitted] := by
      cases symmetry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ symmetry _ hsymmetry
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (magnitude : Magnitude) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,magnitude,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,magnitude,prediction,record,extension⟩ := by
 cases magnitude <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier symmetry orientation composition magnitude prediction record extension =>
  cases carrier <;> cases symmetry <;> cases orientation <;> cases composition
  · exact sourceDecisionBlock0000 magnitude prediction record extension
  · exact sourceDecisionBlock0001 magnitude prediction record extension
  · exact sourceDecisionBlock0010 magnitude prediction record extension
  · exact sourceDecisionBlock0011 magnitude prediction record extension
  · exact sourceDecisionBlock0100 magnitude prediction record extension
  · exact sourceDecisionBlock0101 magnitude prediction record extension
  · exact sourceDecisionBlock0110 magnitude prediction record extension
  · exact sourceDecisionBlock0111 magnitude prediction record extension
  · exact sourceDecisionBlock1000 magnitude prediction record extension
  · exact sourceDecisionBlock1001 magnitude prediction record extension
  · exact sourceDecisionBlock1010 magnitude prediction record extension
  · exact sourceDecisionBlock1011 magnitude prediction record extension
  · exact sourceDecisionBlock1100 magnitude prediction record extension
  · exact sourceDecisionBlock1101 magnitude prediction record extension
  · exact sourceDecisionBlock1110 magnitude prediction record extension
  · exact sourceDecisionBlock1111 magnitude prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-named-molecular-charge-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem symmetryCriterion (value : Symmetry) : SFT.Host.Text.equal (symmetryName value) "symmetry-forced-component-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-orientation-positive-components" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "finite-distinct-axis-Junction" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "exact-squared-magnitude-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-symmetry-and-relation-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-five-species-nine-row-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-structural-law-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, symmetryCriterion, orientationCriterion, compositionCriterion, magnitudeCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier symmetry orientation composition magnitude prediction record extension =>
    cases carrier <;> cases symmetry <;> cases orientation <;> cases composition <;> cases magnitude <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.symmetry = .admitted ∧ c.orientation = .admitted ∧ c.composition = .admitted ∧ c.magnitude = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier symmetry orientation composition magnitude prediction record extension =>
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

theorem symmetry_rejected_rejected (c : Candidate) (h : c.symmetry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.symmetry eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

theorem magnitude_rejected_rejected (c : Candidate) (h : c.magnitude = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnitude eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
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

end SFT.Chemistry.MolecularDipoleMagnitudeGrammar
