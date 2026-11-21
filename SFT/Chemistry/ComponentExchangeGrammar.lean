import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ComponentExchangeGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Accounts where
  | rejected | admitted

def accountsName : Accounts → String
  | .rejected => "bulk-phase-value-or-answer-only-potential"
  | .admitted => "complete-distinct-phase-component-addition-accounts"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "changed-component-or-unheld-environment"
  | .admitted => "same-held-component-and-fixed-environment"

inductive Exchange where
  | rejected | admitted

def exchangeName : Exchange → String
  | .rejected => "created-erased-or-unpaired-component"
  | .admitted => "paired-one-component-exchange-conserving-total-carrier"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "signed-logarithmic-or-fitted-chemical-potential"
  | .admitted => "exact-positive-energy-and-closed-distinction-increments"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "weighted-sum-tie-break-or-equal-composition-rule"
  | .admitted => "strict-product-order-with-EmptyOne-equilibrium"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "compound-condition-or-composition-readable-before-seal"
  | .admitted => "complete-value-free-74-row-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-mixture-row-or-deleted-endpoint"
  | .admitted => "complete-four-system-74-row-VLE-vector-with-eight-endpoints"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-common-context-successor"
  | .admitted => "depth-independent-common-context-successor"

structure Candidate where
  accounts : Accounts
  identity : Identity
  exchange : Exchange
  support : Support
  relation : Relation
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [accountsName c.accounts, identityName c.identity, exchangeName c.exchange, supportName c.support, relationName c.relation, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "accounts=" (accountsName c.accounts), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "exchange=" (exchangeName c.exchange), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-distinct-phase-component-addition-accounts__same-held-component-and-fixed-environment__paired-one-component-exchange-conserving-total-carrier__exact-positive-energy-and-closed-distinction-increments__strict-product-order-with-EmptyOne-equilibrium__complete-value-free-74-row-identity-seal__complete-four-system-74-row-VLE-vector-with-eight-endpoints__depth-independent-common-context-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (accountsName c.accounts) "complete-distinct-phase-component-addition-accounts" &&
  SFT.Host.Text.equal (identityName c.identity) "same-held-component-and-fixed-environment" &&
  SFT.Host.Text.equal (exchangeName c.exchange) "paired-one-component-exchange-conserving-total-carrier" &&
  SFT.Host.Text.equal (supportName c.support) "exact-positive-energy-and-closed-distinction-increments" &&
  SFT.Host.Text.equal (relationName c.relation) "strict-product-order-with-EmptyOne-equilibrium" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-74-row-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-four-system-74-row-VLE-vector-with-eight-endpoints" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-context-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (accountsName c.accounts) "complete-distinct-phase-component-addition-accounts") then "A bulk value or named answer does not identify the marginal component change." else
  if !(SFT.Host.Text.equal (identityName c.identity) "same-held-component-and-fixed-environment") then "Changing the component or environment destroys the exchange comparison." else
  if !(SFT.Host.Text.equal (exchangeName c.exchange) "paired-one-component-exchange-conserving-total-carrier") then "An unpaired move violates the admitted component carrier conservation." else
  if !(SFT.Host.Text.equal (supportName c.support) "exact-positive-energy-and-closed-distinction-increments") then "A signed scalar, logarithm or fit imports an unforced chemical-potential model." else
  if !(SFT.Host.Text.equal (relationName c.relation) "strict-product-order-with-EmptyOne-equilibrium") then "A weight, tie-break or equal-composition premise adds content not forced by exchange." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-74-row-identity-seal") then "Withheld mixture values could select the component relation." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-four-system-74-row-VLE-vector-with-eight-endpoints") then "Selecting a system or dropping a source boundary can hide adverse phase behavior." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-context-successor") then "Refitting after a shared context destroys structural invariance." else
  "complete-distinct-phase-component-addition-accounts__same-held-component-and-fixed-environment__paired-one-component-exchange-conserving-total-carrier__exact-positive-energy-and-closed-distinction-increments__strict-product-order-with-EmptyOne-equilibrium__complete-value-free-74-row-identity-seal__complete-four-system-74-row-VLE-vector-with-eight-endpoints__depth-independent-common-context-successor"

