import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.KineticIsotopeFractionationGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "mass-only-rate"
  | .admitted => "held-reaction-light-heavy-identities"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "continuous-time-premise"
  | .admitted => "positive-ordered-resource-intervals"

inductive Events where
  | rejected | admitted

def eventsName : Events → String
  | .rejected => "expected-product-yield"
  | .admitted => "positive-counted-isotope-products"

inductive Rates where
  | rejected | admitted

def ratesName : Rates → String
  | .rejected => "fitted-rate-constants"
  | .admitted => "exact-products-per-resource-rates"

inductive Factor where
  | rejected | admitted

def factorName : Factor → String
  | .rejected => "imported-kinetic-isotope-effect"
  | .admitted => "exact-light-heavy-rate-ratio"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-rate-difference"
  | .admitted => "held-faster-class-or-EmptyOne"

inductive Inventory where
  | rejected | admitted

def inventoryName : Inventory → String
  | .rejected => "negative-depleted-reactant"
  | .admitted => "positive-Take-or-EmptyOne-remainder"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "Rayleigh-continuum-premise"
  | .admitted => "finite-time-series-successor-recomputes"

structure Candidate where
  identity : Identity
  support : Support
  events : Events
  rates : Rates
  factor : Factor
  orientation : Orientation
  inventory : Inventory
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, supportName c.support, eventsName c.events, ratesName c.rates, factorName c.factor, orientationName c.orientation, inventoryName c.inventory, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "events=" (eventsName c.events), SFT.Host.Text.append "rates=" (ratesName c.rates), SFT.Host.Text.append "factor=" (factorName c.factor), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "inventory=" (inventoryName c.inventory), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-reaction-light-heavy-identities__positive-ordered-resource-intervals__positive-counted-isotope-products__exact-products-per-resource-rates__exact-light-heavy-rate-ratio__held-faster-class-or-EmptyOne__positive-Take-or-EmptyOne-remainder__finite-time-series-successor-recomputes"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-reaction-light-heavy-identities" &&
  SFT.Host.Text.equal (supportName c.support) "positive-ordered-resource-intervals" &&
  SFT.Host.Text.equal (eventsName c.events) "positive-counted-isotope-products" &&
  SFT.Host.Text.equal (ratesName c.rates) "exact-products-per-resource-rates" &&
  SFT.Host.Text.equal (factorName c.factor) "exact-light-heavy-rate-ratio" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-faster-class-or-EmptyOne" &&
  SFT.Host.Text.equal (inventoryName c.inventory) "positive-Take-or-EmptyOne-remainder" &&
  SFT.Host.Text.equal (extensionName c.extension) "finite-time-series-successor-recomputes"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-reaction-light-heavy-identities") then "Rate needs reaction and isotope identity." else
  if !(SFT.Host.Text.equal (supportName c.support) "positive-ordered-resource-intervals") then "Continuum time is not proof support." else
  if !(SFT.Host.Text.equal (eventsName c.events) "positive-counted-isotope-products") then "Expectation is not event custody." else
  if !(SFT.Host.Text.equal (ratesName c.rates) "exact-products-per-resource-rates") then "Fitted constants cannot define the native rates." else
  if !(SFT.Host.Text.equal (factorName c.factor) "exact-light-heavy-rate-ratio") then "No imported factor is admissible." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-faster-class-or-EmptyOne") then "A signed difference imports negative values." else
  if !(SFT.Host.Text.equal (inventoryName c.inventory) "positive-Take-or-EmptyOne-remainder") then "Depletion cannot produce a negative proof value." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "finite-time-series-successor-recomputes") then "A continuum law is not required." else
  "held-reaction-light-heavy-identities__positive-ordered-resource-intervals__positive-counted-isotope-products__exact-products-per-resource-rates__exact-light-heavy-rate-ratio__held-faster-class-or-EmptyOne__positive-Take-or-EmptyOne-remainder__finite-time-series-successor-recomputes"

