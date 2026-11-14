import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AtomicTransitionRateEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "replace-selection-law"
  | .admitted => "retain-one-unit-elementary-act"

inductive Gap where
  | rejected | admitted

def gapName : Gap → String
  | .rejected => "selected-decimal-frequency"
  | .admitted => "exact-positive-level-gap"

inductive Space where
  | rejected | admitted

def spaceName : Space → String
  | .rejected => "free-rate-exponent"
  | .admitted => "complete-generator-three-volume"

inductive Strength where
  | rejected | admitted

def strengthName : Strength → String
  | .rejected => "erase-or-fit-strength"
  | .admitted => "held-exact-line-strength"

inductive Weight where
  | rejected | admitted

def weightName : Weight → String
  | .rejected => "unweighted-or-fitted-factor"
  | .admitted => "divide-by-complete-positive-weight"

inductive Lifetime where
  | rejected | admitted

def lifetimeName : Lifetime → String
  | .rejected => "independent-lifetime-parameter"
  | .admitted => "reciprocal-complete-rate-sum"

inductive Multipole where
  | rejected | admitted

def multipoleName : Multipole → String
  | .rejected => "chosen-power-list"
  | .admitted => "append-held-boundary-pair"

inductive Forbidden where
  | rejected | admitted

def forbiddenName : Forbidden → String
  | .rejected => "universal-slower-label"
  | .admitted => "typed-channel-conditional-suppression"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "external-target-readable"
  | .admitted => "target-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-coefficient-or-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  gap : Gap
  space : Space
  strength : Strength
  weight : Weight
  lifetime : Lifetime
  multipole : Multipole
  forbidden : Forbidden
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, gapName c.gap, spaceName c.space, strengthName c.strength, weightName c.weight, lifetimeName c.lifetime, multipoleName c.multipole, forbiddenName c.forbidden, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "gap=" (gapName c.gap), SFT.Host.Text.append "space=" (spaceName c.space), SFT.Host.Text.append "strength=" (strengthName c.strength), SFT.Host.Text.append "weight=" (weightName c.weight), SFT.Host.Text.append "lifetime=" (lifetimeName c.lifetime), SFT.Host.Text.append "multipole=" (multipoleName c.multipole), SFT.Host.Text.append "forbidden=" (forbiddenName c.forbidden), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "retain-one-unit-elementary-act__exact-positive-level-gap__complete-generator-three-volume__held-exact-line-strength__divide-by-complete-positive-weight__reciprocal-complete-rate-sum__append-held-boundary-pair__typed-channel-conditional-suppression__target-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "retain-one-unit-elementary-act" &&
  SFT.Host.Text.equal (gapName c.gap) "exact-positive-level-gap" &&
  SFT.Host.Text.equal (spaceName c.space) "complete-generator-three-volume" &&
  SFT.Host.Text.equal (strengthName c.strength) "held-exact-line-strength" &&
  SFT.Host.Text.equal (weightName c.weight) "divide-by-complete-positive-weight" &&
  SFT.Host.Text.equal (lifetimeName c.lifetime) "reciprocal-complete-rate-sum" &&
  SFT.Host.Text.equal (multipoleName c.multipole) "append-held-boundary-pair" &&
  SFT.Host.Text.equal (forbiddenName c.forbidden) "typed-channel-conditional-suppression" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "replace-selection-law" then "A successor cannot rewrite the immutable one-unit receipt." else
  if SFT.Host.Text.equal (gapName c.gap) "selected-decimal-frequency" then "A selected frequency would be a target-bearing parameter." else
  if SFT.Host.Text.equal (spaceName c.space) "free-rate-exponent" then "A chosen exponent is a parameter." else
  if SFT.Host.Text.equal (strengthName c.strength) "erase-or-fit-strength" then "Erasure or fitting cannot distinguish lines." else
  if SFT.Host.Text.equal (weightName c.weight) "unweighted-or-fitted-factor" then "A hidden multiplicity changes rates freely." else
  if SFT.Host.Text.equal (lifetimeName c.lifetime) "independent-lifetime-parameter" then "A separately chosen lifetime is not forced." else
  if SFT.Host.Text.equal (multipoleName c.multipole) "chosen-power-list" then "A list has no successor theorem." else
  if SFT.Host.Text.equal (forbiddenName c.forbidden) "universal-slower-label" then "M1 shares the cubic exponent and distinct strengths can reverse an unqualified ordering." else
  if SFT.Host.Text.equal (targetName c.target) "external-target-readable" then "Target-readable execution cannot seal a prediction." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-coefficient-or-exception" then "An ungenerated coefficient is a parameter." else
  "Normalized E1 rate is gap^3*S/g; lifetime is 1/(sum_i A_i); normalized electric rank-L rate is gap^(2L+1)*S/g and the equal-strength/equal-weight successor ratio is gap^2. The elementary orbital step remains One, while non-electric typed channels require their own held strengths."

