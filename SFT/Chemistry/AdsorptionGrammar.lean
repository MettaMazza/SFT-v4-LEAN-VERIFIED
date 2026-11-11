import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AdsorptionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "bulk-only"
  | .admitted => "retained-interface"

inductive Roles where
  | rejected | admitted

def rolesName : Roles → String
  | .rejected => "carrier-identity-erased"
  | .admitted => "adsorbate-and-adsorbent-retained"

inductive Location where
  | rejected | admitted

def locationName : Location → String
  | .rejected => "uniform-bulk-distribution"
  | .admitted => "accumulation-at-interface"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "surface-equals-bulk"
  | .admitted => "surface-concentration-differs"

inductive Binding where
  | rejected | admitted

def bindingName : Binding → String
  | .rejected => "irreversible-erasure"
  | .admitted => "reversible-desorption-boundary"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "condition-free-coverage"
  | .admitted => "condition-and-surface-bounded"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "adsorption-name-only"
  | .admitted => "complete-interface-event-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-isotherm-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  boundary : Boundary
  roles : Roles
  location : Location
  composition : Composition
  binding : Binding
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [boundaryName c.boundary, rolesName c.roles, locationName c.location, compositionName c.composition, bindingName c.binding, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "roles=" (rolesName c.roles), SFT.Host.Text.append "location=" (locationName c.location), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "binding=" (bindingName c.binding), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "retained-interface__adsorbate-and-adsorbent-retained__accumulation-at-interface__surface-concentration-differs__reversible-desorption-boundary__condition-and-surface-bounded__complete-interface-event-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (boundaryName c.boundary) "retained-interface" &&
  SFT.Host.Text.equal (rolesName c.roles) "adsorbate-and-adsorbent-retained" &&
  SFT.Host.Text.equal (locationName c.location) "accumulation-at-interface" &&
  SFT.Host.Text.equal (compositionName c.composition) "surface-concentration-differs" &&
  SFT.Host.Text.equal (bindingName c.binding) "reversible-desorption-boundary" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "condition-and-surface-bounded" &&
  SFT.Host.Text.equal (recordName c.record) "complete-interface-event-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "retained-interface") then "No interface is present." else
  if !(SFT.Host.Text.equal (rolesName c.roles) "adsorbate-and-adsorbent-retained") then "Surface membership is ambiguous." else
  if !(SFT.Host.Text.equal (locationName c.location) "accumulation-at-interface") then "No surface accumulation occurs." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "surface-concentration-differs") then "The interface adds no distinction." else
  if !(SFT.Host.Text.equal (bindingName c.binding) "reversible-desorption-boundary") then "The adsorbate cannot be recovered." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "condition-and-surface-bounded") then "Surface support is context-bound." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-interface-event-trace") then "Localization cannot be reproduced." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fit can select coverage." else
  "retained-interface__adsorbate-and-adsorbent-retained__accumulation-at-interface__surface-concentration-differs__reversible-desorption-boundary"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by carrier preservation, complete support, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite two-region chemical boundary with named adsorbate and adsorbent, counted arrivals/residence/departures and source-bound conditions."

def candidates : List Candidate :=
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Roles.rejected,Roles.admitted]).flatMap fun roles =>
  ([Location.rejected,Location.admitted]).flatMap fun location =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Binding.rejected,Binding.admitted]).flatMap fun binding =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨boundary,roles,location,composition,binding,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk boundary roles location composition binding conditions record extra =>
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hroles : roles ∈ [Roles.rejected,Roles.admitted] := by
      cases roles <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlocation : location ∈ [Location.rejected,Location.admitted] := by
      cases location <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbinding : binding ∈ [Binding.rejected,Binding.admitted] := by
      cases binding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ roles _ hroles
    apply CommonRefinement.memFlatMap _ _ location _ hlocation
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ binding _ hbinding
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk boundary roles location composition binding conditions record extra =>
    cases boundary <;> cases roles <;> cases location <;> cases composition <;> cases binding <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk boundary roles location composition binding conditions record extra =>
    cases boundary <;> cases roles <;> cases location <;> cases composition <;> cases binding <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.boundary = .admitted ∧ c.roles = .admitted ∧ c.location = .admitted ∧ c.composition = .admitted ∧ c.binding = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk boundary roles location composition binding conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
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

theorem location_rejected_rejected (c : Candidate) (h : c.location = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.location eq
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

theorem binding_rejected_rejected (c : Candidate) (h : c.binding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.binding eq
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

end SFT.Chemistry.AdsorptionGrammar
