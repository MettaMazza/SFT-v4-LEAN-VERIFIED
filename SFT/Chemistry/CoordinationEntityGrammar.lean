import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CoordinationEntityGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "formula-or-name-only"
  | .admitted => "complete-coordination-entity-carrier"

inductive Role where
  | rejected | admitted

def roleName : Role → String
  | .rejected => "conventional-central-and-ligand-names-imported"
  | .admitted => "incidence-forced-central-and-surrounding-roles"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "element-or-ligand-occurrences-collapsed"
  | .admitted => "central-and-every-ligand-occurrence-retained"

inductive Attachment where
  | rejected | admitted

def attachmentName : Attachment → String
  | .rejected => "proximity-or-continuum-distance-only"
  | .admitted => "positive-central-ligand-incidence-trace"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "selected-or-average-ligand-support"
  | .admitted => "complete-gap-free-ligand-support"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-or-negative-vacancy"
  | .admitted => "structural-EmptyOne-only"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "source-structure-visible-before-seal"
  | .admitted => "complete-20-record-identity-sealed-structure-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "successor-replaces-central-or-prior-ligand"
  | .admitted => "next-ligand-preserves-entire-prior-entity"

structure Candidate where
  carrier : Carrier
  role : Role
  identity : Identity
  attachment : Attachment
  composition : Composition
  absence : Absence
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, roleName c.role, identityName c.identity, attachmentName c.attachment, compositionName c.composition, absenceName c.absence, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "role=" (roleName c.role), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "attachment=" (attachmentName c.attachment), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-coordination-entity-carrier__incidence-forced-central-and-surrounding-roles__central-and-every-ligand-occurrence-retained__positive-central-ligand-incidence-trace__complete-gap-free-ligand-support__structural-EmptyOne-only__complete-20-record-identity-sealed-structure-vector__next-ligand-preserves-entire-prior-entity"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-coordination-entity-carrier" &&
  SFT.Host.Text.equal (roleName c.role) "incidence-forced-central-and-surrounding-roles" &&
  SFT.Host.Text.equal (identityName c.identity) "central-and-every-ligand-occurrence-retained" &&
  SFT.Host.Text.equal (attachmentName c.attachment) "positive-central-ligand-incidence-trace" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-gap-free-ligand-support" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-only" &&
  SFT.Host.Text.equal (observationName c.observation) "complete-20-record-identity-sealed-structure-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "next-ligand-preserves-entire-prior-entity"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-coordination-entity-carrier") then "A name does not retain the entity's generated constituents." else
  if !(SFT.Host.Text.equal (roleName c.role) "incidence-forced-central-and-surrounding-roles") then "Imported role names cannot force which occurrence is common to every incidence." else
  if !(SFT.Host.Text.equal (identityName c.identity) "central-and-every-ligand-occurrence-retained") then "Collapsing repeated labels erases distinct occurrences." else
  if !(SFT.Host.Text.equal (attachmentName c.attachment) "positive-central-ligand-incidence-trace") then "Proximity alone does not retain a generated attachment." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complete-gap-free-ligand-support") then "Selection or averaging erases members of the coordination entity." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-only") then "Numerical zero and signed vacancy are not Fold-native forms." else
  if !(SFT.Host.Text.equal (observationName c.observation) "complete-20-record-identity-sealed-structure-vector") then "Observed structures could select the law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "next-ligand-preserves-entire-prior-entity") then "Replacement destroys retained identity." else
  "complete-coordination-entity-carrier__incidence-forced-central-and-surrounding-roles__central-and-every-ligand-occurrence-retained__positive-central-ligand-incidence-trace__complete-gap-free-ligand-support__structural-EmptyOne-only__complete-20-record-identity-sealed-structure-vector__next-ligand-preserves-entire-prior-entity"

def generationRule : String := "Generate the literal product of carrier, role, identity, attachment, composition, absence, observation and extension forms. Decide all 256 forms only by admitted Fold identity, finite incidence, exact composition, source-boundary and successor laws."
def grammarBoundary : String := "Every positive finite single-central coordination support with one or more distinct attached ligand occurrences, tested after seal against all twenty registered IUPAC and NIST definition, structure, value, reference and limitation records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Role.rejected,Role.admitted]).flatMap fun role =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Attachment.rejected,Attachment.admitted]).flatMap fun attachment =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,role,identity,attachment,composition,absence,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier role identity attachment composition absence observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrole : role ∈ [Role.rejected,Role.admitted] := by
      cases role <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hattachment : attachment ∈ [Attachment.rejected,Attachment.admitted] := by
      cases attachment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ role _ hrole
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ attachment _ hattachment
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,composition,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,composition,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,composition,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,composition,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,composition,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,composition,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,composition,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,composition,absence,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,composition,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,composition,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,composition,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,composition,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,composition,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,composition,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,composition,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (composition : Composition) (absence : Absence) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,composition,absence,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,composition,absence,observation,extension⟩ := by
 cases composition <;> cases absence <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier role identity attachment composition absence observation extension =>
  cases carrier <;> cases role <;> cases identity <;> cases attachment
  · exact sourceDecisionBlock0000 composition absence observation extension
  · exact sourceDecisionBlock0001 composition absence observation extension
  · exact sourceDecisionBlock0010 composition absence observation extension
  · exact sourceDecisionBlock0011 composition absence observation extension
  · exact sourceDecisionBlock0100 composition absence observation extension
  · exact sourceDecisionBlock0101 composition absence observation extension
  · exact sourceDecisionBlock0110 composition absence observation extension
  · exact sourceDecisionBlock0111 composition absence observation extension
  · exact sourceDecisionBlock1000 composition absence observation extension
  · exact sourceDecisionBlock1001 composition absence observation extension
  · exact sourceDecisionBlock1010 composition absence observation extension
  · exact sourceDecisionBlock1011 composition absence observation extension
  · exact sourceDecisionBlock1100 composition absence observation extension
  · exact sourceDecisionBlock1101 composition absence observation extension
  · exact sourceDecisionBlock1110 composition absence observation extension
  · exact sourceDecisionBlock1111 composition absence observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-coordination-entity-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem roleCriterion (value : Role) : SFT.Host.Text.equal (roleName value) "incidence-forced-central-and-surrounding-roles" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "central-and-every-ligand-occurrence-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem attachmentCriterion (value : Attachment) : SFT.Host.Text.equal (attachmentName value) "positive-central-ligand-incidence-trace" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "complete-gap-free-ligand-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-only" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "complete-20-record-identity-sealed-structure-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "next-ligand-preserves-entire-prior-entity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, roleCriterion, identityCriterion, attachmentCriterion, compositionCriterion, absenceCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier role identity attachment composition absence observation extension =>
    cases carrier <;> cases role <;> cases identity <;> cases attachment <;> cases composition <;> cases absence <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.role = .admitted ∧ c.identity = .admitted ∧ c.attachment = .admitted ∧ c.composition = .admitted ∧ c.absence = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier role identity attachment composition absence observation extension =>
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

theorem role_rejected_rejected (c : Candidate) (h : c.role = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.role eq
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

theorem attachment_rejected_rejected (c : Candidate) (h : c.attachment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.attachment eq
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

end SFT.Chemistry.CoordinationEntityGrammar
