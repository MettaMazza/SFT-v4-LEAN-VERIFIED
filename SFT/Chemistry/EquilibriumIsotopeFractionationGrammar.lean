import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.EquilibriumIsotopeFractionationGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-heavy-light"
  | .admitted => "held-light-heavy-isotopes"

inductive Phases where
  | rejected | admitted

def phasesName : Phases → String
  | .rejected => "single-phase-ratio"
  | .admitted => "held-distinct-phase-pair"

inductive Inventory where
  | rejected | admitted

def inventoryName : Inventory → String
  | .rejected => "continuum-abundance-premise"
  | .admitted => "positive-complete-isotope-counts"

inductive Ratios where
  | rejected | admitted

def ratiosName : Ratios → String
  | .rejected => "decimal-isotope-ratio"
  | .admitted => "exact-heavy-per-light-ratios"

inductive Factor where
  | rejected | admitted

def factorName : Factor → String
  | .rejected => "fitted-fractionation-factor"
  | .admitted => "exact-ratio-of-ratios"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-delta-premise"
  | .admitted => "held-enrichment-or-EmptyOne-coincidence"

inductive Equilibrium where
  | rejected | admitted

def equilibriumName : Equilibrium → String
  | .rejected => "named-equilibrium-assumption"
  | .admitted => "exchange-balance-plus-stable-factor"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "selected-isotope-pair"
  | .admitted => "complete-vector-successor-recomputes"

structure Candidate where
  identity : Identity
  phases : Phases
  inventory : Inventory
  ratios : Ratios
  factor : Factor
  orientation : Orientation
  equilibrium : Equilibrium
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, phasesName c.phases, inventoryName c.inventory, ratiosName c.ratios, factorName c.factor, orientationName c.orientation, equilibriumName c.equilibrium, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "phases=" (phasesName c.phases), SFT.Host.Text.append "inventory=" (inventoryName c.inventory), SFT.Host.Text.append "ratios=" (ratiosName c.ratios), SFT.Host.Text.append "factor=" (factorName c.factor), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "equilibrium=" (equilibriumName c.equilibrium), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-light-heavy-isotopes__held-distinct-phase-pair__positive-complete-isotope-counts__exact-heavy-per-light-ratios__exact-ratio-of-ratios__held-enrichment-or-EmptyOne-coincidence__exchange-balance-plus-stable-factor__complete-vector-successor-recomputes"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-light-heavy-isotopes" &&
  SFT.Host.Text.equal (phasesName c.phases) "held-distinct-phase-pair" &&
  SFT.Host.Text.equal (inventoryName c.inventory) "positive-complete-isotope-counts" &&
  SFT.Host.Text.equal (ratiosName c.ratios) "exact-heavy-per-light-ratios" &&
  SFT.Host.Text.equal (factorName c.factor) "exact-ratio-of-ratios" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-enrichment-or-EmptyOne-coincidence" &&
  SFT.Host.Text.equal (equilibriumName c.equilibrium) "exchange-balance-plus-stable-factor" &&
  SFT.Host.Text.equal (extensionName c.extension) "complete-vector-successor-recomputes"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-light-heavy-isotopes") then "Heavy/light labels need isotope identity." else
  if !(SFT.Host.Text.equal (phasesName c.phases) "held-distinct-phase-pair") then "Fractionation compares two carriers or phases." else
  if !(SFT.Host.Text.equal (inventoryName c.inventory) "positive-complete-isotope-counts") then "Continuum abundance hides occurrences." else
  if !(SFT.Host.Text.equal (ratiosName c.ratios) "exact-heavy-per-light-ratios") then "A decimal is only a display form." else
  if !(SFT.Host.Text.equal (factorName c.factor) "exact-ratio-of-ratios") then "No fitted factor is admissible." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-enrichment-or-EmptyOne-coincidence") then "A signed delta imports negative proof values." else
  if !(SFT.Host.Text.equal (equilibriumName c.equilibrium) "exchange-balance-plus-stable-factor") then "A label cannot prove equilibrium." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "complete-vector-successor-recomputes") then "One selected pair hides the complete system." else
  "held-light-heavy-isotopes__held-distinct-phase-pair__positive-complete-isotope-counts__exact-heavy-per-light-ratios__exact-ratio-of-ratios__held-enrichment-or-EmptyOne-coincidence__exchange-balance-plus-stable-factor__complete-vector-successor-recomputes"

