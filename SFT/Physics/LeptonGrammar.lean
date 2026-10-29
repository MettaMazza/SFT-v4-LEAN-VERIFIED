import SFT.Physics.LeptonLedger
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.LeptonGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "three-names-without-joint-invariants"
  | .admitted => "one-complete-symmetric-three-root-carrier"

inductive Generator where
  | rejected | admitted

def generatorName : Generator → String
  | .rejected => "selected-three"
  | .admitted => "admitted-generator-three"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "unnormalized-root-sum"
  | .admitted => "root-sum-is-the-One"

inductive Pair where
  | rejected0 | admitted | rejected2

def pairName : Pair → String
  | .rejected0 => "one-over-colour"
  | .admitted => "one-over-two-colour"
  | .rejected2 => "one-over-colour-square"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "colour-fourth-power"
  | .admitted => "twice-colour-fifth-power"

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "support-count-itself"
  | .admitted => "positive-predecessor-of-support"

inductive Channel where
  | rejected0 | admitted | rejected2

def channelName : Channel → String
  | .rejected0 => "binary-channel"
  | .admitted => "colour-channel"
  | .rejected2 => "successor-channel"

inductive Sharpening where
  | rejected | admitted

def sharpeningName : Sharpening → String
  | .rejected => "add-channel-whole"
  | .admitted => "positive-take-one-channel-part"

inductive Roots where
  | rejected | admitted

def rootsName : Roots → String
  | .rejected => "solve-and-round-roots"
  | .admitted => "retain-exact-symmetric-invariants"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-coefficient-or-measured-selector"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  generator : Generator
  partition : Partition
  pair : Pair
  support : Support
  predecessor : Predecessor
  channel : Channel
  sharpening : Sharpening
  roots : Roots
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, generatorName c.generator, partitionName c.partition, pairName c.pair, supportName c.support, predecessorName c.predecessor, channelName c.channel, sharpeningName c.sharpening, rootsName c.roots, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "generator=" (generatorName c.generator), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "pair=" (pairName c.pair), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "channel=" (channelName c.channel), SFT.Host.Text.append "sharpening=" (sharpeningName c.sharpening), SFT.Host.Text.append "roots=" (rootsName c.roots), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-complete-symmetric-three-root-carrier__admitted-generator-three__root-sum-is-the-One__one-over-two-colour__twice-colour-fifth-power__positive-predecessor-of-support__colour-channel__positive-take-one-channel-part__retain-exact-symmetric-invariants__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-complete-symmetric-three-root-carrier" &&
  SFT.Host.Text.equal (generatorName c.generator) "admitted-generator-three" &&
  SFT.Host.Text.equal (partitionName c.partition) "root-sum-is-the-One" &&
  SFT.Host.Text.equal (pairName c.pair) "one-over-two-colour" &&
  SFT.Host.Text.equal (supportName c.support) "twice-colour-fifth-power" &&
  SFT.Host.Text.equal (predecessorName c.predecessor) "positive-predecessor-of-support" &&
  SFT.Host.Text.equal (channelName c.channel) "colour-channel" &&
  SFT.Host.Text.equal (sharpeningName c.sharpening) "positive-take-one-channel-part" &&
  SFT.Host.Text.equal (rootsName c.roots) "retain-exact-symmetric-invariants" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "three-names-without-joint-invariants" then "Names do not retain one cubic relation." else
  if SFT.Host.Text.equal (generatorName c.generator) "selected-three" then "A familiar generation count cannot be assumed." else
  if SFT.Host.Text.equal (partitionName c.partition) "unnormalized-root-sum" then "An unnormalized sum adds a free scale." else
  if SFT.Host.Text.equal (pairName c.pair) "one-over-colour" then "This omits the two Fold fibres." else
  if SFT.Host.Text.equal (pairName c.pair) "one-over-colour-square" then "This substitutes a colour pair for the Fold-fibre pairing." else
  if SFT.Host.Text.equal (supportName c.support) "colour-fourth-power" then "This stops before the complete fifth colour succession." else
  if SFT.Host.Text.equal (predecessorName c.predecessor) "support-count-itself" then "The complete support retains the terminal One rather than the massive interior." else
  if SFT.Host.Text.equal (channelName c.channel) "binary-channel" then "The binary channel is not the carrier's generator identity." else
  if SFT.Host.Text.equal (channelName c.channel) "successor-channel" then "The successor channel adds an ungenerated carrier role." else
  if SFT.Host.Text.equal (sharpeningName c.sharpening) "add-channel-whole" then "A whole channel count changes scale rather than resolves one channel part." else
  if SFT.Host.Text.equal (rootsName c.roots) "solve-and-round-roots" then "Root approximation introduces brackets and stopping choices." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-coefficient-or-measured-selector" then "An added number or target-selected channel is a free parameter." else
  "The exact charged-lepton cubic invariant tuple is (sum=1, pair-sum=1/6, leading-product=1/485, sharpened-product=3/1454), with the sharpened colour channel uniquely retained over channels two, three and four."

