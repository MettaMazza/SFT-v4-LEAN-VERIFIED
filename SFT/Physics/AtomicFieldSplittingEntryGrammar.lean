import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AtomicFieldSplittingEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "replace-field-predecessors"
  | .admitted => "compose-immutable-field-predecessors"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "selected-line-count"
  | .admitted => "complete-held-orientation-successor"

inductive Direction where
  | rejected | admitted

def directionName : Direction → String
  | .rejected => "signed-energy-scalar"
  | .admitted => "held-side-label-and-positive-distance"

inductive Magnetic where
  | rejected | admitted

def magneticName : Magnetic → String
  | .rejected => "chosen-field-polynomial"
  | .admitted => "one-field-act-per-held-orientation"

inductive Spacing where
  | rejected | admitted

def spacingName : Spacing → String
  | .rejected => "unequal-free-spacing"
  | .admitted => "one-common-positive-field-step"

inductive ElectricDegenerate where
  | rejected | admitted

def electricDegenerateName : ElectricDegenerate → String
  | .rejected => "erase-first-displacement"
  | .admitted => "held-first-order-dipole-channel"

inductive ElectricNondegenerate where
  | rejected | admitted

def electricNondegenerateName : ElectricNondegenerate → String
  | .rejected => "free-first-order-shift"
  | .admitted => "paired-first-act-closes-then-square"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "universal-single-order"
  | .admitted => "degeneracy-typed-response-order"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "external-target-readable"
  | .admitted => "target-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-coefficient-or-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  multiplicity : Multiplicity
  direction : Direction
  magnetic : Magnetic
  spacing : Spacing
  electricDegenerate : ElectricDegenerate
  electricNondegenerate : ElectricNondegenerate
  order : Order
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, multiplicityName c.multiplicity, directionName c.direction, magneticName c.magnetic, spacingName c.spacing, electricDegenerateName c.electricDegenerate, electricNondegenerateName c.electricNondegenerate, orderName c.order, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "direction=" (directionName c.direction), SFT.Host.Text.append "magnetic=" (magneticName c.magnetic), SFT.Host.Text.append "spacing=" (spacingName c.spacing), SFT.Host.Text.append "electric-degenerate=" (electricDegenerateName c.electricDegenerate), SFT.Host.Text.append "electric-nondegenerate=" (electricNondegenerateName c.electricNondegenerate), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "compose-immutable-field-predecessors__complete-held-orientation-successor__held-side-label-and-positive-distance__one-field-act-per-held-orientation__one-common-positive-field-step__held-first-order-dipole-channel__paired-first-act-closes-then-square__degeneracy-typed-response-order__target-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-field-predecessors" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "complete-held-orientation-successor" &&
  SFT.Host.Text.equal (directionName c.direction) "held-side-label-and-positive-distance" &&
  SFT.Host.Text.equal (magneticName c.magnetic) "one-field-act-per-held-orientation" &&
  SFT.Host.Text.equal (spacingName c.spacing) "one-common-positive-field-step" &&
  SFT.Host.Text.equal (electricDegenerateName c.electricDegenerate) "held-first-order-dipole-channel" &&
  SFT.Host.Text.equal (electricNondegenerateName c.electricNondegenerate) "paired-first-act-closes-then-square" &&
  SFT.Host.Text.equal (orderName c.order) "degeneracy-typed-response-order" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "replace-field-predecessors" then "A successor cannot rewrite admitted receipts." else
  if SFT.Host.Text.equal (multiplicityName c.multiplicity) "selected-line-count" then "A chosen multiplet width imports the answer." else
  if SFT.Host.Text.equal (directionName c.direction) "signed-energy-scalar" then "Negative proof scalars violate the domain." else
  if SFT.Host.Text.equal (magneticName c.magnetic) "chosen-field-polynomial" then "A chosen response polynomial is a parameter." else
  if SFT.Host.Text.equal (spacingName c.spacing) "unequal-free-spacing" then "Free spacings destroy the generated orientation order." else
  if SFT.Host.Text.equal (electricDegenerateName c.electricDegenerate) "erase-first-displacement" then "Erasure loses the held cross-state channel." else
  if SFT.Host.Text.equal (electricNondegenerateName c.electricNondegenerate) "free-first-order-shift" then "A first-order scalar without a retained partner is ungenerated." else
  if SFT.Host.Text.equal (orderName c.order) "universal-single-order" then "One order erases the degeneracy discriminator." else
  if SFT.Host.Text.equal (targetName c.target) "external-target-readable" then "Target-readable execution cannot seal a prediction." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-coefficient-or-rule" then "An ungenerated response is a parameter." else
  "A J level has 2J+1 magnetic classes; Zeeman magnitude is g*m*B with adjacent spacing g*B; retained degeneracy gives dipole*E while nondegenerate closure gives polarizability*E^2/2."

