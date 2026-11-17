import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.BranchYieldGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Channel where
  | rejected | admitted

def channelName : Channel → String
  | .rejected => "unlabelled-yield"
  | .admitted => "held-decay-channel"

inductive Daughter where
  | rejected | admitted

def daughterName : Daughter → String
  | .rejected => "anonymous-product-amount"
  | .admitted => "held-daughter-chemical-species"

inductive Events where
  | rejected | admitted

def eventsName : Events → String
  | .rejected => "continuum-branch-probability"
  | .admitted => "positive-counted-branch-events"

inductive Recovery where
  | rejected | admitted

def recoveryName : Recovery → String
  | .rejected => "fitted-chemical-recovery"
  | .admitted => "positive-counted-recovered-events"

inductive Yield where
  | rejected | admitted

def yieldName : Yield → String
  | .rejected => "percentage-premise"
  | .admitted => "exact-recovered-per-branch-ratio"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "independent-branch-fractions"
  | .admitted => "complete-branch-partition-sums-to-One"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-favorable-daughter"
  | .admitted => "complete-daughter-yield-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "renormalize-after-omission"
  | .admitted => "new-branch-repartitions-complete-total"

structure Candidate where
  channel : Channel
  daughter : Daughter
  events : Events
  recovery : Recovery
  yield : Yield
  partition : Partition
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [channelName c.channel, daughterName c.daughter, eventsName c.events, recoveryName c.recovery, yieldName c.yield, partitionName c.partition, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "channel=" (channelName c.channel), SFT.Host.Text.append "daughter=" (daughterName c.daughter), SFT.Host.Text.append "events=" (eventsName c.events), SFT.Host.Text.append "recovery=" (recoveryName c.recovery), SFT.Host.Text.append "yield=" (yieldName c.yield), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-decay-channel__held-daughter-chemical-species__positive-counted-branch-events__positive-counted-recovered-events__exact-recovered-per-branch-ratio__complete-branch-partition-sums-to-One__complete-daughter-yield-vector__new-branch-repartitions-complete-total"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (channelName c.channel) "held-decay-channel" &&
  SFT.Host.Text.equal (daughterName c.daughter) "held-daughter-chemical-species" &&
  SFT.Host.Text.equal (eventsName c.events) "positive-counted-branch-events" &&
  SFT.Host.Text.equal (recoveryName c.recovery) "positive-counted-recovered-events" &&
  SFT.Host.Text.equal (yieldName c.yield) "exact-recovered-per-branch-ratio" &&
  SFT.Host.Text.equal (partitionName c.partition) "complete-branch-partition-sums-to-One" &&
  SFT.Host.Text.equal (recordName c.record) "complete-daughter-yield-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "new-branch-repartitions-complete-total"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (channelName c.channel) "held-decay-channel") then "Yield needs channel identity." else
  if !(SFT.Host.Text.equal (daughterName c.daughter) "held-daughter-chemical-species") then "Product amount loses species." else
  if !(SFT.Host.Text.equal (eventsName c.events) "positive-counted-branch-events") then "Probability hides event support." else
  if !(SFT.Host.Text.equal (recoveryName c.recovery) "positive-counted-recovered-events") then "A fitted factor is not custody." else
  if !(SFT.Host.Text.equal (yieldName c.yield) "exact-recovered-per-branch-ratio") then "A percentage is a display form." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "complete-branch-partition-sums-to-One") then "Independent values need not close." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-daughter-yield-vector") then "Selection hides adverse/absent branches." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "new-branch-repartitions-complete-total") then "Renormalization hides missing branches." else
  "held-decay-channel__held-daughter-chemical-species__positive-counted-branch-events__positive-counted-recovered-events__exact-recovered-per-branch-ratio__complete-branch-partition-sums-to-One__complete-daughter-yield-vector__new-branch-repartitions-complete-total"

def generationRule : String := "Generate the literal product of eight registered branching decisions."
def grammarBoundary : String := "Eight dimensions exhaust channel, daughter, events, recovery, yield, partition, record and extension."