def generationRule : String := "Generate the literal product of eight registered kinetic decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, support, events, rates, factor, orientation, inventory and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Events.rejected,Events.admitted]).flatMap fun events =>
  ([Rates.rejected,Rates.admitted]).flatMap fun rates =>
  ([Factor.rejected,Factor.admitted]).flatMap fun factor =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Inventory.rejected,Inventory.admitted]).flatMap fun inventory =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,support,events,rates,factor,orientation,inventory,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity support events rates factor orientation inventory extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevents : events ∈ [Events.rejected,Events.admitted] := by
      cases events <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrates : rates ∈ [Rates.rejected,Rates.admitted] := by
      cases rates <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfactor : factor ∈ [Factor.rejected,Factor.admitted] := by
      cases factor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinventory : inventory ∈ [Inventory.rejected,Inventory.admitted] := by
      cases inventory <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ events _ hevents
    apply CommonRefinement.memFlatMap _ _ rates _ hrates
    apply CommonRefinement.memFlatMap _ _ factor _ hfactor
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ inventory _ hinventory
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (factor : Factor) (orientation : Orientation) (inventory : Inventory) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,factor,orientation,inventory,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,factor,orientation,inventory,extension⟩ := by
 cases factor <;> cases orientation <;> cases inventory <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity support events rates factor orientation inventory extension =>
  cases identity <;> cases support <;> cases events <;> cases rates
  · exact sourceDecisionBlock0000 factor orientation inventory extension
  · exact sourceDecisionBlock0001 factor orientation inventory extension
  · exact sourceDecisionBlock0010 factor orientation inventory extension
  · exact sourceDecisionBlock0011 factor orientation inventory extension
  · exact sourceDecisionBlock0100 factor orientation inventory extension
  · exact sourceDecisionBlock0101 factor orientation inventory extension
  · exact sourceDecisionBlock0110 factor orientation inventory extension
  · exact sourceDecisionBlock0111 factor orientation inventory extension
  · exact sourceDecisionBlock1000 factor orientation inventory extension
  · exact sourceDecisionBlock1001 factor orientation inventory extension
  · exact sourceDecisionBlock1010 factor orientation inventory extension
  · exact sourceDecisionBlock1011 factor orientation inventory extension
  · exact sourceDecisionBlock1100 factor orientation inventory extension
  · exact sourceDecisionBlock1101 factor orientation inventory extension
  · exact sourceDecisionBlock1110 factor orientation inventory extension
  · exact sourceDecisionBlock1111 factor orientation inventory extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-reaction-light-heavy-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "positive-ordered-resource-intervals" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eventsCriterion (value : Events) : SFT.Host.Text.equal (eventsName value) "positive-counted-isotope-products" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem ratesCriterion (value : Rates) : SFT.Host.Text.equal (ratesName value) "exact-products-per-resource-rates" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem factorCriterion (value : Factor) : SFT.Host.Text.equal (factorName value) "exact-light-heavy-rate-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-faster-class-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem inventoryCriterion (value : Inventory) : SFT.Host.Text.equal (inventoryName value) "positive-Take-or-EmptyOne-remainder" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "finite-time-series-successor-recomputes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, supportCriterion, eventsCriterion, ratesCriterion, factorCriterion, orientationCriterion, inventoryCriterion, extensionCriterion]
  cases c with
  | mk identity support events rates factor orientation inventory extension =>
    cases identity <;> cases support <;> cases events <;> cases rates <;> cases factor <;> cases orientation <;> cases inventory <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.support = .admitted ∧ c.events = .admitted ∧ c.rates = .admitted ∧ c.factor = .admitted ∧ c.orientation = .admitted ∧ c.inventory = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity support events rates factor orientation inventory extension =>
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
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

theorem rates_rejected_rejected (c : Candidate) (h : c.rates = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rates eq
    rw [h] at field
    cases field

theorem factor_rejected_rejected (c : Candidate) (h : c.factor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.factor eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.KineticIsotopeFractionationGrammar
