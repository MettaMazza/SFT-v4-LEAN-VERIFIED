import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ChiralityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "formula-only"
  | .admitted => "complete-three-dimensional-object"

inductive Reflection where
  | rejected | admitted

def reflectionName : Reflection → String
  | .rejected => "mirror-image-not-generated"
  | .admitted => "exact-mirror-image-generated"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "mirror-composition-changed"
  | .admitted => "composition-preserved"

inductive Adjacency where
  | rejected | admitted

def adjacencyName : Adjacency → String
  | .rejected => "mirror-adjacency-changed"
  | .admitted => "adjacency-preserved"

inductive Superposition where
  | rejected | admitted

def superpositionName : Superposition → String
  | .rejected => "visual-guess"
  | .admitted => "all-proper-finite-relabelings-enumerated"

inductive Result where
  | rejected | admitted

def resultName : Result → String
  | .rejected => "arbitrary-handedness-name"
  | .admitted => "no-proper-superposition"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "chirality-label-only"
  | .admitted => "orientation-and-map-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-chirality-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  reflection : Reflection
  composition : Composition
  adjacency : Adjacency
  superposition : Superposition
  result : Result
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, reflectionName c.reflection, compositionName c.composition, adjacencyName c.adjacency, superpositionName c.superposition, resultName c.result, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "reflection=" (reflectionName c.reflection), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "adjacency=" (adjacencyName c.adjacency), SFT.Host.Text.append "superposition=" (superpositionName c.superposition), SFT.Host.Text.append "result=" (resultName c.result), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "complete-three-dimensional-object__exact-mirror-image-generated__composition-preserved__adjacency-preserved__all-proper-finite-relabelings-enumerated__no-proper-superposition__orientation-and-map-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-three-dimensional-object" &&
  SFT.Host.Text.equal (reflectionName c.reflection) "exact-mirror-image-generated" &&
  SFT.Host.Text.equal (compositionName c.composition) "composition-preserved" &&
  SFT.Host.Text.equal (adjacencyName c.adjacency) "adjacency-preserved" &&
  SFT.Host.Text.equal (superpositionName c.superposition) "all-proper-finite-relabelings-enumerated" &&
  SFT.Host.Text.equal (resultName c.result) "no-proper-superposition" &&
  SFT.Host.Text.equal (recordName c.record) "orientation-and-map-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-three-dimensional-object") then "A formula has no spatial orientation." else
  if !(SFT.Host.Text.equal (reflectionName c.reflection) "exact-mirror-image-generated") then "Chirality cannot be decided." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "composition-preserved") then "The comparison is not reflective identity." else
  if !(SFT.Host.Text.equal (adjacencyName c.adjacency) "adjacency-preserved") then "The comparison changes constitution." else
  if !(SFT.Host.Text.equal (superpositionName c.superposition) "all-proper-finite-relabelings-enumerated") then "A guess cannot establish equivalence." else
  if !(SFT.Host.Text.equal (resultName c.result) "no-proper-superposition") then "A name cannot force distinction." else
  if !(SFT.Host.Text.equal (recordName c.record) "orientation-and-map-trace") then "The result cannot be reproduced." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An extra rule can classify anything." else
  "complete-three-dimensional-object__exact-mirror-image-generated__composition-preserved__adjacency-preserved__no-proper-superposition"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite complete three-dimensional chemical structure with named atoms, adjacency, orientation and exhaustive identity-preserving proper maps."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Reflection.rejected,Reflection.admitted]).flatMap fun reflection =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Adjacency.rejected,Adjacency.admitted]).flatMap fun adjacency =>
  ([Superposition.rejected,Superposition.admitted]).flatMap fun superposition =>
  ([Result.rejected,Result.admitted]).flatMap fun result =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨carrier,reflection,composition,adjacency,superposition,result,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier reflection composition adjacency superposition result record extra =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreflection : reflection ∈ [Reflection.rejected,Reflection.admitted] := by
      cases reflection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadjacency : adjacency ∈ [Adjacency.rejected,Adjacency.admitted] := by
      cases adjacency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuperposition : superposition ∈ [Superposition.rejected,Superposition.admitted] := by
      cases superposition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresult : result ∈ [Result.rejected,Result.admitted] := by
      cases result <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ reflection _ hreflection
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ adjacency _ hadjacency
    apply CommonRefinement.memFlatMap _ _ superposition _ hsuperposition
    apply CommonRefinement.memFlatMap _ _ result _ hresult
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier reflection composition adjacency superposition result record extra =>
    cases carrier <;> cases reflection <;> cases composition <;> cases adjacency <;> cases superposition <;> cases result <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier reflection composition adjacency superposition result record extra =>
    cases carrier <;> cases reflection <;> cases composition <;> cases adjacency <;> cases superposition <;> cases result <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.reflection = .admitted ∧ c.composition = .admitted ∧ c.adjacency = .admitted ∧ c.superposition = .admitted ∧ c.result = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier reflection composition adjacency superposition result record extra =>
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

theorem reflection_rejected_rejected (c : Candidate) (h : c.reflection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reflection eq
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

theorem adjacency_rejected_rejected (c : Candidate) (h : c.adjacency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adjacency eq
    rw [h] at field
    cases field

theorem superposition_rejected_rejected (c : Candidate) (h : c.superposition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.superposition eq
    rw [h] at field
    cases field

theorem result_rejected_rejected (c : Candidate) (h : c.result = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.result eq
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

end SFT.Chemistry.ChiralityGrammar
