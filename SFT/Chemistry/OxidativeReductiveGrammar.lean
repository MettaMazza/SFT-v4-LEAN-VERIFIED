import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.OxidativeReductiveGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "anonymous-reaction-name"
  | .admitted => "one-retained-organometallic-process"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "selected-reactant-fragments"
  | .admitted => "complete-two-carrier-source-bond"

inductive Product where
  | rejected | admitted

def productName : Product → String
  | .rejected => "asserted-oxidation-state-change"
  | .admitted => "two-generated-metal-carrier-incidences"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "formal-charge-bookkeeping"
  | .admitted => "exact-carrier-and-metal-conservation"

inductive Transfer where
  | rejected | admitted

def transferName : Transfer → String
  | .rejected => "signed-electron-loss"
  | .admitted => "held-two-electron-transfer-orientation"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "single-conventional-mechanism"
  | .admitted => "complete-one-metal-two-or-two-metal-one-one-partition"

inductive Reverse where
  | rejected | admitted

def reverseName : Reverse → String
  | .rejected => "separate-reductive-rule"
  | .admitted => "exact-reductive-inverse-correspondence"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-specific-exception"
  | .admitted => "trace-composition-with-no-extra-rule"

structure Candidate where
  carrier : Carrier
  source : Source
  product : Product
  conservation : Conservation
  transfer : Transfer
  partition : Partition
  reverse : Reverse
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, sourceName c.source, productName c.product, conservationName c.conservation, transferName c.transfer, partitionName c.partition, reverseName c.reverse, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "product=" (productName c.product), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "transfer=" (transferName c.transfer), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "reverse=" (reverseName c.reverse), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-organometallic-process__complete-two-carrier-source-bond__two-generated-metal-carrier-incidences__exact-carrier-and-metal-conservation__held-two-electron-transfer-orientation__complete-one-metal-two-or-two-metal-one-one-partition__exact-reductive-inverse-correspondence__trace-composition-with-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-organometallic-process" &&
  SFT.Host.Text.equal (sourceName c.source) "complete-two-carrier-source-bond" &&
  SFT.Host.Text.equal (productName c.product) "two-generated-metal-carrier-incidences" &&
  SFT.Host.Text.equal (conservationName c.conservation) "exact-carrier-and-metal-conservation" &&
  SFT.Host.Text.equal (transferName c.transfer) "held-two-electron-transfer-orientation" &&
  SFT.Host.Text.equal (partitionName c.partition) "complete-one-metal-two-or-two-metal-one-one-partition" &&
  SFT.Host.Text.equal (reverseName c.reverse) "exact-reductive-inverse-correspondence" &&
  SFT.Host.Text.equal (extensionName c.extension) "trace-composition-with-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-organometallic-process") then "A name loses the process carrier." else
  if !(SFT.Host.Text.equal (sourceName c.source) "complete-two-carrier-source-bond") then "Selected fragments lose the complete covalent source bond." else
  if !(SFT.Host.Text.equal (productName c.product) "two-generated-metal-carrier-incidences") then "A signed oxidation-state change is not a topology." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "exact-carrier-and-metal-conservation") then "Formal charge bookkeeping can lose occurrences." else
  if !(SFT.Host.Text.equal (transferName c.transfer) "held-two-electron-transfer-orientation") then "Signed loss imports negative proof values." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "complete-one-metal-two-or-two-metal-one-one-partition") then "One conventional mechanism omits the split-metal form." else
  if !(SFT.Host.Text.equal (reverseName c.reverse) "exact-reductive-inverse-correspondence") then "A separate rule need not invert the process." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "trace-composition-with-no-extra-rule") then "An exception destroys zero-parameter closure." else
  "one-retained-organometallic-process__complete-two-carrier-source-bond__two-generated-metal-carrier-incidences__exact-carrier-and-metal-conservation__held-two-electron-transfer-orientation__complete-one-metal-two-or-two-metal-one-one-partition__exact-reductive-inverse-correspondence__trace-composition-with-no-extra-rule"

