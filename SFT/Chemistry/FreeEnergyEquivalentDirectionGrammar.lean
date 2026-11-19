import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.FreeEnergyEquivalentDirectionGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Paths where
  | rejected | admitted

def pathsName : Paths → String
  | .rejected => "single-path-or-answer-only-direction"
  | .admitted => "complete-forward-and-reverse-path-accounts"

inductive Energy where
  | rejected | admitted

def energyName : Energy → String
  | .rejected => "signed-or-fitted-free-energy-scalar"
  | .admitted => "exact-positive-retained-energy-requirements"

inductive Distinctions where
  | rejected | admitted

def distinctionsName : Distinctions → String
  | .rejected => "entropy-logarithm-or-omitted-distinction-cost"
  | .admitted => "exact-positive-closed-distinction-counts"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "weighted-sum-or-target-selected-comparison"
  | .admitted => "strict-exact-product-support-order"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-direction-value-or-forced-tie-break"
  | .admitted => "held-forward-reverse-or-EmptyOne-equilibrium"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "Gibbs-logK-or-direction-target-readable-before-seal"
  | .admitted => "complete-value-free-reaction-state-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-temperature-or-single-direction-showcase"
  | .admitted => "complete-64-row-two-direction-crossing-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-order-after-shared-successor"
  | .admitted => "depth-independent-common-account-successor"

structure Candidate where
  paths : Paths
  energy : Energy
  distinctions : Distinctions
  order : Order
  orientation : Orientation
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [pathsName c.paths, energyName c.energy, distinctionsName c.distinctions, orderName c.order, orientationName c.orientation, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "paths=" (pathsName c.paths), SFT.Host.Text.append "energy=" (energyName c.energy), SFT.Host.Text.append "distinctions=" (distinctionsName c.distinctions), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-forward-and-reverse-path-accounts__exact-positive-retained-energy-requirements__exact-positive-closed-distinction-counts__strict-exact-product-support-order__held-forward-reverse-or-EmptyOne-equilibrium__complete-value-free-reaction-state-identity-seal__complete-64-row-two-direction-crossing-vector__depth-independent-common-account-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (pathsName c.paths) "complete-forward-and-reverse-path-accounts" &&
  SFT.Host.Text.equal (energyName c.energy) "exact-positive-retained-energy-requirements" &&
  SFT.Host.Text.equal (distinctionsName c.distinctions) "exact-positive-closed-distinction-counts" &&
  SFT.Host.Text.equal (orderName c.order) "strict-exact-product-support-order" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-forward-reverse-or-EmptyOne-equilibrium" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-reaction-state-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-64-row-two-direction-crossing-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-account-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (pathsName c.paths) "complete-forward-and-reverse-path-accounts") then "One path or an answer label cannot establish comparative direction." else
  if !(SFT.Host.Text.equal (energyName c.energy) "exact-positive-retained-energy-requirements") then "A signed or fitted scalar imports an equation and erases energy provenance." else
  if !(SFT.Host.Text.equal (distinctionsName c.distinctions) "exact-positive-closed-distinction-counts") then "A logarithm or omitted cost imports a convention and loses closed distinctions." else
  if !(SFT.Host.Text.equal (orderName c.order) "strict-exact-product-support-order") then "A weighted scalar requires a free trade-off and may select the target." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-forward-reverse-or-EmptyOne-equilibrium") then "A sign or tie-break invents content not present in the accounts." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-reaction-state-identity-seal") then "Target values could select the ordering rule." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-64-row-two-direction-crossing-vector") then "A selected row can hide a direction reversal or adverse record." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-account-successor") then "Refitting destroys invariance under a common retained addition." else
  "complete-forward-and-reverse-path-accounts__exact-positive-retained-energy-requirements__exact-positive-closed-distinction-counts__strict-exact-product-support-order__held-forward-reverse-or-EmptyOne-equilibrium__complete-value-free-reaction-state-identity-seal__complete-64-row-two-direction-crossing-vector__depth-independent-common-account-successor"

