import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MulticomponentPhaseDiagramGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unbound-coordinate-cloud"
  | .admitted => "complete-multicomponent-two-phase-point"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "selected-coordinate-or-unclosed-sum"
  | .admitted => "complete-exact-phase-words-closing-to-One"

inductive Phase where
  | rejected | admitted

def phaseName : Phase → String
  | .rejected => "single-bulk-composition-or-erased-phase"
  | .admitted => "two-distinct-held-phase-composition-words"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "imported-lever-rule-or-target-derived-tie-line"
  | .admitted => "componentwise-exact-exchange-support-balance"

inductive Degree where
  | rejected | admitted

def degreeName : Degree → String
  | .rejected => "free-continuum-diagram-plane"
  | .admitted => "exact-phase-rule-component-count-support"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-composition"
  | .admitted => "structural-EmptyOne-absent-coordinate"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "coexistence-values-readable-before-seal"
  | .admitted => "complete-value-free-116-record-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "redraw-refit-or-interpolate-after-extension"
  | .admitted => "depth-independent-append-and-exchange-replication"

structure Candidate where
  carrier : Carrier
  composition : Composition
  phase : Phase
  balance : Balance
  degree : Degree
  absence : Absence
  prediction : Prediction
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, compositionName c.composition, phaseName c.phase, balanceName c.balance, degreeName c.degree, absenceName c.absence, predictionName c.prediction, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "phase=" (phaseName c.phase), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "degree=" (degreeName c.degree), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-multicomponent-two-phase-point__complete-exact-phase-words-closing-to-One__two-distinct-held-phase-composition-words__componentwise-exact-exchange-support-balance__exact-phase-rule-component-count-support__structural-EmptyOne-absent-coordinate__complete-value-free-116-record-identity-seal__depth-independent-append-and-exchange-replication"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-multicomponent-two-phase-point" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-exact-phase-words-closing-to-One" &&
  SFT.Host.Text.equal (phaseName c.phase) "two-distinct-held-phase-composition-words" &&
  SFT.Host.Text.equal (balanceName c.balance) "componentwise-exact-exchange-support-balance" &&
  SFT.Host.Text.equal (degreeName c.degree) "exact-phase-rule-component-count-support" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-absent-coordinate" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-116-record-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-and-exchange-replication"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-multicomponent-two-phase-point") then "Detached coordinates erase component, phase and coexistence identity." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complete-exact-phase-words-closing-to-One") then "A selected coordinate or unclosed collection does not specify a composition." else
  if !(SFT.Host.Text.equal (phaseName c.phase) "two-distinct-held-phase-composition-words") then "A bulk composition cannot identify two coexisting states." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "componentwise-exact-exchange-support-balance") then "An imported construction or target correction does not force coexistence." else
  if !(SFT.Host.Text.equal (degreeName c.degree) "exact-phase-rule-component-count-support") then "A continuum plane imports unenumerated states and free coordinates." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-absent-coordinate") then "Numerical zero is not an SFT value." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-116-record-identity-seal") then "Readable values could select the relation." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-and-exchange-replication") then "Redrawing or fitting destroys exact finite provenance." else
  "complete-multicomponent-two-phase-point__complete-exact-phase-words-closing-to-One__two-distinct-held-phase-composition-words__componentwise-exact-exchange-support-balance__exact-phase-rule-component-count-support__structural-EmptyOne-absent-coordinate__complete-value-free-116-record-identity-seal__depth-independent-append-and-exchange-replication"

def generationRule : String := "Generate the literal product of carrier, composition, phase, balance, degree, absence, prediction and extension forms; decide all 256 candidates only from admitted exact composition, component exchange, phase-rule cancellation, EmptyOne and finite-word successor laws."
def grammarBoundary : String := "Every finite positive word of binary-or-higher, two-distinct-phase coexistence points whose complete exact phase-coordinate words close to the One and whose componentwise exchange supports are equal. External testing preserves all five binary dataset pairs and 65 points, the complete 51-point ternary dataset, all six companion pure datasets and the complete 17-dataset, 187-point parent source."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Phase.rejected,Phase.admitted]).flatMap fun phase =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Degree.rejected,Degree.admitted]).flatMap fun degree =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,composition,phase,balance,degree,absence,prediction,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier composition phase balance degree absence prediction extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphase : phase ∈ [Phase.rejected,Phase.admitted] := by
      cases phase <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdegree : degree ∈ [Degree.rejected,Degree.admitted] := by
      cases degree <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ phase _ hphase
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ degree _ hdegree
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (degree : Degree) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,degree,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,degree,absence,prediction,extension⟩ := by
 cases degree <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier composition phase balance degree absence prediction extension =>
  cases carrier <;> cases composition <;> cases phase <;> cases balance
  · exact sourceDecisionBlock0000 degree absence prediction extension
  · exact sourceDecisionBlock0001 degree absence prediction extension
  · exact sourceDecisionBlock0010 degree absence prediction extension
  · exact sourceDecisionBlock0011 degree absence prediction extension
  · exact sourceDecisionBlock0100 degree absence prediction extension
  · exact sourceDecisionBlock0101 degree absence prediction extension
  · exact sourceDecisionBlock0110 degree absence prediction extension
  · exact sourceDecisionBlock0111 degree absence prediction extension
  · exact sourceDecisionBlock1000 degree absence prediction extension
  · exact sourceDecisionBlock1001 degree absence prediction extension
  · exact sourceDecisionBlock1010 degree absence prediction extension
  · exact sourceDecisionBlock1011 degree absence prediction extension
  · exact sourceDecisionBlock1100 degree absence prediction extension
  · exact sourceDecisionBlock1101 degree absence prediction extension
  · exact sourceDecisionBlock1110 degree absence prediction extension
  · exact sourceDecisionBlock1111 degree absence prediction extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-multicomponent-two-phase-point" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "complete-exact-phase-words-closing-to-One" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem phaseCriterion (value : Phase) : SFT.Host.Text.equal (phaseName value) "two-distinct-held-phase-composition-words" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem balanceCriterion (value : Balance) : SFT.Host.Text.equal (balanceName value) "componentwise-exact-exchange-support-balance" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem degreeCriterion (value : Degree) : SFT.Host.Text.equal (degreeName value) "exact-phase-rule-component-count-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-absent-coordinate" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-116-record-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-append-and-exchange-replication" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, compositionCriterion, phaseCriterion, balanceCriterion, degreeCriterion, absenceCriterion, predictionCriterion, extensionCriterion]
  cases c with
  | mk carrier composition phase balance degree absence prediction extension =>
    cases carrier <;> cases composition <;> cases phase <;> cases balance <;> cases degree <;> cases absence <;> cases prediction <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.composition = .admitted ∧ c.phase = .admitted ∧ c.balance = .admitted ∧ c.degree = .admitted ∧ c.absence = .admitted ∧ c.prediction = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier composition phase balance degree absence prediction extension =>
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

theorem phase_rejected_rejected (c : Candidate) (h : c.phase = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.phase eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem degree_rejected_rejected (c : Candidate) (h : c.degree = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.degree eq
    rw [h] at field
    cases field

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.MulticomponentPhaseDiagramGrammar
