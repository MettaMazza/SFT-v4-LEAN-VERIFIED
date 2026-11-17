import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.StateSymmetryGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "cross-carrier-equivalence"
  | .admitted => "one-molecule-equivalence"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "energy-only-equivalence"
  | .admitted => "complete-symmetry-signature"

inductive Spin where
  | rejected | admitted

def spinName : Spin → String
  | .rejected => "unsigned-or-absent-multiplicity"
  | .admitted => "positive-spin-multiplicity"

inductive Axis where
  | rejected | admitted

def axisName : Axis → String
  | .rejected => "continuum-or-zero-projection"
  | .admitted => "empty-One-or-positive-axis-rank"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "free-degeneracy-number"
  | .admitted => "one-or-complementary-orientation-support"

inductive Symmetry where
  | rejected | admitted

def symmetryName : Symmetry → String
  | .rejected => "erased-sign-labels"
  | .admitted => "held-symmetry-label-composition"

inductive Class where
  | rejected | admitted

def classAxisName : Class → String
  | .rejected => "unbounded-anonymous-members"
  | .admitted => "complete-positive-component-class"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "term-table-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  identity : Identity
  spin : Spin
  axis : Axis
  orientation : Orientation
  symmetry : Symmetry
  classAxis : Class
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, spinName c.spin, axisName c.axis, orientationName c.orientation, symmetryName c.symmetry, classAxisName c.classAxis, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "spin=" (spinName c.spin), SFT.Host.Text.append "axis=" (axisName c.axis), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "symmetry=" (symmetryName c.symmetry), SFT.Host.Text.append "class=" (classAxisName c.classAxis), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-molecule-equivalence__complete-symmetry-signature__positive-spin-multiplicity__empty-One-or-positive-axis-rank__one-or-complementary-orientation-support__held-symmetry-label-composition__complete-positive-component-class__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-molecule-equivalence" &&
  SFT.Host.Text.equal (identityName c.identity) "complete-symmetry-signature" &&
  SFT.Host.Text.equal (spinName c.spin) "positive-spin-multiplicity" &&
  SFT.Host.Text.equal (axisName c.axis) "empty-One-or-positive-axis-rank" &&
  SFT.Host.Text.equal (orientationName c.orientation) "one-or-complementary-orientation-support" &&
  SFT.Host.Text.equal (symmetryName c.symmetry) "held-symmetry-label-composition" &&
  SFT.Host.Text.equal (classAxisName c.classAxis) "complete-positive-component-class" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-molecule-equivalence") then "States on different molecules cannot share one declared chemical equivalence class." else
  if !(SFT.Host.Text.equal (identityName c.identity) "complete-symmetry-signature") then "Equal or nearby energy alone erases support and symmetry distinctions." else
  if !(SFT.Host.Text.equal (spinName c.spin) "positive-spin-multiplicity") then "Erasing positive spin width loses generated component support." else
  if !(SFT.Host.Text.equal (axisName c.axis) "empty-One-or-positive-axis-rank") then "A continuum coordinate or numerical zero violates the generated axis grammar." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "one-or-complementary-orientation-support") then "An asserted degeneracy count is an unforced parameter." else
  if !(SFT.Host.Text.equal (symmetryName c.symmetry) "held-symmetry-label-composition") then "Erasing inversion, reflection and component labels merges distinguishable terms." else
  if !(SFT.Host.Text.equal (classAxisName c.classAxis) "complete-positive-component-class") then "Anonymous or unbounded members cannot certify degeneracy." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A species or term lookup lets source assignments select the law." else
  "one-molecule-equivalence__complete-symmetry-signature__positive-spin-multiplicity__empty-One-or-positive-axis-rank__one-or-complementary-orientation-support__held-symmetry-label-composition__complete-positive-component-class__no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, identity, spin, axis, orientation, symmetry, class and extension forms. Decide all 256 forms solely by admitted exact equivalence, held-label, spin, exclusion, support and finite-order laws."
