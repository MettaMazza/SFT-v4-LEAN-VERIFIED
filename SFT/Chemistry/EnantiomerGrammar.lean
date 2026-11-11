import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.EnantiomerGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Members where
  | rejected | admitted

def membersName : Members → String
  | .rejected => "one-structure-only"
  | .admitted => "paired-stereoisomers"

inductive Constitution where
  | rejected | admitted

def constitutionName : Constitution → String
  | .rejected => "different-connectivity"
  | .admitted => "same-composition-and-connectivity"

inductive Mirror where
  | rejected | admitted

def mirrorName : Mirror → String
  | .rejected => "unrelated-orientations"
  | .admitted => "exact-mirror-relation"

inductive Superposition where
  | rejected | admitted

def superpositionName : Superposition → String
  | .rejected => "superposable-pair"
  | .admitted => "non-superposable-pair"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "orientation-erased"
  | .admitted => "opposed-configurations-held"

inductive Environment where
  | rejected | admitted

def environmentName : Environment → String
  | .rejected => "universal-property-difference"
  | .admitted => "chiral-observation-boundary"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "pair-name-only"
  | .admitted => "paired-map-and-observation-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-enantiomer-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  members : Members
  constitution : Constitution
  mirror : Mirror
  superposition : Superposition
  orientation : Orientation
  environment : Environment
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [membersName c.members, constitutionName c.constitution, mirrorName c.mirror, superpositionName c.superposition, orientationName c.orientation, environmentName c.environment, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "members=" (membersName c.members), SFT.Host.Text.append "constitution=" (constitutionName c.constitution), SFT.Host.Text.append "mirror=" (mirrorName c.mirror), SFT.Host.Text.append "superposition=" (superpositionName c.superposition), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "environment=" (environmentName c.environment), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "paired-stereoisomers__same-composition-and-connectivity__exact-mirror-relation__non-superposable-pair__opposed-configurations-held__chiral-observation-boundary__paired-map-and-observation-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (membersName c.members) "paired-stereoisomers" &&
  SFT.Host.Text.equal (constitutionName c.constitution) "same-composition-and-connectivity" &&
  SFT.Host.Text.equal (mirrorName c.mirror) "exact-mirror-relation" &&
  SFT.Host.Text.equal (superpositionName c.superposition) "non-superposable-pair" &&
  SFT.Host.Text.equal (orientationName c.orientation) "opposed-configurations-held" &&
  SFT.Host.Text.equal (environmentName c.environment) "chiral-observation-boundary" &&
  SFT.Host.Text.equal (recordName c.record) "paired-map-and-observation-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (membersName c.members) "paired-stereoisomers") then "No pair exists." else
  if !(SFT.Host.Text.equal (constitutionName c.constitution) "same-composition-and-connectivity") then "They are constitutional isomers." else
  if !(SFT.Host.Text.equal (mirrorName c.mirror) "exact-mirror-relation") then "The pair is not enantiomeric." else
  if !(SFT.Host.Text.equal (superpositionName c.superposition) "non-superposable-pair") then "The reflected structures are identical." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "opposed-configurations-held") then "Opposed configurations merge." else
  if !(SFT.Host.Text.equal (environmentName c.environment) "chiral-observation-boundary") then "Response depends on observation context." else
  if !(SFT.Host.Text.equal (recordName c.record) "paired-map-and-observation-trace") then "The mirror test cannot be checked." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A discretionary label can force the pair." else
  "paired-stereoisomers__same-composition-and-connectivity__exact-mirror-relation__non-superposable-pair__opposed-configurations-held"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite pair of equal-composition, equal-connectivity oriented molecular carriers with exhaustive mirror and proper-superposition tests."

def candidates : List Candidate :=
  ([Members.rejected,Members.admitted]).flatMap fun members =>
  ([Constitution.rejected,Constitution.admitted]).flatMap fun constitution =>
  ([Mirror.rejected,Mirror.admitted]).flatMap fun mirror =>
  ([Superposition.rejected,Superposition.admitted]).flatMap fun superposition =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Environment.rejected,Environment.admitted]).flatMap fun environment =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨members,constitution,mirror,superposition,orientation,environment,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk members constitution mirror superposition orientation environment record extra =>
    have hmembers : members ∈ [Members.rejected,Members.admitted] := by
      cases members <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstitution : constitution ∈ [Constitution.rejected,Constitution.admitted] := by
      cases constitution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmirror : mirror ∈ [Mirror.rejected,Mirror.admitted] := by
      cases mirror <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuperposition : superposition ∈ [Superposition.rejected,Superposition.admitted] := by
      cases superposition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henvironment : environment ∈ [Environment.rejected,Environment.admitted] := by
      cases environment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ members _ hmembers
    apply CommonRefinement.memFlatMap _ _ constitution _ hconstitution
    apply CommonRefinement.memFlatMap _ _ mirror _ hmirror
    apply CommonRefinement.memFlatMap _ _ superposition _ hsuperposition
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ environment _ henvironment
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk members constitution mirror superposition orientation environment record extra =>
    cases members <;> cases constitution <;> cases mirror <;> cases superposition <;> cases orientation <;> cases environment <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk members constitution mirror superposition orientation environment record extra =>
    cases members <;> cases constitution <;> cases mirror <;> cases superposition <;> cases orientation <;> cases environment <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.members = .admitted ∧ c.constitution = .admitted ∧ c.mirror = .admitted ∧ c.superposition = .admitted ∧ c.orientation = .admitted ∧ c.environment = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk members constitution mirror superposition orientation environment record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem members_rejected_rejected (c : Candidate) (h : c.members = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.members eq
    rw [h] at field
    cases field

theorem constitution_rejected_rejected (c : Candidate) (h : c.constitution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.constitution eq
    rw [h] at field
    cases field

theorem mirror_rejected_rejected (c : Candidate) (h : c.mirror = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mirror eq
    rw [h] at field
    cases field

theorem superposition_rejected_rejected (c : Candidate) (h : c.superposition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.superposition eq
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

theorem environment_rejected_rejected (c : Candidate) (h : c.environment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.environment eq
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

end SFT.Chemistry.EnantiomerGrammar
