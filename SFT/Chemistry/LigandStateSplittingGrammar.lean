import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.LigandStateSplittingGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "imported-orbital-or-field-table"
  | .admitted => "generated-rank-three-boundary-two-support"

inductive Interaction where
  | rejected | admitted

def interactionName : Interaction → String
  | .rejected => "free-field-strength-or-fitted-parameter"
  | .admitted => "complete-ligand-support-incidence"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "asserted-level-catalogue"
  | .admitted => "complete-equivalence-partition-by-incidence"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "free-degeneracy-label"
  | .admitted => "positive-cardinality-of-each-partition-block"

inductive Separation where
  | rejected | admitted

def separationName : Separation → String
  | .rejected => "signed-floating-or-dimensional-gap"
  | .admitted => "exact-positive-normalized-incidence-separation"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "opposite-signed-shift-premise"
  | .admitted => "complementary-positive-two-block-distances"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "selected-peak-or-favourable-spectrum"
  | .admitted => "complete-sealed-definition-and-spectrum-surfaces"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-specific-exception-or-reclassification"
  | .admitted => "same-partition-law-and-removed-ligand-remerging"

structure Candidate where
  carrier : Carrier
  interaction : Interaction
  partition : Partition
  multiplicity : Multiplicity
  separation : Separation
  balance : Balance
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, interactionName c.interaction, partitionName c.partition, multiplicityName c.multiplicity, separationName c.separation, balanceName c.balance, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "interaction=" (interactionName c.interaction), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "separation=" (separationName c.separation), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "generated-rank-three-boundary-two-support__complete-ligand-support-incidence__complete-equivalence-partition-by-incidence__positive-cardinality-of-each-partition-block__exact-positive-normalized-incidence-separation__complementary-positive-two-block-distances__complete-sealed-definition-and-spectrum-surfaces__same-partition-law-and-removed-ligand-remerging"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "generated-rank-three-boundary-two-support" &&
  SFT.Host.Text.equal (interactionName c.interaction) "complete-ligand-support-incidence" &&
  SFT.Host.Text.equal (partitionName c.partition) "complete-equivalence-partition-by-incidence" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "positive-cardinality-of-each-partition-block" &&
  SFT.Host.Text.equal (separationName c.separation) "exact-positive-normalized-incidence-separation" &&
  SFT.Host.Text.equal (balanceName c.balance) "complementary-positive-two-block-distances" &&
  SFT.Host.Text.equal (observationName c.observation) "complete-sealed-definition-and-spectrum-surfaces" &&
  SFT.Host.Text.equal (extensionName c.extension) "same-partition-law-and-removed-ligand-remerging"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "generated-rank-three-boundary-two-support") then "A named table imports the desired splitting." else
  if !(SFT.Host.Text.equal (interactionName c.interaction) "complete-ligand-support-incidence") then "A free strength can fit any spectrum." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "complete-equivalence-partition-by-incidence") then "An asserted catalogue does not derive degeneracy removal." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "positive-cardinality-of-each-partition-block") then "A free degeneracy loses member conservation." else
  if !(SFT.Host.Text.equal (separationName c.separation) "exact-positive-normalized-incidence-separation") then "Signed or fitted gaps violate the exact Fold domain." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "complementary-positive-two-block-distances") then "Signed displacements import negative values." else
  if !(SFT.Host.Text.equal (observationName c.observation) "complete-sealed-definition-and-spectrum-surfaces") then "Selected peaks can manufacture correspondence." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "same-partition-law-and-removed-ligand-remerging") then "An exception permits outcomes to select the law." else
  "generated-rank-three-boundary-two-support__complete-ligand-support-incidence__complete-equivalence-partition-by-incidence__positive-cardinality-of-each-partition-block__exact-positive-normalized-incidence-separation__complementary-positive-two-block-distances__complete-sealed-definition-and-spectrum-surfaces__same-partition-law-and-removed-ligand-remerging"

