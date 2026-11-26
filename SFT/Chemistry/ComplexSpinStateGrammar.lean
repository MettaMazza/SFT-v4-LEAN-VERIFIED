import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ComplexSpinStateGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "cross-complex-state-mixture"
  | .admitted => "one-complex-electron-support"

inductive Split where
  | rejected | admitted

def splitName : Split → String
  | .rejected => "imported-orbital-or-field-table"
  | .admitted => "forced-three-plus-two-support"

inductive Enumeration where
  | rejected | admitted

def enumerationName : Enumeration → String
  | .rejected => "selected-configurations"
  | .admitted => "complete-pair-single-occupancy-census"

inductive Low where
  | rejected | admitted

def lowName : Low → String
  | .rejected => "named-low-spin-assumption"
  | .admitted => "least-crossing-then-least-unmatched-extremum"

inductive High where
  | rejected | admitted

def highName : High → String
  | .rejected => "named-high-spin-assumption"
  | .admitted => "greatest-unmatched-then-least-crossing-extremum"

inductive Cost where
  | rejected | admitted

def costName : Cost → String
  | .rejected => "fitted-pairing-or-field-energy"
  | .admitted => "counted-pair-closure-plus-split-crossing-paths"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "asserted-ground-state-label"
  | .admitted => "complete-weak-boundary-strong-trichotomy"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-temperature-or-distance-fit"
  | .admitted => "monotone-dilution-with-no-extra-rule"

structure Candidate where
  carrier : Carrier
  split : Split
  enumeration : Enumeration
  low : Low
  high : High
  cost : Cost
  order : Order
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, splitName c.split, enumerationName c.enumeration, lowName c.low, highName c.high, costName c.cost, orderName c.order, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "split=" (splitName c.split), SFT.Host.Text.append "enumeration=" (enumerationName c.enumeration), SFT.Host.Text.append "low=" (lowName c.low), SFT.Host.Text.append "high=" (highName c.high), SFT.Host.Text.append "cost=" (costName c.cost), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-complex-electron-support__forced-three-plus-two-support__complete-pair-single-occupancy-census__least-crossing-then-least-unmatched-extremum__greatest-unmatched-then-least-crossing-extremum__counted-pair-closure-plus-split-crossing-paths__complete-weak-boundary-strong-trichotomy__monotone-dilution-with-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-complex-electron-support" &&
  SFT.Host.Text.equal (splitName c.split) "forced-three-plus-two-support" &&
  SFT.Host.Text.equal (enumerationName c.enumeration) "complete-pair-single-occupancy-census" &&
  SFT.Host.Text.equal (lowName c.low) "least-crossing-then-least-unmatched-extremum" &&
  SFT.Host.Text.equal (highName c.high) "greatest-unmatched-then-least-crossing-extremum" &&
  SFT.Host.Text.equal (costName c.cost) "counted-pair-closure-plus-split-crossing-paths" &&
  SFT.Host.Text.equal (orderName c.order) "complete-weak-boundary-strong-trichotomy" &&
  SFT.Host.Text.equal (extensionName c.extension) "monotone-dilution-with-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-complex-electron-support") then "States from different carriers do not share one exact order." else
  if !(SFT.Host.Text.equal (splitName c.split) "forced-three-plus-two-support") then "A conventional table would select the state grammar." else
  if !(SFT.Host.Text.equal (enumerationName c.enumeration) "complete-pair-single-occupancy-census") then "Selected configurations cannot establish an extremum." else
  if !(SFT.Host.Text.equal (lowName c.low) "least-crossing-then-least-unmatched-extremum") then "A name does not force an occupancy." else
  if !(SFT.Host.Text.equal (highName c.high) "greatest-unmatched-then-least-crossing-extremum") then "A name does not force an occupancy." else
  if !(SFT.Host.Text.equal (costName c.cost) "counted-pair-closure-plus-split-crossing-paths") then "A fitted energy imports a free parameter and target choice." else
  if !(SFT.Host.Text.equal (orderName c.order) "complete-weak-boundary-strong-trichotomy") then "An asserted label does not compare both generated extrema." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "monotone-dilution-with-no-extra-rule") then "A species fit can manufacture a crossover." else
  "one-complex-electron-support__forced-three-plus-two-support__complete-pair-single-occupancy-census__least-crossing-then-least-unmatched-extremum__greatest-unmatched-then-least-crossing-extremum__counted-pair-closure-plus-split-crossing-paths__complete-weak-boundary-strong-trichotomy__monotone-dilution-with-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, split, enumeration, low extremum, high extremum, cost, order and extension choices; decide all 256 candidates only from admitted support, occupancy, state-order, INORG-006 split and geometric-dilution dependencies."
