import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.IonicGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "neutral-atom-pair-only"
  | .admitted => "cation-anion-carriers"

inductive Formation where
  | rejected | admitted

def formationName : Formation → String
  | .rejected => "unpaired-charge-creation"
  | .admitted => "closed-charge-transfer"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-charge-magnitudes"
  | .admitted => "opposed-held-charge-fibres"

inductive Interaction where
  | rejected | admitted

def interactionName : Interaction → String
  | .rejected => "generic-proximity"
  | .admitted => "electrostatic-attraction-support"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "element-identity-erased"
  | .admitted => "chemical-identities-retained"

inductive Character where
  | rejected | admitted

def characterName : Character → String
  | .rejected => "pure-binary-dogma"
  | .admitted => "exact-support-composition"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "ionic-label-only"
  | .admitted => "ion-transfer-interaction-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-electronegativity-cutoff"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  formation : Formation
  orientation : Orientation
  interaction : Interaction
  identity : Identity
  character : Character
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, formationName c.formation, orientationName c.orientation, interactionName c.interaction, identityName c.identity, characterName c.character, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "formation=" (formationName c.formation), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "interaction=" (interactionName c.interaction), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "character=" (characterName c.character), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "cation-anion-carriers__closed-charge-transfer__opposed-held-charge-fibres__electrostatic-attraction-support__chemical-identities-retained__exact-support-composition__ion-transfer-interaction-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "cation-anion-carriers" &&
  SFT.Host.Text.equal (formationName c.formation) "closed-charge-transfer" &&
  SFT.Host.Text.equal (orientationName c.orientation) "opposed-held-charge-fibres" &&
  SFT.Host.Text.equal (interactionName c.interaction) "electrostatic-attraction-support" &&
  SFT.Host.Text.equal (identityName c.identity) "chemical-identities-retained" &&
  SFT.Host.Text.equal (characterName c.character) "exact-support-composition" &&
  SFT.Host.Text.equal (recordName c.record) "ion-transfer-interaction-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "cation-anion-carriers") then "The ionic class requires retained ion carriers." else
  if !(SFT.Host.Text.equal (formationName c.formation) "closed-charge-transfer") then "Charge cannot appear without conserved transfer." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "opposed-held-charge-fibres") then "Negative proof magnitude is inadmissible." else
  if !(SFT.Host.Text.equal (interactionName c.interaction) "electrostatic-attraction-support") then "Proximity does not explain ionic stability." else
  if !(SFT.Host.Text.equal (identityName c.identity) "chemical-identities-retained") then "Ion formation preserves nuclear element identity." else
  if !(SFT.Host.Text.equal (characterName c.character) "exact-support-composition") then "Observed bonds may retain both ionic and shared support." else
  if !(SFT.Host.Text.equal (recordName c.record) "ion-transfer-interaction-trace") then "A label cannot reconstruct transfer and attraction." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A fitted cutoff would import the classification." else
  "cation-anion-carriers__closed-charge-transfer__opposed-held-charge-fibres__electrostatic-attraction-support"

def generationRule : String := "Generate the literal product of the registered ionic carrier, formation, orientation, interaction, identity, character, record and extension choices."
def grammarBoundary : String := "Every finite charge-transfer product containing opposed cation/anion held fibres whose closed electric interaction yields stable joint recurrence while both chemical identities remain retained."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Formation.rejected,Formation.admitted]).flatMap fun formation =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Interaction.rejected,Interaction.admitted]).flatMap fun interaction =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Character.rejected,Character.admitted]).flatMap fun character =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,formation,orientation,interaction,identity,character,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier formation orientation interaction identity character record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hformation : formation ∈ [Formation.rejected,Formation.admitted] := by
      cases formation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinteraction : interaction ∈ [Interaction.rejected,Interaction.admitted] := by
      cases interaction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcharacter : character ∈ [Character.rejected,Character.admitted] := by
      cases character <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ formation _ hformation
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ interaction _ hinteraction
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ character _ hcharacter
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier formation orientation interaction identity character record extension =>
    cases carrier <;> cases formation <;> cases orientation <;> cases interaction <;> cases identity <;> cases character <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier formation orientation interaction identity character record extension =>
    cases carrier <;> cases formation <;> cases orientation <;> cases interaction <;> cases identity <;> cases character <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.formation = .admitted ∧ c.orientation = .admitted ∧ c.interaction = .admitted ∧ c.identity = .admitted ∧ c.character = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier formation orientation interaction identity character record extension =>
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

theorem formation_rejected_rejected (c : Candidate) (h : c.formation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.formation eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem character_rejected_rejected (c : Candidate) (h : c.character = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.character eq
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

end SFT.Chemistry.IonicGrammar
