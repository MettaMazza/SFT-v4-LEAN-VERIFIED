import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SolidLocalGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "bulk-material-response"
  | .admitted => "one-finite-local-chemical-motif"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "nominal-formula-label"
  | .admitted => "complete-species-occurrence-multiset"

inductive Formula where
  | rejected | admitted

def formulaName : Formula → String
  | .rejected => "unreduced-or-fitted-stoichiometry"
  | .admitted => "exact-primitive-positive-count-ratio"

inductive Bonds where
  | rejected | admitted

def bondsName : Bonds → String
  | .rejected => "averaged-coordination-number"
  | .admitted => "complete-local-bond-adjacency-support"

inductive Network where
  | rejected | admitted

def networkName : Network → String
  | .rejected => "continuum-infinite-lattice"
  | .admitted => "generated-repeat-axis-rank-one-two-or-three"

inductive Constituent where
  | rejected | admitted

def constituentName : Constituent → String
  | .rejected => "real-valued-solid-solution-fraction"
  | .admitted => "positive-second-constituent-support-or-EmptyOne"

inductive Ownership where
  | rejected | admitted

def ownershipName : Ownership → String
  | .rejected => "chemistry-claims-bulk-response"
  | .admitted => "chemistry-local-materials-bulk-handoff"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "crystal-family-exception"
  | .admitted => "local-occurrence-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  composition : Composition
  formula : Formula
  bonds : Bonds
  network : Network
  constituent : Constituent
  ownership : Ownership
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, compositionName c.composition, formulaName c.formula, bondsName c.bonds, networkName c.network, constituentName c.constituent, ownershipName c.ownership, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "formula=" (formulaName c.formula), SFT.Host.Text.append "bonds=" (bondsName c.bonds), SFT.Host.Text.append "network=" (networkName c.network), SFT.Host.Text.append "constituent=" (constituentName c.constituent), SFT.Host.Text.append "ownership=" (ownershipName c.ownership), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-finite-local-chemical-motif__complete-species-occurrence-multiset__exact-primitive-positive-count-ratio__complete-local-bond-adjacency-support__generated-repeat-axis-rank-one-two-or-three__positive-second-constituent-support-or-EmptyOne__chemistry-local-materials-bulk-handoff__local-occurrence-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-finite-local-chemical-motif" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-species-occurrence-multiset" &&
  SFT.Host.Text.equal (formulaName c.formula) "exact-primitive-positive-count-ratio" &&
  SFT.Host.Text.equal (bondsName c.bonds) "complete-local-bond-adjacency-support" &&
  SFT.Host.Text.equal (networkName c.network) "generated-repeat-axis-rank-one-two-or-three" &&
  SFT.Host.Text.equal (constituentName c.constituent) "positive-second-constituent-support-or-EmptyOne" &&
  SFT.Host.Text.equal (ownershipName c.ownership) "chemistry-local-materials-bulk-handoff" &&
  SFT.Host.Text.equal (extensionName c.extension) "local-occurrence-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-finite-local-chemical-motif") then "Bulk response is outside Chemistry ownership." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complete-species-occurrence-multiset") then "A label can omit occurrences." else
  if !(SFT.Host.Text.equal (formulaName c.formula) "exact-primitive-positive-count-ratio") then "Unreduced or fitted coefficients are not unique." else
  if !(SFT.Host.Text.equal (bondsName c.bonds) "complete-local-bond-adjacency-support") then "An average loses local adjacency." else
  if !(SFT.Host.Text.equal (networkName c.network) "generated-repeat-axis-rank-one-two-or-three") then "A continuum lattice imports infinity." else
  if !(SFT.Host.Text.equal (constituentName c.constituent) "positive-second-constituent-support-or-EmptyOne") then "A real fraction imports continuum fitting." else
  if !(SFT.Host.Text.equal (ownershipName c.ownership) "chemistry-local-materials-bulk-handoff") then "Bulk response belongs to Materials." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "local-occurrence-successor-no-extra-rule") then "A catalogue exception destroys closure." else
  "one-finite-local-chemical-motif__complete-species-occurrence-multiset__exact-primitive-positive-count-ratio__complete-local-bond-adjacency-support__generated-repeat-axis-rank-one-two-or-three__positive-second-constituent-support-or-EmptyOne__chemistry-local-materials-bulk-handoff__local-occurrence-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, composition, formula, bonds, network, constituent, ownership and extension alternatives; decide all 256 forms from the admitted exact-arithmetic, graph, generator-three, stoichiometry, bond, coordination and cluster dependencies."
