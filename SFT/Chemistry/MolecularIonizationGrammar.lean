import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularIonizationGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "ionization-answer-with-erased-states"
  | .admitted => "complete-neutral-to-ionic-carrier"

inductive Transformation where
  | rejected | admitted

def transformationName : Transformation → String
  | .rejected => "signed-electron-subtraction"
  | .admitted => "held-removal-and-positive-terminal-separation"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "imported-orbital-energy-equality"
  | .admitted => "ordered-positive-final-from-initial-Take"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "adiabatic-vertical-state-conflation"
  | .admitted => "least-adiabatic-and-held-geometry-vertical-paths"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "unconstrained-vertical-reordering"
  | .admitted => "vertical-not-below-adiabatic"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "ionization-value-readable-before-seal"
  | .admitted => "value-free-carrier-and-operation-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-isotopologue-or-favorable-row"
  | .admitted => "complete-nine-diatomic-NIST-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-fit-or-residual-correction"
  | .admitted => "one-ionization-law-no-extra-rule"

structure Candidate where
  carrier : Carrier
  transformation : Transformation
  magnitude : Magnitude
  path : Path
  order : Order
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, transformationName c.transformation, magnitudeName c.magnitude, pathName c.path, orderName c.order, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "transformation=" (transformationName c.transformation), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-neutral-to-ionic-carrier__held-removal-and-positive-terminal-separation__ordered-positive-final-from-initial-Take__least-adiabatic-and-held-geometry-vertical-paths__vertical-not-below-adiabatic__value-free-carrier-and-operation-seal__complete-nine-diatomic-NIST-vector__one-ionization-law-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-neutral-to-ionic-carrier" &&
  SFT.Host.Text.equal (transformationName c.transformation) "held-removal-and-positive-terminal-separation" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "ordered-positive-final-from-initial-Take" &&
  SFT.Host.Text.equal (pathName c.path) "least-adiabatic-and-held-geometry-vertical-paths" &&
  SFT.Host.Text.equal (orderName c.order) "vertical-not-below-adiabatic" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-carrier-and-operation-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-nine-diatomic-NIST-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-ionization-law-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-neutral-to-ionic-carrier") then "An answer-only energy erases the neutral carrier and resulting ionic state." else
  if !(SFT.Host.Text.equal (transformationName c.transformation) "held-removal-and-positive-terminal-separation") then "A signed electron subtraction imports a negative proof magnitude." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "ordered-positive-final-from-initial-Take") then "An imported orbital theorem does not force the complete many-carrier state difference." else
  if !(SFT.Host.Text.equal (pathName c.path) "least-adiabatic-and-held-geometry-vertical-paths") then "Erasing geometry custody conflates two different terminal-state classes." else
  if !(SFT.Host.Text.equal (orderName c.order) "vertical-not-below-adiabatic") then "A held-geometry member cannot be declared below the least complete-support member." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-carrier-and-operation-seal") then "Readable energy values could select the law or carrier boundary." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-nine-diatomic-NIST-vector") then "A selected subset can conceal isotope, spin or polarity dependence." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-ionization-law-no-extra-rule") then "A species coefficient or residual correction is a fitted parameter." else
  "complete-neutral-to-ionic-carrier__held-removal-and-positive-terminal-separation__ordered-positive-final-from-initial-Take__least-adiabatic-and-held-geometry-vertical-paths__vertical-not-below-adiabatic__value-free-carrier-and-operation-seal__complete-nine-diatomic-NIST-vector__one-ionization-law-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, transformation, magnitude, path, order, prediction, record and extension forms; decide all 256 forms from admitted exact energy, state-transition, order, ion and measurement-custody laws."
def grammarBoundary : String := "The depth-independent ordered positive ionization Take and adiabatic/vertical terminal-state order, tested at the finite complete first-nine-neutral-diatomic boundary inherited value-free from PROP-006: D2, HD, H2, N2, CO, NO, O2, HF and F2, retaining initial state and conformation, resulting ionic state, held removed carrier, path, method, condition, units, uncertainty class and official source identity."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Transformation.rejected,Transformation.admitted]).flatMap fun transformation =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,transformation,magnitude,path,order,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier transformation magnitude path order prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransformation : transformation ∈ [Transformation.rejected,Transformation.admitted] := by
      cases transformation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ transformation _ htransformation
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,order,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,order,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,order,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,order,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,order,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,order,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,order,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,order,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,order,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,order,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,order,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,order,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,order,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,order,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,order,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (order : Order) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,order,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,order,prediction,record,extension⟩ := by
 cases order <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier transformation magnitude path order prediction record extension =>
  cases carrier <;> cases transformation <;> cases magnitude <;> cases path
  · exact sourceDecisionBlock0000 order prediction record extension
  · exact sourceDecisionBlock0001 order prediction record extension
  · exact sourceDecisionBlock0010 order prediction record extension
  · exact sourceDecisionBlock0011 order prediction record extension
  · exact sourceDecisionBlock0100 order prediction record extension
  · exact sourceDecisionBlock0101 order prediction record extension
  · exact sourceDecisionBlock0110 order prediction record extension
  · exact sourceDecisionBlock0111 order prediction record extension
  · exact sourceDecisionBlock1000 order prediction record extension
  · exact sourceDecisionBlock1001 order prediction record extension
  · exact sourceDecisionBlock1010 order prediction record extension
  · exact sourceDecisionBlock1011 order prediction record extension
  · exact sourceDecisionBlock1100 order prediction record extension
  · exact sourceDecisionBlock1101 order prediction record extension
  · exact sourceDecisionBlock1110 order prediction record extension
  · exact sourceDecisionBlock1111 order prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-neutral-to-ionic-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem transformationCriterion (value : Transformation) : SFT.Host.Text.equal (transformationName value) "held-removal-and-positive-terminal-separation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "ordered-positive-final-from-initial-Take" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "least-adiabatic-and-held-geometry-vertical-paths" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orderCriterion (value : Order) : SFT.Host.Text.equal (orderName value) "vertical-not-below-adiabatic" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-carrier-and-operation-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-nine-diatomic-NIST-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-ionization-law-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, transformationCriterion, magnitudeCriterion, pathCriterion, orderCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier transformation magnitude path order prediction record extension =>
    cases carrier <;> cases transformation <;> cases magnitude <;> cases path <;> cases order <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.transformation = .admitted ∧ c.magnitude = .admitted ∧ c.path = .admitted ∧ c.order = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier transformation magnitude path order prediction record extension =>
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

theorem transformation_rejected_rejected (c : Candidate) (h : c.transformation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transformation eq
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

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
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

end SFT.Chemistry.MolecularIonizationGrammar
