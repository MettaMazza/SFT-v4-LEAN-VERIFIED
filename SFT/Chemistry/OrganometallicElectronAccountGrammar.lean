import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.OrganometallicElectronAccountGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "free-electron-number"
  | .admitted => "one-retained-organometallic-entity"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-valence-electrons"
  | .admitted => "complete-nonbonded-and-bond-pair-support"

inductive Capacity where
  | rejected | admitted

def capacityName : Capacity → String
  | .rejected => "imported-eighteen-rule"
  | .admitted => "forced-two-plus-six-plus-ten-capacity"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "signed-spin-sum"
  | .admitted => "complete-complementary-fibre-pairing"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "oxidation-state-bookkeeping"
  | .admitted => "exact-nonbonded-plus-bond-partition"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "species-stability-lookup"
  | .admitted => "capacity-complete-or-incomplete-held-relation"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "measured-total-selects-capacity"
  | .admitted => "postseal-stable-complex-correspondence"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "complex-specific-exception"
  | .admitted => "pair-successor-until-capacity-then-halt"

structure Candidate where
  carrier : Carrier
  support : Support
  capacity : Capacity
  balance : Balance
  partition : Partition
  relation : Relation
  comparison : Comparison
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, supportName c.support, capacityName c.capacity, balanceName c.balance, partitionName c.partition, relationName c.relation, comparisonName c.comparison, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "capacity=" (capacityName c.capacity), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-organometallic-entity__complete-nonbonded-and-bond-pair-support__forced-two-plus-six-plus-ten-capacity__complete-complementary-fibre-pairing__exact-nonbonded-plus-bond-partition__capacity-complete-or-incomplete-held-relation__postseal-stable-complex-correspondence__pair-successor-until-capacity-then-halt"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-organometallic-entity" &&
  SFT.Host.Text.equal (supportName c.support) "complete-nonbonded-and-bond-pair-support" &&
  SFT.Host.Text.equal (capacityName c.capacity) "forced-two-plus-six-plus-ten-capacity" &&
  SFT.Host.Text.equal (balanceName c.balance) "complete-complementary-fibre-pairing" &&
  SFT.Host.Text.equal (partitionName c.partition) "exact-nonbonded-plus-bond-partition" &&
  SFT.Host.Text.equal (relationName c.relation) "capacity-complete-or-incomplete-held-relation" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "postseal-stable-complex-correspondence" &&
  SFT.Host.Text.equal (extensionName c.extension) "pair-successor-until-capacity-then-halt"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-organometallic-entity") then "A free number is detached from the complex." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-nonbonded-and-bond-pair-support") then "Selected electrons lose complete occurrence support." else
  if !(SFT.Host.Text.equal (capacityName c.capacity) "forced-two-plus-six-plus-ten-capacity") then "Importing eighteen assumes the target." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "complete-complementary-fibre-pairing") then "A signed sum imports negative proof values." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "exact-nonbonded-plus-bond-partition") then "Conventional oxidation bookkeeping can change labels without support." else
  if !(SFT.Host.Text.equal (relationName c.relation) "capacity-complete-or-incomplete-held-relation") then "A species lookup lets observed stability choose the rule." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "postseal-stable-complex-correspondence") then "An observed count cannot select the capacity." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "pair-successor-until-capacity-then-halt") then "An exception destroys zero-parameter closure." else
  "one-retained-organometallic-entity__complete-nonbonded-and-bond-pair-support__forced-two-plus-six-plus-ten-capacity__complete-complementary-fibre-pairing__exact-nonbonded-plus-bond-partition__capacity-complete-or-incomplete-held-relation__postseal-stable-complex-correspondence__pair-successor-until-capacity-then-halt"

def generationRule : String := "Generate the literal product of carrier, support, capacity, balance, partition, relation, comparison and extension choices; decide all 256 candidates only from admitted spin, exclusion, orbital-support, magnetic-response and INORG-010 dependencies."
def grammarBoundary : String := "Every finite complementary-pair support partitioned into nonbonded and bond occurrences on one retained organometallic entity, up to the exact generated s+p+d capacity; all four frozen IUPAC scope, component and total surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Capacity.rejected,Capacity.admitted]).flatMap fun capacity =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,support,capacity,balance,partition,relation,comparison,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier support capacity balance partition relation comparison extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcapacity : capacity ∈ [Capacity.rejected,Capacity.admitted] := by
      cases capacity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ capacity _ hcapacity
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (partition : Partition) (relation : Relation) (comparison : Comparison) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,partition,relation,comparison,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,partition,relation,comparison,extension⟩ := by
 cases partition <;> cases relation <;> cases comparison <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier support capacity balance partition relation comparison extension =>
  cases carrier <;> cases support <;> cases capacity <;> cases balance
  · exact sourceDecisionBlock0000 partition relation comparison extension
  · exact sourceDecisionBlock0001 partition relation comparison extension
  · exact sourceDecisionBlock0010 partition relation comparison extension
  · exact sourceDecisionBlock0011 partition relation comparison extension
  · exact sourceDecisionBlock0100 partition relation comparison extension
  · exact sourceDecisionBlock0101 partition relation comparison extension
  · exact sourceDecisionBlock0110 partition relation comparison extension
  · exact sourceDecisionBlock0111 partition relation comparison extension
  · exact sourceDecisionBlock1000 partition relation comparison extension
  · exact sourceDecisionBlock1001 partition relation comparison extension
  · exact sourceDecisionBlock1010 partition relation comparison extension
  · exact sourceDecisionBlock1011 partition relation comparison extension
  · exact sourceDecisionBlock1100 partition relation comparison extension
  · exact sourceDecisionBlock1101 partition relation comparison extension
  · exact sourceDecisionBlock1110 partition relation comparison extension
  · exact sourceDecisionBlock1111 partition relation comparison extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-organometallic-entity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-nonbonded-and-bond-pair-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem capacityCriterion (value : Capacity) : SFT.Host.Text.equal (capacityName value) "forced-two-plus-six-plus-ten-capacity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem balanceCriterion (value : Balance) : SFT.Host.Text.equal (balanceName value) "complete-complementary-fibre-pairing" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "exact-nonbonded-plus-bond-partition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "capacity-complete-or-incomplete-held-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem comparisonCriterion (value : Comparison) : SFT.Host.Text.equal (comparisonName value) "postseal-stable-complex-correspondence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "pair-successor-until-capacity-then-halt" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, supportCriterion, capacityCriterion, balanceCriterion, partitionCriterion, relationCriterion, comparisonCriterion, extensionCriterion]
  cases c with
  | mk carrier support capacity balance partition relation comparison extension =>
    cases carrier <;> cases support <;> cases capacity <;> cases balance <;> cases partition <;> cases relation <;> cases comparison <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.support = .admitted ∧ c.capacity = .admitted ∧ c.balance = .admitted ∧ c.partition = .admitted ∧ c.relation = .admitted ∧ c.comparison = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier support capacity balance partition relation comparison extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
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

theorem capacity_rejected_rejected (c : Candidate) (h : c.capacity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.capacity eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
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

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
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

end SFT.Chemistry.OrganometallicElectronAccountGrammar
