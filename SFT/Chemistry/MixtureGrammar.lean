import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MixtureGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "substance-name-only"
  | .admitted => "portion-of-matter-carrier"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "single-constituent"
  | .admitted => "multiple-constituent-support"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-components"
  | .admitted => "chemical-substance-identities"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "unmeasured-presence-list"
  | .admitted => "exact-positive-composition-parts"

inductive Bonding where
  | rejected | admitted

def bondingName : Bonding → String
  | .rejected => "new-substance-conflation"
  | .admitted => "constituent-identities-retained"

inductive Phase where
  | rejected | admitted

def phaseName : Phase → String
  | .rejected => "single-phase-required"
  | .admitted => "phase-support-recorded-not-forced"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "mixture-label-only"
  | .admitted => "component-part-phase-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-mixture-equivalence"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  multiplicity : Multiplicity
  identity : Identity
  composition : Composition
  bonding : Bonding
  phase : Phase
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, multiplicityName c.multiplicity, identityName c.identity, compositionName c.composition, bondingName c.bonding, phaseName c.phase, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "bonding=" (bondingName c.bonding), SFT.Host.Text.append "phase=" (phaseName c.phase), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "portion-of-matter-carrier__multiple-constituent-support__chemical-substance-identities__exact-positive-composition-parts__constituent-identities-retained__phase-support-recorded-not-forced__component-part-phase-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "portion-of-matter-carrier" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "multiple-constituent-support" &&
  SFT.Host.Text.equal (identityName c.identity) "chemical-substance-identities" &&
  SFT.Host.Text.equal (compositionName c.composition) "exact-positive-composition-parts" &&
  SFT.Host.Text.equal (bondingName c.bonding) "constituent-identities-retained" &&
  SFT.Host.Text.equal (phaseName c.phase) "phase-support-recorded-not-forced" &&
  SFT.Host.Text.equal (recordName c.record) "component-part-phase-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "portion-of-matter-carrier") then "One substance name does not define a mixture." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "multiple-constituent-support") then "A single constituent is not a mixture." else
  if !(SFT.Host.Text.equal (identityName c.identity) "chemical-substance-identities") then "Anonymous components erase chemical distinction." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "exact-positive-composition-parts") then "Presence alone cannot reconstruct composition." else
  if !(SFT.Host.Text.equal (bondingName c.bonding) "constituent-identities-retained") then "Mixing does not by itself force a new chemical identity." else
  if !(SFT.Host.Text.equal (phaseName c.phase) "phase-support-recorded-not-forced") then "Mixtures may contain one or several phases." else
  if !(SFT.Host.Text.equal (recordName c.record) "component-part-phase-trace") then "A label cannot reconstruct components." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An arbitrary equivalence can merge distinct mixtures." else
  "portion-of-matter-carrier__multiple-constituent-support__chemical-substance-identities__exact-positive-composition-parts"

def generationRule : String := "Generate the literal product of the registered mixture carrier, multiplicity, identity, composition, bonding, phase, record and extension choices."
def grammarBoundary : String := "Every finite portion of matter containing multiple retained chemical-substance identities and their exact positive composition parts without requiring a new bonded substance identity."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Bonding.rejected,Bonding.admitted]).flatMap fun bonding =>
  ([Phase.rejected,Phase.admitted]).flatMap fun phase =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,multiplicity,identity,composition,bonding,phase,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier multiplicity identity composition bonding phase record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbonding : bonding ∈ [Bonding.rejected,Bonding.admitted] := by
      cases bonding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphase : phase ∈ [Phase.rejected,Phase.admitted] := by
      cases phase <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ bonding _ hbonding
    apply CommonRefinement.memFlatMap _ _ phase _ hphase
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier multiplicity identity composition bonding phase record extension =>
    cases carrier <;> cases multiplicity <;> cases identity <;> cases composition <;> cases bonding <;> cases phase <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier multiplicity identity composition bonding phase record extension =>
    cases carrier <;> cases multiplicity <;> cases identity <;> cases composition <;> cases bonding <;> cases phase <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.multiplicity = .admitted ∧ c.identity = .admitted ∧ c.composition = .admitted ∧ c.bonding = .admitted ∧ c.phase = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier multiplicity identity composition bonding phase record extension =>
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

theorem multiplicity_rejected_rejected (c : Candidate) (h : c.multiplicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

theorem phase_rejected_rejected (c : Candidate) (h : c.phase = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.phase eq
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

end SFT.Chemistry.MixtureGrammar
