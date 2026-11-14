import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.TerminalElectronAnomalyEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Leading where
  | rejected | admitted

def leadingName : Leading → String
  | .rejected => "replace-bare-or-leading-law"
  | .admitted => "retain-admitted-leading-alpha-carrier"

inductive Turn where
  | rejected | admitted

def turnName : Turn → String
  | .rejected => "imported-irrational-turn"
  | .admitted => "terminal-exact-turn-projection"

inductive Bulk where
  | rejected | admitted

def bulkName : Bulk → String
  | .rejected => "selected-bulk-subset"
  | .admitted => "complete-volume-held-by-boundary-channels"

inductive First where
  | rejected | admitted

def firstName : First → String
  | .rejected => "free-first-loop-coefficient"
  | .admitted => "down-over-open-bulk-held-by-binary-alpha-over-down-colour"

inductive Second where
  | rejected | admitted

def secondName : Second → String
  | .rejected => "free-terminal-loop-coefficient"
  | .admitted => "One-alpha-square-over-down-colour-held-by-up-alpha-cube-over-closed-support"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-or-complex-coefficients"
  | .admitted => "two-positive-held-pairs"

inductive Retention where
  | rejected | admitted

def retentionName : Retention → String
  | .rejected => "append-unbound-anomaly"
  | .admitted => "hold-alpha-loop-once-from-leading"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "measurement-readable-execution"
  | .admitted => "target-inaccessible-until-prediction-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "unregistered-fit"
  | .admitted => "registered-observational-prediction-protocol"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-radiative-term"
  | .admitted => "no-extra-rule"

