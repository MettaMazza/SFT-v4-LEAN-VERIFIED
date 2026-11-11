import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.BondGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "bond-name-without-atoms"
  | .admitted => "atoms-or-atomic-groups"

inductive Interaction where
  | rejected | admitted

def interactionName : Interaction → String
  | .rejected => "coincidental-proximity"
  | .admitted => "source-bound-interaction-support"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "transient-contact-only"
  | .admitted => "stable-joint-recurrence"

inductive Independence where
  | rejected | admitted

def independenceName : Independence → String
  | .rejected => "parts-only-observation"
  | .admitted => "independent-chemical-entity"

inductive Energy where
  | rejected | admitted

def energyName : Energy → String
  | .rejected => "imported-potential-function"
  | .admitted => "measured-stability-record-separated"

inductive Reversal where
  | rejected | admitted

def reversalName : Reversal → String
  | .rejected => "irreversible-by-definition"
  | .admitted => "opening-closes-to-separated-support"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "bond-label-only"
  | .admitted => "carrier-interaction-recurrence-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-bond-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  interaction : Interaction
  closure : Closure
  independence : Independence
  energy : Energy
  reversal : Reversal
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, interactionName c.interaction, closureName c.closure, independenceName c.independence, energyName c.energy, reversalName c.reversal, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "interaction=" (interactionName c.interaction), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "independence=" (independenceName c.independence), SFT.Host.Text.append "energy=" (energyName c.energy), SFT.Host.Text.append "reversal=" (reversalName c.reversal), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "atoms-or-atomic-groups__source-bound-interaction-support__stable-joint-recurrence__independent-chemical-entity__measured-stability-record-separated__opening-closes-to-separated-support__carrier-interaction-recurrence-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "atoms-or-atomic-groups" &&
  SFT.Host.Text.equal (interactionName c.interaction) "source-bound-interaction-support" &&
  SFT.Host.Text.equal (closureName c.closure) "stable-joint-recurrence" &&
  SFT.Host.Text.equal (independenceName c.independence) "independent-chemical-entity" &&
  SFT.Host.Text.equal (energyName c.energy) "measured-stability-record-separated" &&
  SFT.Host.Text.equal (reversalName c.reversal) "opening-closes-to-separated-support" &&
  SFT.Host.Text.equal (recordName c.record) "carrier-interaction-recurrence-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "atoms-or-atomic-groups") then "A bond name detached from carriers has no chemical support." else
  if !(SFT.Host.Text.equal (interactionName c.interaction) "source-bound-interaction-support") then "Proximity alone need not produce a stable entity." else
  if !(SFT.Host.Text.equal (closureName c.closure) "stable-joint-recurrence") then "A contact without recurrence is not an independent bonded carrier." else
  if !(SFT.Host.Text.equal (independenceName c.independence) "independent-chemical-entity") then "If only separated parts persist, no joined entity is formed." else
  if !(SFT.Host.Text.equal (energyName c.energy) "measured-stability-record-separated") then "A consensus potential cannot select closure." else
  if !(SFT.Host.Text.equal (reversalName c.reversal) "opening-closes-to-separated-support") then "Bond opening may be lawful and must retain carriers." else
  if !(SFT.Host.Text.equal (recordName c.record) "carrier-interaction-recurrence-trace") then "A label cannot reproduce interaction and stability." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can call any contact a bond." else
  "atoms-or-atomic-groups__source-bound-interaction-support__stable-joint-recurrence__independent-chemical-entity"

def generationRule : String := "Generate the literal product of the registered bond carrier, interaction, closure, independence, energy, reversal, record and extension choices."
def grammarBoundary : String := "Every finite pair or group of admitted atomic carriers and complete interaction support whose joint recurrence is stable as an independently distinguishable chemical carrier at the registered boundary."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Interaction.rejected,Interaction.admitted]).flatMap fun interaction =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Independence.rejected,Independence.admitted]).flatMap fun independence =>
  ([Energy.rejected,Energy.admitted]).flatMap fun energy =>
  ([Reversal.rejected,Reversal.admitted]).flatMap fun reversal =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,interaction,closure,independence,energy,reversal,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier interaction closure independence energy reversal record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinteraction : interaction ∈ [Interaction.rejected,Interaction.admitted] := by
      cases interaction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hindependence : independence ∈ [Independence.rejected,Independence.admitted] := by
      cases independence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henergy : energy ∈ [Energy.rejected,Energy.admitted] := by
      cases energy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreversal : reversal ∈ [Reversal.rejected,Reversal.admitted] := by
      cases reversal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ interaction _ hinteraction
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ independence _ hindependence
    apply CommonRefinement.memFlatMap _ _ energy _ henergy
    apply CommonRefinement.memFlatMap _ _ reversal _ hreversal
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier interaction closure independence energy reversal record extension =>
    cases carrier <;> cases interaction <;> cases closure <;> cases independence <;> cases energy <;> cases reversal <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier interaction closure independence energy reversal record extension =>
    cases carrier <;> cases interaction <;> cases closure <;> cases independence <;> cases energy <;> cases reversal <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.interaction = .admitted ∧ c.closure = .admitted ∧ c.independence = .admitted ∧ c.energy = .admitted ∧ c.reversal = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier interaction closure independence energy reversal record extension =>
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

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
    rw [h] at field
    cases field

theorem independence_rejected_rejected (c : Candidate) (h : c.independence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.independence eq
    rw [h] at field
    cases field

theorem energy_rejected_rejected (c : Candidate) (h : c.energy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.energy eq
    rw [h] at field
    cases field

theorem reversal_rejected_rejected (c : Candidate) (h : c.reversal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reversal eq
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

end SFT.Chemistry.BondGrammar
