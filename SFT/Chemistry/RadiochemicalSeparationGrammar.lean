import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RadiochemicalSeparationGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "total-radioactivity-only"
  | .admitted => "held-target-and-contaminant-species"

inductive Streams where
  | rejected | admitted

def streamsName : Streams → String
  | .rejected => "product-only-record"
  | .admitted => "complete-feed-product-waste-streams"

inductive Inventory where
  | rejected | admitted

def inventoryName : Inventory → String
  | .rejected => "continuum-concentration-premise"
  | .admitted => "positive-species-resolved-counts"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "unrecorded-process-loss"
  | .admitted => "exact-target-and-contaminant-conservation"

inductive Recovery where
  | rejected | admitted

def recoveryName : Recovery → String
  | .rejected => "percent-recovery-premise"
  | .admitted => "exact-product-target-per-feed-target-ratio"

inductive Decontamination where
  | rejected | admitted

def decontaminationName : Decontamination → String
  | .rejected => "fitted-separation-factor"
  | .admitted => "exact-contaminant-fraction-ratio"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-contaminant"
  | .admitted => "positive-Take-or-EmptyOne-residual"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "selected-best-stage"
  | .admitted => "successor-composes-balanced-stages"

structure Candidate where
  identity : Identity
  streams : Streams
  inventory : Inventory
  balance : Balance
  recovery : Recovery
  decontamination : Decontamination
  absence : Absence
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, streamsName c.streams, inventoryName c.inventory, balanceName c.balance, recoveryName c.recovery, decontaminationName c.decontamination, absenceName c.absence, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "streams=" (streamsName c.streams), SFT.Host.Text.append "inventory=" (inventoryName c.inventory), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "recovery=" (recoveryName c.recovery), SFT.Host.Text.append "decontamination=" (decontaminationName c.decontamination), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-target-and-contaminant-species__complete-feed-product-waste-streams__positive-species-resolved-counts__exact-target-and-contaminant-conservation__exact-product-target-per-feed-target-ratio__exact-contaminant-fraction-ratio__positive-Take-or-EmptyOne-residual__successor-composes-balanced-stages"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-target-and-contaminant-species" &&
  SFT.Host.Text.equal (streamsName c.streams) "complete-feed-product-waste-streams" &&
  SFT.Host.Text.equal (inventoryName c.inventory) "positive-species-resolved-counts" &&
  SFT.Host.Text.equal (balanceName c.balance) "exact-target-and-contaminant-conservation" &&
  SFT.Host.Text.equal (recoveryName c.recovery) "exact-product-target-per-feed-target-ratio" &&
  SFT.Host.Text.equal (decontaminationName c.decontamination) "exact-contaminant-fraction-ratio" &&
  SFT.Host.Text.equal (absenceName c.absence) "positive-Take-or-EmptyOne-residual" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-composes-balanced-stages"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-target-and-contaminant-species") then "Total activity loses target and contaminant identity." else
  if !(SFT.Host.Text.equal (streamsName c.streams) "complete-feed-product-waste-streams") then "A product alone hides feed and waste." else
  if !(SFT.Host.Text.equal (inventoryName c.inventory) "positive-species-resolved-counts") then "Continuum concentration hides occurrences." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "exact-target-and-contaminant-conservation") then "Unrecorded loss breaks custody." else
  if !(SFT.Host.Text.equal (recoveryName c.recovery) "exact-product-target-per-feed-target-ratio") then "A displayed percentage cannot define recovery." else
  if !(SFT.Host.Text.equal (decontaminationName c.decontamination) "exact-contaminant-fraction-ratio") then "A fit cannot define decontamination." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "positive-Take-or-EmptyOne-residual") then "Numerical zero is not native absence." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-composes-balanced-stages") then "Selecting a best stage erases the process." else
  "held-target-and-contaminant-species__complete-feed-product-waste-streams__positive-species-resolved-counts__exact-target-and-contaminant-conservation__exact-product-target-per-feed-target-ratio__exact-contaminant-fraction-ratio__positive-Take-or-EmptyOne-residual__successor-composes-balanced-stages"