def generationRule : String := "Generate the complete ten-axis field-predecessor, multiplicity, held-direction, magnetic response, spacing, degenerate/nondegenerate electric response, order, custody and extension product."
def grammarBoundary : String := "Every finite positive angular support, exact positive field magnitude, held side/orientation label and the two complete electric support classes distinguished by whether a degenerate partner is retained."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Direction.rejected,Direction.admitted]).flatMap fun direction =>
  ([Magnetic.rejected,Magnetic.admitted]).flatMap fun magnetic =>
  ([Spacing.rejected,Spacing.admitted]).flatMap fun spacing =>
  ([ElectricDegenerate.rejected,ElectricDegenerate.admitted]).flatMap fun electricDegenerate =>
  ([ElectricNondegenerate.rejected,ElectricNondegenerate.admitted]).flatMap fun electricNondegenerate =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,multiplicity,direction,magnetic,spacing,electricDegenerate,electricNondegenerate,order,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor multiplicity direction magnetic spacing electricDegenerate electricNondegenerate order target extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdirection : direction ∈ [Direction.rejected,Direction.admitted] := by
      cases direction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnetic : magnetic ∈ [Magnetic.rejected,Magnetic.admitted] := by
      cases magnetic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspacing : spacing ∈ [Spacing.rejected,Spacing.admitted] := by
      cases spacing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectricDegenerate : electricDegenerate ∈ [ElectricDegenerate.rejected,ElectricDegenerate.admitted] := by
      cases electricDegenerate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectricNondegenerate : electricNondegenerate ∈ [ElectricNondegenerate.rejected,ElectricNondegenerate.admitted] := by
      cases electricNondegenerate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ direction _ hdirection
    apply CommonRefinement.memFlatMap _ _ magnetic _ hmagnetic
    apply CommonRefinement.memFlatMap _ _ spacing _ hspacing
    apply CommonRefinement.memFlatMap _ _ electricDegenerate _ helectricDegenerate
    apply CommonRefinement.memFlatMap _ _ electricNondegenerate _ helectricNondegenerate
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor multiplicity direction magnetic spacing electricDegenerate electricNondegenerate order target extension =>
    cases predecessor <;> cases multiplicity <;> cases direction <;> cases magnetic <;> cases spacing <;> cases electricDegenerate <;> cases electricNondegenerate <;> cases order <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor multiplicity direction magnetic spacing electricDegenerate electricNondegenerate order target extension =>
    cases predecessor <;> cases multiplicity <;> cases direction <;> cases magnetic <;> cases spacing <;> cases electricDegenerate <;> cases electricNondegenerate <;> cases order <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.multiplicity = .admitted ∧ c.direction = .admitted ∧ c.magnetic = .admitted ∧ c.spacing = .admitted ∧ c.electricDegenerate = .admitted ∧ c.electricNondegenerate = .admitted ∧ c.order = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor multiplicity direction magnetic spacing electricDegenerate electricNondegenerate order target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
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

theorem direction_rejected_rejected (c : Candidate) (h : c.direction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.direction eq
    rw [h] at field
    cases field

theorem magnetic_rejected_rejected (c : Candidate) (h : c.magnetic = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnetic eq
    rw [h] at field
    cases field

theorem spacing_rejected_rejected (c : Candidate) (h : c.spacing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spacing eq
    rw [h] at field
    cases field

theorem electricDegenerate_rejected_rejected (c : Candidate) (h : c.electricDegenerate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electricDegenerate eq
    rw [h] at field
    cases field

theorem electricNondegenerate_rejected_rejected (c : Candidate) (h : c.electricNondegenerate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electricNondegenerate eq
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

end SFT.Physics.AtomicFieldSplittingEntryGrammar
