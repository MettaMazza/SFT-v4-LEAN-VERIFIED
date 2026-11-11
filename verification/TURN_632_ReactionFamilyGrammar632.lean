import «work».ReactionFamilyCarrier632
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ReactionFamilyGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Members where
  | rejected | admitted

def membersName : Members → String
  | .rejected => "one-reaction-only"
  | .admitted => "multiple-generated-reactions"

inductive Encoding where
  | rejected | admitted

def encodingName : Encoding → String
  | .rejected => "reaction-names-only"
  | .admitted => "complete-reactant-product-maps"

inductive Pattern where
  | rejected | admitted

def patternName : Pattern → String
  | .rejected => "unrelated-bond-changes"
  | .admitted => "shared-bond-change-pattern"

inductive Roles where
  | rejected | admitted

def rolesName : Roles → String
  | .rejected => "reactant-product-roles-erased"
  | .admitted => "reactant-product-role-correspondence"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "carrier-balance-erased"
  | .admitted => "elemental-carriers-balanced"

inductive Mechanism where
  | rejected | admitted

def mechanismName : Mechanism → String
  | .rejected => "mechanism-assumed-from-pattern"
  | .admitted => "mechanism-not-assumed"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "family-label-only"
  | .admitted => "member-and-pattern-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-reaction-taxonomy"
  | .admitted => "no-extra-rule"

structure Candidate where
  members : Members
  encoding : Encoding
  pattern : Pattern
  roles : Roles
  composition : Composition
  mechanism : Mechanism
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [membersName c.members, encodingName c.encoding, patternName c.pattern, rolesName c.roles, compositionName c.composition, mechanismName c.mechanism, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "members=" (membersName c.members), SFT.Host.Text.append "encoding=" (encodingName c.encoding), SFT.Host.Text.append "pattern=" (patternName c.pattern), SFT.Host.Text.append "roles=" (rolesName c.roles), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "mechanism=" (mechanismName c.mechanism), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "multiple-generated-reactions__complete-reactant-product-maps__shared-bond-change-pattern__reactant-product-role-correspondence__elemental-carriers-balanced__mechanism-not-assumed__member-and-pattern-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (membersName c.members) "multiple-generated-reactions" &&
  SFT.Host.Text.equal (encodingName c.encoding) "complete-reactant-product-maps" &&
  SFT.Host.Text.equal (patternName c.pattern) "shared-bond-change-pattern" &&
  SFT.Host.Text.equal (rolesName c.roles) "reactant-product-role-correspondence" &&
  SFT.Host.Text.equal (compositionName c.composition) "elemental-carriers-balanced" &&
  SFT.Host.Text.equal (mechanismName c.mechanism) "mechanism-not-assumed" &&
  SFT.Host.Text.equal (recordName c.record) "member-and-pattern-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (membersName c.members) "multiple-generated-reactions") then "No family is formed." else
  if !(SFT.Host.Text.equal (encodingName c.encoding) "complete-reactant-product-maps") then "Names do not establish common structure." else
  if !(SFT.Host.Text.equal (patternName c.pattern) "shared-bond-change-pattern") then "No shared family relation exists." else
  if !(SFT.Host.Text.equal (rolesName c.roles) "reactant-product-role-correspondence") then "Pattern orientation is ambiguous." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "elemental-carriers-balanced") then "The transformations cannot close." else
  if !(SFT.Host.Text.equal (mechanismName c.mechanism) "mechanism-not-assumed") then "Equal net changes need not share a mechanism." else
  if !(SFT.Host.Text.equal (recordName c.record) "member-and-pattern-trace") then "Membership cannot be audited." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An imported list can force membership." else
  "multiple-generated-reactions__complete-reactant-product-maps__shared-bond-change-pattern__reactant-product-role-correspondence__elemental-carriers-balanced"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite generated set of balanced organic reactant-product atom maps with complete bond changes, functional roles, conditions and separate mechanism records."

def candidates : List Candidate :=
  ([Members.rejected,Members.admitted]).flatMap fun members =>
  ([Encoding.rejected,Encoding.admitted]).flatMap fun encoding =>
  ([Pattern.rejected,Pattern.admitted]).flatMap fun pattern =>
  ([Roles.rejected,Roles.admitted]).flatMap fun roles =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Mechanism.rejected,Mechanism.admitted]).flatMap fun mechanism =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨members,encoding,pattern,roles,composition,mechanism,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk members encoding pattern roles composition mechanism record extra =>
    have hmembers : members ∈ [Members.rejected,Members.admitted] := by
      cases members <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hencoding : encoding ∈ [Encoding.rejected,Encoding.admitted] := by
      cases encoding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpattern : pattern ∈ [Pattern.rejected,Pattern.admitted] := by
      cases pattern <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hroles : roles ∈ [Roles.rejected,Roles.admitted] := by
      cases roles <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmechanism : mechanism ∈ [Mechanism.rejected,Mechanism.admitted] := by
      cases mechanism <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ members _ hmembers
    apply CommonRefinement.memFlatMap _ _ encoding _ hencoding
    apply CommonRefinement.memFlatMap _ _ pattern _ hpattern
    apply CommonRefinement.memFlatMap _ _ roles _ hroles
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ mechanism _ hmechanism
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk members encoding pattern roles composition mechanism record extra =>
    cases members <;> cases encoding <;> cases pattern <;> cases roles <;> cases composition <;> cases mechanism <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk members encoding pattern roles composition mechanism record extra =>
    cases members <;> cases encoding <;> cases pattern <;> cases roles <;> cases composition <;> cases mechanism <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.members = .admitted ∧ c.encoding = .admitted ∧ c.pattern = .admitted ∧ c.roles = .admitted ∧ c.composition = .admitted ∧ c.mechanism = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk members encoding pattern roles composition mechanism record extra =>
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

theorem encoding_rejected_rejected (c : Candidate) (h : c.encoding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.encoding eq
    rw [h] at field
    cases field

theorem pattern_rejected_rejected (c : Candidate) (h : c.pattern = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pattern eq
    rw [h] at field
    cases field

theorem roles_rejected_rejected (c : Candidate) (h : c.roles = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.roles eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem mechanism_rejected_rejected (c : Candidate) (h : c.mechanism = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mechanism eq
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

end SFT.Physics.ReactionFamilyGrammar
