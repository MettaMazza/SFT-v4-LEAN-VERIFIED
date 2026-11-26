import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PhaseRuleGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unbound-degree-number"
  | .admitted => "complete-component-phase-coordinate-account"

inductive Components where
  | rejected | admitted

def componentsName : Components → String
  | .rejected => "bulk-substance-with-erased-independent-components"
  | .admitted => "complete-held-independent-component-support"

inductive Phases where
  | rejected | admitted

def phasesName : Phases → String
  | .rejected => "phase-label-without-coexistence-constraint"
  | .admitted => "one-exact-coordinate-cancellation-per-coexisting-phase"

inductive Environment where
  | rejected | admitted

def environmentName : Environment → String
  | .rejected => "free-or-continuum-intensive-coordinate-space"
  | .admitted => "two-held-environment-coordinate-carriers"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "imported-subtractive-phase-rule-equation"
  | .admitted => "exact-carrier-cancellation-relation"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-degree-count"
  | .admitted => "structural-EmptyOne-invariant-state"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "degree-outcome-readable-before-seal"
  | .admitted => "complete-value-free-18-row-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "recalculate-with-free-exception"
  | .admitted => "depth-independent-joint-component-phase-successor"

structure Candidate where
  carrier : Carrier
  components : Components
  phases : Phases
  environment : Environment
  relation : Relation
  absence : Absence
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, componentsName c.components, phasesName c.phases, environmentName c.environment, relationName c.relation, absenceName c.absence, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "components=" (componentsName c.components), SFT.Host.Text.append "phases=" (phasesName c.phases), SFT.Host.Text.append "environment=" (environmentName c.environment), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-component-phase-coordinate-account__complete-held-independent-component-support__one-exact-coordinate-cancellation-per-coexisting-phase__two-held-environment-coordinate-carriers__exact-carrier-cancellation-relation__structural-EmptyOne-invariant-state__complete-value-free-18-row-identity-seal__depth-independent-joint-component-phase-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-component-phase-coordinate-account" &&
  SFT.Host.Text.equal (componentsName c.components) "complete-held-independent-component-support" &&
  SFT.Host.Text.equal (phasesName c.phases) "one-exact-coordinate-cancellation-per-coexisting-phase" &&
  SFT.Host.Text.equal (environmentName c.environment) "two-held-environment-coordinate-carriers" &&
  SFT.Host.Text.equal (relationName c.relation) "exact-carrier-cancellation-relation" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-invariant-state" &&
  SFT.Host.Text.equal (observationName c.observation) "complete-value-free-18-row-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-joint-component-phase-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-component-phase-coordinate-account") then "A detached number erases which component, phase and coordinate supports produced it." else
  if !(SFT.Host.Text.equal (componentsName c.components) "complete-held-independent-component-support") then "Erasing independent component identities changes the available coordinate support." else
  if !(SFT.Host.Text.equal (phasesName c.phases) "one-exact-coordinate-cancellation-per-coexisting-phase") then "A phase name alone does not record the equilibrium identification it imposes." else
  if !(SFT.Host.Text.equal (environmentName c.environment) "two-held-environment-coordinate-carriers") then "A free continuum imports unenumerated degrees and an additional premise." else
  if !(SFT.Host.Text.equal (relationName c.relation) "exact-carrier-cancellation-relation") then "Importing a subtractive formula introduces signed arithmetic instead of forcing the structure." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-invariant-state") then "Numerical zero is not an SFT value." else
  if !(SFT.Host.Text.equal (observationName c.observation) "complete-value-free-18-row-identity-seal") then "A readable degree outcome could select the cancellation relation." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-joint-component-phase-successor") then "A special-case exception would destroy structural closure." else
  "complete-component-phase-coordinate-account__complete-held-independent-component-support__one-exact-coordinate-cancellation-per-coexisting-phase__two-held-environment-coordinate-carriers__exact-carrier-cancellation-relation__structural-EmptyOne-invariant-state__complete-value-free-18-row-identity-seal__depth-independent-joint-component-phase-successor"

