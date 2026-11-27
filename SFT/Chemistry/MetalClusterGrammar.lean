import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MetalClusterGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "free-cluster-name"
  | .admitted => "one-retained-cluster-entity"

inductive Centres where
  | rejected | admitted

def centresName : Centres → String
  | .rejected => "selected-metal-pair"
  | .admitted => "complete-finite-multicentre-support"

inductive Connectivity where
  | rejected | admitted

def connectivityName : Connectivity → String
  | .rejected => "proximity-only-list"
  | .admitted => "complete-connected-cluster-relation-graph"

inductive Direct where
  | rejected | admitted

def directName : Direct → String
  | .rejected => "assumed-metal-metal-bond"
  | .admitted => "explicit-direct-metal-bond-subgraph"

inductive Bridge where
  | rejected | admitted

def bridgeName : Bridge → String
  | .rejected => "implicit-ligand-bridge"
  | .admitted => "complete-bridging-ligand-path-support"

inductive Grouping where
  | rejected | admitted

def groupingName : Grouping → String
  | .rejected => "bond-required-cluster-definition"
  | .admitted => "held-grouping-relation-without-bond-necessity"

inductive Counts where
  | rejected | admitted

def countsName : Counts → String
  | .rejected => "numerical-zero-missing-mode"
  | .admitted => "positive-count-or-EmptyOne-per-relation-class"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "catalogue-specific-exception"
  | .admitted => "connected-centre-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  centres : Centres
  connectivity : Connectivity
  direct : Direct
  bridge : Bridge
  grouping : Grouping
  counts : Counts
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, centresName c.centres, connectivityName c.connectivity, directName c.direct, bridgeName c.bridge, groupingName c.grouping, countsName c.counts, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "centres=" (centresName c.centres), SFT.Host.Text.append "connectivity=" (connectivityName c.connectivity), SFT.Host.Text.append "direct=" (directName c.direct), SFT.Host.Text.append "bridge=" (bridgeName c.bridge), SFT.Host.Text.append "grouping=" (groupingName c.grouping), SFT.Host.Text.append "counts=" (countsName c.counts), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-cluster-entity__complete-finite-multicentre-support__complete-connected-cluster-relation-graph__explicit-direct-metal-bond-subgraph__complete-bridging-ligand-path-support__held-grouping-relation-without-bond-necessity__positive-count-or-EmptyOne-per-relation-class__connected-centre-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-cluster-entity" &&
  SFT.Host.Text.equal (centresName c.centres) "complete-finite-multicentre-support" &&
  SFT.Host.Text.equal (connectivityName c.connectivity) "complete-connected-cluster-relation-graph" &&
  SFT.Host.Text.equal (directName c.direct) "explicit-direct-metal-bond-subgraph" &&
  SFT.Host.Text.equal (bridgeName c.bridge) "complete-bridging-ligand-path-support" &&
  SFT.Host.Text.equal (groupingName c.grouping) "held-grouping-relation-without-bond-necessity" &&
  SFT.Host.Text.equal (countsName c.counts) "positive-count-or-EmptyOne-per-relation-class" &&
  SFT.Host.Text.equal (extensionName c.extension) "connected-centre-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-cluster-entity") then "A name loses centre support." else
  if !(SFT.Host.Text.equal (centresName c.centres) "complete-finite-multicentre-support") then "A selected pair loses remaining centres." else
  if !(SFT.Host.Text.equal (connectivityName c.connectivity) "complete-connected-cluster-relation-graph") then "A list does not prove connected support." else
  if !(SFT.Host.Text.equal (directName c.direct) "explicit-direct-metal-bond-subgraph") then "Assumption confuses grouping with bonding." else
  if !(SFT.Host.Text.equal (bridgeName c.bridge) "complete-bridging-ligand-path-support") then "An implicit bridge loses ligand occurrences." else
  if !(SFT.Host.Text.equal (groupingName c.grouping) "held-grouping-relation-without-bond-necessity") then "Requiring a bond rejects lawful held grouping." else
  if !(SFT.Host.Text.equal (countsName c.counts) "positive-count-or-EmptyOne-per-relation-class") then "Numerical zero is not structural absence." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "connected-centre-successor-no-extra-rule") then "A catalogue destroys closure." else
  "one-retained-cluster-entity__complete-finite-multicentre-support__complete-connected-cluster-relation-graph__explicit-direct-metal-bond-subgraph__complete-bridging-ligand-path-support__held-grouping-relation-without-bond-necessity__positive-count-or-EmptyOne-per-relation-class__connected-centre-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, centres, connectivity, direct, bridge, grouping, count and extension alternatives; decide all 256 forms from admitted graph, bond, composition and coordination dependencies."
