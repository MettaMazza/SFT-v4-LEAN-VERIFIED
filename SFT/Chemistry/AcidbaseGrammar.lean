import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AcidbaseGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Pair where
  | rejected | admitted

def pairName : Pair → String
  | .rejected => "one-species-label"
  | .admitted => "two-conjugate-identities"

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "anonymous-hydrogen-count"
  | .admitted => "one-held-proton-occurrence"

inductive AcidRole where
  | rejected | admitted

def acidRoleName : AcidRole → String
  | .rejected => "acid-by-name"
  | .admitted => "proton-donor-role"

inductive BaseRole where
  | rejected | admitted

def baseRoleName : BaseRole → String
  | .rejected => "base-by-name"
  | .admitted => "proton-acceptor-role"

inductive Difference where
  | rejected | admitted

def differenceName : Difference → String
  | .rejected => "unbounded-composition-change"
  | .admitted => "differ-by-one-proton"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-acidity-scalar"
  | .admitted => "held-donor-acceptor-orientation"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "acid-base-answer-only"
  | .admitted => "pair-and-proton-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-acid-base-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  pair : Pair
  carrier : Carrier
  acidRole : AcidRole
  baseRole : BaseRole
  difference : Difference
  orientation : Orientation
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [pairName c.pair, carrierName c.carrier, acidRoleName c.acidRole, baseRoleName c.baseRole, differenceName c.difference, orientationName c.orientation, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "pair=" (pairName c.pair), SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "acid-role=" (acidRoleName c.acidRole), SFT.Host.Text.append "base-role=" (baseRoleName c.baseRole), SFT.Host.Text.append "difference=" (differenceName c.difference), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "two-conjugate-identities__one-held-proton-occurrence__proton-donor-role__proton-acceptor-role__differ-by-one-proton__held-donor-acceptor-orientation__pair-and-proton-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (pairName c.pair) "two-conjugate-identities" &&
  SFT.Host.Text.equal (carrierName c.carrier) "one-held-proton-occurrence" &&
  SFT.Host.Text.equal (acidRoleName c.acidRole) "proton-donor-role" &&
  SFT.Host.Text.equal (baseRoleName c.baseRole) "proton-acceptor-role" &&
  SFT.Host.Text.equal (differenceName c.difference) "differ-by-one-proton" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-donor-acceptor-orientation" &&
  SFT.Host.Text.equal (recordName c.record) "pair-and-proton-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (pairName c.pair) "two-conjugate-identities") then "A conjugate relation compares two carrier identities." else
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-held-proton-occurrence") then "A count cannot trace the transferred occurrence." else
  if !(SFT.Host.Text.equal (acidRoleName c.acidRole) "proton-donor-role") then "A name cannot establish a transition." else
  if !(SFT.Host.Text.equal (baseRoleName c.baseRole) "proton-acceptor-role") then "A name cannot establish a transition." else
  if !(SFT.Host.Text.equal (differenceName c.difference) "differ-by-one-proton") then "Additional changes destroy conjugacy." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-donor-acceptor-orientation") then "A signed scalar is not a carrier trace." else
  if !(SFT.Host.Text.equal (recordName c.record) "pair-and-proton-trace") then "An answer cannot reconstruct conjugacy." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can label arbitrary species." else
  "two-conjugate-identities__one-held-proton-occurrence__proton-donor-role__proton-acceptor-role__differ-by-one-proton"

def generationRule : String := "Generate the literal product of the registered conjugate pair, carrier, acid role, base role, difference, orientation, record and extension choices."
def grammarBoundary : String := "Every finite generated pair of chemical carriers related by exactly one retained proton occurrence, with the protonated member able to donate that occurrence and the deprotonated member able to accept it."

def candidates : List Candidate :=
  ([Pair.rejected,Pair.admitted]).flatMap fun pair =>
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([AcidRole.rejected,AcidRole.admitted]).flatMap fun acidRole =>
  ([BaseRole.rejected,BaseRole.admitted]).flatMap fun baseRole =>
  ([Difference.rejected,Difference.admitted]).flatMap fun difference =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨pair,carrier,acidRole,baseRole,difference,orientation,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk pair carrier acidRole baseRole difference orientation record extension =>
    have hpair : pair ∈ [Pair.rejected,Pair.admitted] := by
      cases pair <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacidRole : acidRole ∈ [AcidRole.rejected,AcidRole.admitted] := by
      cases acidRole <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbaseRole : baseRole ∈ [BaseRole.rejected,BaseRole.admitted] := by
      cases baseRole <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdifference : difference ∈ [Difference.rejected,Difference.admitted] := by
      cases difference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ pair _ hpair
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ acidRole _ hacidRole
    apply CommonRefinement.memFlatMap _ _ baseRole _ hbaseRole
    apply CommonRefinement.memFlatMap _ _ difference _ hdifference
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk pair carrier acidRole baseRole difference orientation record extension =>
    cases pair <;> cases carrier <;> cases acidRole <;> cases baseRole <;> cases difference <;> cases orientation <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk pair carrier acidRole baseRole difference orientation record extension =>
    cases pair <;> cases carrier <;> cases acidRole <;> cases baseRole <;> cases difference <;> cases orientation <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.pair = .admitted ∧ c.carrier = .admitted ∧ c.acidRole = .admitted ∧ c.baseRole = .admitted ∧ c.difference = .admitted ∧ c.orientation = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk pair carrier acidRole baseRole difference orientation record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem pair_rejected_rejected (c : Candidate) (h : c.pair = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pair eq
    rw [h] at field
    cases field

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem acidRole_rejected_rejected (c : Candidate) (h : c.acidRole = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.acidRole eq
    rw [h] at field
    cases field

theorem baseRole_rejected_rejected (c : Candidate) (h : c.baseRole = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.baseRole eq
    rw [h] at field
    cases field

theorem difference_rejected_rejected (c : Candidate) (h : c.difference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.difference eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.AcidbaseGrammar