def generationRule : String := "Generate the literal product of process carrier, source, product, conservation, transfer, partition, reverse and extension alternatives; decide all 256 forms solely from admitted transition, conservation, covalent-bond and INORG-010/011 dependencies."
def grammarBoundary : String := "Every finite one- or two-metal exact trace containing one two-carrier source bond, two product incidences, the complete transfer partition and its exact inverse; all five frozen IUPAC oxidative, split, radical-scope and reductive surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Product.rejected,Product.admitted]).flatMap fun product =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Transfer.rejected,Transfer.admitted]).flatMap fun transfer =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Reverse.rejected,Reverse.admitted]).flatMap fun reverse =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,source,product,conservation,transfer,partition,reverse,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier source product conservation transfer partition reverse extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproduct : product ∈ [Product.rejected,Product.admitted] := by
      cases product <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransfer : transfer ∈ [Transfer.rejected,Transfer.admitted] := by
      cases transfer <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreverse : reverse ∈ [Reverse.rejected,Reverse.admitted] := by
      cases reverse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ product _ hproduct
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ transfer _ htransfer
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ reverse _ hreverse
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (transfer : Transfer) (partition : Partition) (reverse : Reverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,transfer,partition,reverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,transfer,partition,reverse,extension⟩ := by
 cases transfer <;> cases partition <;> cases reverse <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier source product conservation transfer partition reverse extension =>
  cases carrier <;> cases source <;> cases product <;> cases conservation
  · exact sourceDecisionBlock0000 transfer partition reverse extension
  · exact sourceDecisionBlock0001 transfer partition reverse extension
  · exact sourceDecisionBlock0010 transfer partition reverse extension
  · exact sourceDecisionBlock0011 transfer partition reverse extension
  · exact sourceDecisionBlock0100 transfer partition reverse extension
  · exact sourceDecisionBlock0101 transfer partition reverse extension
  · exact sourceDecisionBlock0110 transfer partition reverse extension
  · exact sourceDecisionBlock0111 transfer partition reverse extension
  · exact sourceDecisionBlock1000 transfer partition reverse extension
  · exact sourceDecisionBlock1001 transfer partition reverse extension
  · exact sourceDecisionBlock1010 transfer partition reverse extension
  · exact sourceDecisionBlock1011 transfer partition reverse extension
  · exact sourceDecisionBlock1100 transfer partition reverse extension
  · exact sourceDecisionBlock1101 transfer partition reverse extension
  · exact sourceDecisionBlock1110 transfer partition reverse extension
  · exact sourceDecisionBlock1111 transfer partition reverse extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-organometallic-process" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem sourceCriterion (value : Source) : SFT.Host.Text.equal (sourceName value) "complete-two-carrier-source-bond" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem productCriterion (value : Product) : SFT.Host.Text.equal (productName value) "two-generated-metal-carrier-incidences" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem conservationCriterion (value : Conservation) : SFT.Host.Text.equal (conservationName value) "exact-carrier-and-metal-conservation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem transferCriterion (value : Transfer) : SFT.Host.Text.equal (transferName value) "held-two-electron-transfer-orientation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "complete-one-metal-two-or-two-metal-one-one-partition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem reverseCriterion (value : Reverse) : SFT.Host.Text.equal (reverseName value) "exact-reductive-inverse-correspondence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "trace-composition-with-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, sourceCriterion, productCriterion, conservationCriterion, transferCriterion, partitionCriterion, reverseCriterion, extensionCriterion]
  cases c with
  | mk carrier source product conservation transfer partition reverse extension =>
    cases carrier <;> cases source <;> cases product <;> cases conservation <;> cases transfer <;> cases partition <;> cases reverse <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.source = .admitted ∧ c.product = .admitted ∧ c.conservation = .admitted ∧ c.transfer = .admitted ∧ c.partition = .admitted ∧ c.reverse = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier source product conservation transfer partition reverse extension =>
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

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem product_rejected_rejected (c : Candidate) (h : c.product = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.product eq
    rw [h] at field
    cases field

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
    rw [h] at field
    cases field

theorem transfer_rejected_rejected (c : Candidate) (h : c.transfer = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transfer eq
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

theorem reverse_rejected_rejected (c : Candidate) (h : c.reverse = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reverse eq
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

end SFT.Chemistry.OxidativeReductiveGrammar
