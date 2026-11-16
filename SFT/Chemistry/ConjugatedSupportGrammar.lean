import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ConjugatedSupportGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "selected-unbound-bond-marks"
  | .admitted => "one-retained-molecular-subcarrier"

inductive Connectivity where
  | rejected | admitted

def connectivityName : Connectivity → String
  | .rejected => "disconnected-support-fragments"
  | .admitted => "complete-connected-adjacency-path"

inductive Fibres where
  | rejected | admitted

def fibresName : Fibres → String
  | .rejected => "bond-support-label-erased"
  | .admitted => "two-forced-held-support-fibres"

inductive Alternation where
  | rejected | admitted

def alternationName : Alternation → String
  | .rejected => "arbitrary-adjacent-fibre-repetition"
  | .admitted => "exact-opposed-adjacent-fibre-recurrence"

inductive Coverage where
  | rejected | admitted

def coverageName : Coverage → String
  | .rejected => "favourable-subpath-only"
  | .admitted => "complete-atom-and-incidence-support"

inductive Propagation where
  | rejected | admitted

def propagationName : Propagation → String
  | .rejected => "independent-bond-pairs"
  | .admitted => "shared-centre-support-propagation"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "spectrum-or-name-selects-structure"
  | .admitted => "structure-sealed-before-external-observation"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "named-conjugation-exception"
  | .admitted => "opposed-fibre-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  connectivity : Connectivity
  fibres : Fibres
  alternation : Alternation
  coverage : Coverage
  propagation : Propagation
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, connectivityName c.connectivity, fibresName c.fibres, alternationName c.alternation, coverageName c.coverage, propagationName c.propagation, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "connectivity=" (connectivityName c.connectivity), SFT.Host.Text.append "fibres=" (fibresName c.fibres), SFT.Host.Text.append "alternation=" (alternationName c.alternation), SFT.Host.Text.append "coverage=" (coverageName c.coverage), SFT.Host.Text.append "propagation=" (propagationName c.propagation), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-molecular-subcarrier__complete-connected-adjacency-path__two-forced-held-support-fibres__exact-opposed-adjacent-fibre-recurrence__complete-atom-and-incidence-support__shared-centre-support-propagation__structure-sealed-before-external-observation__opposed-fibre-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-molecular-subcarrier" &&
  SFT.Host.Text.equal (connectivityName c.connectivity) "complete-connected-adjacency-path" &&
  SFT.Host.Text.equal (fibresName c.fibres) "two-forced-held-support-fibres" &&
  SFT.Host.Text.equal (alternationName c.alternation) "exact-opposed-adjacent-fibre-recurrence" &&
  SFT.Host.Text.equal (coverageName c.coverage) "complete-atom-and-incidence-support" &&
  SFT.Host.Text.equal (propagationName c.propagation) "shared-centre-support-propagation" &&
  SFT.Host.Text.equal (observationName c.observation) "structure-sealed-before-external-observation" &&
  SFT.Host.Text.equal (extensionName c.extension) "opposed-fibre-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-molecular-subcarrier") then "Selected marks do not define one molecular subcarrier." else
  if !(SFT.Host.Text.equal (connectivityName c.connectivity) "complete-connected-adjacency-path") then "Disconnected fragments cannot propagate one support distinction." else
  if !(SFT.Host.Text.equal (fibresName c.fibres) "two-forced-held-support-fibres") then "Erasure merges the two required support distinctions." else
  if !(SFT.Host.Text.equal (alternationName c.alternation) "exact-opposed-adjacent-fibre-recurrence") then "Repeated adjacent fibres close the alternating path." else
  if !(SFT.Host.Text.equal (coverageName c.coverage) "complete-atom-and-incidence-support") then "A selected subpath can hide a failing incidence." else
  if !(SFT.Host.Text.equal (propagationName c.propagation) "shared-centre-support-propagation") then "Independent pairs do not share a propagation centre." else
  if !(SFT.Host.Text.equal (observationName c.observation) "structure-sealed-before-external-observation") then "An external name or spectrum cannot select the Fold law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "opposed-fibre-successor-no-extra-rule") then "A named exception introduces an unforced rule." else
  "one-retained-molecular-subcarrier__complete-connected-adjacency-path__two-forced-held-support-fibres__exact-opposed-adjacent-fibre-recurrence__complete-atom-and-incidence-support__shared-centre-support-propagation__structure-sealed-before-external-observation__opposed-fibre-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, connectivity, fibres, alternation, coverage, propagation, observation and extension alternatives; decide all 256 forms from admitted form enforcement, exact graph, distinction, conservation, molecular, bond-order and organic-carrier dependencies."
