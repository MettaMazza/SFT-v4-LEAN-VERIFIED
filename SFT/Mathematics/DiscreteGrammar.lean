import SFT.Mathematics.DiscreteRelations
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.DiscreteGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Collection where
  | rejected | admitted

def collectionName : Collection → String
  | .rejected => "partial-or-duplicated"
  | .admitted => "complete-unique-trace"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "presentation-alias"
  | .admitted => "canonical-form-identity"

inductive Membership where
  | rejected | admitted

def membershipName : Membership → String
  | .rejected => "unrecorded-assertion"
  | .admitted => "retained-occurrence"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "free-pair-list"
  | .admitted => "held-pair-cell-selection"

inductive Map where
  | rejected | admitted

def mapName : Map → String
  | .rejected => "partial-or-multivalued"
  | .admitted => "total-single-valued"

inductive Sequence where
  | rejected | admitted

def sequenceName : Sequence → String
  | .rejected => "unordered-carrier"
  | .admitted => "held-generation-order"

inductive Induction where
  | rejected | admitted

def inductionName : Induction → String
  | .rejected => "sampled-depths"
  | .admitted => "One-base-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-constructor"
  | .admitted => "no-extra-constructor"

structure Candidate where
  collection : Collection
  identity : Identity
  membership : Membership
  relation : Relation
  map : Map
  sequence : Sequence
  induction : Induction
  addition : Addition

def sourceFields (c : Candidate) : List String := [collectionName c.collection, identityName c.identity, membershipName c.membership, relationName c.relation, mapName c.map, sequenceName c.sequence, inductionName c.induction, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "collection=" (collectionName c.collection), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "membership=" (membershipName c.membership), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "map=" (mapName c.map), SFT.Host.Text.append "sequence=" (sequenceName c.sequence), SFT.Host.Text.append "induction=" (inductionName c.induction), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-unique-trace__canonical-form-identity__retained-occurrence__held-pair-cell-selection__total-single-valued__held-generation-order__One-base-successor__no-extra-constructor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (collectionName c.collection) "complete-unique-trace" &&
  SFT.Host.Text.equal (identityName c.identity) "canonical-form-identity" &&
  SFT.Host.Text.equal (membershipName c.membership) "retained-occurrence" &&
  SFT.Host.Text.equal (relationName c.relation) "held-pair-cell-selection" &&
  SFT.Host.Text.equal (mapName c.map) "total-single-valued" &&
  SFT.Host.Text.equal (sequenceName c.sequence) "held-generation-order" &&
  SFT.Host.Text.equal (inductionName c.induction) "One-base-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-constructor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (collectionName c.collection) "complete-unique-trace") then "Omission or duplication changes the generated collection trace." else
  if !(SFT.Host.Text.equal (identityName c.identity) "canonical-form-identity") then "Presentation names can merge distinct forms or split one form." else
  if !(SFT.Host.Text.equal (membershipName c.membership) "retained-occurrence") then "An unrecorded assertion has no source-bound occurrence witness." else
  if !(SFT.Host.Text.equal (relationName c.relation) "held-pair-cell-selection") then "A free pair list has no complete source-product boundary." else
  if !(SFT.Host.Text.equal (mapName c.map) "total-single-valued") then "A missing or repeated image does not define one image for every source member." else
  if !(SFT.Host.Text.equal (sequenceName c.sequence) "held-generation-order") then "An unordered carrier erases the generated predecessor relation." else
  if !(SFT.Host.Text.equal (inductionName c.induction) "One-base-successor") then "Sampled depths do not establish the successor step." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-constructor") then "An extra constructor is not supplied by the Foundation grammar." else
  "The discrete kernel is complete unique canonical collections with retained membership, pair-cell-selected relations, total single-valued maps, held sequence order, One/base-successor induction and no extra constructor."

def generationRule : String := "Generate the complete product of collection coverage, canonical identity, membership, relation support, map law, sequence order, induction closure and extra-constructor status."
def grammarBoundary : String := "All discrete structures generated from finite canonical One/Fold forms, exact positive traces, held selections, pair-cell relations and successor construction."

def candidates : List Candidate :=
  ([Collection.rejected,Collection.admitted]).flatMap fun collection =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Membership.rejected,Membership.admitted]).flatMap fun membership =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Map.rejected,Map.admitted]).flatMap fun map =>
  ([Sequence.rejected,Sequence.admitted]).flatMap fun sequence =>
  ([Induction.rejected,Induction.admitted]).flatMap fun induction =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨collection,identity,membership,relation,map,sequence,induction,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk collection identity membership relation map sequence induction addition =>
    have hcollection : collection ∈ [Collection.rejected,Collection.admitted] := by
      cases collection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmembership : membership ∈ [Membership.rejected,Membership.admitted] := by
      cases membership <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmap : map ∈ [Map.rejected,Map.admitted] := by
      cases map <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsequence : sequence ∈ [Sequence.rejected,Sequence.admitted] := by
      cases sequence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinduction : induction ∈ [Induction.rejected,Induction.admitted] := by
      cases induction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ collection _ hcollection
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ membership _ hmembership
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ map _ hmap
    apply CommonRefinement.memFlatMap _ _ sequence _ hsequence
    apply CommonRefinement.memFlatMap _ _ induction _ hinduction
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk collection identity membership relation map sequence induction addition =>
    cases collection <;> cases identity <;> cases membership <;> cases relation <;> cases map <;> cases sequence <;> cases induction <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk collection identity membership relation map sequence induction addition =>
    cases collection <;> cases identity <;> cases membership <;> cases relation <;> cases map <;> cases sequence <;> cases induction <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.collection = .admitted ∧ c.identity = .admitted ∧ c.membership = .admitted ∧ c.relation = .admitted ∧ c.map = .admitted ∧ c.sequence = .admitted ∧ c.induction = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk collection identity membership relation map sequence induction addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem collection_rejected_rejected (c : Candidate) (h : c.collection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.collection eq
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

theorem membership_rejected_rejected (c : Candidate) (h : c.membership = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.membership eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem map_rejected_rejected (c : Candidate) (h : c.map = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.map eq
    rw [h] at field
    cases field

theorem sequence_rejected_rejected (c : Candidate) (h : c.sequence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sequence eq
    rw [h] at field
    cases field

theorem induction_rejected_rejected (c : Candidate) (h : c.induction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.induction eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Mathematics.DiscreteGrammar
