import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AmphotericGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Species where
  | rejected | admitted

def speciesName : Species → String
  | .rejected => "two-unrelated-species"
  | .admitted => "same-species-identity"

inductive AcidContext where
  | rejected | admitted

def acidContextName : AcidContext → String
  | .rejected => "acid-label-without-event"
  | .admitted => "valid-donor-event"

inductive BaseContext where
  | rejected | admitted

def baseContextName : BaseContext → String
  | .rejected => "base-label-without-event"
  | .admitted => "valid-acceptor-event"

inductive Context where
  | rejected | admitted

def contextName : Context → String
  | .rejected => "roles-conflated"
  | .admitted => "contexts-separately-held"

inductive Duality where
  | rejected | admitted

def dualityName : Duality → String
  | .rejected => "one-role-only"
  | .admitted => "both-roles-realized"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "species-changed-between-roles"
  | .admitted => "species-identity-retained"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "amphoteric-label-only"
  | .admitted => "dual-event-context-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-dual-role-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  species : Species
  acidContext : AcidContext
  baseContext : BaseContext
  context : Context
  duality : Duality
  identity : Identity
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [speciesName c.species, acidContextName c.acidContext, baseContextName c.baseContext, contextName c.context, dualityName c.duality, identityName c.identity, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "species=" (speciesName c.species), SFT.Host.Text.append "acid-context=" (acidContextName c.acidContext), SFT.Host.Text.append "base-context=" (baseContextName c.baseContext), SFT.Host.Text.append "context=" (contextName c.context), SFT.Host.Text.append "duality=" (dualityName c.duality), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "same-species-identity__valid-donor-event__valid-acceptor-event__contexts-separately-held__both-roles-realized__species-identity-retained__dual-event-context-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (speciesName c.species) "same-species-identity" &&
  SFT.Host.Text.equal (acidContextName c.acidContext) "valid-donor-event" &&
  SFT.Host.Text.equal (baseContextName c.baseContext) "valid-acceptor-event" &&
  SFT.Host.Text.equal (contextName c.context) "contexts-separately-held" &&
  SFT.Host.Text.equal (dualityName c.duality) "both-roles-realized" &&
  SFT.Host.Text.equal (identityName c.identity) "species-identity-retained" &&
  SFT.Host.Text.equal (recordName c.record) "dual-event-context-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (speciesName c.species) "same-species-identity") then "Dual behavior must belong to one retained carrier identity." else
  if !(SFT.Host.Text.equal (acidContextName c.acidContext) "valid-donor-event") then "A label does not establish donation." else
  if !(SFT.Host.Text.equal (baseContextName c.baseContext) "valid-acceptor-event") then "A label does not establish acceptance." else
  if !(SFT.Host.Text.equal (contextName c.context) "contexts-separately-held") then "Conflation can assert incompatible events simultaneously." else
  if !(SFT.Host.Text.equal (dualityName c.duality) "both-roles-realized") then "One role does not close amphoteric behavior." else
  if !(SFT.Host.Text.equal (identityName c.identity) "species-identity-retained") then "A changed carrier does not establish dual capacity." else
  if !(SFT.Host.Text.equal (recordName c.record) "dual-event-context-trace") then "A label cannot reproduce both contexts." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can admit any species." else
  "same-species-identity__valid-donor-event__valid-acceptor-event__contexts-separately-held__both-roles-realized"

def generationRule : String := "Generate the literal product of the registered amphoteric species, acid context, base context, context separation, duality, identity, record and extension choices."
def grammarBoundary : String := "Every finite chemical carrier for which two separately registered contexts contain a valid donor transition and a valid acceptor transition involving that same retained species identity."

def candidates : List Candidate :=
  ([Species.rejected,Species.admitted]).flatMap fun species =>
  ([AcidContext.rejected,AcidContext.admitted]).flatMap fun acidContext =>
  ([BaseContext.rejected,BaseContext.admitted]).flatMap fun baseContext =>
  ([Context.rejected,Context.admitted]).flatMap fun context =>
  ([Duality.rejected,Duality.admitted]).flatMap fun duality =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨species,acidContext,baseContext,context,duality,identity,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk species acidContext baseContext context duality identity record extension =>
    have hspecies : species ∈ [Species.rejected,Species.admitted] := by
      cases species <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacidContext : acidContext ∈ [AcidContext.rejected,AcidContext.admitted] := by
      cases acidContext <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbaseContext : baseContext ∈ [BaseContext.rejected,BaseContext.admitted] := by
      cases baseContext <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontext : context ∈ [Context.rejected,Context.admitted] := by
      cases context <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hduality : duality ∈ [Duality.rejected,Duality.admitted] := by
      cases duality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ species _ hspecies
    apply CommonRefinement.memFlatMap _ _ acidContext _ hacidContext
    apply CommonRefinement.memFlatMap _ _ baseContext _ hbaseContext
    apply CommonRefinement.memFlatMap _ _ context _ hcontext
    apply CommonRefinement.memFlatMap _ _ duality _ hduality
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk species acidContext baseContext context duality identity record extension =>
    cases species <;> cases acidContext <;> cases baseContext <;> cases context <;> cases duality <;> cases identity <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk species acidContext baseContext context duality identity record extension =>
    cases species <;> cases acidContext <;> cases baseContext <;> cases context <;> cases duality <;> cases identity <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.species = .admitted ∧ c.acidContext = .admitted ∧ c.baseContext = .admitted ∧ c.context = .admitted ∧ c.duality = .admitted ∧ c.identity = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk species acidContext baseContext context duality identity record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem species_rejected_rejected (c : Candidate) (h : c.species = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.species eq
    rw [h] at field
    cases field

theorem acidContext_rejected_rejected (c : Candidate) (h : c.acidContext = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.acidContext eq
    rw [h] at field
    cases field

theorem baseContext_rejected_rejected (c : Candidate) (h : c.baseContext = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.baseContext eq
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

theorem duality_rejected_rejected (c : Candidate) (h : c.duality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.duality eq
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

end SFT.Chemistry.AmphotericGrammar