def generationRule : String := "Generate the complete ten-axis transition-act, gap, spatial-volume, strength, weight, lifetime, multipole, typed-channel, custody and extension product."
def grammarBoundary : String := "All exact positive normalized electric-multipole rates generated from an admitted level gap, held strength, positive upper-state weight and every finite positive multipole rank, plus complete finite positive decay-channel sums."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Gap.rejected,Gap.admitted]).flatMap fun gap =>
  ([Space.rejected,Space.admitted]).flatMap fun space =>
  ([Strength.rejected,Strength.admitted]).flatMap fun strength =>
  ([Weight.rejected,Weight.admitted]).flatMap fun weight =>
  ([Lifetime.rejected,Lifetime.admitted]).flatMap fun lifetime =>
  ([Multipole.rejected,Multipole.admitted]).flatMap fun multipole =>
  ([Forbidden.rejected,Forbidden.admitted]).flatMap fun forbidden =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,gap,space,strength,weight,lifetime,multipole,forbidden,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor gap space strength weight lifetime multipole forbidden target extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgap : gap ∈ [Gap.rejected,Gap.admitted] := by
      cases gap <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspace : space ∈ [Space.rejected,Space.admitted] := by
      cases space <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstrength : strength ∈ [Strength.rejected,Strength.admitted] := by
      cases strength <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hweight : weight ∈ [Weight.rejected,Weight.admitted] := by
      cases weight <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlifetime : lifetime ∈ [Lifetime.rejected,Lifetime.admitted] := by
      cases lifetime <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultipole : multipole ∈ [Multipole.rejected,Multipole.admitted] := by
      cases multipole <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hforbidden : forbidden ∈ [Forbidden.rejected,Forbidden.admitted] := by
      cases forbidden <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ gap _ hgap
    apply CommonRefinement.memFlatMap _ _ space _ hspace
    apply CommonRefinement.memFlatMap _ _ strength _ hstrength
    apply CommonRefinement.memFlatMap _ _ weight _ hweight
    apply CommonRefinement.memFlatMap _ _ lifetime _ hlifetime
    apply CommonRefinement.memFlatMap _ _ multipole _ hmultipole
    apply CommonRefinement.memFlatMap _ _ forbidden _ hforbidden
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor gap space strength weight lifetime multipole forbidden target extension =>
    cases predecessor <;> cases gap <;> cases space <;> cases strength <;> cases weight <;> cases lifetime <;> cases multipole <;> cases forbidden <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor gap space strength weight lifetime multipole forbidden target extension =>
    cases predecessor <;> cases gap <;> cases space <;> cases strength <;> cases weight <;> cases lifetime <;> cases multipole <;> cases forbidden <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.gap = .admitted ∧ c.space = .admitted ∧ c.strength = .admitted ∧ c.weight = .admitted ∧ c.lifetime = .admitted ∧ c.multipole = .admitted ∧ c.forbidden = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor gap space strength weight lifetime multipole forbidden target extension =>
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

theorem gap_rejected_rejected (c : Candidate) (h : c.gap = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.gap eq
    rw [h] at field
    cases field

theorem space_rejected_rejected (c : Candidate) (h : c.space = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.space eq
    rw [h] at field
    cases field

theorem strength_rejected_rejected (c : Candidate) (h : c.strength = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.strength eq
    rw [h] at field
    cases field

theorem weight_rejected_rejected (c : Candidate) (h : c.weight = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.weight eq
    rw [h] at field
    cases field

theorem lifetime_rejected_rejected (c : Candidate) (h : c.lifetime = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.lifetime eq
    rw [h] at field
    cases field

theorem multipole_rejected_rejected (c : Candidate) (h : c.multipole = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multipole eq
    rw [h] at field
    cases field

theorem forbidden_rejected_rejected (c : Candidate) (h : c.forbidden = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.forbidden eq
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

end SFT.Physics.AtomicTransitionRateEntryGrammar
