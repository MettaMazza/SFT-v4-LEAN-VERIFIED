import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.IsomerGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Pair where
  | rejected | admitted

def pairName : Pair → String
  | .rejected => "single-carrier-description"
  | .admitted => "two-identified-carriers"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "different-compositions"
  | .admitted => "equal-exact-composition"

inductive Structure where
  | rejected | admitted

def structureName : Structure → String
  | .rejected => "formula-equated-identity"
  | .admitted => "complete-structure-signatures"

inductive Equivalence where
  | rejected | admitted

def equivalenceName : Equivalence → String
  | .rejected => "name-string-inequality"
  | .admitted => "all-identity-preserving-relabelings"

inductive Distinction where
  | rejected | admitted

def distinctionName : Distinction → String
  | .rejected => "equivalent-signatures"
  | .admitted => "connectivity-or-orientation-difference"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "distinction-erased"
  | .admitted => "separate-chemical-identities"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "isomer-label-only"
  | .admitted => "composition-and-structure-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-isomer-class"
  | .admitted => "no-extra-rule"

structure Candidate where
  pair : Pair
  composition : Composition
  structural : Structure
  equivalence : Equivalence
  distinction : Distinction
  identity : Identity
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [pairName c.pair, compositionName c.composition, structureName c.structural, equivalenceName c.equivalence, distinctionName c.distinction, identityName c.identity, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "pair=" (pairName c.pair), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "structure=" (structureName c.structural), SFT.Host.Text.append "equivalence=" (equivalenceName c.equivalence), SFT.Host.Text.append "distinction=" (distinctionName c.distinction), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "two-identified-carriers__equal-exact-composition__complete-structure-signatures__all-identity-preserving-relabelings__connectivity-or-orientation-difference__separate-chemical-identities__composition-and-structure-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (pairName c.pair) "two-identified-carriers" &&
  SFT.Host.Text.equal (compositionName c.composition) "equal-exact-composition" &&
  SFT.Host.Text.equal (structureName c.structural) "complete-structure-signatures" &&
  SFT.Host.Text.equal (equivalenceName c.equivalence) "all-identity-preserving-relabelings" &&
  SFT.Host.Text.equal (distinctionName c.distinction) "connectivity-or-orientation-difference" &&
  SFT.Host.Text.equal (identityName c.identity) "separate-chemical-identities" &&
  SFT.Host.Text.equal (recordName c.record) "composition-and-structure-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (pairName c.pair) "two-identified-carriers") then "Isomerism compares at least two chemical carriers." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "equal-exact-composition") then "Different composition is not isomerism." else
  if !(SFT.Host.Text.equal (structureName c.structural) "complete-structure-signatures") then "A formula does not exhaust bonded organization." else
  if !(SFT.Host.Text.equal (equivalenceName c.equivalence) "all-identity-preserving-relabelings") then "Different names can denote the same structure." else
  if !(SFT.Host.Text.equal (distinctionName c.distinction) "connectivity-or-orientation-difference") then "Equivalent complete signatures denote the same isomeric form." else
  if !(SFT.Host.Text.equal (identityName c.identity) "separate-chemical-identities") then "Erasing the difference destroys the chemical question." else
  if !(SFT.Host.Text.equal (recordName c.record) "composition-and-structure-trace") then "A label cannot reproduce equality and difference." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A free class label can manufacture a distinction." else
  "two-identified-carriers__equal-exact-composition__complete-structure-signatures__all-identity-preserving-relabelings__connectivity-or-orientation-difference"

def generationRule : String := "Generate the literal product of the registered isomer pair, composition, structure, equivalence, distinction, identity, record and extension choices."
def grammarBoundary : String := "Every finite pair of admitted chemical carriers with exactly equal composition signatures but unequal complete connectivity or held-orientation signatures after every identity-preserving relabelling."

def candidates : List Candidate :=
  ([Pair.rejected,Pair.admitted]).flatMap fun pair =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Structure.rejected,Structure.admitted]).flatMap fun structural =>
  ([Equivalence.rejected,Equivalence.admitted]).flatMap fun equivalence =>
  ([Distinction.rejected,Distinction.admitted]).flatMap fun distinction =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨pair,composition,structural,equivalence,distinction,identity,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk pair composition structural equivalence distinction identity record extension =>
    have hpair : pair ∈ [Pair.rejected,Pair.admitted] := by
      cases pair <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstructure : structural ∈ [Structure.rejected,Structure.admitted] := by
      cases structural <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequivalence : equivalence ∈ [Equivalence.rejected,Equivalence.admitted] := by
      cases equivalence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistinction : distinction ∈ [Distinction.rejected,Distinction.admitted] := by
      cases distinction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ pair _ hpair
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ structural _ hstructure
    apply CommonRefinement.memFlatMap _ _ equivalence _ hequivalence
    apply CommonRefinement.memFlatMap _ _ distinction _ hdistinction
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk pair composition structural equivalence distinction identity record extension =>
    cases pair <;> cases composition <;> cases structural <;> cases equivalence <;> cases distinction <;> cases identity <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk pair composition structural equivalence distinction identity record extension =>
    cases pair <;> cases composition <;> cases structural <;> cases equivalence <;> cases distinction <;> cases identity <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.pair = .admitted ∧ c.composition = .admitted ∧ c.structural = .admitted ∧ c.equivalence = .admitted ∧ c.distinction = .admitted ∧ c.identity = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk pair composition structural equivalence distinction identity record extension =>
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem structure_rejected_rejected (c : Candidate) (h : c.structural = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.structural eq
    rw [h] at field
    cases field

theorem equivalence_rejected_rejected (c : Candidate) (h : c.equivalence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equivalence eq
    rw [h] at field
    cases field

theorem distinction_rejected_rejected (c : Candidate) (h : c.distinction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distinction eq
    rw [h] at field
    cases field

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
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

end SFT.Chemistry.IsomerGrammar
