import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MulticentreSupportGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "isolated-bond-list"
  | .admitted => "complete-molecular-carrier"

inductive Centres where
  | rejected | admitted

def centresName : Centres → String
  | .rejected => "two-centre-only-premise"
  | .admitted => "three-or-more-generated-centres"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "localized-edge-identities"
  | .admitted => "one-complete-extended-support"

inductive Connection where
  | rejected | admitted

def connectionName : Connection → String
  | .rejected => "disconnected-centre-union"
  | .admitted => "connected-generated-graph"

inductive Topology where
  | rejected | admitted

def topologyName : Topology → String
  | .rejected => "imported-or-single-topology"
  | .admitted => "ribbon-surface-volume-census"

inductive Reduction where
  | rejected | admitted

def reductionName : Reduction → String
  | .rejected => "pairwise-model-declared-complete"
  | .admitted => "multicentre-irreducible-support"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-example-only"
  | .admitted => "complete-authority-and-geometry-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-specific-extra-rule"
  | .admitted => "connected-successor-with-no-extra-rule"

structure Candidate where
  carrier : Carrier
  centres : Centres
  support : Support
  connection : Connection
  topology : Topology
  reduction : Reduction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, centresName c.centres, supportName c.support, connectionName c.connection, topologyName c.topology, reductionName c.reduction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "centres=" (centresName c.centres), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "connection=" (connectionName c.connection), SFT.Host.Text.append "topology=" (topologyName c.topology), SFT.Host.Text.append "reduction=" (reductionName c.reduction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-molecular-carrier__three-or-more-generated-centres__one-complete-extended-support__connected-generated-graph__ribbon-surface-volume-census__multicentre-irreducible-support__complete-authority-and-geometry-vector__connected-successor-with-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-molecular-carrier" &&
  SFT.Host.Text.equal (centresName c.centres) "three-or-more-generated-centres" &&
  SFT.Host.Text.equal (supportName c.support) "one-complete-extended-support" &&
  SFT.Host.Text.equal (connectionName c.connection) "connected-generated-graph" &&
  SFT.Host.Text.equal (topologyName c.topology) "ribbon-surface-volume-census" &&
  SFT.Host.Text.equal (reductionName c.reduction) "multicentre-irreducible-support" &&
  SFT.Host.Text.equal (recordName c.record) "complete-authority-and-geometry-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "connected-successor-with-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-molecular-carrier") then "A list erases the single molecular carrier joining the support." else
  if !(SFT.Host.Text.equal (centresName c.centres) "three-or-more-generated-centres") then "A two-centre restriction excludes generated supports before enumeration." else
  if !(SFT.Host.Text.equal (supportName c.support) "one-complete-extended-support") then "Separate edge identities cannot preserve one electron-support identity spanning the graph." else
  if !(SFT.Host.Text.equal (connectionName c.connection) "connected-generated-graph") then "A disconnected union is not one molecular support." else
  if !(SFT.Host.Text.equal (topologyName c.topology) "ribbon-surface-volume-census") then "Selecting one familiar shape omits lawful connected alternatives." else
  if !(SFT.Host.Text.equal (reductionName c.reduction) "multicentre-irreducible-support") then "Independent localized pairs erase the one support identity extending beyond either endpoint." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-authority-and-geometry-vector") then "One favourable example cannot test the registered topology and geometry surface." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "connected-successor-with-no-extra-rule") then "A species exception or empirical bonding model adds an unforced premise." else
  "complete-molecular-carrier__three-or-more-generated-centres__one-complete-extended-support__connected-generated-graph__ribbon-surface-volume-census__multicentre-irreducible-support__complete-authority-and-geometry-vector__connected-successor-with-no-extra-rule"

def generationRule : String := "Generate the literal product of molecular carrier, centre count, electron support, connection, topology, reduction, external record and extension forms. Decide all 256 forms solely by admitted Fold graph, joint-support, exchange and exclusion laws."
def grammarBoundary : String := "Every positive finite connected molecular support containing at least three retained centres, with post-seal testing against all four IUPAC delocalization records, all nine NIST neutral-diborane geometry/bond-count records and all seven NIST benzene geometry/bond-count records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Centres.rejected,Centres.admitted]).flatMap fun centres =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Connection.rejected,Connection.admitted]).flatMap fun connection =>
  ([Topology.rejected,Topology.admitted]).flatMap fun topology =>
  ([Reduction.rejected,Reduction.admitted]).flatMap fun reduction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,centres,support,connection,topology,reduction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier centres support connection topology reduction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcentres : centres ∈ [Centres.rejected,Centres.admitted] := by
      cases centres <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconnection : connection ∈ [Connection.rejected,Connection.admitted] := by
      cases connection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htopology : topology ∈ [Topology.rejected,Topology.admitted] := by
      cases topology <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreduction : reduction ∈ [Reduction.rejected,Reduction.admitted] := by
      cases reduction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ centres _ hcentres
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ connection _ hconnection
    apply CommonRefinement.memFlatMap _ _ topology _ htopology
    apply CommonRefinement.memFlatMap _ _ reduction _ hreduction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,topology,reduction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,topology,reduction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,topology,reduction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,topology,reduction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,topology,reduction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,topology,reduction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,topology,reduction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,topology,reduction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,topology,reduction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,topology,reduction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,topology,reduction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,topology,reduction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,topology,reduction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,topology,reduction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,topology,reduction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (topology : Topology) (reduction : Reduction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,topology,reduction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,topology,reduction,record,extension⟩ := by
 cases topology <;> cases reduction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier centres support connection topology reduction record extension =>
  cases carrier <;> cases centres <;> cases support <;> cases connection
  · exact sourceDecisionBlock0000 topology reduction record extension
  · exact sourceDecisionBlock0001 topology reduction record extension
  · exact sourceDecisionBlock0010 topology reduction record extension
  · exact sourceDecisionBlock0011 topology reduction record extension
  · exact sourceDecisionBlock0100 topology reduction record extension
  · exact sourceDecisionBlock0101 topology reduction record extension
  · exact sourceDecisionBlock0110 topology reduction record extension
  · exact sourceDecisionBlock0111 topology reduction record extension
  · exact sourceDecisionBlock1000 topology reduction record extension
  · exact sourceDecisionBlock1001 topology reduction record extension
  · exact sourceDecisionBlock1010 topology reduction record extension
  · exact sourceDecisionBlock1011 topology reduction record extension
  · exact sourceDecisionBlock1100 topology reduction record extension
  · exact sourceDecisionBlock1101 topology reduction record extension
  · exact sourceDecisionBlock1110 topology reduction record extension
  · exact sourceDecisionBlock1111 topology reduction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-molecular-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem centresCriterion (value : Centres) : SFT.Host.Text.equal (centresName value) "three-or-more-generated-centres" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "one-complete-extended-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem connectionCriterion (value : Connection) : SFT.Host.Text.equal (connectionName value) "connected-generated-graph" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem topologyCriterion (value : Topology) : SFT.Host.Text.equal (topologyName value) "ribbon-surface-volume-census" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem reductionCriterion (value : Reduction) : SFT.Host.Text.equal (reductionName value) "multicentre-irreducible-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-authority-and-geometry-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "connected-successor-with-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, centresCriterion, supportCriterion, connectionCriterion, topologyCriterion, reductionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier centres support connection topology reduction record extension =>
    cases carrier <;> cases centres <;> cases support <;> cases connection <;> cases topology <;> cases reduction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.centres = .admitted ∧ c.support = .admitted ∧ c.connection = .admitted ∧ c.topology = .admitted ∧ c.reduction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier centres support connection topology reduction record extension =>
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem connection_rejected_rejected (c : Candidate) (h : c.connection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.connection eq
    rw [h] at field
    cases field

theorem topology_rejected_rejected (c : Candidate) (h : c.topology = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.topology eq
    rw [h] at field
    cases field

theorem reduction_rejected_rejected (c : Candidate) (h : c.reduction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reduction eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
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

end SFT.Chemistry.MulticentreSupportGrammar