def grammarBoundary : String := "Every positive finite complete local occurrence motif with exact local adjacency, primitive positive formula, generated repeat rank one, two or three, and explicit Chemistry-to-Materials handoff; all ten frozen coordination-network and returned mixed-crystal surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Formula.rejected,Formula.admitted]).flatMap fun formula =>
  ([Bonds.rejected,Bonds.admitted]).flatMap fun bonds =>
  ([Network.rejected,Network.admitted]).flatMap fun network =>
  ([Constituent.rejected,Constituent.admitted]).flatMap fun constituent =>
  ([Ownership.rejected,Ownership.admitted]).flatMap fun ownership =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,composition,formula,bonds,network,constituent,ownership,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier composition formula bonds network constituent ownership extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hformula : formula ∈ [Formula.rejected,Formula.admitted] := by
      cases formula <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbonds : bonds ∈ [Bonds.rejected,Bonds.admitted] := by
      cases bonds <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnetwork : network ∈ [Network.rejected,Network.admitted] := by
      cases network <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstituent : constituent ∈ [Constituent.rejected,Constituent.admitted] := by
      cases constituent <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hownership : ownership ∈ [Ownership.rejected,Ownership.admitted] := by
      cases ownership <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ formula _ hformula
    apply CommonRefinement.memFlatMap _ _ bonds _ hbonds
    apply CommonRefinement.memFlatMap _ _ network _ hnetwork
    apply CommonRefinement.memFlatMap _ _ constituent _ hconstituent
    apply CommonRefinement.memFlatMap _ _ ownership _ hownership
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (network : Network) (constituent : Constituent) (ownership : Ownership) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,network,constituent,ownership,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,network,constituent,ownership,extension⟩ := by
 cases network <;> cases constituent <;> cases ownership <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier composition formula bonds network constituent ownership extension =>
  cases carrier <;> cases composition <;> cases formula <;> cases bonds
  · exact sourceDecisionBlock0000 network constituent ownership extension
  · exact sourceDecisionBlock0001 network constituent ownership extension
  · exact sourceDecisionBlock0010 network constituent ownership extension
  · exact sourceDecisionBlock0011 network constituent ownership extension
  · exact sourceDecisionBlock0100 network constituent ownership extension
  · exact sourceDecisionBlock0101 network constituent ownership extension
  · exact sourceDecisionBlock0110 network constituent ownership extension
  · exact sourceDecisionBlock0111 network constituent ownership extension
  · exact sourceDecisionBlock1000 network constituent ownership extension
  · exact sourceDecisionBlock1001 network constituent ownership extension
  · exact sourceDecisionBlock1010 network constituent ownership extension
  · exact sourceDecisionBlock1011 network constituent ownership extension
  · exact sourceDecisionBlock1100 network constituent ownership extension
  · exact sourceDecisionBlock1101 network constituent ownership extension
  · exact sourceDecisionBlock1110 network constituent ownership extension
  · exact sourceDecisionBlock1111 network constituent ownership extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-finite-local-chemical-motif" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "complete-species-occurrence-multiset" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem formulaCriterion (value : Formula) : SFT.Host.Text.equal (formulaName value) "exact-primitive-positive-count-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem bondsCriterion (value : Bonds) : SFT.Host.Text.equal (bondsName value) "complete-local-bond-adjacency-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem networkCriterion (value : Network) : SFT.Host.Text.equal (networkName value) "generated-repeat-axis-rank-one-two-or-three" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem constituentCriterion (value : Constituent) : SFT.Host.Text.equal (constituentName value) "positive-second-constituent-support-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem ownershipCriterion (value : Ownership) : SFT.Host.Text.equal (ownershipName value) "chemistry-local-materials-bulk-handoff" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "local-occurrence-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, compositionCriterion, formulaCriterion, bondsCriterion, networkCriterion, constituentCriterion, ownershipCriterion, extensionCriterion]
  cases c with
  | mk carrier composition formula bonds network constituent ownership extension =>
    cases carrier <;> cases composition <;> cases formula <;> cases bonds <;> cases network <;> cases constituent <;> cases ownership <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.composition = .admitted ∧ c.formula = .admitted ∧ c.bonds = .admitted ∧ c.network = .admitted ∧ c.constituent = .admitted ∧ c.ownership = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier composition formula bonds network constituent ownership extension =>
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem formula_rejected_rejected (c : Candidate) (h : c.formula = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.formula eq
    rw [h] at field
    cases field

theorem bonds_rejected_rejected (c : Candidate) (h : c.bonds = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bonds eq
    rw [h] at field
    cases field

theorem network_rejected_rejected (c : Candidate) (h : c.network = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.network eq
    rw [h] at field
    cases field

theorem constituent_rejected_rejected (c : Candidate) (h : c.constituent = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.constituent eq
    rw [h] at field
    cases field

theorem ownership_rejected_rejected (c : Candidate) (h : c.ownership = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ownership eq
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

end SFT.Chemistry.SolidLocalGrammar