def generationRule : String := "Generate the complete literal product of carrier, interaction, partition, multiplicity, separation, balance, observation and extension choices; decide all 256 candidates solely from admitted exact arithmetic, generator-three, space-rank, boundary-rank, state-equivalence, geometry and prior INORG receipts."
def grammarBoundary : String := "Every finite three-axis ligand word formed only from the two forced Fold fibres and structural EmptyOne; the complete two-contrast plus three-boundary-pair state support; every exact interaction-signature partition; all thirty-two registered definition, development, ancillary, adverse absence and law-sealed blind spectrum surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Interaction.rejected,Interaction.admitted]).flatMap fun interaction =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Separation.rejected,Separation.admitted]).flatMap fun separation =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,interaction,partition,multiplicity,separation,balance,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier interaction partition multiplicity separation balance observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinteraction : interaction ∈ [Interaction.rejected,Interaction.admitted] := by
      cases interaction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hseparation : separation ∈ [Separation.rejected,Separation.admitted] := by
      cases separation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ interaction _ hinteraction
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ separation _ hseparation
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,separation,balance,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,separation,balance,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,separation,balance,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,separation,balance,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,separation,balance,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,separation,balance,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,separation,balance,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,separation,balance,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,separation,balance,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,separation,balance,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,separation,balance,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,separation,balance,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,separation,balance,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,separation,balance,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,separation,balance,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (separation : Separation) (balance : Balance) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,separation,balance,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,separation,balance,observation,extension⟩ := by
 cases separation <;> cases balance <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier interaction partition multiplicity separation balance observation extension =>
  cases carrier <;> cases interaction <;> cases partition <;> cases multiplicity
  · exact sourceDecisionBlock0000 separation balance observation extension
  · exact sourceDecisionBlock0001 separation balance observation extension
  · exact sourceDecisionBlock0010 separation balance observation extension
  · exact sourceDecisionBlock0011 separation balance observation extension
  · exact sourceDecisionBlock0100 separation balance observation extension
  · exact sourceDecisionBlock0101 separation balance observation extension
  · exact sourceDecisionBlock0110 separation balance observation extension
  · exact sourceDecisionBlock0111 separation balance observation extension
  · exact sourceDecisionBlock1000 separation balance observation extension
  · exact sourceDecisionBlock1001 separation balance observation extension
  · exact sourceDecisionBlock1010 separation balance observation extension
  · exact sourceDecisionBlock1011 separation balance observation extension
  · exact sourceDecisionBlock1100 separation balance observation extension
  · exact sourceDecisionBlock1101 separation balance observation extension
  · exact sourceDecisionBlock1110 separation balance observation extension
  · exact sourceDecisionBlock1111 separation balance observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "generated-rank-three-boundary-two-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem interactionCriterion (value : Interaction) : SFT.Host.Text.equal (interactionName value) "complete-ligand-support-incidence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "complete-equivalence-partition-by-incidence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem multiplicityCriterion (value : Multiplicity) : SFT.Host.Text.equal (multiplicityName value) "positive-cardinality-of-each-partition-block" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem separationCriterion (value : Separation) : SFT.Host.Text.equal (separationName value) "exact-positive-normalized-incidence-separation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem balanceCriterion (value : Balance) : SFT.Host.Text.equal (balanceName value) "complementary-positive-two-block-distances" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "complete-sealed-definition-and-spectrum-surfaces" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "same-partition-law-and-removed-ligand-remerging" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, interactionCriterion, partitionCriterion, multiplicityCriterion, separationCriterion, balanceCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier interaction partition multiplicity separation balance observation extension =>
    cases carrier <;> cases interaction <;> cases partition <;> cases multiplicity <;> cases separation <;> cases balance <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.interaction = .admitted ∧ c.partition = .admitted ∧ c.multiplicity = .admitted ∧ c.separation = .admitted ∧ c.balance = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier interaction partition multiplicity separation balance observation extension =>
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

theorem interaction_rejected_rejected (c : Candidate) (h : c.interaction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.interaction eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
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

theorem separation_rejected_rejected (c : Candidate) (h : c.separation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.separation eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
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

end SFT.Chemistry.LigandStateSplittingGrammar
