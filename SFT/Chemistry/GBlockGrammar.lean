import SFT.Chemistry.GBlockWitnesses
import SFT.Chemistry.GBlockFilling
import SFT.Host.Text
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.GBlockGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "borrowed-orbital-notation"
  | .admitted => "positive-principal-and-orbit-ranks"

inductive Capacity where
  | rejected | admitted

def capacityName : Capacity → String
  | .rejected => "imported-subshell-widths"
  | .admitted => "admitted-Fold-orbit-capacity"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "memorized-aufbau-list"
  | .admitted => "increasing-joint-cover-then-principal-rank"

inductive Coordinate where
  | rejected | admitted

def coordinateName : Coordinate → String
  | .rejected => "selected-future-coordinate"
  | .admitted => "first-5g-occupation-at-121"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "answer-only-prediction"
  | .admitted => "complete-fill-and-dependency-trace"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "official-table-readable-before-seal"
  | .admitted => "official-table-opened-after-seal"

inductive Status where
  | rejected | admitted

def statusName : Status → String
  | .rejected => "future-prediction-called-measured"
  | .admitted => "known-prefix-validated-future-coordinate-unobserved"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-exception-or-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  capacity : Capacity
  order : Order
  coordinate : Coordinate
  provenance : Provenance
  target : Target
  status : Status
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, capacityName c.capacity, orderName c.order, coordinateName c.coordinate, provenanceName c.provenance, targetName c.target, statusName c.status, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "capacity=" (capacityName c.capacity), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "coordinate=" (coordinateName c.coordinate), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "status=" (statusName c.status), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "positive-principal-and-orbit-ranks__admitted-Fold-orbit-capacity__increasing-joint-cover-then-principal-rank__first-5g-occupation-at-121__complete-fill-and-dependency-trace__official-table-opened-after-seal__known-prefix-validated-future-coordinate-unobserved__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "positive-principal-and-orbit-ranks" &&
  SFT.Host.Text.equal (capacityName c.capacity) "admitted-Fold-orbit-capacity" &&
  SFT.Host.Text.equal (orderName c.order) "increasing-joint-cover-then-principal-rank" &&
  SFT.Host.Text.equal (coordinateName c.coordinate) "first-5g-occupation-at-121" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "complete-fill-and-dependency-trace" &&
  SFT.Host.Text.equal (targetName c.target) "official-table-opened-after-seal" &&
  SFT.Host.Text.equal (statusName c.status) "known-prefix-validated-future-coordinate-unobserved" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "positive-principal-and-orbit-ranks") then "A borrowed notation has no Fold support trace." else
  if !(SFT.Host.Text.equal (capacityName c.capacity) "admitted-Fold-orbit-capacity") then "Imported widths would supply the answer." else
  if !(SFT.Host.Text.equal (orderName c.order) "increasing-joint-cover-then-principal-rank") then "A memorized order is a target-bearing table." else
  if !(SFT.Host.Text.equal (coordinateName c.coordinate) "first-5g-occupation-at-121") then "A selected coordinate is not forced." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "complete-fill-and-dependency-trace") then "An answer-only prediction cannot be reproduced." else
  if !(SFT.Host.Text.equal (targetName c.target) "official-table-opened-after-seal") then "The known table could select the walk." else
  if !(SFT.Host.Text.equal (statusName c.status) "known-prefix-validated-future-coordinate-unobserved") then "That conflates unobserved consequence with empirical confirmation." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can be tuned to a desired element." else
  "The exact walk has capacities 2,6,10,14,18; noble closures 2,10,18,36,54,86,118; 8s occupations at 119-120; and first 5g occupation at 121."

def generationRule : String := "Generate the complete eight-axis product of positive orbit carrier, capacity, joint-cover order, predicted coordinate, provenance, target custody, evidence status and extra-rule forms."
def grammarBoundary : String := "All finite subshell walks built from the admitted positive-rank capacities, complete valid principal/orbit cells, increasing joint cover and source-rank tie order before the atomic endpoint."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Capacity.rejected,Capacity.admitted]).flatMap fun capacity =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Coordinate.rejected,Coordinate.admitted]).flatMap fun coordinate =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Status.rejected,Status.admitted]).flatMap fun status =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,capacity,order,coordinate,provenance,target,status,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier capacity order coordinate provenance target status extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcapacity : capacity ∈ [Capacity.rejected,Capacity.admitted] := by
      cases capacity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoordinate : coordinate ∈ [Coordinate.rejected,Coordinate.admitted] := by
      cases coordinate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstatus : status ∈ [Status.rejected,Status.admitted] := by
      cases status <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ capacity _ hcapacity
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ coordinate _ hcoordinate
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ status _ hstatus
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier capacity order coordinate provenance target status extension =>
    cases carrier <;> cases capacity <;> cases order <;> cases coordinate <;> cases provenance <;> cases target <;> cases status <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier capacity order coordinate provenance target status extension =>
    cases carrier <;> cases capacity <;> cases order <;> cases coordinate <;> cases provenance <;> cases target <;> cases status <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.capacity = .admitted ∧ c.order = .admitted ∧ c.coordinate = .admitted ∧ c.provenance = .admitted ∧ c.target = .admitted ∧ c.status = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier capacity order coordinate provenance target status extension =>
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

theorem capacity_rejected_rejected (c : Candidate) (h : c.capacity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.capacity eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
    rw [h] at field
    cases field

theorem coordinate_rejected_rejected (c : Candidate) (h : c.coordinate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coordinate eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem status_rejected_rejected (c : Candidate) (h : c.status = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.status eq
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

end SFT.Chemistry.GBlockGrammar
