import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.LengthGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "generic-bond-type-only"
  | .admitted => "specific-identified-bond"

inductive Length where
  | rejected | admitted

def lengthName : Length → String
  | .rejected => "context-free-distance"
  | .admitted => "method-bounded-centre-distance"

inductive Strength where
  | rejected | admitted

def strengthName : Strength → String
  | .rejected => "qualitative-strong-weak-label"
  | .admitted => "positive-dissociation-transfer"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "conditions-erased"
  | .admitted => "measurement-conditions-retained"

inductive Correspondence where
  | rejected | admitted

def correspondenceName : Correspondence → String
  | .rejected => "universal-inverse-equation"
  | .admitted => "common-bond-identity-pairing"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "decimal-as-proof-scalar"
  | .admitted => "separate-source-bound-records"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "paired-values-without-provenance"
  | .admitted => "bond-length-strength-source-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-length-strength-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  length : Length
  strength : Strength
  conditions : Conditions
  correspondence : Correspondence
  measurement : Measurement
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, lengthName c.length, strengthName c.strength, conditionsName c.conditions, correspondenceName c.correspondence, measurementName c.measurement, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "length=" (lengthName c.length), SFT.Host.Text.append "strength=" (strengthName c.strength), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "correspondence=" (correspondenceName c.correspondence), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "specific-identified-bond__method-bounded-centre-distance__positive-dissociation-transfer__measurement-conditions-retained__common-bond-identity-pairing__separate-source-bound-records__bond-length-strength-source-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "specific-identified-bond" &&
  SFT.Host.Text.equal (lengthName c.length) "method-bounded-centre-distance" &&
  SFT.Host.Text.equal (strengthName c.strength) "positive-dissociation-transfer" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "measurement-conditions-retained" &&
  SFT.Host.Text.equal (correspondenceName c.correspondence) "common-bond-identity-pairing" &&
  SFT.Host.Text.equal (measurementName c.measurement) "separate-source-bound-records" &&
  SFT.Host.Text.equal (recordName c.record) "bond-length-strength-source-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "specific-identified-bond") then "A type average can erase the specific molecular carrier." else
  if !(SFT.Host.Text.equal (lengthName c.length) "method-bounded-centre-distance") then "Measured bond length depends on method and state." else
  if !(SFT.Host.Text.equal (strengthName c.strength) "positive-dissociation-transfer") then "A qualitative label cannot reproduce dissociation." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "measurement-conditions-retained") then "Phase, state and cleavage path affect measured records." else
  if !(SFT.Host.Text.equal (correspondenceName c.correspondence) "common-bond-identity-pairing") then "A categorical relation does not force one universal formula." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "separate-source-bound-records") then "Measured decimals cannot enter derivation." else
  if !(SFT.Host.Text.equal (recordName c.record) "bond-length-strength-source-trace") then "A pair without methods cannot be compared." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A fitted curve can force measured examples." else
  "specific-identified-bond__method-bounded-centre-distance__positive-dissociation-transfer__common-bond-identity-pairing"

def generationRule : String := "Generate the literal product of the registered length/strength carrier, length, strength, conditions, correspondence, measurement, record and extension choices."
def grammarBoundary : String := "Every identified bond with one source/method-bounded inter-centre distance record and one separately source/condition-bounded positive dissociation-transfer record, joined only by common bond identity."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Length.rejected,Length.admitted]).flatMap fun length =>
  ([Strength.rejected,Strength.admitted]).flatMap fun strength =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Correspondence.rejected,Correspondence.admitted]).flatMap fun correspondence =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,length,strength,conditions,correspondence,measurement,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier length strength conditions correspondence measurement record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlength : length ∈ [Length.rejected,Length.admitted] := by
      cases length <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstrength : strength ∈ [Strength.rejected,Strength.admitted] := by
      cases strength <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcorrespondence : correspondence ∈ [Correspondence.rejected,Correspondence.admitted] := by
      cases correspondence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ length _ hlength
    apply CommonRefinement.memFlatMap _ _ strength _ hstrength
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ correspondence _ hcorrespondence
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier length strength conditions correspondence measurement record extension =>
    cases carrier <;> cases length <;> cases strength <;> cases conditions <;> cases correspondence <;> cases measurement <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier length strength conditions correspondence measurement record extension =>
    cases carrier <;> cases length <;> cases strength <;> cases conditions <;> cases correspondence <;> cases measurement <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.length = .admitted ∧ c.strength = .admitted ∧ c.conditions = .admitted ∧ c.correspondence = .admitted ∧ c.measurement = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier length strength conditions correspondence measurement record extension =>
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

theorem length_rejected_rejected (c : Candidate) (h : c.length = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.length eq
    rw [h] at field
    cases field

theorem strength_rejected_rejected (c : Candidate) (h : c.strength = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.strength eq
    rw [h] at field
    cases field

theorem conditions_rejected_rejected (c : Candidate) (h : c.conditions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditions eq
    rw [h] at field
    cases field

theorem correspondence_rejected_rejected (c : Candidate) (h : c.correspondence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.correspondence eq
    rw [h] at field
    cases field

theorem measurement_rejected_rejected (c : Candidate) (h : c.measurement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measurement eq
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

end SFT.Chemistry.LengthGrammar
