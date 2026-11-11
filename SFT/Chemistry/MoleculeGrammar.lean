import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MoleculeGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Cardinality where
  | rejected | admitted

def cardinalityName : Cardinality → String
  | .rejected => "single-atomic-occurrence"
  | .admitted => "multiple-atomic-occurrences"

inductive Bonding where
  | rejected | admitted

def bondingName : Bonding → String
  | .rejected => "unbonded-collection"
  | .admitted => "complete-bond-support"

inductive Connectivity where
  | rejected | admitted

def connectivityName : Connectivity → String
  | .rejected => "disconnected-components"
  | .admitted => "one-connected-component"

inductive Charge where
  | rejected | admitted

def chargeName : Charge → String
  | .rejected => "open-net-charge-fibre"
  | .admitted => "closed-charge-boundary"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "anonymous-atom-count"
  | .admitted => "constituent-identities-retained"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "formula-alone"
  | .admitted => "complete-structure-identity"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "molecule-label-only"
  | .admitted => "complete-carrier-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-molecule-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  cardinality : Cardinality
  bonding : Bonding
  connectivity : Connectivity
  charge : Charge
  composition : Composition
  identity : Identity
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [cardinalityName c.cardinality, bondingName c.bonding, connectivityName c.connectivity, chargeName c.charge, compositionName c.composition, identityName c.identity, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "cardinality=" (cardinalityName c.cardinality), SFT.Host.Text.append "bonding=" (bondingName c.bonding), SFT.Host.Text.append "connectivity=" (connectivityName c.connectivity), SFT.Host.Text.append "charge=" (chargeName c.charge), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "multiple-atomic-occurrences__complete-bond-support__one-connected-component__closed-charge-boundary__constituent-identities-retained__complete-structure-identity__complete-carrier-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (cardinalityName c.cardinality) "multiple-atomic-occurrences" &&
  SFT.Host.Text.equal (bondingName c.bonding) "complete-bond-support" &&
  SFT.Host.Text.equal (connectivityName c.connectivity) "one-connected-component" &&
  SFT.Host.Text.equal (chargeName c.charge) "closed-charge-boundary" &&
  SFT.Host.Text.equal (compositionName c.composition) "constituent-identities-retained" &&
  SFT.Host.Text.equal (identityName c.identity) "complete-structure-identity" &&
  SFT.Host.Text.equal (recordName c.record) "complete-carrier-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (cardinalityName c.cardinality) "multiple-atomic-occurrences") then "One occurrence has no internal molecular bond graph." else
  if !(SFT.Host.Text.equal (bondingName c.bonding) "complete-bond-support") then "A collection without joining support is not one molecule." else
  if !(SFT.Host.Text.equal (connectivityName c.connectivity) "one-connected-component") then "Disconnected components are separate carriers." else
  if !(SFT.Host.Text.equal (chargeName c.charge) "closed-charge-boundary") then "An open net fibre describes a molecular ion rather than the neutral molecular class." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "constituent-identities-retained") then "Counts without element identities cannot reproduce the carrier." else
  if !(SFT.Host.Text.equal (identityName c.identity) "complete-structure-identity") then "Equal composition need not imply one molecular structure." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-carrier-trace") then "A label cannot reconstruct atoms and bonds." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can admit arbitrary aggregates." else
  "multiple-atomic-occurrences__complete-bond-support__one-connected-component__closed-charge-boundary__constituent-identities-retained"

def generationRule : String := "Generate the literal product of the registered molecule cardinality, bonding, connectivity, charge, composition, identity, record and extension choices."
def grammarBoundary : String := "Every finite generated multi-atomic carrier with complete connected bond support, retained constituent identity and no open net-charge fibre at the registered observation boundary."

def candidates : List Candidate :=
  ([Cardinality.rejected,Cardinality.admitted]).flatMap fun cardinality =>
  ([Bonding.rejected,Bonding.admitted]).flatMap fun bonding =>
  ([Connectivity.rejected,Connectivity.admitted]).flatMap fun connectivity =>
  ([Charge.rejected,Charge.admitted]).flatMap fun charge =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨cardinality,bonding,connectivity,charge,composition,identity,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk cardinality bonding connectivity charge composition identity record extension =>
    have hcardinality : cardinality ∈ [Cardinality.rejected,Cardinality.admitted] := by
      cases cardinality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbonding : bonding ∈ [Bonding.rejected,Bonding.admitted] := by
      cases bonding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconnectivity : connectivity ∈ [Connectivity.rejected,Connectivity.admitted] := by
      cases connectivity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcharge : charge ∈ [Charge.rejected,Charge.admitted] := by
      cases charge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ cardinality _ hcardinality
    apply CommonRefinement.memFlatMap _ _ bonding _ hbonding
    apply CommonRefinement.memFlatMap _ _ connectivity _ hconnectivity
    apply CommonRefinement.memFlatMap _ _ charge _ hcharge
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk cardinality bonding connectivity charge composition identity record extension =>
    cases cardinality <;> cases bonding <;> cases connectivity <;> cases charge <;> cases composition <;> cases identity <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk cardinality bonding connectivity charge composition identity record extension =>
    cases cardinality <;> cases bonding <;> cases connectivity <;> cases charge <;> cases composition <;> cases identity <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.cardinality = .admitted ∧ c.bonding = .admitted ∧ c.connectivity = .admitted ∧ c.charge = .admitted ∧ c.composition = .admitted ∧ c.identity = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk cardinality bonding connectivity charge composition identity record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem cardinality_rejected_rejected (c : Candidate) (h : c.cardinality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cardinality eq
    rw [h] at field
    cases field

theorem bonding_rejected_rejected (c : Candidate) (h : c.bonding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bonding eq
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

theorem charge_rejected_rejected (c : Candidate) (h : c.charge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.charge eq
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
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

end SFT.Chemistry.MoleculeGrammar