def candidates : List Candidate :=
  ([Channel.rejected,Channel.admitted]).flatMap fun channel =>
  ([Daughter.rejected,Daughter.admitted]).flatMap fun daughter =>
  ([Events.rejected,Events.admitted]).flatMap fun events =>
  ([Recovery.rejected,Recovery.admitted]).flatMap fun recovery =>
  ([Yield.rejected,Yield.admitted]).flatMap fun yield =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨channel,daughter,events,recovery,yield,partition,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk channel daughter events recovery yield partition record extension =>
    have hchannel : channel ∈ [Channel.rejected,Channel.admitted] := by
      cases channel <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdaughter : daughter ∈ [Daughter.rejected,Daughter.admitted] := by
      cases daughter <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevents : events ∈ [Events.rejected,Events.admitted] := by
      cases events <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecovery : recovery ∈ [Recovery.rejected,Recovery.admitted] := by
      cases recovery <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hyield : yield ∈ [Yield.rejected,Yield.admitted] := by
      cases yield <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ channel _ hchannel
    apply CommonRefinement.memFlatMap _ _ daughter _ hdaughter
    apply CommonRefinement.memFlatMap _ _ events _ hevents
    apply CommonRefinement.memFlatMap _ _ recovery _ hrecovery
    apply CommonRefinement.memFlatMap _ _ yield _ hyield
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,yield,partition,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,yield,partition,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,yield,partition,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,yield,partition,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,yield,partition,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,yield,partition,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,yield,partition,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,yield,partition,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,yield,partition,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,yield,partition,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,yield,partition,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,yield,partition,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,yield,partition,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,yield,partition,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,yield,partition,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (yield : Yield) (partition : Partition) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,yield,partition,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,yield,partition,record,extension⟩ := by
 cases yield <;> cases partition <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk channel daughter events recovery yield partition record extension =>
  cases channel <;> cases daughter <;> cases events <;> cases recovery
  · exact sourceDecisionBlock0000 yield partition record extension
  · exact sourceDecisionBlock0001 yield partition record extension
  · exact sourceDecisionBlock0010 yield partition record extension
  · exact sourceDecisionBlock0011 yield partition record extension
  · exact sourceDecisionBlock0100 yield partition record extension
  · exact sourceDecisionBlock0101 yield partition record extension
  · exact sourceDecisionBlock0110 yield partition record extension
  · exact sourceDecisionBlock0111 yield partition record extension
  · exact sourceDecisionBlock1000 yield partition record extension
  · exact sourceDecisionBlock1001 yield partition record extension
  · exact sourceDecisionBlock1010 yield partition record extension
  · exact sourceDecisionBlock1011 yield partition record extension
  · exact sourceDecisionBlock1100 yield partition record extension
  · exact sourceDecisionBlock1101 yield partition record extension
  · exact sourceDecisionBlock1110 yield partition record extension
  · exact sourceDecisionBlock1111 yield partition record extension

theorem channelCriterion (value : Channel) : SFT.Host.Text.equal (channelName value) "held-decay-channel" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem daughterCriterion (value : Daughter) : SFT.Host.Text.equal (daughterName value) "held-daughter-chemical-species" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eventsCriterion (value : Events) : SFT.Host.Text.equal (eventsName value) "positive-counted-branch-events" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recoveryCriterion (value : Recovery) : SFT.Host.Text.equal (recoveryName value) "positive-counted-recovered-events" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem yieldCriterion (value : Yield) : SFT.Host.Text.equal (yieldName value) "exact-recovered-per-branch-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "complete-branch-partition-sums-to-One" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-daughter-yield-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "new-branch-repartitions-complete-total" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [channelCriterion, daughterCriterion, eventsCriterion, recoveryCriterion, yieldCriterion, partitionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk channel daughter events recovery yield partition record extension =>
    cases channel <;> cases daughter <;> cases events <;> cases recovery <;> cases yield <;> cases partition <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.channel = .admitted ∧ c.daughter = .admitted ∧ c.events = .admitted ∧ c.recovery = .admitted ∧ c.yield = .admitted ∧ c.partition = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk channel daughter events recovery yield partition record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem channel_rejected_rejected (c : Candidate) (h : c.channel = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.channel eq
    rw [h] at field
    cases field

theorem daughter_rejected_rejected (c : Candidate) (h : c.daughter = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.daughter eq
    rw [h] at field
    cases field

theorem events_rejected_rejected (c : Candidate) (h : c.events = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.events eq
    rw [h] at field
    cases field

theorem recovery_rejected_rejected (c : Candidate) (h : c.recovery = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recovery eq
    rw [h] at field
    cases field

theorem yield_rejected_rejected (c : Candidate) (h : c.yield = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.yield eq
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

end SFT.Chemistry.BranchYieldGrammar