def generationRule : String := "Generate the literal product of carrier, components, phases, environment, relation, absence, observation and extension forms; decide all 256 candidates only from admitted finite-support, composition, exact cancellation, equilibrium, structural-absence and successor laws."
def grammarBoundary : String := "Every finite positive component word, positive coexisting-phase word and exactly two held environmental coordinate carriers for which phase cancellation does not exceed complete carrier support. External testing preserves the complete 18-row component/phase identity product for one through four components, all 14 positive degree-support outcomes, four invariant EmptyOne outcomes, the full IUPAC term and the complete 32-page NIST source."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Components.rejected,Components.admitted]).flatMap fun components =>
  ([Phases.rejected,Phases.admitted]).flatMap fun phases =>
  ([Environment.rejected,Environment.admitted]).flatMap fun environment =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,components,phases,environment,relation,absence,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier components phases environment relation absence observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomponents : components ∈ [Components.rejected,Components.admitted] := by
      cases components <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphases : phases ∈ [Phases.rejected,Phases.admitted] := by
      cases phases <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henvironment : environment ∈ [Environment.rejected,Environment.admitted] := by
      cases environment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ components _ hcomponents
    apply CommonRefinement.memFlatMap _ _ phases _ hphases
    apply CommonRefinement.memFlatMap _ _ environment _ henvironment
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,relation,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,relation,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,relation,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,relation,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,relation,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,relation,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,relation,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,relation,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,relation,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,relation,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,relation,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,relation,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,relation,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,relation,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,relation,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (relation : Relation) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,relation,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,relation,absence,observation,extension⟩ := by
 cases relation <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier components phases environment relation absence observation extension =>
  cases carrier <;> cases components <;> cases phases <;> cases environment
  · exact sourceDecisionBlock0000 relation absence observation extension
  · exact sourceDecisionBlock0001 relation absence observation extension
  · exact sourceDecisionBlock0010 relation absence observation extension
  · exact sourceDecisionBlock0011 relation absence observation extension
  · exact sourceDecisionBlock0100 relation absence observation extension
  · exact sourceDecisionBlock0101 relation absence observation extension
  · exact sourceDecisionBlock0110 relation absence observation extension
  · exact sourceDecisionBlock0111 relation absence observation extension
  · exact sourceDecisionBlock1000 relation absence observation extension
  · exact sourceDecisionBlock1001 relation absence observation extension
  · exact sourceDecisionBlock1010 relation absence observation extension
  · exact sourceDecisionBlock1011 relation absence observation extension
  · exact sourceDecisionBlock1100 relation absence observation extension
  · exact sourceDecisionBlock1101 relation absence observation extension
  · exact sourceDecisionBlock1110 relation absence observation extension
  · exact sourceDecisionBlock1111 relation absence observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-component-phase-coordinate-account" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem componentsCriterion (value : Components) : SFT.Host.Text.equal (componentsName value) "complete-held-independent-component-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem phasesCriterion (value : Phases) : SFT.Host.Text.equal (phasesName value) "one-exact-coordinate-cancellation-per-coexisting-phase" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem environmentCriterion (value : Environment) : SFT.Host.Text.equal (environmentName value) "two-held-environment-coordinate-carriers" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "exact-carrier-cancellation-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-invariant-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "complete-value-free-18-row-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-joint-component-phase-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, componentsCriterion, phasesCriterion, environmentCriterion, relationCriterion, absenceCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier components phases environment relation absence observation extension =>
    cases carrier <;> cases components <;> cases phases <;> cases environment <;> cases relation <;> cases absence <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.components = .admitted ∧ c.phases = .admitted ∧ c.environment = .admitted ∧ c.relation = .admitted ∧ c.absence = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier components phases environment relation absence observation extension =>
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

theorem components_rejected_rejected (c : Candidate) (h : c.components = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.components eq
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

theorem environment_rejected_rejected (c : Candidate) (h : c.environment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.environment eq
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

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

end SFT.Chemistry.PhaseRuleGrammar
