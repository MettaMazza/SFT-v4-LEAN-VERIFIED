import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.JointCorrelationGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unbound-energy-only-record"
  | .admitted => "bound-carrier-and-product-support"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "independent-single-product-word"
  | .admitted => "complete-complementary-joint-support"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "marginals-declared-complete"
  | .admitted => "nonfactorizable-held-joint-relation"

inductive Exchange where
  | rejected | admitted

def exchangeName : Exchange → String
  | .rejected => "named-electron-product-assignment"
  | .admitted => "held-fibre-exchange-pair"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "dissociation-as-disconnected-lookup"
  | .admitted => "bound-to-separated-support-transition"

inductive Energy where
  | rejected | admitted

def energyName : Energy → String
  | .rejected => "fitted-correlation-correction"
  | .admitted => "positive-post-seal-separation-record"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-single-isotopologue"
  | .admitted => "complete-measurement-and-provenance-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-specific-correlation-rule"
  | .admitted => "pairwise-successor-with-no-extra-rule"

structure Candidate where
  carrier : Carrier
  support : Support
  relation : Relation
  exchange : Exchange
  transition : Transition
  energy : Energy
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, supportName c.support, relationName c.relation, exchangeName c.exchange, transitionName c.transition, energyName c.energy, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "exchange=" (exchangeName c.exchange), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "energy=" (energyName c.energy), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "bound-carrier-and-product-support__complete-complementary-joint-support__nonfactorizable-held-joint-relation__held-fibre-exchange-pair__bound-to-separated-support-transition__positive-post-seal-separation-record__complete-measurement-and-provenance-vector__pairwise-successor-with-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "bound-carrier-and-product-support" &&
  SFT.Host.Text.equal (supportName c.support) "complete-complementary-joint-support" &&
  SFT.Host.Text.equal (relationName c.relation) "nonfactorizable-held-joint-relation" &&
  SFT.Host.Text.equal (exchangeName c.exchange) "held-fibre-exchange-pair" &&
  SFT.Host.Text.equal (transitionName c.transition) "bound-to-separated-support-transition" &&
  SFT.Host.Text.equal (energyName c.energy) "positive-post-seal-separation-record" &&
  SFT.Host.Text.equal (recordName c.record) "complete-measurement-and-provenance-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "pairwise-successor-with-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "bound-carrier-and-product-support") then "An energy alone erases the bound carrier and separated product identities." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-complementary-joint-support") then "One product word omits the complementary assignment required by indistinguishability and exchange." else
  if !(SFT.Host.Text.equal (relationName c.relation) "nonfactorizable-held-joint-relation") then "The two one-carrier marginals generate four Cartesian words and cannot identify the exact two-word joint support." else
  if !(SFT.Host.Text.equal (exchangeName c.exchange) "held-fibre-exchange-pair") then "Named electrons import an unobservable constituent distinction." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "bound-to-separated-support-transition") then "A lookup does not preserve the molecular-to-product transition trace." else
  if !(SFT.Host.Text.equal (energyName c.energy) "positive-post-seal-separation-record") then "A correction coefficient selected from dissociation data is a forbidden free parameter." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-measurement-and-provenance-vector") then "Selecting one favourable molecule cannot test the complete registered dissociation vector." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "pairwise-successor-with-no-extra-rule") then "A species exception or imported correlation functional adds an unforced model." else
  "bound-carrier-and-product-support__complete-complementary-joint-support__nonfactorizable-held-joint-relation__held-fibre-exchange-pair__bound-to-separated-support-transition__positive-post-seal-separation-record__complete-measurement-and-provenance-vector__pairwise-successor-with-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, support, relation, exchange, transition, energy, record and extension forms. Decide all 256 forms solely by admitted indistinguishability, exclusion, joint-state, molecular-support, state-order and exchange laws."
def grammarBoundary : String := "Every identical molecular electron pair at a two-centre separated-product boundary and every pairwise successor in a larger finite support graph. External closure uses all nine pre-registered APS and NIST hydrogen/deuterium neutral, ionic, ground-state, excited-state and threshold dissociation records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Exchange.rejected,Exchange.admitted]).flatMap fun exchange =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Energy.rejected,Energy.admitted]).flatMap fun energy =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,support,relation,exchange,transition,energy,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier support relation exchange transition energy record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexchange : exchange ∈ [Exchange.rejected,Exchange.admitted] := by
      cases exchange <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henergy : energy ∈ [Energy.rejected,Energy.admitted] := by
      cases energy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ exchange _ hexchange
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ energy _ henergy
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,transition,energy,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,transition,energy,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,transition,energy,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,transition,energy,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,transition,energy,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,transition,energy,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,transition,energy,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,transition,energy,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,transition,energy,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,transition,energy,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,transition,energy,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,transition,energy,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,transition,energy,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,transition,energy,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,transition,energy,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (transition : Transition) (energy : Energy) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,transition,energy,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,transition,energy,record,extension⟩ := by
 cases transition <;> cases energy <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier support relation exchange transition energy record extension =>
  cases carrier <;> cases support <;> cases relation <;> cases exchange
  · exact sourceDecisionBlock0000 transition energy record extension
  · exact sourceDecisionBlock0001 transition energy record extension
  · exact sourceDecisionBlock0010 transition energy record extension
  · exact sourceDecisionBlock0011 transition energy record extension
  · exact sourceDecisionBlock0100 transition energy record extension
  · exact sourceDecisionBlock0101 transition energy record extension
  · exact sourceDecisionBlock0110 transition energy record extension
  · exact sourceDecisionBlock0111 transition energy record extension
  · exact sourceDecisionBlock1000 transition energy record extension
  · exact sourceDecisionBlock1001 transition energy record extension
  · exact sourceDecisionBlock1010 transition energy record extension
  · exact sourceDecisionBlock1011 transition energy record extension
  · exact sourceDecisionBlock1100 transition energy record extension
  · exact sourceDecisionBlock1101 transition energy record extension
  · exact sourceDecisionBlock1110 transition energy record extension
  · exact sourceDecisionBlock1111 transition energy record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "bound-carrier-and-product-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-complementary-joint-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "nonfactorizable-held-joint-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem exchangeCriterion (value : Exchange) : SFT.Host.Text.equal (exchangeName value) "held-fibre-exchange-pair" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem transitionCriterion (value : Transition) : SFT.Host.Text.equal (transitionName value) "bound-to-separated-support-transition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem energyCriterion (value : Energy) : SFT.Host.Text.equal (energyName value) "positive-post-seal-separation-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-measurement-and-provenance-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "pairwise-successor-with-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, supportCriterion, relationCriterion, exchangeCriterion, transitionCriterion, energyCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier support relation exchange transition energy record extension =>
    cases carrier <;> cases support <;> cases relation <;> cases exchange <;> cases transition <;> cases energy <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.support = .admitted ∧ c.relation = .admitted ∧ c.exchange = .admitted ∧ c.transition = .admitted ∧ c.energy = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier support relation exchange transition energy record extension =>
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

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
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

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
    rw [h] at field
    cases field

theorem energy_rejected_rejected (c : Candidate) (h : c.energy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.energy eq
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

end SFT.Chemistry.JointCorrelationGrammar