def generationRule : String := "Generate the literal product of accounts, identity, exchange, support, relation, prediction, record and extension forms; decide all 256 candidates only from admitted exact composition, transfer, energy, distinction and equilibrium laws."
def grammarBoundary : String := "Every finite pair of distinct phase-specific addition accounts for the same held component at one held environment, with paired one-component exchange, exact positive marginal support and common-context successor closure. External testing preserves the complete NIST TRC ThermoML record: four binary systems, 74 matched interior VLE records and eight unmatched endpoints."

def candidates : List Candidate :=
  ([Accounts.rejected,Accounts.admitted]).flatMap fun accounts =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Exchange.rejected,Exchange.admitted]).flatMap fun exchange =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨accounts,identity,exchange,support,relation,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk accounts identity exchange support relation prediction record extension =>
    have haccounts : accounts ∈ [Accounts.rejected,Accounts.admitted] := by
      cases accounts <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexchange : exchange ∈ [Exchange.rejected,Exchange.admitted] := by
      cases exchange <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ accounts _ haccounts
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ exchange _ hexchange
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,relation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,relation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,relation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,relation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,relation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,relation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,relation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,relation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,relation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,relation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,relation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,relation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,relation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,relation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,relation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (relation : Relation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,relation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,relation,prediction,record,extension⟩ := by
 cases relation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk accounts identity exchange support relation prediction record extension =>
  cases accounts <;> cases identity <;> cases exchange <;> cases support
  · exact sourceDecisionBlock0000 relation prediction record extension
  · exact sourceDecisionBlock0001 relation prediction record extension
  · exact sourceDecisionBlock0010 relation prediction record extension
  · exact sourceDecisionBlock0011 relation prediction record extension
  · exact sourceDecisionBlock0100 relation prediction record extension
  · exact sourceDecisionBlock0101 relation prediction record extension
  · exact sourceDecisionBlock0110 relation prediction record extension
  · exact sourceDecisionBlock0111 relation prediction record extension
  · exact sourceDecisionBlock1000 relation prediction record extension
  · exact sourceDecisionBlock1001 relation prediction record extension
  · exact sourceDecisionBlock1010 relation prediction record extension
  · exact sourceDecisionBlock1011 relation prediction record extension
  · exact sourceDecisionBlock1100 relation prediction record extension
  · exact sourceDecisionBlock1101 relation prediction record extension
  · exact sourceDecisionBlock1110 relation prediction record extension
  · exact sourceDecisionBlock1111 relation prediction record extension

theorem accountsCriterion (value : Accounts) : SFT.Host.Text.equal (accountsName value) "complete-distinct-phase-component-addition-accounts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "same-held-component-and-fixed-environment" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem exchangeCriterion (value : Exchange) : SFT.Host.Text.equal (exchangeName value) "paired-one-component-exchange-conserving-total-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "exact-positive-energy-and-closed-distinction-increments" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "strict-product-order-with-EmptyOne-equilibrium" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-74-row-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-four-system-74-row-VLE-vector-with-eight-endpoints" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-common-context-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [accountsCriterion, identityCriterion, exchangeCriterion, supportCriterion, relationCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk accounts identity exchange support relation prediction record extension =>
    cases accounts <;> cases identity <;> cases exchange <;> cases support <;> cases relation <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.accounts = .admitted ∧ c.identity = .admitted ∧ c.exchange = .admitted ∧ c.support = .admitted ∧ c.relation = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk accounts identity exchange support relation prediction record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem accounts_rejected_rejected (c : Candidate) (h : c.accounts = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.accounts eq
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

theorem exchange_rejected_rejected (c : Candidate) (h : c.exchange = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.exchange eq
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

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
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

end SFT.Chemistry.ComponentExchangeGrammar