def generationRule : String := "Generate the literal product of eight registered separation decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, streams, inventory, balance, recovery, decontamination, absence and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Streams.rejected,Streams.admitted]).flatMap fun streams =>
  ([Inventory.rejected,Inventory.admitted]).flatMap fun inventory =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Recovery.rejected,Recovery.admitted]).flatMap fun recovery =>
  ([Decontamination.rejected,Decontamination.admitted]).flatMap fun decontamination =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,streams,inventory,balance,recovery,decontamination,absence,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity streams inventory balance recovery decontamination absence extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstreams : streams ∈ [Streams.rejected,Streams.admitted] := by
      cases streams <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinventory : inventory ∈ [Inventory.rejected,Inventory.admitted] := by
      cases inventory <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecovery : recovery ∈ [Recovery.rejected,Recovery.admitted] := by
      cases recovery <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecontamination : decontamination ∈ [Decontamination.rejected,Decontamination.admitted] := by
      cases decontamination <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ streams _ hstreams
    apply CommonRefinement.memFlatMap _ _ inventory _ hinventory
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ recovery _ hrecovery
    apply CommonRefinement.memFlatMap _ _ decontamination _ hdecontamination
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (recovery : Recovery) (decontamination : Decontamination) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,recovery,decontamination,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,recovery,decontamination,absence,extension⟩ := by
 cases recovery <;> cases decontamination <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity streams inventory balance recovery decontamination absence extension =>
  cases identity <;> cases streams <;> cases inventory <;> cases balance
  · exact sourceDecisionBlock0000 recovery decontamination absence extension
  · exact sourceDecisionBlock0001 recovery decontamination absence extension
  · exact sourceDecisionBlock0010 recovery decontamination absence extension
  · exact sourceDecisionBlock0011 recovery decontamination absence extension
  · exact sourceDecisionBlock0100 recovery decontamination absence extension
  · exact sourceDecisionBlock0101 recovery decontamination absence extension
  · exact sourceDecisionBlock0110 recovery decontamination absence extension
  · exact sourceDecisionBlock0111 recovery decontamination absence extension
  · exact sourceDecisionBlock1000 recovery decontamination absence extension
  · exact sourceDecisionBlock1001 recovery decontamination absence extension
  · exact sourceDecisionBlock1010 recovery decontamination absence extension
  · exact sourceDecisionBlock1011 recovery decontamination absence extension
  · exact sourceDecisionBlock1100 recovery decontamination absence extension
  · exact sourceDecisionBlock1101 recovery decontamination absence extension
  · exact sourceDecisionBlock1110 recovery decontamination absence extension
  · exact sourceDecisionBlock1111 recovery decontamination absence extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-target-and-contaminant-species" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem streamsCriterion (value : Streams) : SFT.Host.Text.equal (streamsName value) "complete-feed-product-waste-streams" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem inventoryCriterion (value : Inventory) : SFT.Host.Text.equal (inventoryName value) "positive-species-resolved-counts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem balanceCriterion (value : Balance) : SFT.Host.Text.equal (balanceName value) "exact-target-and-contaminant-conservation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recoveryCriterion (value : Recovery) : SFT.Host.Text.equal (recoveryName value) "exact-product-target-per-feed-target-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem decontaminationCriterion (value : Decontamination) : SFT.Host.Text.equal (decontaminationName value) "exact-contaminant-fraction-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "positive-Take-or-EmptyOne-residual" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-composes-balanced-stages" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, streamsCriterion, inventoryCriterion, balanceCriterion, recoveryCriterion, decontaminationCriterion, absenceCriterion, extensionCriterion]
  cases c with
  | mk identity streams inventory balance recovery decontamination absence extension =>
    cases identity <;> cases streams <;> cases inventory <;> cases balance <;> cases recovery <;> cases decontamination <;> cases absence <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.streams = .admitted ∧ c.inventory = .admitted ∧ c.balance = .admitted ∧ c.recovery = .admitted ∧ c.decontamination = .admitted ∧ c.absence = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity streams inventory balance recovery decontamination absence extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem streams_rejected_rejected (c : Candidate) (h : c.streams = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.streams eq
    rw [h] at field
    cases field

theorem inventory_rejected_rejected (c : Candidate) (h : c.inventory = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.inventory eq
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

theorem recovery_rejected_rejected (c : Candidate) (h : c.recovery = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recovery eq
    rw [h] at field
    cases field

theorem decontamination_rejected_rejected (c : Candidate) (h : c.decontamination = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decontamination eq
    rw [h] at field
    cases field

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

end SFT.Chemistry.RadiochemicalSeparationGrammar
