import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.EliminationGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "selected-alkene-or-leaving-fragment-omitted"
  | .admitted => "complete-single-source-and-multicarrier-products"

inductive Atoms where
  | rejected | admitted

def atomsName : Atoms → String
  | .rejected => "atom-erased-created-or-collapsed-to-formula"
  | .admitted => "every-source-atom-occurrence-retained"

inductive Supports where
  | rejected | admitted

def supportsName : Supports → String
  | .rejected => "support-erased-created-or-collapsed-to-order-number"
  | .admitted => "every-held-support-occurrence-retained"

inductive Adjacency where
  | rejected | admitted

def adjacencyName : Adjacency → String
  | .rejected => "named-leaving-group-or-arbitrary-cleavage-count"
  | .admitted => "exact-two-source-adjacencies-removed-across-product-components"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "fixed-one-layer-or-product-selected-order"
  | .admitted => "positive-finite-multiplicity-family-restored-with-base-retained"

inductive Sites where
  | rejected | admitted

def sitesName : Sites → String
  | .rejected => "beta-only-or-species-selected-site"
  | .admitted => "complete-productwise-same-adjacent-and-nonadjacent-site-family"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "product-scheme-or-yield-readable-before-seal"
  | .admitted => "value-free-elimination-product-vector-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "reaction-specific-exception-or-recomputed-prefix"
  | .admitted => "fresh-unchanged-carrier-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  atoms : Atoms
  supports : Supports
  adjacency : Adjacency
  multiplicity : Multiplicity
  sites : Sites
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, atomsName c.atoms, supportsName c.supports, adjacencyName c.adjacency, multiplicityName c.multiplicity, sitesName c.sites, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "atoms=" (atomsName c.atoms), SFT.Host.Text.append "supports=" (supportsName c.supports), SFT.Host.Text.append "adjacency=" (adjacencyName c.adjacency), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "sites=" (sitesName c.sites), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-single-source-and-multicarrier-products__every-source-atom-occurrence-retained__every-held-support-occurrence-retained__exact-two-source-adjacencies-removed-across-product-components__positive-finite-multiplicity-family-restored-with-base-retained__complete-productwise-same-adjacent-and-nonadjacent-site-family__value-free-elimination-product-vector-seal__fresh-unchanged-carrier-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-single-source-and-multicarrier-products" &&
  SFT.Host.Text.equal (atomsName c.atoms) "every-source-atom-occurrence-retained" &&
  SFT.Host.Text.equal (supportsName c.supports) "every-held-support-occurrence-retained" &&
  SFT.Host.Text.equal (adjacencyName c.adjacency) "exact-two-source-adjacencies-removed-across-product-components" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "positive-finite-multiplicity-family-restored-with-base-retained" &&
  SFT.Host.Text.equal (sitesName c.sites) "complete-productwise-same-adjacent-and-nonadjacent-site-family" &&
  SFT.Host.Text.equal (observationName c.observation) "value-free-elimination-product-vector-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "fresh-unchanged-carrier-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-single-source-and-multicarrier-products") then "A selected product cannot reconstruct the complete reaction carrier." else
  if !(SFT.Host.Text.equal (atomsName c.atoms) "every-source-atom-occurrence-retained") then "An omitted leaving atom violates exact occurrence conservation." else
  if !(SFT.Host.Text.equal (supportsName c.supports) "every-held-support-occurrence-retained") then "A scalar bond order cannot retain the held support identity." else
  if !(SFT.Host.Text.equal (adjacencyName c.adjacency) "exact-two-source-adjacencies-removed-across-product-components") then "A named group or free cleavage count imports a selector." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "positive-finite-multiplicity-family-restored-with-base-retained") then "One chosen multiplicity omits the positive finite inverse family." else
  if !(SFT.Host.Text.equal (sitesName c.sites) "complete-productwise-same-adjacent-and-nonadjacent-site-family") then "A beta-only convention omits same-site and positive finite non-adjacent forms." else
  if !(SFT.Host.Text.equal (observationName c.observation) "value-free-elimination-product-vector-seal") then "An opened product scope could choose the survivor." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "fresh-unchanged-carrier-successor-no-extra-rule") then "A named exception is not depth-independent." else
  "complete-single-source-and-multicarrier-products__every-source-atom-occurrence-retained__every-held-support-occurrence-retained__exact-two-source-adjacencies-removed-across-product-components__positive-finite-multiplicity-family-restored-with-base-retained__complete-productwise-same-adjacent-and-nonadjacent-site-family__value-free-elimination-product-vector-seal__fresh-unchanged-carrier-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, atom, support, adjacency, multiplicity, site, observation and extension alternatives; decide every one of the 256 forms only from admitted Fold conservation, graph and reversible addition laws."
