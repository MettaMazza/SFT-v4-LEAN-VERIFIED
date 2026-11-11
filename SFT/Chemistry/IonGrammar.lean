import SFT.Chemistry.IonTransfer
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.IonGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "charge-label-without-particle"
  | .admitted => "atomic-or-molecular-particle"

inductive Charge where
  | rejected | admitted

def chargeName : Charge → String
  | .rejected => "signed-proof-number"
  | .admitted => "net-held-electric-charge"

inductive Formation where
  | rejected | admitted

def formationName : Formation → String
  | .rejected => "identity-destroying-change"
  | .admitted => "label-transfer-with-identity-retained"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "unpaired-charge-creation"
  | .admitted => "closed-charge-transfer"

inductive Element where
  | rejected | admitted

def elementName : Element → String
  | .rejected => "proton-count-change"
  | .admitted => "atomic-number-retained"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "positive-negative-proof-scalars"
  | .admitted => "cation-anion-held-fibres"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "ion-name-only"
  | .admitted => "carrier-charge-transfer-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-charge-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  charge : Charge
  formation : Formation
  conservation : Conservation
  element : Element
  orientation : Orientation
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, chargeName c.charge, formationName c.formation, conservationName c.conservation, elementName c.element, orientationName c.orientation, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "charge=" (chargeName c.charge), SFT.Host.Text.append "formation=" (formationName c.formation), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "element=" (elementName c.element), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "atomic-or-molecular-particle__net-held-electric-charge__label-transfer-with-identity-retained__closed-charge-transfer__atomic-number-retained__cation-anion-held-fibres__carrier-charge-transfer-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "atomic-or-molecular-particle" &&
  SFT.Host.Text.equal (chargeName c.charge) "net-held-electric-charge" &&
  SFT.Host.Text.equal (formationName c.formation) "label-transfer-with-identity-retained" &&
  SFT.Host.Text.equal (conservationName c.conservation) "closed-charge-transfer" &&
  SFT.Host.Text.equal (elementName c.element) "atomic-number-retained" &&
  SFT.Host.Text.equal (orientationName c.orientation) "cation-anion-held-fibres" &&
  SFT.Host.Text.equal (recordName c.record) "carrier-charge-transfer-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "atomic-or-molecular-particle") then "A charge label detached from matter is not a chemical ion." else
  if !(SFT.Host.Text.equal (chargeName c.charge) "net-held-electric-charge") then "A signed proof magnitude violates the positive exact domain." else
  if !(SFT.Host.Text.equal (formationName c.formation) "label-transfer-with-identity-retained") then "Destroying the carrier does not create a charge state of it." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "closed-charge-transfer") then "Unpaired creation violates closed label flow." else
  if !(SFT.Host.Text.equal (elementName c.element) "atomic-number-retained") then "Changing proton count changes element identity." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "cation-anion-held-fibres") then "Signed scalars are not SFT proof objects." else
  if !(SFT.Host.Text.equal (recordName c.record) "carrier-charge-transfer-trace") then "A name cannot reconstruct carrier, charge and transfer." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can create or erase charge without transfer." else
  "atomic-or-molecular-particle__net-held-electric-charge__label-transfer-with-identity-retained__closed-charge-transfer"

def generationRule : String := "Generate the literal product of the registered ion carrier, charge, formation, conservation, element, orientation, record and extension choices."
def grammarBoundary : String := "Every finite atomic or molecular chemical carrier whose complete conserved electric-label accounting leaves one non-neutral held orientation while retaining its elemental and molecular identity records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Charge.rejected,Charge.admitted]).flatMap fun charge =>
  ([Formation.rejected,Formation.admitted]).flatMap fun formation =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Element.rejected,Element.admitted]).flatMap fun element =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,charge,formation,conservation,element,orientation,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier charge formation conservation element orientation record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcharge : charge ∈ [Charge.rejected,Charge.admitted] := by
      cases charge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hformation : formation ∈ [Formation.rejected,Formation.admitted] := by
      cases formation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helement : element ∈ [Element.rejected,Element.admitted] := by
      cases element <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ charge _ hcharge
    apply CommonRefinement.memFlatMap _ _ formation _ hformation
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ element _ helement
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier charge formation conservation element orientation record extension =>
    cases carrier <;> cases charge <;> cases formation <;> cases conservation <;> cases element <;> cases orientation <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier charge formation conservation element orientation record extension =>
    cases carrier <;> cases charge <;> cases formation <;> cases conservation <;> cases element <;> cases orientation <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.charge = .admitted ∧ c.formation = .admitted ∧ c.conservation = .admitted ∧ c.element = .admitted ∧ c.orientation = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier charge formation conservation element orientation record extension =>
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

theorem charge_rejected_rejected (c : Candidate) (h : c.charge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.charge eq
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

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
    rw [h] at field
    cases field

theorem element_rejected_rejected (c : Candidate) (h : c.element = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.element eq
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

end SFT.Chemistry.IonGrammar
