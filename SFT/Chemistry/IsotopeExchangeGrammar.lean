import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.IsotopeExchangeGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "mass-number-only"
  | .admitted => "held-element-light-heavy-isotopes"

inductive Carriers where
  | rejected | admitted

def carriersName : Carriers → String
  | .rejected => "phase-free-exchange"
  | .admitted => "held-distinct-chemical-carriers"

inductive Inventory where
  | rejected | admitted

def inventoryName : Inventory → String
  | .rejected => "continuum-concentration-premise"
  | .admitted => "positive-complete-four-count-inventory"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "isotope-label-overwrite"
  | .admitted => "exact-isotope-and-carrier-conservation"

inductive Direction where
  | rejected | admitted

def directionName : Direction → String
  | .rejected => "signed-exchange-extent"
  | .admitted => "held-direction-positive-Take"

inductive Quotient where
  | rejected | admitted

def quotientName : Quotient → String
  | .rejected => "fitted-exchange-constant"
  | .admitted => "exact-cross-product-exchange-quotient"

inductive Equilibrium where
  | rejected | admitted

def equilibriumName : Equilibrium → String
  | .rejected => "numerical-zero-net"
  | .admitted => "equal-forward-reverse-closes-EmptyOne"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "lookup-fractionation-factor"
  | .admitted => "successor-preserves-identities-and-totals"

structure Candidate where
  identity : Identity
  carriers : Carriers
  inventory : Inventory
  conservation : Conservation
  direction : Direction
  quotient : Quotient
  equilibrium : Equilibrium
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, carriersName c.carriers, inventoryName c.inventory, conservationName c.conservation, directionName c.direction, quotientName c.quotient, equilibriumName c.equilibrium, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "carriers=" (carriersName c.carriers), SFT.Host.Text.append "inventory=" (inventoryName c.inventory), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "direction=" (directionName c.direction), SFT.Host.Text.append "quotient=" (quotientName c.quotient), SFT.Host.Text.append "equilibrium=" (equilibriumName c.equilibrium), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-element-light-heavy-isotopes__held-distinct-chemical-carriers__positive-complete-four-count-inventory__exact-isotope-and-carrier-conservation__held-direction-positive-Take__exact-cross-product-exchange-quotient__equal-forward-reverse-closes-EmptyOne__successor-preserves-identities-and-totals"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-element-light-heavy-isotopes" &&
  SFT.Host.Text.equal (carriersName c.carriers) "held-distinct-chemical-carriers" &&
  SFT.Host.Text.equal (inventoryName c.inventory) "positive-complete-four-count-inventory" &&
  SFT.Host.Text.equal (conservationName c.conservation) "exact-isotope-and-carrier-conservation" &&
  SFT.Host.Text.equal (directionName c.direction) "held-direction-positive-Take" &&
  SFT.Host.Text.equal (quotientName c.quotient) "exact-cross-product-exchange-quotient" &&
  SFT.Host.Text.equal (equilibriumName c.equilibrium) "equal-forward-reverse-closes-EmptyOne" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-preserves-identities-and-totals"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-element-light-heavy-isotopes") then "Mass number alone loses elemental and isotope identity." else
  if !(SFT.Host.Text.equal (carriersName c.carriers) "held-distinct-chemical-carriers") then "Exchange requires two chemical carriers." else
  if !(SFT.Host.Text.equal (inventoryName c.inventory) "positive-complete-four-count-inventory") then "Continuum concentration hides occurrences." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "exact-isotope-and-carrier-conservation") then "Overwriting destroys custody." else
  if !(SFT.Host.Text.equal (directionName c.direction) "held-direction-positive-Take") then "A signed scalar imports negative values." else
  if !(SFT.Host.Text.equal (quotientName c.quotient) "exact-cross-product-exchange-quotient") then "A fit cannot define exchange." else
  if !(SFT.Host.Text.equal (equilibriumName c.equilibrium) "equal-forward-reverse-closes-EmptyOne") then "Numerical zero is not native balance." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-preserves-identities-and-totals") then "A lookup cannot select a transition." else
  "held-element-light-heavy-isotopes__held-distinct-chemical-carriers__positive-complete-four-count-inventory__exact-isotope-and-carrier-conservation__held-direction-positive-Take__exact-cross-product-exchange-quotient__equal-forward-reverse-closes-EmptyOne__successor-preserves-identities-and-totals"

