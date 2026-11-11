import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SolutionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "gas-or-unclassified-matter"
  | .admitted => "liquid-or-solid-phase"

inductive Phase where
  | rejected | admitted

def phaseName : Phase → String
  | .rejected => "multiple-unresolved-phases"
  | .admitted => "single-phase-support"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "single-substance-phase"
  | .admitted => "multiple-substance-support"

inductive Roles where
  | rejected | admitted

def rolesName : Roles → String
  | .rejected => "unpartitioned-components"
  | .admitted => "solvent-solute-role-partition"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "roles-replace-identity"
  | .admitted => "substance-identities-retained"

inductive Context where
  | rejected | admitted

def contextName : Context → String
  | .rejected => "intrinsic-permanent-role"
  | .admitted => "declared-context-role"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "solution-name-only"
  | .admitted => "phase-component-role-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-solution-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  phase : Phase
  composition : Composition
  roles : Roles
  identity : Identity
  context : Context
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, phaseName c.phase, compositionName c.composition, rolesName c.roles, identityName c.identity, contextName c.context, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "phase=" (phaseName c.phase), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "roles=" (rolesName c.roles), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "context=" (contextName c.context), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "liquid-or-solid-phase__single-phase-support__multiple-substance-support__solvent-solute-role-partition__substance-identities-retained__declared-context-role__phase-component-role-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "liquid-or-solid-phase" &&
  SFT.Host.Text.equal (phaseName c.phase) "single-phase-support" &&
  SFT.Host.Text.equal (compositionName c.composition) "multiple-substance-support" &&
  SFT.Host.Text.equal (rolesName c.roles) "solvent-solute-role-partition" &&
  SFT.Host.Text.equal (identityName c.identity) "substance-identities-retained" &&
  SFT.Host.Text.equal (contextName c.context) "declared-context-role" &&
  SFT.Host.Text.equal (recordName c.record) "phase-component-role-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "liquid-or-solid-phase") then "The registered solution boundary is a liquid or solid phase." else
  if !(SFT.Host.Text.equal (phaseName c.phase) "single-phase-support") then "Unresolved phase multiplicity does not define one solution carrier." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "multiple-substance-support") then "A pure phase lacks solute/solvent distinction." else
  if !(SFT.Host.Text.equal (rolesName c.roles) "solvent-solute-role-partition") then "A solution record distinguishes solvent from solutes." else
  if !(SFT.Host.Text.equal (identityName c.identity) "substance-identities-retained") then "A role label must not erase substance identity." else
  if !(SFT.Host.Text.equal (contextName c.context) "declared-context-role") then "Solvent/solute assignment can depend on the description context." else
  if !(SFT.Host.Text.equal (recordName c.record) "phase-component-role-trace") then "A name cannot reproduce phase and roles." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can relabel a multiphase mixture as one solution." else
  "liquid-or-solid-phase__single-phase-support__multiple-substance-support__solvent-solute-role-partition"

def generationRule : String := "Generate the literal product of the registered solution carrier, phase, composition, roles, identity, context, record and extension choices."
def grammarBoundary : String := "Every finite liquid or solid single-phase mixture with multiple retained substances and an explicit contextual partition between solvent carrier roles and solute carrier roles."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Phase.rejected,Phase.admitted]).flatMap fun phase =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Roles.rejected,Roles.admitted]).flatMap fun roles =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Context.rejected,Context.admitted]).flatMap fun context =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,phase,composition,roles,identity,context,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier phase composition roles identity context record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphase : phase ∈ [Phase.rejected,Phase.admitted] := by
      cases phase <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hroles : roles ∈ [Roles.rejected,Roles.admitted] := by
      cases roles <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontext : context ∈ [Context.rejected,Context.admitted] := by
      cases context <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ phase _ hphase
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ roles _ hroles
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ context _ hcontext
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier phase composition roles identity context record extension =>
    cases carrier <;> cases phase <;> cases composition <;> cases roles <;> cases identity <;> cases context <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier phase composition roles identity context record extension =>
    cases carrier <;> cases phase <;> cases composition <;> cases roles <;> cases identity <;> cases context <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.phase = .admitted ∧ c.composition = .admitted ∧ c.roles = .admitted ∧ c.identity = .admitted ∧ c.context = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier phase composition roles identity context record extension =>
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

theorem phase_rejected_rejected (c : Candidate) (h : c.phase = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.phase eq
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

theorem roles_rejected_rejected (c : Candidate) (h : c.roles = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.roles eq
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

theorem context_rejected_rejected (c : Candidate) (h : c.context = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.context eq
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

end SFT.Chemistry.SolutionGrammar
