import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.NuclearResidualForceEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "rewrite-nucleon-predecessors"
  | .admitted => "compose-immutable-neutral-composite-predecessors"

inductive Neutral where
  | rejected | admitted

def neutralName : Neutral → String
  | .rejected => "export-raw-colour-label"
  | .admitted => "leading-colour-act-closes-to-empty-form"

inductive Residual where
  | rejected | admitted

def residualName : Residual → String
  | .rejected => "reuse-primary-half-One"
  | .admitted => "paired-half-One-boundary-act"

inductive Strength where
  | rejected | admitted

def strengthName : Strength → String
  | .rejected => "identify-quarter-with-all-cross-sections"
  | .admitted => "structural-order-not-universal-dimensional-strength"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "numerical-zero-mass"
  | .admitted => "empty-mass-label-or-positive-mass-carrier"

inductive Range where
  | rejected | admitted

def rangeName : Range → String
  | .rejected => "chosen-decay-length"
  | .admitted => "exact-reciprocal-mass-scale"

inductive Ordering where
  | rejected | admitted

def orderingName : Ordering → String
  | .rejected => "import-particle-range-ranking"
  | .admitted => "lighter-positive-mass-has-greater-reciprocal"

inductive Saturation where
  | rejected | admitted

def saturationName : Saturation → String
  | .rejected => "all-to-all-independent-links"
  | .admitted => "finite-boundary-cells-with-finite-range"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "external-target-readable"
  | .admitted => "target-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-decay-profile-or-coupling"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  neutral : Neutral
  residual : Residual
  strength : Strength
  mass : Mass
  range : Range
  ordering : Ordering
  saturation : Saturation
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, neutralName c.neutral, residualName c.residual, strengthName c.strength, massName c.mass, rangeName c.range, orderingName c.ordering, saturationName c.saturation, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "neutral=" (neutralName c.neutral), SFT.Host.Text.append "residual=" (residualName c.residual), SFT.Host.Text.append "strength=" (strengthName c.strength), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "range=" (rangeName c.range), SFT.Host.Text.append "ordering=" (orderingName c.ordering), SFT.Host.Text.append "saturation=" (saturationName c.saturation), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "compose-immutable-neutral-composite-predecessors__leading-colour-act-closes-to-empty-form__paired-half-One-boundary-act__structural-order-not-universal-dimensional-strength__empty-mass-label-or-positive-mass-carrier__exact-reciprocal-mass-scale__lighter-positive-mass-has-greater-reciprocal__finite-boundary-cells-with-finite-range__target-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-neutral-composite-predecessors" &&
  SFT.Host.Text.equal (neutralName c.neutral) "leading-colour-act-closes-to-empty-form" &&
  SFT.Host.Text.equal (residualName c.residual) "paired-half-One-boundary-act" &&
  SFT.Host.Text.equal (strengthName c.strength) "structural-order-not-universal-dimensional-strength" &&
  SFT.Host.Text.equal (massName c.mass) "empty-mass-label-or-positive-mass-carrier" &&
  SFT.Host.Text.equal (rangeName c.range) "exact-reciprocal-mass-scale" &&
  SFT.Host.Text.equal (orderingName c.ordering) "lighter-positive-mass-has-greater-reciprocal" &&
  SFT.Host.Text.equal (saturationName c.saturation) "finite-boundary-cells-with-finite-range" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "rewrite-nucleon-predecessors" then "A successor cannot alter admitted receipts." else
  if SFT.Host.Text.equal (neutralName c.neutral) "export-raw-colour-label" then "A raw colour label would violate the admitted singlet boundary." else
  if SFT.Host.Text.equal (residualName c.residual) "reuse-primary-half-One" then "A first-order carrier ignores both neutral closures." else
  if SFT.Host.Text.equal (strengthName c.strength) "identify-quarter-with-all-cross-sections" then "Measured channels need not share one dimensional strength." else
  if SFT.Host.Text.equal (massName c.mass) "numerical-zero-mass" then "Numerical zero is outside the proof domain." else
  if SFT.Host.Text.equal (rangeName c.range) "chosen-decay-length" then "A selected length is a parameter." else
  if SFT.Host.Text.equal (orderingName c.ordering) "import-particle-range-ranking" then "A named particle table cannot prove the order." else
  if SFT.Host.Text.equal (saturationName c.saturation) "all-to-all-independent-links" then "Unlimited independent links ignore finite boundary support and finite range." else
  if SFT.Host.Text.equal (targetName c.target) "external-target-readable" then "Target access cannot seal a prediction." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-decay-profile-or-coupling" then "An ungenerated profile or coefficient is a parameter." else
  "Leading colour exchange outside a singlet is the empty form; the first retained two-boundary order is (1/2)^2=1/4 and returns 1/4 to 1/2 to One in two Folds; every positive mediator has finite normalized range 1/m and m1<m2 forces 1/m1>1/m2."

