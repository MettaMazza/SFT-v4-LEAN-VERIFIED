import «work».MassSpectralCarrier640
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.MassSpectralGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "neutral-sample-label-only"
  | .admitted => "generated-ionized-carriers"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "carrier-composition-erased"
  | .admitted => "composition-and-isotope-support-held"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "undifferentiated-response"
  | .admitted => "mass-charge-classes-held"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "peak-position-only"
  | .admitted => "class-position-and-abundance-held"

inductive Fragments where
  | rejected | admitted

def fragmentsName : Fragments → String
  | .rejected => "fragment-origin-erased"
  | .admitted => "precursor-fragment-map-held"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "universal-spectrum"
  | .admitted => "ionization-and-instrument-boundary"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "spectrum-image-only"
  | .admitted => "complete-carrier-response-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-peak-assignment"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  identity : Identity
  partition : Partition
  response : Response
  fragments : Fragments
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, partitionName c.partition, responseName c.response, fragmentsName c.fragments, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "fragments=" (fragmentsName c.fragments), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "generated-ionized-carriers__composition-and-isotope-support-held__mass-charge-classes-held__class-position-and-abundance-held__precursor-fragment-map-held__ionization-and-instrument-boundary__complete-carrier-response-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "generated-ionized-carriers" &&
  SFT.Host.Text.equal (identityName c.identity) "composition-and-isotope-support-held" &&
  SFT.Host.Text.equal (partitionName c.partition) "mass-charge-classes-held" &&
  SFT.Host.Text.equal (responseName c.response) "class-position-and-abundance-held" &&
  SFT.Host.Text.equal (fragmentsName c.fragments) "precursor-fragment-map-held" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "ionization-and-instrument-boundary" &&
  SFT.Host.Text.equal (recordName c.record) "complete-carrier-response-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "generated-ionized-carriers") then "No detected carrier class is generated." else
  if !(SFT.Host.Text.equal (identityName c.identity) "composition-and-isotope-support-held") then "Composition correspondence is impossible." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "mass-charge-classes-held") then "Distinct carrier classes merge." else
  if !(SFT.Host.Text.equal (responseName c.response) "class-position-and-abundance-held") then "Multiplicity support is lost." else
  if !(SFT.Host.Text.equal (fragmentsName c.fragments) "precursor-fragment-map-held") then "Products cannot be related to precursors." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "ionization-and-instrument-boundary") then "Carrier production is method-bound." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-carrier-response-trace") then "The composition map cannot be checked." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A library guess can select composition." else
  "generated-ionized-carriers__composition-and-isotope-support-held__mass-charge-classes-held__class-position-and-abundance-held__precursor-fragment-map-held"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite generated ionized-carrier support with complete composition, isotope, mass/charge, response and precursor-fragment records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Fragments.rejected,Fragments.admitted]).flatMap fun fragments =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨carrier,identity,partition,response,fragments,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity partition response fragments conditions record extra =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfragments : fragments ∈ [Fragments.rejected,Fragments.admitted] := by
      cases fragments <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ fragments _ hfragments
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier identity partition response fragments conditions record extra =>
    cases carrier <;> cases identity <;> cases partition <;> cases response <;> cases fragments <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier identity partition response fragments conditions record extra =>
    cases carrier <;> cases identity <;> cases partition <;> cases response <;> cases fragments <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.partition = .admitted ∧ c.response = .admitted ∧ c.fragments = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity partition response fragments conditions record extra =>
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
    rw [h] at field
    cases field

theorem fragments_rejected_rejected (c : Candidate) (h : c.fragments = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fragments eq
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

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Physics.MassSpectralGrammar