def grammarBoundary : String := "Every finite connected graph of at least two metal centres with direct, bridging or held grouping relations and explicit bridge occurrences; all ten frozen cluster and iron-sulfur-cluster topology, example and charge-inscription surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Centres.rejected,Centres.admitted]).flatMap fun centres =>
  ([Connectivity.rejected,Connectivity.admitted]).flatMap fun connectivity =>
  ([Direct.rejected,Direct.admitted]).flatMap fun direct =>
  ([Bridge.rejected,Bridge.admitted]).flatMap fun bridge =>
  ([Grouping.rejected,Grouping.admitted]).flatMap fun grouping =>
  ([Counts.rejected,Counts.admitted]).flatMap fun counts =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,centres,connectivity,direct,bridge,grouping,counts,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier centres connectivity direct bridge grouping counts extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcentres : centres ∈ [Centres.rejected,Centres.admitted] := by
      cases centres <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconnectivity : connectivity ∈ [Connectivity.rejected,Connectivity.admitted] := by
      cases connectivity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdirect : direct ∈ [Direct.rejected,Direct.admitted] := by
      cases direct <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbridge : bridge ∈ [Bridge.rejected,Bridge.admitted] := by
      cases bridge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgrouping : grouping ∈ [Grouping.rejected,Grouping.admitted] := by
      cases grouping <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcounts : counts ∈ [Counts.rejected,Counts.admitted] := by
      cases counts <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ centres _ hcentres
    apply CommonRefinement.memFlatMap _ _ connectivity _ hconnectivity
    apply CommonRefinement.memFlatMap _ _ direct _ hdirect
    apply CommonRefinement.memFlatMap _ _ bridge _ hbridge
    apply CommonRefinement.memFlatMap _ _ grouping _ hgrouping
    apply CommonRefinement.memFlatMap _ _ counts _ hcounts
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (bridge : Bridge) (grouping : Grouping) (counts : Counts) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,bridge,grouping,counts,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,bridge,grouping,counts,extension⟩ := by
 cases bridge <;> cases grouping <;> cases counts <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier centres connectivity direct bridge grouping counts extension =>
  cases carrier <;> cases centres <;> cases connectivity <;> cases direct
  · exact sourceDecisionBlock0000 bridge grouping counts extension
  · exact sourceDecisionBlock0001 bridge grouping counts extension
  · exact sourceDecisionBlock0010 bridge grouping counts extension
  · exact sourceDecisionBlock0011 bridge grouping counts extension
  · exact sourceDecisionBlock0100 bridge grouping counts extension
  · exact sourceDecisionBlock0101 bridge grouping counts extension
  · exact sourceDecisionBlock0110 bridge grouping counts extension
  · exact sourceDecisionBlock0111 bridge grouping counts extension
  · exact sourceDecisionBlock1000 bridge grouping counts extension
  · exact sourceDecisionBlock1001 bridge grouping counts extension
  · exact sourceDecisionBlock1010 bridge grouping counts extension
  · exact sourceDecisionBlock1011 bridge grouping counts extension
  · exact sourceDecisionBlock1100 bridge grouping counts extension
  · exact sourceDecisionBlock1101 bridge grouping counts extension
  · exact sourceDecisionBlock1110 bridge grouping counts extension
  · exact sourceDecisionBlock1111 bridge grouping counts extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-cluster-entity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem centresCriterion (value : Centres) : SFT.Host.Text.equal (centresName value) "complete-finite-multicentre-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem connectivityCriterion (value : Connectivity) : SFT.Host.Text.equal (connectivityName value) "complete-connected-cluster-relation-graph" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem directCriterion (value : Direct) : SFT.Host.Text.equal (directName value) "explicit-direct-metal-bond-subgraph" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem bridgeCriterion (value : Bridge) : SFT.Host.Text.equal (bridgeName value) "complete-bridging-ligand-path-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem groupingCriterion (value : Grouping) : SFT.Host.Text.equal (groupingName value) "held-grouping-relation-without-bond-necessity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem countsCriterion (value : Counts) : SFT.Host.Text.equal (countsName value) "positive-count-or-EmptyOne-per-relation-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "connected-centre-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, centresCriterion, connectivityCriterion, directCriterion, bridgeCriterion, groupingCriterion, countsCriterion, extensionCriterion]
  cases c with
  | mk carrier centres connectivity direct bridge grouping counts extension =>
    cases carrier <;> cases centres <;> cases connectivity <;> cases direct <;> cases bridge <;> cases grouping <;> cases counts <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.centres = .admitted ∧ c.connectivity = .admitted ∧ c.direct = .admitted ∧ c.bridge = .admitted ∧ c.grouping = .admitted ∧ c.counts = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier centres connectivity direct bridge grouping counts extension =>
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

theorem centres_rejected_rejected (c : Candidate) (h : c.centres = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.centres eq
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

theorem direct_rejected_rejected (c : Candidate) (h : c.direct = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.direct eq
    rw [h] at field
    cases field

theorem bridge_rejected_rejected (c : Candidate) (h : c.bridge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bridge eq
    rw [h] at field
    cases field

theorem grouping_rejected_rejected (c : Candidate) (h : c.grouping = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.grouping eq
    rw [h] at field
    cases field

theorem counts_rejected_rejected (c : Candidate) (h : c.counts = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.counts eq
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

end SFT.Chemistry.MetalClusterGrammar