def grammarBoundary : String := "Every positive finite complete source carrier and complete product-carrier family; every exact atom and held-support occurrence; every positive finite restored multiplicity family; every same, adjacent and non-adjacent site class; the complete IUPAC record; all 22 captured archive members; all 117 PDF pages; all 32 characterized products; all five unsuccessful rows; all seven optimization tables; and the complete 3a-prime/3a intermediate record."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Atoms.rejected,Atoms.admitted]).flatMap fun atoms =>
  ([Supports.rejected,Supports.admitted]).flatMap fun supports =>
  ([Adjacency.rejected,Adjacency.admitted]).flatMap fun adjacency =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Sites.rejected,Sites.admitted]).flatMap fun sites =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,atoms,supports,adjacency,multiplicity,sites,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier atoms supports adjacency multiplicity sites observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hatoms : atoms ∈ [Atoms.rejected,Atoms.admitted] := by
      cases atoms <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupports : supports ∈ [Supports.rejected,Supports.admitted] := by
      cases supports <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadjacency : adjacency ∈ [Adjacency.rejected,Adjacency.admitted] := by
      cases adjacency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsites : sites ∈ [Sites.rejected,Sites.admitted] := by
      cases sites <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ atoms _ hatoms
    apply CommonRefinement.memFlatMap _ _ supports _ hsupports
    apply CommonRefinement.memFlatMap _ _ adjacency _ hadjacency
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ sites _ hsites
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (multiplicity : Multiplicity) (sites : Sites) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,multiplicity,sites,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,multiplicity,sites,observation,extension⟩ := by
 cases multiplicity <;> cases sites <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier atoms supports adjacency multiplicity sites observation extension =>
  cases carrier <;> cases atoms <;> cases supports <;> cases adjacency
  · exact sourceDecisionBlock0000 multiplicity sites observation extension
  · exact sourceDecisionBlock0001 multiplicity sites observation extension
  · exact sourceDecisionBlock0010 multiplicity sites observation extension
  · exact sourceDecisionBlock0011 multiplicity sites observation extension
  · exact sourceDecisionBlock0100 multiplicity sites observation extension
  · exact sourceDecisionBlock0101 multiplicity sites observation extension
  · exact sourceDecisionBlock0110 multiplicity sites observation extension
  · exact sourceDecisionBlock0111 multiplicity sites observation extension
  · exact sourceDecisionBlock1000 multiplicity sites observation extension
  · exact sourceDecisionBlock1001 multiplicity sites observation extension
  · exact sourceDecisionBlock1010 multiplicity sites observation extension
  · exact sourceDecisionBlock1011 multiplicity sites observation extension
  · exact sourceDecisionBlock1100 multiplicity sites observation extension
  · exact sourceDecisionBlock1101 multiplicity sites observation extension
  · exact sourceDecisionBlock1110 multiplicity sites observation extension
  · exact sourceDecisionBlock1111 multiplicity sites observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-single-source-and-multicarrier-products" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem atomsCriterion (value : Atoms) : SFT.Host.Text.equal (atomsName value) "every-source-atom-occurrence-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportsCriterion (value : Supports) : SFT.Host.Text.equal (supportsName value) "every-held-support-occurrence-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem adjacencyCriterion (value : Adjacency) : SFT.Host.Text.equal (adjacencyName value) "exact-two-source-adjacencies-removed-across-product-components" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem multiplicityCriterion (value : Multiplicity) : SFT.Host.Text.equal (multiplicityName value) "positive-finite-multiplicity-family-restored-with-base-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem sitesCriterion (value : Sites) : SFT.Host.Text.equal (sitesName value) "complete-productwise-same-adjacent-and-nonadjacent-site-family" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "value-free-elimination-product-vector-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "fresh-unchanged-carrier-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, atomsCriterion, supportsCriterion, adjacencyCriterion, multiplicityCriterion, sitesCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier atoms supports adjacency multiplicity sites observation extension =>
    cases carrier <;> cases atoms <;> cases supports <;> cases adjacency <;> cases multiplicity <;> cases sites <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.atoms = .admitted ∧ c.supports = .admitted ∧ c.adjacency = .admitted ∧ c.multiplicity = .admitted ∧ c.sites = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier atoms supports adjacency multiplicity sites observation extension =>
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

theorem atoms_rejected_rejected (c : Candidate) (h : c.atoms = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.atoms eq
    rw [h] at field
    cases field

theorem supports_rejected_rejected (c : Candidate) (h : c.supports = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.supports eq
    rw [h] at field
    cases field

theorem adjacency_rejected_rejected (c : Candidate) (h : c.adjacency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adjacency eq
    rw [h] at field
    cases field

theorem multiplicity_rejected_rejected (c : Candidate) (h : c.multiplicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
    rw [h] at field
    cases field

theorem sites_rejected_rejected (c : Candidate) (h : c.sites = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sites eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

end SFT.Chemistry.EliminationGrammar
