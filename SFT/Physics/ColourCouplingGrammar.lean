import SFT.Physics.ColourCouplingDerivation
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ColourCouplingGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "free-colour-count"
  | .admitted => "generator-three-carrier"

inductive Numerator where
  | rejected | admitted

def numeratorName : Numerator → String
  | .rejected => "selected-single-label"
  | .admitted => "both-Fold-labels"

inductive Denominator where
  | rejected | admitted

def denominatorName : Denominator → String
  | .rejected => "external-normalization"
  | .admitted => "complete-generator-support"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "labels-collapsed"
  | .admitted => "labels-held-through-carrier"

inductive Normalization where
  | rejected | admitted

def normalizationName : Normalization → String
  | .rejected => "reciprocal-or-unscaled-count"
  | .admitted => "two-over-three"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "magic-list-visible"
  | .admitted => "closures-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-coupling-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  numerator : Numerator
  denominator : Denominator
  orientation : Orientation
  normalization : Normalization
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, numeratorName c.numerator, denominatorName c.denominator, orientationName c.orientation, normalizationName c.normalization, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "numerator=" (numeratorName c.numerator), SFT.Host.Text.append "denominator=" (denominatorName c.denominator), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "normalization=" (normalizationName c.normalization), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "generator-three-carrier__both-Fold-labels__complete-generator-support__labels-held-through-carrier__two-over-three__closures-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "generator-three-carrier" &&
  SFT.Host.Text.equal (numeratorName c.numerator) "both-Fold-labels" &&
  SFT.Host.Text.equal (denominatorName c.denominator) "complete-generator-support" &&
  SFT.Host.Text.equal (orientationName c.orientation) "labels-held-through-carrier" &&
  SFT.Host.Text.equal (normalizationName c.normalization) "two-over-three" &&
  SFT.Host.Text.equal (targetName c.target) "closures-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "free-colour-count" then "A free carrier count is a parameter." else
  if SFT.Host.Text.equal (numeratorName c.numerator) "selected-single-label" then "One label omits half the Fold distinction." else
  if SFT.Host.Text.equal (denominatorName c.denominator) "external-normalization" then "External normalization is fitted." else
  if SFT.Host.Text.equal (orientationName c.orientation) "labels-collapsed" then "Collapse loses the interaction distinction." else
  if SFT.Host.Text.equal (normalizationName c.normalization) "reciprocal-or-unscaled-count" then "Those forms reverse roles or omit normalization." else
  if SFT.Host.Text.equal (targetName c.target) "magic-list-visible" then "A closure list would fit the coupling." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-coupling-rule" then "An added strength is a free parameter." else
  "The exact generator-three colour-sector Fold coupling is 2/3."

def generationRule : String := "Generate every product of carrier, numerator, denominator, orientation, normalization, target custody and extension forms."
def grammarBoundary : String := "All exact normalized ratios formed by transporting the complete Fold-label support across one generator-three interaction carrier."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Numerator.rejected,Numerator.admitted]).flatMap fun numerator =>
  ([Denominator.rejected,Denominator.admitted]).flatMap fun denominator =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Normalization.rejected,Normalization.admitted]).flatMap fun normalization =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,numerator,denominator,orientation,normalization,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 128 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier numerator denominator orientation normalization target extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnumerator : numerator ∈ [Numerator.rejected,Numerator.admitted] := by
      cases numerator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdenominator : denominator ∈ [Denominator.rejected,Denominator.admitted] := by
      cases denominator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnormalization : normalization ∈ [Normalization.rejected,Normalization.admitted] := by
      cases normalization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ numerator _ hnumerator
    apply CommonRefinement.memFlatMap _ _ denominator _ hdenominator
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ normalization _ hnormalization
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier numerator denominator orientation normalization target extension =>
    cases carrier <;> cases numerator <;> cases denominator <;> cases orientation <;> cases normalization <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier numerator denominator orientation normalization target extension =>
    cases carrier <;> cases numerator <;> cases denominator <;> cases orientation <;> cases normalization <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.numerator = .admitted ∧ c.denominator = .admitted ∧ c.orientation = .admitted ∧ c.normalization = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier numerator denominator orientation normalization target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem numerator_rejected_rejected (c : Candidate) (h : c.numerator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.numerator eq
    rw [h] at field
    cases field

theorem denominator_rejected_rejected (c : Candidate) (h : c.denominator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.denominator eq
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

theorem normalization_rejected_rejected (c : Candidate) (h : c.normalization = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.normalization eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
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

end SFT.Physics.ColourCouplingGrammar
