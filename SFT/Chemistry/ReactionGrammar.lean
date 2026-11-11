import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ReactionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "unregistered-transformation"
  | .admitted => "source-bound-transition"

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "reactants-erased"
  | .admitted => "complete-reactant-organization"

inductive Output where
  | rejected | admitted

def outputName : Output → String
  | .rejected => "products-erased"
  | .admitted => "complete-product-organization"

inductive Carriers where
  | rejected | admitted

def carriersName : Carriers → String
  | .rejected => "element-created-or-lost"
  | .admitted => "all-elemental-carriers-conserved"

inductive Change where
  | rejected | admitted

def changeName : Change → String
  | .rejected => "identity-transition"
  | .admitted => "at-least-one-relation-changed"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "unordered-endpoints"
  | .admitted => "held-reactant-product-orientation"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "reaction-name-only"
  | .admitted => "complete-endpoint-carrier-relation-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-reaction-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  source : Source
  input : Input
  output : Output
  carriers : Carriers
  change : Change
  orientation : Orientation
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [sourceName c.source, inputName c.input, outputName c.output, carriersName c.carriers, changeName c.change, orientationName c.orientation, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "output=" (outputName c.output), SFT.Host.Text.append "carriers=" (carriersName c.carriers), SFT.Host.Text.append "change=" (changeName c.change), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "source-bound-transition__complete-reactant-organization__complete-product-organization__all-elemental-carriers-conserved__at-least-one-relation-changed__held-reactant-product-orientation__complete-endpoint-carrier-relation-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sourceName c.source) "source-bound-transition" &&
  SFT.Host.Text.equal (inputName c.input) "complete-reactant-organization" &&
  SFT.Host.Text.equal (outputName c.output) "complete-product-organization" &&
  SFT.Host.Text.equal (carriersName c.carriers) "all-elemental-carriers-conserved" &&
  SFT.Host.Text.equal (changeName c.change) "at-least-one-relation-changed" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-reactant-product-orientation" &&
  SFT.Host.Text.equal (recordName c.record) "complete-endpoint-carrier-relation-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (sourceName c.source) "source-bound-transition") then "No chemical provenance is retained." else
  if !(SFT.Host.Text.equal (inputName c.input) "complete-reactant-organization") then "A product alone cannot define change." else
  if !(SFT.Host.Text.equal (outputName c.output) "complete-product-organization") then "An input alone cannot define change." else
  if !(SFT.Host.Text.equal (carriersName c.carriers) "all-elemental-carriers-conserved") then "It violates chemical closure." else
  if !(SFT.Host.Text.equal (changeName c.change) "at-least-one-relation-changed") then "No changed relation means no reaction event." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-reactant-product-orientation") then "Direction cannot be audited." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-endpoint-carrier-relation-trace") then "A name cannot reproduce the transition." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An exception can admit arbitrary change." else
  "source-bound-transition__complete-reactant-organization__complete-product-organization__all-elemental-carriers-conserved__at-least-one-relation-changed"

def generationRule : String := "Generate the literal product of source, input, output, carrier, change, orientation, record and extension choices."
def grammarBoundary : String := "Every finite source-bound chemical transition between complete named reactant and product organizations, conserving every elemental carrier while changing at least one registered chemical relation."

def candidates : List Candidate :=
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Output.rejected,Output.admitted]).flatMap fun output =>
  ([Carriers.rejected,Carriers.admitted]).flatMap fun carriers =>
  ([Change.rejected,Change.admitted]).flatMap fun change =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨source,input,output,carriers,change,orientation,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk source input output carriers change orientation record extra =>
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have houtput : output ∈ [Output.rejected,Output.admitted] := by
      cases output <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarriers : carriers ∈ [Carriers.rejected,Carriers.admitted] := by
      cases carriers <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchange : change ∈ [Change.rejected,Change.admitted] := by
      cases change <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ output _ houtput
    apply CommonRefinement.memFlatMap _ _ carriers _ hcarriers
    apply CommonRefinement.memFlatMap _ _ change _ hchange
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk source input output carriers change orientation record extra =>
    cases source <;> cases input <;> cases output <;> cases carriers <;> cases change <;> cases orientation <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk source input output carriers change orientation record extra =>
    cases source <;> cases input <;> cases output <;> cases carriers <;> cases change <;> cases orientation <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.source = .admitted ∧ c.input = .admitted ∧ c.output = .admitted ∧ c.carriers = .admitted ∧ c.change = .admitted ∧ c.orientation = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk source input output carriers change orientation record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
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

theorem carriers_rejected_rejected (c : Candidate) (h : c.carriers = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carriers eq
    rw [h] at field
    cases field

theorem change_rejected_rejected (c : Candidate) (h : c.change = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.change eq
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

end SFT.Chemistry.ReactionGrammar
