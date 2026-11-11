import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.DiastereomerGrammar
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
  | .rejected => "different-composition-or-connectivity"
  | .admitted => "same-composition-and-connectivity"

inductive Superposition where
  | rejected | admitted

def superpositionName : Superposition → String
  | .rejected => "superposable-pair"
  | .admitted => "non-superposable-pair"

inductive Mirror where
  | rejected | admitted

def mirrorName : Mirror → String
  | .rejected => "exact-mirror-pair"
  | .admitted => "not-mirror-related"

inductive Configuration where
  | rejected | admitted

def configurationName : Configuration → String
  | .rejected => "all-centres-erased"
  | .admitted => "complete-relative-configurations-held"

inductive Properties where
  | rejected | admitted

def propertiesName : Properties → String
  | .rejected => "properties-forced-equal"
  | .admitted => "property-distinction-open"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "diastereomer-label-only"
  | .admitted => "complete-pair-classification-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-diastereomer-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  members : Members
  constitution : Constitution
  superposition : Superposition
  mirror : Mirror
  configuration : Configuration
  properties : Properties
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [membersName c.members, constitutionName c.constitution, superpositionName c.superposition, mirrorName c.mirror, configurationName c.configuration, propertiesName c.properties, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "members=" (membersName c.members), SFT.Host.Text.append "constitution=" (constitutionName c.constitution), SFT.Host.Text.append "superposition=" (superpositionName c.superposition), SFT.Host.Text.append "mirror=" (mirrorName c.mirror), SFT.Host.Text.append "configuration=" (configurationName c.configuration), SFT.Host.Text.append "properties=" (propertiesName c.properties), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "paired-stereoisomers__same-composition-and-connectivity__non-superposable-pair__not-mirror-related__complete-relative-configurations-held__property-distinction-open__complete-pair-classification-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (membersName c.members) "paired-stereoisomers" &&
  SFT.Host.Text.equal (constitutionName c.constitution) "same-composition-and-connectivity" &&
  SFT.Host.Text.equal (superpositionName c.superposition) "non-superposable-pair" &&
  SFT.Host.Text.equal (mirrorName c.mirror) "not-mirror-related" &&
  SFT.Host.Text.equal (configurationName c.configuration) "complete-relative-configurations-held" &&
  SFT.Host.Text.equal (propertiesName c.properties) "property-distinction-open" &&
  SFT.Host.Text.equal (recordName c.record) "complete-pair-classification-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (membersName c.members) "paired-stereoisomers") then "No pair exists." else
  if !(SFT.Host.Text.equal (constitutionName c.constitution) "same-composition-and-connectivity") then "They are not stereoisomers." else
  if !(SFT.Host.Text.equal (superpositionName c.superposition) "non-superposable-pair") then "No stereochemical distinction remains." else
  if !(SFT.Host.Text.equal (mirrorName c.mirror) "not-mirror-related") then "That pair is enantiomeric." else
  if !(SFT.Host.Text.equal (configurationName c.configuration) "complete-relative-configurations-held") then "The difference is unreproducible." else
  if !(SFT.Host.Text.equal (propertiesName c.properties) "property-distinction-open") then "Non-mirror structures need not share response." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-pair-classification-trace") then "The exclusions cannot be checked." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A taxonomy can select the answer." else
  "paired-stereoisomers__same-composition-and-connectivity__non-superposable-pair__not-mirror-related__complete-relative-configurations-held"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite equal-constitution oriented molecular pair with exhaustive identity, reflection and proper-superposition classifications."

def candidates : List Candidate :=
  ([Members.rejected,Members.admitted]).flatMap fun members =>
  ([Constitution.rejected,Constitution.admitted]).flatMap fun constitution =>
  ([Superposition.rejected,Superposition.admitted]).flatMap fun superposition =>
  ([Mirror.rejected,Mirror.admitted]).flatMap fun mirror =>
  ([Configuration.rejected,Configuration.admitted]).flatMap fun configuration =>
  ([Properties.rejected,Properties.admitted]).flatMap fun properties =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨members,constitution,superposition,mirror,configuration,properties,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk members constitution superposition mirror configuration properties record extra =>
    have hmembers : members ∈ [Members.rejected,Members.admitted] := by
      cases members <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstitution : constitution ∈ [Constitution.rejected,Constitution.admitted] := by
      cases constitution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuperposition : superposition ∈ [Superposition.rejected,Superposition.admitted] := by
      cases superposition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmirror : mirror ∈ [Mirror.rejected,Mirror.admitted] := by
      cases mirror <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconfiguration : configuration ∈ [Configuration.rejected,Configuration.admitted] := by
      cases configuration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproperties : properties ∈ [Properties.rejected,Properties.admitted] := by
      cases properties <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ members _ hmembers
    apply CommonRefinement.memFlatMap _ _ constitution _ hconstitution
    apply CommonRefinement.memFlatMap _ _ superposition _ hsuperposition
    apply CommonRefinement.memFlatMap _ _ mirror _ hmirror
    apply CommonRefinement.memFlatMap _ _ configuration _ hconfiguration
    apply CommonRefinement.memFlatMap _ _ properties _ hproperties
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk members constitution superposition mirror configuration properties record extra =>
    cases members <;> cases constitution <;> cases superposition <;> cases mirror <;> cases configuration <;> cases properties <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk members constitution superposition mirror configuration properties record extra =>
    cases members <;> cases constitution <;> cases superposition <;> cases mirror <;> cases configuration <;> cases properties <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.members = .admitted ∧ c.constitution = .admitted ∧ c.superposition = .admitted ∧ c.mirror = .admitted ∧ c.configuration = .admitted ∧ c.properties = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk members constitution superposition mirror configuration properties record extra =>
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

theorem superposition_rejected_rejected (c : Candidate) (h : c.superposition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.superposition eq
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

theorem configuration_rejected_rejected (c : Candidate) (h : c.configuration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.configuration eq
    rw [h] at field
    cases field

theorem properties_rejected_rejected (c : Candidate) (h : c.properties = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.properties eq
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

end SFT.Chemistry.DiastereomerGrammar
