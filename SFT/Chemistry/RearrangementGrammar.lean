import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RearrangementGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "selected-group-or-product-fragment-only"
  | .admitted => "complete-source-and-terminal-carrier"

inductive Atoms where
  | rejected | admitted

def atomsName : Atoms → String
  | .rejected => "atom-created-erased-or-collapsed-to-formula"
  | .admitted => "every-atom-occurrence-retained-in-source-order"

inductive Supports where
  | rejected | admitted

def supportsName : Supports → String
  | .rejected => "support-created-erased-or-renamed"
  | .admitted => "every-held-support-occurrence-retained-once"

inductive Adjacency where
  | rejected | admitted

def adjacencyName : Adjacency → String
  | .rejected => "unchanged-graph-or-unregistered-edit"
  | .admitted => "positive-finite-held-support-incidence-change"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "named-mechanism-or-single-imported-order"
  | .admitted => "complete-direct-or-opened-reclosure-path-family"

inductive Alternatives where
  | rejected | admitted

def alternativesName : Alternatives → String
  | .rejected => "species-selected-target-or-degenerate-path-erased"
  | .admitted => "all-nonoriginal-incidences-and-degenerate-traces-generated"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "product-scope-readable-before-seal"
  | .admitted => "value-free-rearrangement-product-vector-seal"

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
  path : Path
  alternatives : Alternatives
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, atomsName c.atoms, supportsName c.supports, adjacencyName c.adjacency, pathName c.path, alternativesName c.alternatives, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "atoms=" (atomsName c.atoms), SFT.Host.Text.append "supports=" (supportsName c.supports), SFT.Host.Text.append "adjacency=" (adjacencyName c.adjacency), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "alternatives=" (alternativesName c.alternatives), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-source-and-terminal-carrier__every-atom-occurrence-retained-in-source-order__every-held-support-occurrence-retained-once__positive-finite-held-support-incidence-change__complete-direct-or-opened-reclosure-path-family__all-nonoriginal-incidences-and-degenerate-traces-generated__value-free-rearrangement-product-vector-seal__fresh-unchanged-carrier-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-source-and-terminal-carrier" &&
  SFT.Host.Text.equal (atomsName c.atoms) "every-atom-occurrence-retained-in-source-order" &&
  SFT.Host.Text.equal (supportsName c.supports) "every-held-support-occurrence-retained-once" &&
  SFT.Host.Text.equal (adjacencyName c.adjacency) "positive-finite-held-support-incidence-change" &&
  SFT.Host.Text.equal (pathName c.path) "complete-direct-or-opened-reclosure-path-family" &&
  SFT.Host.Text.equal (alternativesName c.alternatives) "all-nonoriginal-incidences-and-degenerate-traces-generated" &&
  SFT.Host.Text.equal (observationName c.observation) "value-free-rearrangement-product-vector-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "fresh-unchanged-carrier-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-source-and-terminal-carrier") then "A fragment cannot prove that the same complete carrier rearranged." else
  if !(SFT.Host.Text.equal (atomsName c.atoms) "every-atom-occurrence-retained-in-source-order") then "A changed atom inventory is a different composition, not a rearrangement." else
  if !(SFT.Host.Text.equal (supportsName c.supports) "every-held-support-occurrence-retained-once") then "A replaced bond label cannot be traced through the rearrangement." else
  if !(SFT.Host.Text.equal (adjacencyName c.adjacency) "positive-finite-held-support-incidence-change") then "No change is not a rearrangement and an arbitrary edit is not forced." else
  if !(SFT.Host.Text.equal (pathName c.path) "complete-direct-or-opened-reclosure-path-family") then "A conventional mechanism name cannot select the native path." else
  if !(SFT.Host.Text.equal (alternativesName c.alternatives) "all-nonoriginal-incidences-and-degenerate-traces-generated") then "A named product omits other lawful target incidences and constitutionally degenerate traces." else
  if !(SFT.Host.Text.equal (observationName c.observation) "value-free-rearrangement-product-vector-seal") then "An opened rearrangement scope could choose the survivor." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "fresh-unchanged-carrier-successor-no-extra-rule") then "A named exception is not depth-independent." else
  "complete-source-and-terminal-carrier__every-atom-occurrence-retained-in-source-order__every-held-support-occurrence-retained-once__positive-finite-held-support-incidence-change__complete-direct-or-opened-reclosure-path-family__all-nonoriginal-incidences-and-degenerate-traces-generated__value-free-rearrangement-product-vector-seal__fresh-unchanged-carrier-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, atom, support, adjacency, path, alternative, observation and extension coordinates; decide all 256 forms only from admitted Fold conservation, graph and reversible laws."