def grammarBoundary : String := "Every positive finite molecular electronic-state support; every positive spin multiplicity; structural axis invariance and every positive axis recurrence; both held inversion/reflection fibres where applicable; and structural EmptyOne wherever a symmetry coordinate is absent. Closure is depth-independent because each added component, multiplicity successor or axis recurrence repeats the same exact signature and complete-component checks."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Spin.rejected,Spin.admitted]).flatMap fun spin =>
  ([Axis.rejected,Axis.admitted]).flatMap fun axis =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Symmetry.rejected,Symmetry.admitted]).flatMap fun symmetry =>
  ([Class.rejected,Class.admitted]).flatMap fun classAxis =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,identity,spin,axis,orientation,symmetry,classAxis,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity spin axis orientation symmetry classAxis extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspin : spin ∈ [Spin.rejected,Spin.admitted] := by
      cases spin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haxis : axis ∈ [Axis.rejected,Axis.admitted] := by
      cases axis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsymmetry : symmetry ∈ [Symmetry.rejected,Symmetry.admitted] := by
      cases symmetry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclassAxis : classAxis ∈ [Class.rejected,Class.admitted] := by
      cases classAxis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ spin _ hspin
    apply CommonRefinement.memFlatMap _ _ axis _ haxis
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ symmetry _ hsymmetry
    apply CommonRefinement.memFlatMap _ _ classAxis _ hclassAxis
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (orientation : Orientation) (symmetry : Symmetry) (classAxis : Class) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,orientation,symmetry,classAxis,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,orientation,symmetry,classAxis,extension⟩ := by
 cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier identity spin axis orientation symmetry classAxis extension =>
  cases carrier <;> cases identity <;> cases spin <;> cases axis
  · exact sourceDecisionBlock0000 orientation symmetry classAxis extension
  · exact sourceDecisionBlock0001 orientation symmetry classAxis extension
  · exact sourceDecisionBlock0010 orientation symmetry classAxis extension
  · exact sourceDecisionBlock0011 orientation symmetry classAxis extension
  · exact sourceDecisionBlock0100 orientation symmetry classAxis extension
  · exact sourceDecisionBlock0101 orientation symmetry classAxis extension
  · exact sourceDecisionBlock0110 orientation symmetry classAxis extension
  · exact sourceDecisionBlock0111 orientation symmetry classAxis extension
  · exact sourceDecisionBlock1000 orientation symmetry classAxis extension
  · exact sourceDecisionBlock1001 orientation symmetry classAxis extension
  · exact sourceDecisionBlock1010 orientation symmetry classAxis extension
  · exact sourceDecisionBlock1011 orientation symmetry classAxis extension
  · exact sourceDecisionBlock1100 orientation symmetry classAxis extension
  · exact sourceDecisionBlock1101 orientation symmetry classAxis extension
  · exact sourceDecisionBlock1110 orientation symmetry classAxis extension
  · exact sourceDecisionBlock1111 orientation symmetry classAxis extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-molecule-equivalence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "complete-symmetry-signature" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem spinCriterion (value : Spin) : SFT.Host.Text.equal (spinName value) "positive-spin-multiplicity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem axisCriterion (value : Axis) : SFT.Host.Text.equal (axisName value) "empty-One-or-positive-axis-rank" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "one-or-complementary-orientation-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem symmetryCriterion (value : Symmetry) : SFT.Host.Text.equal (symmetryName value) "held-symmetry-label-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem classAxisCriterion (value : Class) : SFT.Host.Text.equal (classAxisName value) "complete-positive-component-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, identityCriterion, spinCriterion, axisCriterion, orientationCriterion, symmetryCriterion, classAxisCriterion, extensionCriterion]
  cases c with
  | mk carrier identity spin axis orientation symmetry classAxis extension =>
    cases carrier <;> cases identity <;> cases spin <;> cases axis <;> cases orientation <;> cases symmetry <;> cases classAxis <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.spin = .admitted ∧ c.axis = .admitted ∧ c.orientation = .admitted ∧ c.symmetry = .admitted ∧ c.classAxis = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity spin axis orientation symmetry classAxis extension =>
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem spin_rejected_rejected (c : Candidate) (h : c.spin = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spin eq
    rw [h] at field
    cases field

theorem axis_rejected_rejected (c : Candidate) (h : c.axis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.axis eq
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

theorem symmetry_rejected_rejected (c : Candidate) (h : c.symmetry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.symmetry eq
    rw [h] at field
    cases field

theorem classAxis_rejected_rejected (c : Candidate) (h : c.classAxis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.classAxis eq
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

end SFT.Chemistry.StateSymmetryGrammar