def generationRule : String := "Generate the literal product of eight registered fractionation decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, phases, inventory, ratios, factor, orientation, equilibrium and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Phases.rejected,Phases.admitted]).flatMap fun phases =>
  ([Inventory.rejected,Inventory.admitted]).flatMap fun inventory =>
  ([Ratios.rejected,Ratios.admitted]).flatMap fun ratios =>
  ([Factor.rejected,Factor.admitted]).flatMap fun factor =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Equilibrium.rejected,Equilibrium.admitted]).flatMap fun equilibrium =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,phases,inventory,ratios,factor,orientation,equilibrium,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity phases inventory ratios factor orientation equilibrium extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphases : phases ∈ [Phases.rejected,Phases.admitted] := by
      cases phases <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinventory : inventory ∈ [Inventory.rejected,Inventory.admitted] := by
      cases inventory <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hratios : ratios ∈ [Ratios.rejected,Ratios.admitted] := by
      cases ratios <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfactor : factor ∈ [Factor.rejected,Factor.admitted] := by
      cases factor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequilibrium : equilibrium ∈ [Equilibrium.rejected,Equilibrium.admitted] := by
      cases equilibrium <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ phases _ hphases
    apply CommonRefinement.memFlatMap _ _ inventory _ hinventory
    apply CommonRefinement.memFlatMap _ _ ratios _ hratios
    apply CommonRefinement.memFlatMap _ _ factor _ hfactor
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ equilibrium _ hequilibrium
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (factor : Factor) (orientation : Orientation) (equilibrium : Equilibrium) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,factor,orientation,equilibrium,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,factor,orientation,equilibrium,extension⟩ := by
 cases factor <;> cases orientation <;> cases equilibrium <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity phases inventory ratios factor orientation equilibrium extension =>
  cases identity <;> cases phases <;> cases inventory <;> cases ratios
  · exact sourceDecisionBlock0000 factor orientation equilibrium extension
  · exact sourceDecisionBlock0001 factor orientation equilibrium extension
  · exact sourceDecisionBlock0010 factor orientation equilibrium extension
  · exact sourceDecisionBlock0011 factor orientation equilibrium extension
  · exact sourceDecisionBlock0100 factor orientation equilibrium extension
  · exact sourceDecisionBlock0101 factor orientation equilibrium extension
  · exact sourceDecisionBlock0110 factor orientation equilibrium extension
  · exact sourceDecisionBlock0111 factor orientation equilibrium extension
  · exact sourceDecisionBlock1000 factor orientation equilibrium extension
  · exact sourceDecisionBlock1001 factor orientation equilibrium extension
  · exact sourceDecisionBlock1010 factor orientation equilibrium extension
  · exact sourceDecisionBlock1011 factor orientation equilibrium extension
  · exact sourceDecisionBlock1100 factor orientation equilibrium extension
  · exact sourceDecisionBlock1101 factor orientation equilibrium extension
  · exact sourceDecisionBlock1110 factor orientation equilibrium extension
  · exact sourceDecisionBlock1111 factor orientation equilibrium extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-light-heavy-isotopes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem phasesCriterion (value : Phases) : SFT.Host.Text.equal (phasesName value) "held-distinct-phase-pair" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem inventoryCriterion (value : Inventory) : SFT.Host.Text.equal (inventoryName value) "positive-complete-isotope-counts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem ratiosCriterion (value : Ratios) : SFT.Host.Text.equal (ratiosName value) "exact-heavy-per-light-ratios" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem factorCriterion (value : Factor) : SFT.Host.Text.equal (factorName value) "exact-ratio-of-ratios" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-enrichment-or-EmptyOne-coincidence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem equilibriumCriterion (value : Equilibrium) : SFT.Host.Text.equal (equilibriumName value) "exchange-balance-plus-stable-factor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "complete-vector-successor-recomputes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, phasesCriterion, inventoryCriterion, ratiosCriterion, factorCriterion, orientationCriterion, equilibriumCriterion, extensionCriterion]
  cases c with
  | mk identity phases inventory ratios factor orientation equilibrium extension =>
    cases identity <;> cases phases <;> cases inventory <;> cases ratios <;> cases factor <;> cases orientation <;> cases equilibrium <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.phases = .admitted ∧ c.inventory = .admitted ∧ c.ratios = .admitted ∧ c.factor = .admitted ∧ c.orientation = .admitted ∧ c.equilibrium = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity phases inventory ratios factor orientation equilibrium extension =>
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

theorem phases_rejected_rejected (c : Candidate) (h : c.phases = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.phases eq
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

theorem ratios_rejected_rejected (c : Candidate) (h : c.ratios = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ratios eq
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

end SFT.Chemistry.EquilibriumIsotopeFractionationGrammar