def grammarBoundary : String := "Every positive finite connected source/terminal carrier pair; every exact atom and held support; every nonoriginal target incidence; both direct and opened-reclosure paths; constitutionally degenerate traces; three complete IUPAC records; the preserved first blind surface; all 38 pages and all eight exact Claisen pairs."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Atoms.rejected,Atoms.admitted]).flatMap fun atoms =>
  ([Supports.rejected,Supports.admitted]).flatMap fun supports =>
  ([Adjacency.rejected,Adjacency.admitted]).flatMap fun adjacency =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Alternatives.rejected,Alternatives.admitted]).flatMap fun alternatives =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,atoms,supports,adjacency,path,alternatives,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier atoms supports adjacency path alternatives observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hatoms : atoms ∈ [Atoms.rejected,Atoms.admitted] := by
      cases atoms <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupports : supports ∈ [Supports.rejected,Supports.admitted] := by
      cases supports <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadjacency : adjacency ∈ [Adjacency.rejected,Adjacency.admitted] := by
      cases adjacency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have halternatives : alternatives ∈ [Alternatives.rejected,Alternatives.admitted] := by
      cases alternatives <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ atoms _ hatoms
    apply CommonRefinement.memFlatMap _ _ supports _ hsupports
    apply CommonRefinement.memFlatMap _ _ adjacency _ hadjacency
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ alternatives _ halternatives
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (path : Path) (alternatives : Alternatives) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,path,alternatives,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,path,alternatives,observation,extension⟩ := by
 cases path <;> cases alternatives <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier atoms supports adjacency path alternatives observation extension =>
  cases carrier <;> cases atoms <;> cases supports <;> cases adjacency
  · exact sourceDecisionBlock0000 path alternatives observation extension
  · exact sourceDecisionBlock0001 path alternatives observation extension
  · exact sourceDecisionBlock0010 path alternatives observation extension
  · exact sourceDecisionBlock0011 path alternatives observation extension
  · exact sourceDecisionBlock0100 path alternatives observation extension
  · exact sourceDecisionBlock0101 path alternatives observation extension
  · exact sourceDecisionBlock0110 path alternatives observation extension
  · exact sourceDecisionBlock0111 path alternatives observation extension
  · exact sourceDecisionBlock1000 path alternatives observation extension
  · exact sourceDecisionBlock1001 path alternatives observation extension
  · exact sourceDecisionBlock1010 path alternatives observation extension
  · exact sourceDecisionBlock1011 path alternatives observation extension
  · exact sourceDecisionBlock1100 path alternatives observation extension
  · exact sourceDecisionBlock1101 path alternatives observation extension
  · exact sourceDecisionBlock1110 path alternatives observation extension
  · exact sourceDecisionBlock1111 path alternatives observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-source-and-terminal-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem atomsCriterion (value : Atoms) : SFT.Host.Text.equal (atomsName value) "every-atom-occurrence-retained-in-source-order" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportsCriterion (value : Supports) : SFT.Host.Text.equal (supportsName value) "every-held-support-occurrence-retained-once" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem adjacencyCriterion (value : Adjacency) : SFT.Host.Text.equal (adjacencyName value) "positive-finite-held-support-incidence-change" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "complete-direct-or-opened-reclosure-path-family" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem alternativesCriterion (value : Alternatives) : SFT.Host.Text.equal (alternativesName value) "all-nonoriginal-incidences-and-degenerate-traces-generated" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "value-free-rearrangement-product-vector-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "fresh-unchanged-carrier-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, atomsCriterion, supportsCriterion, adjacencyCriterion, pathCriterion, alternativesCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier atoms supports adjacency path alternatives observation extension =>
    cases carrier <;> cases atoms <;> cases supports <;> cases adjacency <;> cases path <;> cases alternatives <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.atoms = .admitted ∧ c.supports = .admitted ∧ c.adjacency = .admitted ∧ c.path = .admitted ∧ c.alternatives = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier atoms supports adjacency path alternatives observation extension =>
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

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
    rw [h] at field
    cases field

theorem alternatives_rejected_rejected (c : Candidate) (h : c.alternatives = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.alternatives eq
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

end SFT.Chemistry.RearrangementGrammar