def generationRule : String := "Generate the complete ten-axis predecessor, neutral closure, residual order, strength scope, mass class, reciprocal range, ordering, saturation, custody and extension product."
def grammarBoundary : String := "Every exchange between two complete colour-three neutral composite boundaries, the forced half-One primary carrier, absent or exact positive mediator-mass labels, and every positive mass ordering under reciprocal range."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Neutral.rejected,Neutral.admitted]).flatMap fun neutral =>
  ([Residual.rejected,Residual.admitted]).flatMap fun residual =>
  ([Strength.rejected,Strength.admitted]).flatMap fun strength =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Range.rejected,Range.admitted]).flatMap fun range =>
  ([Ordering.rejected,Ordering.admitted]).flatMap fun ordering =>
  ([Saturation.rejected,Saturation.admitted]).flatMap fun saturation =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,neutral,residual,strength,mass,range,ordering,saturation,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor neutral residual strength mass range ordering saturation target extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hneutral : neutral ∈ [Neutral.rejected,Neutral.admitted] := by
      cases neutral <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresidual : residual ∈ [Residual.rejected,Residual.admitted] := by
      cases residual <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstrength : strength ∈ [Strength.rejected,Strength.admitted] := by
      cases strength <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrange : range ∈ [Range.rejected,Range.admitted] := by
      cases range <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hordering : ordering ∈ [Ordering.rejected,Ordering.admitted] := by
      cases ordering <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsaturation : saturation ∈ [Saturation.rejected,Saturation.admitted] := by
      cases saturation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ neutral _ hneutral
    apply CommonRefinement.memFlatMap _ _ residual _ hresidual
    apply CommonRefinement.memFlatMap _ _ strength _ hstrength
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ range _ hrange
    apply CommonRefinement.memFlatMap _ _ ordering _ hordering
    apply CommonRefinement.memFlatMap _ _ saturation _ hsaturation
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor neutral residual strength mass range ordering saturation target extension =>
    cases predecessor <;> cases neutral <;> cases residual <;> cases strength <;> cases mass <;> cases range <;> cases ordering <;> cases saturation <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor neutral residual strength mass range ordering saturation target extension =>
    cases predecessor <;> cases neutral <;> cases residual <;> cases strength <;> cases mass <;> cases range <;> cases ordering <;> cases saturation <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.neutral = .admitted ∧ c.residual = .admitted ∧ c.strength = .admitted ∧ c.mass = .admitted ∧ c.range = .admitted ∧ c.ordering = .admitted ∧ c.saturation = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor neutral residual strength mass range ordering saturation target extension =>
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

theorem neutral_rejected_rejected (c : Candidate) (h : c.neutral = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.neutral eq
    rw [h] at field
    cases field

theorem residual_rejected_rejected (c : Candidate) (h : c.residual = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.residual eq
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

theorem mass_rejected_rejected (c : Candidate) (h : c.mass = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mass eq
    rw [h] at field
    cases field

theorem range_rejected_rejected (c : Candidate) (h : c.range = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.range eq
    rw [h] at field
    cases field

theorem ordering_rejected_rejected (c : Candidate) (h : c.ordering = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ordering eq
    rw [h] at field
    cases field

theorem saturation_rejected_rejected (c : Candidate) (h : c.saturation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.saturation eq
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

end SFT.Physics.NuclearResidualForceEntryGrammar
