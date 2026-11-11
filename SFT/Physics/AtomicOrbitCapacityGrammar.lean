import SFT.Physics.AtomicOrbitCapacity
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AtomicOrbitCapacityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unlabelled-cell-count"
  | .admitted => "held-orientation-cell"

inductive Central where
  | rejected | admitted

def centralName : Central → String
  | .rejected => "empty-numerical-origin"
  | .admitted => "one-central-orientation"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "free-rank-increment"
  | .admitted => "one-boundary-orientation-pair"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "single-or-three-direction-addition"
  | .admitted => "forced-rank-two-pair"

inductive Label where
  | rejected | admitted

def labelName : Label → String
  | .rejected => "label-erased-or-selected"
  | .admitted => "both-Fold-labels"

inductive Exclusion where
  | rejected | admitted

def exclusionName : Exclusion → String
  | .rejected => "duplicate-cell-label"
  | .admitted => "one-of-each-label-per-cell"

inductive Capacity where
  | rejected | admitted

def capacityName : Capacity → String
  | .rejected => "linear-or-doubling-without-boundary"
  | .admitted => "labels-times-complete-orientations"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "finite-width-list"
  | .admitted => "constant-boundary-pair-successor"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "width-list-visible"
  | .admitted => "widths-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-degeneracy-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  central : Central
  successor : Successor
  boundary : Boundary
  label : Label
  exclusion : Exclusion
  capacity : Capacity
  generality : Generality
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, centralName c.central, successorName c.successor, boundaryName c.boundary, labelName c.label, exclusionName c.exclusion, capacityName c.capacity, generalityName c.generality, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "central=" (centralName c.central), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "label=" (labelName c.label), SFT.Host.Text.append "exclusion=" (exclusionName c.exclusion), SFT.Host.Text.append "capacity=" (capacityName c.capacity), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-orientation-cell__one-central-orientation__one-boundary-orientation-pair__forced-rank-two-pair__both-Fold-labels__one-of-each-label-per-cell__labels-times-complete-orientations__constant-boundary-pair-successor__widths-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "held-orientation-cell" &&
  SFT.Host.Text.equal (centralName c.central) "one-central-orientation" &&
  SFT.Host.Text.equal (successorName c.successor) "one-boundary-orientation-pair" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "forced-rank-two-pair" &&
  SFT.Host.Text.equal (labelName c.label) "both-Fold-labels" &&
  SFT.Host.Text.equal (exclusionName c.exclusion) "one-of-each-label-per-cell" &&
  SFT.Host.Text.equal (capacityName c.capacity) "labels-times-complete-orientations" &&
  SFT.Host.Text.equal (generalityName c.generality) "constant-boundary-pair-successor" &&
  SFT.Host.Text.equal (targetName c.target) "widths-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "unlabelled-cell-count" then "An unlabelled count loses orientation identity." else
  if SFT.Host.Text.equal (centralName c.central) "empty-numerical-origin" then "Numerical zero is not an SFT carrier." else
  if SFT.Host.Text.equal (successorName c.successor) "free-rank-increment" then "A free increment is a parameter." else
  if SFT.Host.Text.equal (boundaryName c.boundary) "single-or-three-direction-addition" then "One omits a boundary side and three re-adds the held normal." else
  if SFT.Host.Text.equal (labelName c.label) "label-erased-or-selected" then "Erasure or selection violates complete Fold support." else
  if SFT.Host.Text.equal (exclusionName c.exclusion) "duplicate-cell-label" then "Duplication destroys distinguishability." else
  if SFT.Host.Text.equal (capacityName c.capacity) "linear-or-doubling-without-boundary" then "Those former survivors ignore the newly admitted boundary discriminator." else
  if SFT.Host.Text.equal (generalityName c.generality) "finite-width-list" then "A list has no next-rank proof." else
  if SFT.Host.Text.equal (targetName c.target) "width-list-visible" then "That reverses derivation and test." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-degeneracy-rule" then "An added degeneracy is a parameter." else
  "For every positive orbit rank r, capacity is exactly 2(1+2(r-1)); ranks one through five have capacities 2, 6, 10, 14 and 18."

def generationRule : String := "Generate the complete product of carrier, central class, successor extension, boundary multiplicity, Fold label, exclusion, capacity, generality, target custody and extension forms."
def grammarBoundary : String := "All orbit-cell capacity laws generated from one central orientation, positive orbit succession, the complete rank-two boundary, two held Fold labels and exclusion."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Central.rejected,Central.admitted]).flatMap fun central =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Label.rejected,Label.admitted]).flatMap fun label =>
  ([Exclusion.rejected,Exclusion.admitted]).flatMap fun exclusion =>
  ([Capacity.rejected,Capacity.admitted]).flatMap fun capacity =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,central,successor,boundary,label,exclusion,capacity,generality,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier central successor boundary label exclusion capacity generality target extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcentral : central ∈ [Central.rejected,Central.admitted] := by
      cases central <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlabel : label ∈ [Label.rejected,Label.admitted] := by
      cases label <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexclusion : exclusion ∈ [Exclusion.rejected,Exclusion.admitted] := by
      cases exclusion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcapacity : capacity ∈ [Capacity.rejected,Capacity.admitted] := by
      cases capacity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ central _ hcentral
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ label _ hlabel
    apply CommonRefinement.memFlatMap _ _ exclusion _ hexclusion
    apply CommonRefinement.memFlatMap _ _ capacity _ hcapacity
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier central successor boundary label exclusion capacity generality target extension =>
    cases carrier <;> cases central <;> cases successor <;> cases boundary <;> cases label <;> cases exclusion <;> cases capacity <;> cases generality <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier central successor boundary label exclusion capacity generality target extension =>
    cases carrier <;> cases central <;> cases successor <;> cases boundary <;> cases label <;> cases exclusion <;> cases capacity <;> cases generality <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.central = .admitted ∧ c.successor = .admitted ∧ c.boundary = .admitted ∧ c.label = .admitted ∧ c.exclusion = .admitted ∧ c.capacity = .admitted ∧ c.generality = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier central successor boundary label exclusion capacity generality target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem central_rejected_rejected (c : Candidate) (h : c.central = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.central eq
    rw [h] at field
    cases field

theorem successor_rejected_rejected (c : Candidate) (h : c.successor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.successor eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem label_rejected_rejected (c : Candidate) (h : c.label = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.label eq
    rw [h] at field
    cases field

theorem exclusion_rejected_rejected (c : Candidate) (h : c.exclusion = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.exclusion eq
    rw [h] at field
    cases field

theorem capacity_rejected_rejected (c : Candidate) (h : c.capacity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.capacity eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
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

end SFT.Physics.AtomicOrbitCapacityGrammar
