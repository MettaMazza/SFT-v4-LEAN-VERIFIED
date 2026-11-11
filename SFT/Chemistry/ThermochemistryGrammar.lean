import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ThermochemistryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Reaction where
  | rejected | admitted

def reactionName : Reaction → String
  | .rejected => "energy-value-without-reaction"
  | .admitted => "registered-reaction-trace"

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "reactant-energy-erased"
  | .admitted => "complete-reactant-energy-support"

inductive Output where
  | rejected | admitted

def outputName : Output → String
  | .rejected => "product-energy-erased"
  | .admitted => "complete-product-energy-support"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "free-energy-creation"
  | .admitted => "energy-transfer-balanced"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-heat-number"
  | .admitted => "held-absorbed-or-released-orientation"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "condition-free-value"
  | .admitted => "phase-condition-reference-held"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "enthalpy-answer-only"
  | .admitted => "reaction-energy-source-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-calibration-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  reaction : Reaction
  input : Input
  output : Output
  conservation : Conservation
  orientation : Orientation
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [reactionName c.reaction, inputName c.input, outputName c.output, conservationName c.conservation, orientationName c.orientation, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "reaction=" (reactionName c.reaction), SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "output=" (outputName c.output), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "registered-reaction-trace__complete-reactant-energy-support__complete-product-energy-support__energy-transfer-balanced__held-absorbed-or-released-orientation__phase-condition-reference-held__reaction-energy-source-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (reactionName c.reaction) "registered-reaction-trace" &&
  SFT.Host.Text.equal (inputName c.input) "complete-reactant-energy-support" &&
  SFT.Host.Text.equal (outputName c.output) "complete-product-energy-support" &&
  SFT.Host.Text.equal (conservationName c.conservation) "energy-transfer-balanced" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-absorbed-or-released-orientation" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "phase-condition-reference-held" &&
  SFT.Host.Text.equal (recordName c.record) "reaction-energy-source-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (reactionName c.reaction) "registered-reaction-trace") then "No chemical identity is retained." else
  if !(SFT.Host.Text.equal (inputName c.input) "complete-reactant-energy-support") then "The ledger cannot close." else
  if !(SFT.Host.Text.equal (outputName c.output) "complete-product-energy-support") then "The ledger cannot close." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "energy-transfer-balanced") then "It violates closure." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-absorbed-or-released-orientation") then "A signed scalar is unnecessary." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "phase-condition-reference-held") then "Thermochemical quantities are state-bound." else
  if !(SFT.Host.Text.equal (recordName c.record) "reaction-energy-source-trace") then "It cannot reproduce accounting." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fit can select any value." else
  "registered-reaction-trace__complete-reactant-energy-support__complete-product-energy-support__energy-transfer-balanced__held-absorbed-or-released-orientation"

def generationRule : String := "Generate the literal product of reaction, input, output, conservation, orientation, condition, record and extension choices."
def grammarBoundary : String := "Every finite closed chemical reaction with complete source-bound energy carriers at reactant and product boundaries, held transfer orientation, phase, conditions and reference state."

def candidates : List Candidate :=
  ([Reaction.rejected,Reaction.admitted]).flatMap fun reaction =>
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Output.rejected,Output.admitted]).flatMap fun output =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨reaction,input,output,conservation,orientation,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk reaction input output conservation orientation conditions record extra =>
    have hreaction : reaction ∈ [Reaction.rejected,Reaction.admitted] := by
      cases reaction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have houtput : output ∈ [Output.rejected,Output.admitted] := by
      cases output <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ reaction _ hreaction
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ output _ houtput
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk reaction input output conservation orientation conditions record extra =>
    cases reaction <;> cases input <;> cases output <;> cases conservation <;> cases orientation <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk reaction input output conservation orientation conditions record extra =>
    cases reaction <;> cases input <;> cases output <;> cases conservation <;> cases orientation <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.reaction = .admitted ∧ c.input = .admitted ∧ c.output = .admitted ∧ c.conservation = .admitted ∧ c.orientation = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk reaction input output conservation orientation conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem reaction_rejected_rejected (c : Candidate) (h : c.reaction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reaction eq
    rw [h] at field
    cases field

theorem input_rejected_rejected (c : Candidate) (h : c.input = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.input eq
    rw [h] at field
    cases field

theorem output_rejected_rejected (c : Candidate) (h : c.output = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.output eq
    rw [h] at field
    cases field

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
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

theorem conditions_rejected_rejected (c : Candidate) (h : c.conditions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditions eq
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

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Chemistry.ThermochemistryGrammar
