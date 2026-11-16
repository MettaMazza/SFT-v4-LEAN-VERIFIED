import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.StateEnergyOrderGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "cross-molecule-state-list"
  | .admitted => "one-molecule-state-support"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "energy-only-anonymous-row"
  | .admitted => "state-and-support-identity"

inductive Least where
  | rejected | admitted

def leastName : Least → String
  | .rejected => "numerical-zero-ground"
  | .admitted => "structural-empty-One-ground"

inductive Excitation where
  | rejected | admitted

def excitationName : Excitation → String
  | .rejected => "signed-energy-displacement"
  | .admitted => "positive-successor-excitation"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "partial-selected-comparison"
  | .admitted => "complete-finite-total-order"

inductive Gap where
  | rejected | admitted

def gapName : Gap → String
  | .rejected => "unretained-transition-gap"
  | .admitted => "retained-positive-order-gap"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "ordered-labels-without-trace"
  | .admitted => "complete-state-order-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-energy-lookup-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  identity : Identity
  least : Least
  excitation : Excitation
  order : Order
  gap : Gap
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, leastName c.least, excitationName c.excitation, orderName c.order, gapName c.gap, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "least=" (leastName c.least), SFT.Host.Text.append "excitation=" (excitationName c.excitation), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "gap=" (gapName c.gap), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-molecule-state-support__state-and-support-identity__structural-empty-One-ground__positive-successor-excitation__complete-finite-total-order__retained-positive-order-gap__complete-state-order-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-molecule-state-support" &&
  SFT.Host.Text.equal (identityName c.identity) "state-and-support-identity" &&
  SFT.Host.Text.equal (leastName c.least) "structural-empty-One-ground" &&
  SFT.Host.Text.equal (excitationName c.excitation) "positive-successor-excitation" &&
  SFT.Host.Text.equal (orderName c.order) "complete-finite-total-order" &&
  SFT.Host.Text.equal (gapName c.gap) "retained-positive-order-gap" &&
  SFT.Host.Text.equal (recordName c.record) "complete-state-order-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-molecule-state-support") then "States from different carriers have no common declared molecular order." else
  if !(SFT.Host.Text.equal (identityName c.identity) "state-and-support-identity") then "An anonymous energy cannot preserve which electronic support carries it." else
  if !(SFT.Host.Text.equal (leastName c.least) "structural-empty-One-ground") then "Numerical zero imports a forbidden proof magnitude and does not establish structural leastness." else
  if !(SFT.Host.Text.equal (excitationName c.excitation) "positive-successor-excitation") then "A signed displacement imports negative proof quantities." else
  if !(SFT.Host.Text.equal (orderName c.order) "complete-finite-total-order") then "Selected comparisons cannot establish a complete finite state order." else
  if !(SFT.Host.Text.equal (gapName c.gap) "retained-positive-order-gap") then "Erasing the positive separation loses transition and reconstruction information." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-state-order-record") then "A label list without support and observation trace cannot reproduce the order." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A species lookup or measured energy in generation lets the target select the law." else
  "one-molecule-state-support__state-and-support-identity__structural-empty-One-ground__positive-successor-excitation__complete-finite-total-order__retained-positive-order-gap__complete-state-order-record__no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, identity, least-state, excitation, order, gap, record and extension forms. Decide all 256 forms only by admitted exact order, distinguishability, discrete spectrum, electronic state, electron-count and molecular-support laws."
def grammarBoundary : String := "Every positive finite set of distinguishable molecular electronic states at one declared composition and geometry. The least element is structural empty One and each remaining state is one positive successor. Closure is depth-independent because adjoining one distinguishable state forces exactly the next positive position and its comparisons with every retained predecessor."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Least.rejected,Least.admitted]).flatMap fun least =>
  ([Excitation.rejected,Excitation.admitted]).flatMap fun excitation =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Gap.rejected,Gap.admitted]).flatMap fun gap =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,identity,least,excitation,order,gap,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity least excitation order gap record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hleast : least ∈ [Least.rejected,Least.admitted] := by
      cases least <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexcitation : excitation ∈ [Excitation.rejected,Excitation.admitted] := by
      cases excitation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgap : gap ∈ [Gap.rejected,Gap.admitted] := by
      cases gap <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ least _ hleast
    apply CommonRefinement.memFlatMap _ _ excitation _ hexcitation
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ gap _ hgap
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,order,gap,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,order,gap,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,order,gap,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,order,gap,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,order,gap,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,order,gap,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,order,gap,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,order,gap,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,order,gap,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,order,gap,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,order,gap,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,order,gap,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,order,gap,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,order,gap,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,order,gap,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (order : Order) (gap : Gap) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,order,gap,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,order,gap,record,extension⟩ := by
 cases order <;> cases gap <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier identity least excitation order gap record extension =>
  cases carrier <;> cases identity <;> cases least <;> cases excitation
  · exact sourceDecisionBlock0000 order gap record extension
  · exact sourceDecisionBlock0001 order gap record extension
  · exact sourceDecisionBlock0010 order gap record extension
  · exact sourceDecisionBlock0011 order gap record extension
  · exact sourceDecisionBlock0100 order gap record extension
  · exact sourceDecisionBlock0101 order gap record extension
  · exact sourceDecisionBlock0110 order gap record extension
  · exact sourceDecisionBlock0111 order gap record extension
  · exact sourceDecisionBlock1000 order gap record extension
  · exact sourceDecisionBlock1001 order gap record extension
  · exact sourceDecisionBlock1010 order gap record extension
  · exact sourceDecisionBlock1011 order gap record extension
  · exact sourceDecisionBlock1100 order gap record extension
  · exact sourceDecisionBlock1101 order gap record extension
  · exact sourceDecisionBlock1110 order gap record extension
  · exact sourceDecisionBlock1111 order gap record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-molecule-state-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "state-and-support-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem leastCriterion (value : Least) : SFT.Host.Text.equal (leastName value) "structural-empty-One-ground" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem excitationCriterion (value : Excitation) : SFT.Host.Text.equal (excitationName value) "positive-successor-excitation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orderCriterion (value : Order) : SFT.Host.Text.equal (orderName value) "complete-finite-total-order" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem gapCriterion (value : Gap) : SFT.Host.Text.equal (gapName value) "retained-positive-order-gap" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-state-order-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, identityCriterion, leastCriterion, excitationCriterion, orderCriterion, gapCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier identity least excitation order gap record extension =>
    cases carrier <;> cases identity <;> cases least <;> cases excitation <;> cases order <;> cases gap <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.least = .admitted ∧ c.excitation = .admitted ∧ c.order = .admitted ∧ c.gap = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity least excitation order gap record extension =>
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem least_rejected_rejected (c : Candidate) (h : c.least = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.least eq
    rw [h] at field
    cases field

theorem excitation_rejected_rejected (c : Candidate) (h : c.excitation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.excitation eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
    rw [h] at field
    cases field

theorem gap_rejected_rejected (c : Candidate) (h : c.gap = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.gap eq
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

end SFT.Chemistry.StateEnergyOrderGrammar
