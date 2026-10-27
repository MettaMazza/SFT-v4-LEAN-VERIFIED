import SFT.Mathematics.OrderWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.OrderGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "presentation-carrier"
  | .admitted => "canonical-carrier"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "borrowed-scalar-comparison"
  | .admitted => "held-pair-relation"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "named-order"
  | .admitted => "exhaustive-partial-order-witness"

inductive Comparability where
  | rejected | admitted

def comparabilityName : Comparability → String
  | .rejected => "assumed-totality"
  | .admitted => "pairwise-totality-witness"

inductive Bounds where
  | rejected | admitted

def boundsName : Bounds → String
  | .rejected => "selected-bound"
  | .admitted => "complete-bound-selection"

inductive Meet where
  | rejected | admitted

def meetName : Meet → String
  | .rejected => "assumed-meet"
  | .admitted => "unique-greatest-lower-witness"

inductive Join where
  | rejected | admitted

def joinName : Join → String
  | .rejected => "assumed-join"
  | .admitted => "unique-least-upper-witness"

inductive Maps where
  | rejected | admitted

def mapsName : Maps → String
  | .rejected => "arbitrary-map"
  | .admitted => "comparison-preserving-map"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-order-axiom"
  | .admitted => "no-extra-order-axiom"

structure Candidate where
  carrier : Carrier
  relation : Relation
  order : Order
  comparability : Comparability
  bounds : Bounds
  meet : Meet
  join : Join
  maps : Maps
  addition : Addition

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, relationName c.relation, orderName c.order, comparabilityName c.comparability, boundsName c.bounds, meetName c.meet, joinName c.join, mapsName c.maps, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "comparability=" (comparabilityName c.comparability), SFT.Host.Text.append "bounds=" (boundsName c.bounds), SFT.Host.Text.append "meet=" (meetName c.meet), SFT.Host.Text.append "join=" (joinName c.join), SFT.Host.Text.append "maps=" (mapsName c.maps), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "canonical-carrier__held-pair-relation__exhaustive-partial-order-witness__pairwise-totality-witness__complete-bound-selection__unique-greatest-lower-witness__unique-least-upper-witness__comparison-preserving-map__no-extra-order-axiom"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "canonical-carrier" &&
  SFT.Host.Text.equal (relationName c.relation) "held-pair-relation" &&
  SFT.Host.Text.equal (orderName c.order) "exhaustive-partial-order-witness" &&
  SFT.Host.Text.equal (comparabilityName c.comparability) "pairwise-totality-witness" &&
  SFT.Host.Text.equal (boundsName c.bounds) "complete-bound-selection" &&
  SFT.Host.Text.equal (meetName c.meet) "unique-greatest-lower-witness" &&
  SFT.Host.Text.equal (joinName c.join) "unique-least-upper-witness" &&
  SFT.Host.Text.equal (mapsName c.maps) "comparison-preserving-map" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-order-axiom"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "canonical-carrier") then "Presentation aliases do not fix exact ordered identity." else
  if !(SFT.Host.Text.equal (relationName c.relation) "held-pair-relation") then "A scalar comparison imports an answer-producing order." else
  if !(SFT.Host.Text.equal (orderName c.order) "exhaustive-partial-order-witness") then "A name does not establish reflexivity, antisymmetry and transitivity." else
  if !(SFT.Host.Text.equal (comparabilityName c.comparability) "pairwise-totality-witness") then "Partial orders can contain incomparable forms." else
  if !(SFT.Host.Text.equal (boundsName c.bounds) "complete-bound-selection") then "Selecting a familiar candidate can omit another held condition." else
  if !(SFT.Host.Text.equal (meetName c.meet) "unique-greatest-lower-witness") then "A lower bound need not be greatest or unique." else
  if !(SFT.Host.Text.equal (joinName c.join) "unique-least-upper-witness") then "An upper bound need not be least or unique." else
  if !(SFT.Host.Text.equal (mapsName c.maps) "comparison-preserving-map") then "An arbitrary map can reverse a retained comparison." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-order-axiom") then "An extra totality or completeness axiom is not structurally forced." else
  "The order/lattice kernel is a canonical carrier with an exhaustively witnessed partial-order relation, conditional totality, complete bound selections, uniquely witnessed meet/join and monotone maps."

def generationRule : String := "Generate the complete product of carrier identity, relation provenance, partial-order laws, comparability, bound generation, meet uniqueness, join uniqueness, monotonicity and extra-order status."
def grammarBoundary : String := "All finite order structures generated from canonical carriers, held pair-cell relations, exhaustive relation closure, complete bound selections and unique extremal witnesses."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Comparability.rejected,Comparability.admitted]).flatMap fun comparability =>
  ([Bounds.rejected,Bounds.admitted]).flatMap fun bounds =>
  ([Meet.rejected,Meet.admitted]).flatMap fun meet =>
  ([Join.rejected,Join.admitted]).flatMap fun join =>
  ([Maps.rejected,Maps.admitted]).flatMap fun maps =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨carrier,relation,order,comparability,bounds,meet,join,maps,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier relation order comparability bounds meet join maps addition =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparability : comparability ∈ [Comparability.rejected,Comparability.admitted] := by
      cases comparability <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbounds : bounds ∈ [Bounds.rejected,Bounds.admitted] := by
      cases bounds <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeet : meet ∈ [Meet.rejected,Meet.admitted] := by
      cases meet <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoin : join ∈ [Join.rejected,Join.admitted] := by
      cases join <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmaps : maps ∈ [Maps.rejected,Maps.admitted] := by
      cases maps <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ comparability _ hcomparability
    apply CommonRefinement.memFlatMap _ _ bounds _ hbounds
    apply CommonRefinement.memFlatMap _ _ meet _ hmeet
    apply CommonRefinement.memFlatMap _ _ join _ hjoin
    apply CommonRefinement.memFlatMap _ _ maps _ hmaps
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier relation order comparability bounds meet join maps addition =>
    cases carrier <;> cases relation <;> cases order <;> cases comparability <;> cases bounds <;> cases meet <;> cases join <;> cases maps <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier relation order comparability bounds meet join maps addition =>
    cases carrier <;> cases relation <;> cases order <;> cases comparability <;> cases bounds <;> cases meet <;> cases join <;> cases maps <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.relation = .admitted ∧ c.order = .admitted ∧ c.comparability = .admitted ∧ c.bounds = .admitted ∧ c.meet = .admitted ∧ c.join = .admitted ∧ c.maps = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier relation order comparability bounds meet join maps addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
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

theorem comparability_rejected_rejected (c : Candidate) (h : c.comparability = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparability eq
    rw [h] at field
    cases field

theorem bounds_rejected_rejected (c : Candidate) (h : c.bounds = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bounds eq
    rw [h] at field
    cases field

theorem meet_rejected_rejected (c : Candidate) (h : c.meet = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.meet eq
    rw [h] at field
    cases field

theorem join_rejected_rejected (c : Candidate) (h : c.join = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.join eq
    rw [h] at field
    cases field

theorem maps_rejected_rejected (c : Candidate) (h : c.maps = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.maps eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Mathematics.OrderGrammar