def grammarBoundary : String := "Every finite complete molecular path of at least three distinct atom occurrences and its complete adjacent incidence support; all ten frozen terminology, experimental structure, separated-support control, vibrational and UV-visible surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Connectivity.rejected,Connectivity.admitted]).flatMap fun connectivity =>
  ([Fibres.rejected,Fibres.admitted]).flatMap fun fibres =>
  ([Alternation.rejected,Alternation.admitted]).flatMap fun alternation =>
  ([Coverage.rejected,Coverage.admitted]).flatMap fun coverage =>
  ([Propagation.rejected,Propagation.admitted]).flatMap fun propagation =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,connectivity,fibres,alternation,coverage,propagation,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier connectivity fibres alternation coverage propagation observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconnectivity : connectivity ∈ [Connectivity.rejected,Connectivity.admitted] := by
      cases connectivity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfibres : fibres ∈ [Fibres.rejected,Fibres.admitted] := by
      cases fibres <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have halternation : alternation ∈ [Alternation.rejected,Alternation.admitted] := by
      cases alternation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoverage : coverage ∈ [Coverage.rejected,Coverage.admitted] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpropagation : propagation ∈ [Propagation.rejected,Propagation.admitted] := by
      cases propagation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ connectivity _ hconnectivity
    apply CommonRefinement.memFlatMap _ _ fibres _ hfibres
    apply CommonRefinement.memFlatMap _ _ alternation _ halternation
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ propagation _ hpropagation
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (coverage : Coverage) (propagation : Propagation) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,coverage,propagation,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,coverage,propagation,observation,extension⟩ := by
 cases coverage <;> cases propagation <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier connectivity fibres alternation coverage propagation observation extension =>
  cases carrier <;> cases connectivity <;> cases fibres <;> cases alternation
  · exact sourceDecisionBlock0000 coverage propagation observation extension
  · exact sourceDecisionBlock0001 coverage propagation observation extension
  · exact sourceDecisionBlock0010 coverage propagation observation extension
  · exact sourceDecisionBlock0011 coverage propagation observation extension
  · exact sourceDecisionBlock0100 coverage propagation observation extension
  · exact sourceDecisionBlock0101 coverage propagation observation extension
  · exact sourceDecisionBlock0110 coverage propagation observation extension
  · exact sourceDecisionBlock0111 coverage propagation observation extension
  · exact sourceDecisionBlock1000 coverage propagation observation extension
  · exact sourceDecisionBlock1001 coverage propagation observation extension
  · exact sourceDecisionBlock1010 coverage propagation observation extension
  · exact sourceDecisionBlock1011 coverage propagation observation extension
  · exact sourceDecisionBlock1100 coverage propagation observation extension
  · exact sourceDecisionBlock1101 coverage propagation observation extension
  · exact sourceDecisionBlock1110 coverage propagation observation extension
  · exact sourceDecisionBlock1111 coverage propagation observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-molecular-subcarrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem connectivityCriterion (value : Connectivity) : SFT.Host.Text.equal (connectivityName value) "complete-connected-adjacency-path" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem fibresCriterion (value : Fibres) : SFT.Host.Text.equal (fibresName value) "two-forced-held-support-fibres" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem alternationCriterion (value : Alternation) : SFT.Host.Text.equal (alternationName value) "exact-opposed-adjacent-fibre-recurrence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem coverageCriterion (value : Coverage) : SFT.Host.Text.equal (coverageName value) "complete-atom-and-incidence-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem propagationCriterion (value : Propagation) : SFT.Host.Text.equal (propagationName value) "shared-centre-support-propagation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "structure-sealed-before-external-observation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "opposed-fibre-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, connectivityCriterion, fibresCriterion, alternationCriterion, coverageCriterion, propagationCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier connectivity fibres alternation coverage propagation observation extension =>
    cases carrier <;> cases connectivity <;> cases fibres <;> cases alternation <;> cases coverage <;> cases propagation <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.connectivity = .admitted ∧ c.fibres = .admitted ∧ c.alternation = .admitted ∧ c.coverage = .admitted ∧ c.propagation = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier connectivity fibres alternation coverage propagation observation extension =>
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

theorem connectivity_rejected_rejected (c : Candidate) (h : c.connectivity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.connectivity eq
    rw [h] at field
    cases field

theorem fibres_rejected_rejected (c : Candidate) (h : c.fibres = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fibres eq
    rw [h] at field
    cases field

theorem alternation_rejected_rejected (c : Candidate) (h : c.alternation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.alternation eq
    rw [h] at field
    cases field

theorem coverage_rejected_rejected (c : Candidate) (h : c.coverage = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem propagation_rejected_rejected (c : Candidate) (h : c.propagation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.propagation eq
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

end SFT.Chemistry.ConjugatedSupportGrammar