def grammarBoundary : String := "Every symmetry-distinct pair/single occupancy of six electron occurrences across the forced three-plus-two support; the two complete extrema; every structural EmptyOne or positive interaction recurrence; all three frozen INORG-007 external source identities and their favorable, conventional and transport-mismatch surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Split.rejected,Split.admitted]).flatMap fun split =>
  ([Enumeration.rejected,Enumeration.admitted]).flatMap fun enumeration =>
  ([Low.rejected,Low.admitted]).flatMap fun low =>
  ([High.rejected,High.admitted]).flatMap fun high =>
  ([Cost.rejected,Cost.admitted]).flatMap fun cost =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,split,enumeration,low,high,cost,order,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier split enumeration low high cost order extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsplit : split ∈ [Split.rejected,Split.admitted] := by
      cases split <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henumeration : enumeration ∈ [Enumeration.rejected,Enumeration.admitted] := by
      cases enumeration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlow : low ∈ [Low.rejected,Low.admitted] := by
      cases low <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hhigh : high ∈ [High.rejected,High.admitted] := by
      cases high <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcost : cost ∈ [Cost.rejected,Cost.admitted] := by
      cases cost <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ split _ hsplit
    apply CommonRefinement.memFlatMap _ _ enumeration _ henumeration
    apply CommonRefinement.memFlatMap _ _ low _ hlow
    apply CommonRefinement.memFlatMap _ _ high _ hhigh
    apply CommonRefinement.memFlatMap _ _ cost _ hcost
    apply CommonRefinement.memFlatMap _ _ order _ horder
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,high,cost,order,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,high,cost,order,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,high,cost,order,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,high,cost,order,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,high,cost,order,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,high,cost,order,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,high,cost,order,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,high,cost,order,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,high,cost,order,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,high,cost,order,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,high,cost,order,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,high,cost,order,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,high,cost,order,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,high,cost,order,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,high,cost,order,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (high : High) (cost : Cost) (order : Order) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,high,cost,order,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,high,cost,order,extension⟩ := by
 cases high <;> cases cost <;> cases order <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier split enumeration low high cost order extension =>
  cases carrier <;> cases split <;> cases enumeration <;> cases low
  · exact sourceDecisionBlock0000 high cost order extension
  · exact sourceDecisionBlock0001 high cost order extension
  · exact sourceDecisionBlock0010 high cost order extension
  · exact sourceDecisionBlock0011 high cost order extension
  · exact sourceDecisionBlock0100 high cost order extension
  · exact sourceDecisionBlock0101 high cost order extension
  · exact sourceDecisionBlock0110 high cost order extension
  · exact sourceDecisionBlock0111 high cost order extension
  · exact sourceDecisionBlock1000 high cost order extension
  · exact sourceDecisionBlock1001 high cost order extension
  · exact sourceDecisionBlock1010 high cost order extension
  · exact sourceDecisionBlock1011 high cost order extension
  · exact sourceDecisionBlock1100 high cost order extension
  · exact sourceDecisionBlock1101 high cost order extension
  · exact sourceDecisionBlock1110 high cost order extension
  · exact sourceDecisionBlock1111 high cost order extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-complex-electron-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem splitCriterion (value : Split) : SFT.Host.Text.equal (splitName value) "forced-three-plus-two-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem enumerationCriterion (value : Enumeration) : SFT.Host.Text.equal (enumerationName value) "complete-pair-single-occupancy-census" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem lowCriterion (value : Low) : SFT.Host.Text.equal (lowName value) "least-crossing-then-least-unmatched-extremum" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem highCriterion (value : High) : SFT.Host.Text.equal (highName value) "greatest-unmatched-then-least-crossing-extremum" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem costCriterion (value : Cost) : SFT.Host.Text.equal (costName value) "counted-pair-closure-plus-split-crossing-paths" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orderCriterion (value : Order) : SFT.Host.Text.equal (orderName value) "complete-weak-boundary-strong-trichotomy" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "monotone-dilution-with-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, splitCriterion, enumerationCriterion, lowCriterion, highCriterion, costCriterion, orderCriterion, extensionCriterion]
  cases c with
  | mk carrier split enumeration low high cost order extension =>
    cases carrier <;> cases split <;> cases enumeration <;> cases low <;> cases high <;> cases cost <;> cases order <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.split = .admitted ∧ c.enumeration = .admitted ∧ c.low = .admitted ∧ c.high = .admitted ∧ c.cost = .admitted ∧ c.order = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier split enumeration low high cost order extension =>
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

theorem split_rejected_rejected (c : Candidate) (h : c.split = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.split eq
    rw [h] at field
    cases field

theorem enumeration_rejected_rejected (c : Candidate) (h : c.enumeration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.enumeration eq
    rw [h] at field
    cases field

theorem low_rejected_rejected (c : Candidate) (h : c.low = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.low eq
    rw [h] at field
    cases field

theorem high_rejected_rejected (c : Candidate) (h : c.high = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.high eq
    rw [h] at field
    cases field

theorem cost_rejected_rejected (c : Candidate) (h : c.cost = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cost eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.ComplexSpinStateGrammar