def generationRule : String := "Generate the literal product of eight registered exchange decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, carriers, inventory, conservation, direction, quotient, equilibrium and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Carriers.rejected,Carriers.admitted]).flatMap fun carriers =>
  ([Inventory.rejected,Inventory.admitted]).flatMap fun inventory =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Direction.rejected,Direction.admitted]).flatMap fun direction =>
  ([Quotient.rejected,Quotient.admitted]).flatMap fun quotient =>
  ([Equilibrium.rejected,Equilibrium.admitted]).flatMap fun equilibrium =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,carriers,inventory,conservation,direction,quotient,equilibrium,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity carriers inventory conservation direction quotient equilibrium extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarriers : carriers ∈ [Carriers.rejected,Carriers.admitted] := by
      cases carriers <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinventory : inventory ∈ [Inventory.rejected,Inventory.admitted] := by
      cases inventory <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdirection : direction ∈ [Direction.rejected,Direction.admitted] := by
      cases direction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquotient : quotient ∈ [Quotient.rejected,Quotient.admitted] := by
      cases quotient <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequilibrium : equilibrium ∈ [Equilibrium.rejected,Equilibrium.admitted] := by
      cases equilibrium <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ carriers _ hcarriers
    apply CommonRefinement.memFlatMap _ _ inventory _ hinventory
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ direction _ hdirection
    apply CommonRefinement.memFlatMap _ _ quotient _ hquotient
    apply CommonRefinement.memFlatMap _ _ equilibrium _ hequilibrium
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (direction : Direction) (quotient : Quotient) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,direction,quotient,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,direction,quotient,equilibrium,extension⟩ := by
 cases direction <;> cases quotient <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity carriers inventory conservation direction quotient equilibrium extension =>
  cases identity <;> cases carriers <;> cases inventory <;> cases conservation
  · exact sourceDecisionBlock0000 direction quotient equilibrium extension
  · exact sourceDecisionBlock0001 direction quotient equilibrium extension
  · exact sourceDecisionBlock0010 direction quotient equilibrium extension
  · exact sourceDecisionBlock0011 direction quotient equilibrium extension
  · exact sourceDecisionBlock0100 direction quotient equilibrium extension
  · exact sourceDecisionBlock0101 direction quotient equilibrium extension
  · exact sourceDecisionBlock0110 direction quotient equilibrium extension
  · exact sourceDecisionBlock0111 direction quotient equilibrium extension
  · exact sourceDecisionBlock1000 direction quotient equilibrium extension
  · exact sourceDecisionBlock1001 direction quotient equilibrium extension
  · exact sourceDecisionBlock1010 direction quotient equilibrium extension
  · exact sourceDecisionBlock1011 direction quotient equilibrium extension
  · exact sourceDecisionBlock1100 direction quotient equilibrium extension
  · exact sourceDecisionBlock1101 direction quotient equilibrium extension
  · exact sourceDecisionBlock1110 direction quotient equilibrium extension
  · exact sourceDecisionBlock1111 direction quotient equilibrium extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-element-light-heavy-isotopes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem carriersCriterion (value : Carriers) : SFT.Host.Text.equal (carriersName value) "held-distinct-chemical-carriers" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem inventoryCriterion (value : Inventory) : SFT.Host.Text.equal (inventoryName value) "positive-complete-four-count-inventory" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem conservationCriterion (value : Conservation) : SFT.Host.Text.equal (conservationName value) "exact-isotope-and-carrier-conservation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem directionCriterion (value : Direction) : SFT.Host.Text.equal (directionName value) "held-direction-positive-Take" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem quotientCriterion (value : Quotient) : SFT.Host.Text.equal (quotientName value) "exact-cross-product-exchange-quotient" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem equilibriumCriterion (value : Equilibrium) : SFT.Host.Text.equal (equilibriumName value) "equal-forward-reverse-closes-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-preserves-identities-and-totals" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, carriersCriterion, inventoryCriterion, conservationCriterion, directionCriterion, quotientCriterion, equilibriumCriterion, extensionCriterion]
  cases c with
  | mk identity carriers inventory conservation direction quotient equilibrium extension =>
    cases identity <;> cases carriers <;> cases inventory <;> cases conservation <;> cases direction <;> cases quotient <;> cases equilibrium <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.carriers = .admitted ∧ c.inventory = .admitted ∧ c.conservation = .admitted ∧ c.direction = .admitted ∧ c.quotient = .admitted ∧ c.equilibrium = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity carriers inventory conservation direction quotient equilibrium extension =>
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

theorem carriers_rejected_rejected (c : Candidate) (h : c.carriers = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carriers eq
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

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
    rw [h] at field
    cases field

theorem direction_rejected_rejected (c : Candidate) (h : c.direction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.direction eq
    rw [h] at field
    cases field

theorem quotient_rejected_rejected (c : Candidate) (h : c.quotient = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.quotient eq
    rw [h] at field
    cases field

theorem equilibrium_rejected_rejected (c : Candidate) (h : c.equilibrium = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equilibrium eq
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

end SFT.Chemistry.IsotopeExchangeGrammar
