import SFT.Physics.LeptonTerminal
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.TerminalGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Base where
  | rejected | admitted

def baseName : Base → String
  | .rejected => "replace-cubic-product"
  | .admitted => "retain-admitted-sharpened-product"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "selected-linear-or-square-order"
  | .admitted => "one-alpha-per-three-root"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "single-channel-support"
  | .admitted => "complete-generator-volume"

inductive Down where
  | rejected | admitted

def downName : Down → String
  | .rejected => "free-depth-coefficient"
  | .admitted => "forced-down-cover-depth"

inductive Up where
  | rejected | admitted

def upName : Up → String
  | .rejected => "bare-up-depth"
  | .admitted => "one-alpha-transported-up-depth"

inductive Channel where
  | rejected | admitted

def channelName : Channel → String
  | .rejected => "undistributed-up-depth"
  | .admitted => "one-complete-colour-share"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "append-unheld-product"
  | .admitted => "hold-correction-from-product"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "measurement-readable-relation"
  | .admitted => "measurement-inaccessible-until-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "mislabel-as-blind-forward-discovery"
  | .admitted => "observational-derivation-disclosed"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-fit-term"
  | .admitted => "no-extra-rule"

structure Candidate where
  base : Base
  order : Order
  support : Support
  down : Down
  up : Up
  channel : Channel
  orientation : Orientation
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [baseName c.base, orderName c.order, supportName c.support, downName c.down, upName c.up, channelName c.channel, orientationName c.orientation, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "base=" (baseName c.base), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "down=" (downName c.down), SFT.Host.Text.append "up=" (upName c.up), SFT.Host.Text.append "channel=" (channelName c.channel), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "retain-admitted-sharpened-product__one-alpha-per-three-root__complete-generator-volume__forced-down-cover-depth__one-alpha-transported-up-depth__one-complete-colour-share__hold-correction-from-product__measurement-inaccessible-until-seal__observational-derivation-disclosed__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (baseName c.base) "retain-admitted-sharpened-product" &&
  SFT.Host.Text.equal (orderName c.order) "one-alpha-per-three-root" &&
  SFT.Host.Text.equal (supportName c.support) "complete-generator-volume" &&
  SFT.Host.Text.equal (downName c.down) "forced-down-cover-depth" &&
  SFT.Host.Text.equal (upName c.up) "one-alpha-transported-up-depth" &&
  SFT.Host.Text.equal (channelName c.channel) "one-complete-colour-share" &&
  SFT.Host.Text.equal (orientationName c.orientation) "hold-correction-from-product" &&
  SFT.Host.Text.equal (targetName c.target) "measurement-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "observational-derivation-disclosed" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (baseName c.base) "replace-cubic-product" then "Replacement erases the admitted cubic." else
  if SFT.Host.Text.equal (orderName c.order) "selected-linear-or-square-order" then "A lower selected order does not act once on every root." else
  if SFT.Host.Text.equal (supportName c.support) "single-channel-support" then "One channel omits the complete three-root carrier." else
  if SFT.Host.Text.equal (downName c.down) "free-depth-coefficient" then "A free coefficient is a parameter." else
  if SFT.Host.Text.equal (upName c.up) "bare-up-depth" then "A bare successor depth ignores transport between orders." else
  if SFT.Host.Text.equal (channelName c.channel) "undistributed-up-depth" then "An undistributed successor counts every colour channel as one." else
  if SFT.Host.Text.equal (orientationName c.orientation) "append-unheld-product" then "Appending creates an unaccounted product carrier." else
  if SFT.Host.Text.equal (targetName c.target) "measurement-readable-relation" then "That would fit the failed target." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "mislabel-as-blind-forward-discovery" then "The failed comparison was already observed." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-fit-term" then "An additional term is a free parameter." else
  "The terminal product invariant is exactly 3/1454 held by alpha^3/3^3 times (5 + (7/3)alpha), with alpha the reciprocal of the admitted terminal inverse fine-structure ratio."

def generationRule : String := "Generate the complete product of base invariant, interaction order, support, down-depth role, up-depth transport, channel distribution, correction orientation, target custody and extension forms."
def grammarBoundary : String := "All exact first terminal self-coupling refinements of the admitted three-root product constructed from its generator order, complete generator volume, terminal alpha and forced down/up cover depths."

def candidates : List Candidate :=
  ([Base.rejected,Base.admitted]).flatMap fun base =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Down.rejected,Down.admitted]).flatMap fun down =>
  ([Up.rejected,Up.admitted]).flatMap fun up =>
  ([Channel.rejected,Channel.admitted]).flatMap fun channel =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨base,order,support,down,up,channel,orientation,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk base order support down up channel orientation target provenance extension =>
    have hbase : base ∈ [Base.rejected,Base.admitted] := by
      cases base <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdown : down ∈ [Down.rejected,Down.admitted] := by
      cases down <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hup : up ∈ [Up.rejected,Up.admitted] := by
      cases up <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchannel : channel ∈ [Channel.rejected,Channel.admitted] := by
      cases channel <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ base _ hbase
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ down _ hdown
    apply CommonRefinement.memFlatMap _ _ up _ hup
    apply CommonRefinement.memFlatMap _ _ channel _ hchannel
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk base order support down up channel orientation target provenance extension =>
    cases base <;> cases order <;> cases support <;> cases down <;> cases up <;> cases channel <;> cases orientation <;> cases target <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk base order support down up channel orientation target provenance extension =>
    cases base <;> cases order <;> cases support <;> cases down <;> cases up <;> cases channel <;> cases orientation <;> cases target <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.base = .admitted ∧ c.order = .admitted ∧ c.support = .admitted ∧ c.down = .admitted ∧ c.up = .admitted ∧ c.channel = .admitted ∧ c.orientation = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk base order support down up channel orientation target provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem base_rejected_rejected (c : Candidate) (h : c.base = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.base eq
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem down_rejected_rejected (c : Candidate) (h : c.down = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.down eq
    rw [h] at field
    cases field

theorem up_rejected_rejected (c : Candidate) (h : c.up = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.up eq
    rw [h] at field
    cases field

theorem channel_rejected_rejected (c : Candidate) (h : c.channel = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.channel eq
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

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
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

end SFT.Physics.TerminalGrammar