def generationRule : String := "Generate the literal product of paths, energy, distinctions, order, orientation, prediction, record and extension forms; decide all 256 candidates only from admitted exact energy, entropy, observation, reaction-direction and equilibrium laws."
def grammarBoundary : String := "Every finite pair of forward/reverse reaction path accounts on one held boundary and condition, ordered only by exact positive retained-energy and closed-distinction support, with common-successor closure. External testing retains every finite common NIST-JANAF NO2/N2O4 gas row and every direction."

def candidates : List Candidate :=
  ([Paths.rejected,Paths.admitted]).flatMap fun paths =>
  ([Energy.rejected,Energy.admitted]).flatMap fun energy =>
  ([Distinctions.rejected,Distinctions.admitted]).flatMap fun distinctions =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨paths,energy,distinctions,order,orientation,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk paths energy distinctions order orientation prediction record extension =>
    have hpaths : paths ∈ [Paths.rejected,Paths.admitted] := by
      cases paths <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henergy : energy ∈ [Energy.rejected,Energy.admitted] := by
      cases energy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistinctions : distinctions ∈ [Distinctions.rejected,Distinctions.admitted] := by
      cases distinctions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ paths _ hpaths
    apply CommonRefinement.memFlatMap _ _ energy _ henergy
    apply CommonRefinement.memFlatMap _ _ distinctions _ hdistinctions
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk paths energy distinctions order orientation prediction record extension =>
  cases paths <;> cases energy <;> cases distinctions <;> cases order
  · exact sourceDecisionBlock0000 orientation prediction record extension
  · exact sourceDecisionBlock0001 orientation prediction record extension
  · exact sourceDecisionBlock0010 orientation prediction record extension
  · exact sourceDecisionBlock0011 orientation prediction record extension
  · exact sourceDecisionBlock0100 orientation prediction record extension
  · exact sourceDecisionBlock0101 orientation prediction record extension
  · exact sourceDecisionBlock0110 orientation prediction record extension
  · exact sourceDecisionBlock0111 orientation prediction record extension
  · exact sourceDecisionBlock1000 orientation prediction record extension
  · exact sourceDecisionBlock1001 orientation prediction record extension
  · exact sourceDecisionBlock1010 orientation prediction record extension
  · exact sourceDecisionBlock1011 orientation prediction record extension
  · exact sourceDecisionBlock1100 orientation prediction record extension
  · exact sourceDecisionBlock1101 orientation prediction record extension
  · exact sourceDecisionBlock1110 orientation prediction record extension
  · exact sourceDecisionBlock1111 orientation prediction record extension

theorem pathsCriterion (value : Paths) : SFT.Host.Text.equal (pathsName value) "complete-forward-and-reverse-path-accounts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem energyCriterion (value : Energy) : SFT.Host.Text.equal (energyName value) "exact-positive-retained-energy-requirements" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem distinctionsCriterion (value : Distinctions) : SFT.Host.Text.equal (distinctionsName value) "exact-positive-closed-distinction-counts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orderCriterion (value : Order) : SFT.Host.Text.equal (orderName value) "strict-exact-product-support-order" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-forward-reverse-or-EmptyOne-equilibrium" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-reaction-state-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-64-row-two-direction-crossing-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-common-account-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [pathsCriterion, energyCriterion, distinctionsCriterion, orderCriterion, orientationCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk paths energy distinctions order orientation prediction record extension =>
    cases paths <;> cases energy <;> cases distinctions <;> cases order <;> cases orientation <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.paths = .admitted ∧ c.energy = .admitted ∧ c.distinctions = .admitted ∧ c.order = .admitted ∧ c.orientation = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk paths energy distinctions order orientation prediction record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem paths_rejected_rejected (c : Candidate) (h : c.paths = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.paths eq
    rw [h] at field
    cases field

theorem energy_rejected_rejected (c : Candidate) (h : c.energy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.energy eq
    rw [h] at field
    cases field

theorem distinctions_rejected_rejected (c : Candidate) (h : c.distinctions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distinctions eq
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

end SFT.Chemistry.FreeEnergyEquivalentDirectionGrammar