structure Candidate where
  leading : Leading
  turn : Turn
  bulk : Bulk
  first : First
  second : Second
  orientation : Orientation
  retention : Retention
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [leadingName c.leading, turnName c.turn, bulkName c.bulk, firstName c.first, secondName c.second, orientationName c.orientation, retentionName c.retention, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "leading=" (leadingName c.leading), SFT.Host.Text.append "turn=" (turnName c.turn), SFT.Host.Text.append "bulk=" (bulkName c.bulk), SFT.Host.Text.append "first=" (firstName c.first), SFT.Host.Text.append "second=" (secondName c.second), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "retention=" (retentionName c.retention), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "retain-admitted-leading-alpha-carrier__terminal-exact-turn-projection__complete-volume-held-by-boundary-channels__down-over-open-bulk-held-by-binary-alpha-over-down-colour__One-alpha-square-over-down-colour-held-by-up-alpha-cube-over-closed-support__two-positive-held-pairs__hold-alpha-loop-once-from-leading__target-inaccessible-until-prediction-seal__registered-observational-prediction-protocol__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (leadingName c.leading) "retain-admitted-leading-alpha-carrier" &&
  SFT.Host.Text.equal (turnName c.turn) "terminal-exact-turn-projection" &&
  SFT.Host.Text.equal (bulkName c.bulk) "complete-volume-held-by-boundary-channels" &&
  SFT.Host.Text.equal (firstName c.first) "down-over-open-bulk-held-by-binary-alpha-over-down-colour" &&
  SFT.Host.Text.equal (secondName c.second) "One-alpha-square-over-down-colour-held-by-up-alpha-cube-over-closed-support" &&
  SFT.Host.Text.equal (orientationName c.orientation) "two-positive-held-pairs" &&
  SFT.Host.Text.equal (retentionName c.retention) "hold-alpha-loop-once-from-leading" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-prediction-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "registered-observational-prediction-protocol" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (leadingName c.leading) "replace-bare-or-leading-law" then "Replacement erases the admitted Dirac and leading receipts." else
  if SFT.Host.Text.equal (turnName c.turn) "imported-irrational-turn" then "An irrational carrier violates the domain." else
  if SFT.Host.Text.equal (bulkName c.bulk) "selected-bulk-subset" then "A subset can tune the result." else
  if SFT.Host.Text.equal (firstName c.first) "free-first-loop-coefficient" then "A free coefficient is fitted." else
  if SFT.Host.Text.equal (secondName c.second) "free-terminal-loop-coefficient" then "A free coefficient is fitted." else
  if SFT.Host.Text.equal (orientationName c.orientation) "signed-or-complex-coefficients" then "Signed or complex proof values violate the Fold domain." else
  if SFT.Host.Text.equal (retentionName c.retention) "append-unbound-anomaly" then "Appending creates an unnormalized extra carrier." else
  if SFT.Host.Text.equal (targetName c.target) "measurement-readable-execution" then "That cannot issue a target-inaccessible seal." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "unregistered-fit" then "An unregistered fit lacks custody and prediction receipts." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-radiative-term" then "Every down/up, bulk/boundary and terminal carrier is already consumed." else
  "With alpha the admitted exact coupling and T=355/113, the electron anomaly is exactly [alpha/(2T)] times positive_take(One, alpha L), where L is the sum of positive_take(5/24,2 alpha/15) and positive_take(alpha^2/15,7 alpha^3/30)."

def generationRule : String := "Generate the complete ten-axis product of leading carrier, turn, open bulk, first pair, second pair, orientation, retention, target custody, provenance and extension forms."
def grammarBoundary : String := "All first terminal finite-loop completions of the admitted leading electron anomaly using the down/up covers, complete colour bulk/boundary supports, binary labels and terminal alpha exactly once in their typed loop roles."

def candidates : List Candidate :=
  ([Leading.rejected,Leading.admitted]).flatMap fun leading =>
  ([Turn.rejected,Turn.admitted]).flatMap fun turn =>
  ([Bulk.rejected,Bulk.admitted]).flatMap fun bulk =>
  ([First.rejected,First.admitted]).flatMap fun first =>
  ([Second.rejected,Second.admitted]).flatMap fun second =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Retention.rejected,Retention.admitted]).flatMap fun retention =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨leading,turn,bulk,first,second,orientation,retention,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk leading turn bulk first second orientation retention target provenance extension =>
    have hleading : leading ∈ [Leading.rejected,Leading.admitted] := by
      cases leading <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hturn : turn ∈ [Turn.rejected,Turn.admitted] := by
      cases turn <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbulk : bulk ∈ [Bulk.rejected,Bulk.admitted] := by
      cases bulk <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfirst : first ∈ [First.rejected,First.admitted] := by
      cases first <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsecond : second ∈ [Second.rejected,Second.admitted] := by
      cases second <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hretention : retention ∈ [Retention.rejected,Retention.admitted] := by
      cases retention <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ leading _ hleading
    apply CommonRefinement.memFlatMap _ _ turn _ hturn
    apply CommonRefinement.memFlatMap _ _ bulk _ hbulk
    apply CommonRefinement.memFlatMap _ _ first _ hfirst
    apply CommonRefinement.memFlatMap _ _ second _ hsecond
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ retention _ hretention
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk leading turn bulk first second orientation retention target provenance extension =>
    cases leading <;> cases turn <;> cases bulk <;> cases first <;> cases second <;> cases orientation <;> cases retention <;> cases target <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk leading turn bulk first second orientation retention target provenance extension =>
    cases leading <;> cases turn <;> cases bulk <;> cases first <;> cases second <;> cases orientation <;> cases retention <;> cases target <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.leading = .admitted ∧ c.turn = .admitted ∧ c.bulk = .admitted ∧ c.first = .admitted ∧ c.second = .admitted ∧ c.orientation = .admitted ∧ c.retention = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk leading turn bulk first second orientation retention target provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem leading_rejected_rejected (c : Candidate) (h : c.leading = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.leading eq
    rw [h] at field
    cases field

theorem turn_rejected_rejected (c : Candidate) (h : c.turn = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.turn eq
    rw [h] at field
    cases field

theorem bulk_rejected_rejected (c : Candidate) (h : c.bulk = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bulk eq
    rw [h] at field
    cases field

theorem first_rejected_rejected (c : Candidate) (h : c.first = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.first eq
    rw [h] at field
    cases field

theorem second_rejected_rejected (c : Candidate) (h : c.second = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.second eq
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

theorem retention_rejected_rejected (c : Candidate) (h : c.retention = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.retention eq
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

end SFT.Physics.TerminalElectronAnomalyEntryGrammar