def generationRule : String := "Generate the complete product of cubic carrier, generator, partition, pair invariant, leading support, predecessor, sharpening channel, sharpening form, root boundary and extra-rule forms; enumerate channels two, three and four without measurement access."
def grammarBoundary : String := "All exact positive-rational symmetric three-root invariant constructions made from the admitted Fold fibre count, generator three, complete colour fifth-power support, positive predecessor and one neighbouring generated channel part."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Generator.rejected,Generator.admitted]).flatMap fun generator =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Pair.rejected0,Pair.admitted,Pair.rejected2]).flatMap fun pair =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Channel.rejected0,Channel.admitted,Channel.rejected2]).flatMap fun channel =>
  ([Sharpening.rejected,Sharpening.admitted]).flatMap fun sharpening =>
  ([Roots.rejected,Roots.admitted]).flatMap fun roots =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,generator,partition,pair,support,predecessor,channel,sharpening,roots,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2304 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier generator partition pair support predecessor channel sharpening roots extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerator : generator ∈ [Generator.rejected,Generator.admitted] := by
      cases generator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpair : pair ∈ [Pair.rejected0,Pair.admitted,Pair.rejected2] := by
      cases pair <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchannel : channel ∈ [Channel.rejected0,Channel.admitted,Channel.rejected2] := by
      cases channel <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsharpening : sharpening ∈ [Sharpening.rejected,Sharpening.admitted] := by
      cases sharpening <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hroots : roots ∈ [Roots.rejected,Roots.admitted] := by
      cases roots <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ generator _ hgenerator
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ pair _ hpair
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ channel _ hchannel
    apply CommonRefinement.memFlatMap _ _ sharpening _ hsharpening
    apply CommonRefinement.memFlatMap _ _ roots _ hroots
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 50000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier generator partition pair support predecessor channel sharpening roots extension =>
    cases carrier <;> cases generator <;> cases partition <;> cases pair <;> cases support <;> cases predecessor <;> cases channel <;> cases sharpening <;> cases roots <;> cases extension
    all_goals rfl

set_option maxHeartbeats 50000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier generator partition pair support predecessor channel sharpening roots extension =>
    cases carrier <;> cases generator <;> cases partition <;> cases pair <;> cases support <;> cases predecessor <;> cases channel <;> cases sharpening <;> cases roots <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.generator = .admitted ∧ c.partition = .admitted ∧ c.pair = .admitted ∧ c.support = .admitted ∧ c.predecessor = .admitted ∧ c.channel = .admitted ∧ c.sharpening = .admitted ∧ c.roots = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier generator partition pair support predecessor channel sharpening roots extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem generator_rejected_rejected (c : Candidate) (h : c.generator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generator eq
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

theorem pair_rejected0_rejected (c : Candidate) (h : c.pair = .rejected0) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pair eq
    rw [h] at field
    cases field

theorem pair_rejected2_rejected (c : Candidate) (h : c.pair = .rejected2) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pair eq
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

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem channel_rejected0_rejected (c : Candidate) (h : c.channel = .rejected0) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.channel eq
    rw [h] at field
    cases field

theorem channel_rejected2_rejected (c : Candidate) (h : c.channel = .rejected2) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.channel eq
    rw [h] at field
    cases field

theorem sharpening_rejected_rejected (c : Candidate) (h : c.sharpening = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sharpening eq
    rw [h] at field
    cases field

theorem roots_rejected_rejected (c : Candidate) (h : c.roots = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.roots eq
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

end SFT.Physics.LeptonGrammar
