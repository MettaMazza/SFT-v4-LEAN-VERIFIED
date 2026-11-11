import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AffinityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carriers where
  | rejected | admitted

def carriersName : Carriers → String
  | .rejected => "anonymous-element-values"
  | .admitted => "two-named-atomic-occurrences"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "free-affinity-scalar"
  | .admitted => "one-shared-electron-support"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "name-selected-order"
  | .admitted => "complete-endpoint-recurrence-comparison"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-difference"
  | .admitted => "held-preferred-endpoint"

inductive Ties where
  | rejected | admitted

def tiesName : Ties → String
  | .rejected => "forced-strict-order"
  | .admitted => "trace-equivalence-class"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "pairwise-cycle-admitted"
  | .admitted => "transitive-preorder-closure"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "rank-answer-only"
  | .admitted => "complete-comparison-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-scale-constant"
  | .admitted => "no-extra-rule"

structure Candidate where
  carriers : Carriers
  support : Support
  comparison : Comparison
  orientation : Orientation
  ties : Ties
  extension : Extension
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [carriersName c.carriers, supportName c.support, comparisonName c.comparison, orientationName c.orientation, tiesName c.ties, extensionName c.extension, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carriers=" (carriersName c.carriers), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "ties=" (tiesName c.ties), SFT.Host.Text.append "extension=" (extensionName c.extension), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "two-named-atomic-occurrences__one-shared-electron-support__complete-endpoint-recurrence-comparison__held-preferred-endpoint__trace-equivalence-class__transitive-preorder-closure__complete-comparison-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carriersName c.carriers) "two-named-atomic-occurrences" &&
  SFT.Host.Text.equal (supportName c.support) "one-shared-electron-support" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "complete-endpoint-recurrence-comparison" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-preferred-endpoint" &&
  SFT.Host.Text.equal (tiesName c.ties) "trace-equivalence-class" &&
  SFT.Host.Text.equal (extensionName c.extension) "transitive-preorder-closure" &&
  SFT.Host.Text.equal (recordName c.record) "complete-comparison-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carriersName c.carriers) "two-named-atomic-occurrences") then "Values erase endpoint identity." else
  if !(SFT.Host.Text.equal (supportName c.support) "one-shared-electron-support") then "A scalar imports the ordering." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "complete-endpoint-recurrence-comparison") then "Names cannot select preference." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-preferred-endpoint") then "A signed magnitude violates the proof domain." else
  if !(SFT.Host.Text.equal (tiesName c.ties) "trace-equivalence-class") then "Equal complete traces cannot be ordered uniquely." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "transitive-preorder-closure") then "A cycle destroys lawful ordering." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-comparison-trace") then "A rank cannot reconstruct comparisons." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A scale constant can tune any ordering." else
  "two-named-atomic-occurrences__one-shared-electron-support__complete-endpoint-recurrence-comparison__held-preferred-endpoint__transitive-preorder-closure"

def generationRule : String := "Generate the literal product of carrier, support, comparison, orientation, tie, extension, record and extra-rule choices."
def grammarBoundary : String := "Every finite pairwise comparison of two named atomic occurrences joined by one shared electron-labelled support, with the complete recurrence trace determining endpoint preference or an explicitly retained tie."

def candidates : List Candidate :=
  ([Carriers.rejected,Carriers.admitted]).flatMap fun carriers =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Ties.rejected,Ties.admitted]).flatMap fun ties =>
  ([Extension.rejected,Extension.admitted]).flatMap fun extension =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨carriers,support,comparison,orientation,ties,extension,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carriers support comparison orientation ties extension record extra =>
    have hcarriers : carriers ∈ [Carriers.rejected,Carriers.admitted] := by
      cases carriers <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hties : ties ∈ [Ties.rejected,Ties.admitted] := by
      cases ties <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carriers _ hcarriers
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ ties _ hties
    apply CommonRefinement.memFlatMap _ _ extension _ hextension
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carriers support comparison orientation ties extension record extra =>
    cases carriers <;> cases support <;> cases comparison <;> cases orientation <;> cases ties <;> cases extension <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carriers support comparison orientation ties extension record extra =>
    cases carriers <;> cases support <;> cases comparison <;> cases orientation <;> cases ties <;> cases extension <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carriers = .admitted ∧ c.support = .admitted ∧ c.comparison = .admitted ∧ c.orientation = .admitted ∧ c.ties = .admitted ∧ c.extension = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carriers support comparison orientation ties extension record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carriers_rejected_rejected (c : Candidate) (h : c.carriers = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carriers eq
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

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
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

theorem ties_rejected_rejected (c : Candidate) (h : c.ties = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ties eq
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

end SFT.Chemistry.AffinityGrammar
