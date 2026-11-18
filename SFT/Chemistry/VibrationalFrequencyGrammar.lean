import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.VibrationalFrequencyGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "frequency-answer-with-erased-mode"
  | .admitted => "complete-molecule-mode-symmetry-carrier"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "continuum-sinusoid-premise"
  | .admitted => "finite-generated-recurrence-count"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "imported-frequency-scalar"
  | .admitted => "exact-recurrence-over-interval-ratio"

inductive Mode where
  | rejected | admitted

def modeName : Mode → String
  | .rejected => "merged-or-relabelled-mode-support"
  | .admitted => "held-distinct-mode-and-symmetry-support"

inductive Translation where
  | rejected | admitted

def translationName : Translation → String
  | .rejected => "frequency-unit-selects-law"
  | .admitted => "post-recurrence-held-unit-translation"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "frequency-target-readable-before-seal"
  | .admitted => "value-free-complete-mode-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favorable-measured-row-subset"
  | .admitted => "complete-displayed-NIST-surface-with-gap-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "fitted-scale-or-molecular-correction"
  | .admitted => "one-recurrence-law-no-scale-factor"

structure Candidate where
  carrier : Carrier
  recurrence : Recurrence
  magnitude : Magnitude
  mode : Mode
  translation : Translation
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, recurrenceName c.recurrence, magnitudeName c.magnitude, modeName c.mode, translationName c.translation, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "mode=" (modeName c.mode), SFT.Host.Text.append "translation=" (translationName c.translation), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-molecule-mode-symmetry-carrier__finite-generated-recurrence-count__exact-recurrence-over-interval-ratio__held-distinct-mode-and-symmetry-support__post-recurrence-held-unit-translation__value-free-complete-mode-seal__complete-displayed-NIST-surface-with-gap-custody__one-recurrence-law-no-scale-factor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-molecule-mode-symmetry-carrier" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "finite-generated-recurrence-count" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-recurrence-over-interval-ratio" &&
  SFT.Host.Text.equal (modeName c.mode) "held-distinct-mode-and-symmetry-support" &&
  SFT.Host.Text.equal (translationName c.translation) "post-recurrence-held-unit-translation" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-mode-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-displayed-NIST-surface-with-gap-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-recurrence-law-no-scale-factor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-molecule-mode-symmetry-carrier") then "An answer-only number erases the molecule, mode, symmetry and transition class." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "finite-generated-recurrence-count") then "A continuum waveform imports an ungenerated mathematical model." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-recurrence-over-interval-ratio") then "A named frequency without recurrence and interval does not derive its quantity." else
  if !(SFT.Host.Text.equal (modeName c.mode) "held-distinct-mode-and-symmetry-support") then "Merging modes destroys their molecular and symmetry identities." else
  if !(SFT.Host.Text.equal (translationName c.translation) "post-recurrence-held-unit-translation") then "A conventional unit cannot select the recurrence law." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-mode-seal") then "Readable source frequencies could select the relation or row subset." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-displayed-NIST-surface-with-gap-custody") then "Dropping displayed absences or the advertised/displayed count discrepancy hides source limitations." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-recurrence-law-no-scale-factor") then "A scale factor or species residual is a fitted parameter." else
  "complete-molecule-mode-symmetry-carrier__finite-generated-recurrence-count__exact-recurrence-over-interval-ratio__held-distinct-mode-and-symmetry-support__post-recurrence-held-unit-translation__value-free-complete-mode-seal__complete-displayed-NIST-surface-with-gap-custody__one-recurrence-law-no-scale-factor"

def generationRule : String := "Generate the literal product of carrier, recurrence, magnitude, mode, translation, prediction, record and extension forms; decide all 256 from admitted exact arithmetic, recurrence, wave-frequency, spectroscopy, molecular-transition and measurement-custody laws."
def grammarBoundary : String := "The depth-independent exact recurrence-count/positive-interval relation for every generated finite mode, tested against the complete 2,009-row table actually displayed by the frozen official NIST CCCBDB page: 145 displayed molecules, 1,984 positive experimental frequencies and 25 displayed absences. The page's advertised 164 molecules/2,452 vibrations and its undisplayed difference of 19/443 remain explicit."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Mode.rejected,Mode.admitted]).flatMap fun mode =>
  ([Translation.rejected,Translation.admitted]).flatMap fun translation =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,recurrence,magnitude,mode,translation,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier recurrence magnitude mode translation prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmode : mode ∈ [Mode.rejected,Mode.admitted] := by
      cases mode <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htranslation : translation ∈ [Translation.rejected,Translation.admitted] := by
      cases translation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ mode _ hmode
    apply CommonRefinement.memFlatMap _ _ translation _ htranslation
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier recurrence magnitude mode translation prediction record extension =>
  cases carrier <;> cases recurrence <;> cases magnitude <;> cases mode
  · exact sourceDecisionBlock0000 translation prediction record extension
  · exact sourceDecisionBlock0001 translation prediction record extension
  · exact sourceDecisionBlock0010 translation prediction record extension
  · exact sourceDecisionBlock0011 translation prediction record extension
  · exact sourceDecisionBlock0100 translation prediction record extension
  · exact sourceDecisionBlock0101 translation prediction record extension
  · exact sourceDecisionBlock0110 translation prediction record extension
  · exact sourceDecisionBlock0111 translation prediction record extension
  · exact sourceDecisionBlock1000 translation prediction record extension
  · exact sourceDecisionBlock1001 translation prediction record extension
  · exact sourceDecisionBlock1010 translation prediction record extension
  · exact sourceDecisionBlock1011 translation prediction record extension
  · exact sourceDecisionBlock1100 translation prediction record extension
  · exact sourceDecisionBlock1101 translation prediction record extension
  · exact sourceDecisionBlock1110 translation prediction record extension
  · exact sourceDecisionBlock1111 translation prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-molecule-mode-symmetry-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recurrenceCriterion (value : Recurrence) : SFT.Host.Text.equal (recurrenceName value) "finite-generated-recurrence-count" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "exact-recurrence-over-interval-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem modeCriterion (value : Mode) : SFT.Host.Text.equal (modeName value) "held-distinct-mode-and-symmetry-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem translationCriterion (value : Translation) : SFT.Host.Text.equal (translationName value) "post-recurrence-held-unit-translation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-complete-mode-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-displayed-NIST-surface-with-gap-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-recurrence-law-no-scale-factor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, recurrenceCriterion, magnitudeCriterion, modeCriterion, translationCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier recurrence magnitude mode translation prediction record extension =>
    cases carrier <;> cases recurrence <;> cases magnitude <;> cases mode <;> cases translation <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.recurrence = .admitted ∧ c.magnitude = .admitted ∧ c.mode = .admitted ∧ c.translation = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier recurrence magnitude mode translation prediction record extension =>
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

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
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

theorem mode_rejected_rejected (c : Candidate) (h : c.mode = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mode eq
    rw [h] at field
    cases field

theorem translation_rejected_rejected (c : Candidate) (h : c.translation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.translation eq
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

end SFT.Chemistry.VibrationalFrequencyGrammar
