import SFT.Mathematics.AlgebraWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.AlgebraGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "partial-or-aliased-carrier"
  | .admitted => "complete-canonical-carrier"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "partial-operation-sample"
  | .admitted => "complete-single-valued-table"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "external-result"
  | .admitted => "carrier-closed-result"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "named-identity"
  | .admitted => "exhaustive-identity-witness"

inductive Association where
  | rejected | admitted

def associationName : Association → String
  | .rejected => "assumed-parenthesis-law"
  | .admitted => "complete-triple-witness"

inductive Return where
  | rejected | admitted

def returnsName : Return → String
  | .rejected => "signed-inverse-value"
  | .admitted => "unique-held-return-mate"

inductive Properties where
  | rejected | admitted

def propertiesName : Properties → String
  | .rejected => "property-by-name"
  | .admitted => "property-by-exhaustive-witness"

inductive Maps where
  | rejected | admitted

def mapsName : Maps → String
  | .rejected => "arbitrary-carrier-map"
  | .admitted => "operation-preserving-map"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-algebraic-axiom"
  | .admitted => "no-extra-algebraic-axiom"

structure Candidate where
  carrier : Carrier
  operation : Operation
  closure : Closure
  identity : Identity
  association : Association
  returns : Return
  properties : Properties
  maps : Maps
  addition : Addition

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, operationName c.operation, closureName c.closure, identityName c.identity, associationName c.association, returnsName c.returns, propertiesName c.properties, mapsName c.maps, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "association=" (associationName c.association), SFT.Host.Text.append "return=" (returnsName c.returns), SFT.Host.Text.append "properties=" (propertiesName c.properties), SFT.Host.Text.append "maps=" (mapsName c.maps), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-carrier__complete-single-valued-table__carrier-closed-result__exhaustive-identity-witness__complete-triple-witness__unique-held-return-mate__property-by-exhaustive-witness__operation-preserving-map__no-extra-algebraic-axiom"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-canonical-carrier" &&
  SFT.Host.Text.equal (operationName c.operation) "complete-single-valued-table" &&
  SFT.Host.Text.equal (closureName c.closure) "carrier-closed-result" &&
  SFT.Host.Text.equal (identityName c.identity) "exhaustive-identity-witness" &&
  SFT.Host.Text.equal (associationName c.association) "complete-triple-witness" &&
  SFT.Host.Text.equal (returnsName c.returns) "unique-held-return-mate" &&
  SFT.Host.Text.equal (propertiesName c.properties) "property-by-exhaustive-witness" &&
  SFT.Host.Text.equal (mapsName c.maps) "operation-preserving-map" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-algebraic-axiom"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-canonical-carrier") then "Omission or aliasing changes which operation inputs exist." else
  if !(SFT.Host.Text.equal (operationName c.operation) "complete-single-valued-table") then "A partial sample does not assign every generated input pair." else
  if !(SFT.Host.Text.equal (closureName c.closure) "carrier-closed-result") then "An external result silently enlarges the registered carrier." else
  if !(SFT.Host.Text.equal (identityName c.identity) "exhaustive-identity-witness") then "A name alone does not prove left and right preservation." else
  if !(SFT.Host.Text.equal (associationName c.association) "complete-triple-witness") then "An assumed equation imports an algebraic axiom." else
  if !(SFT.Host.Text.equal (returnsName c.returns) "unique-held-return-mate") then "A signed magnitude imports negative quantity." else
  if !(SFT.Host.Text.equal (propertiesName c.properties) "property-by-exhaustive-witness") then "A familiar structure name cannot supply commutation or return." else
  if !(SFT.Host.Text.equal (mapsName c.maps) "operation-preserving-map") then "An arbitrary map can erase the operation relation." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-algebraic-axiom") then "An extra axiom is not forced by the registered operation traces." else
  "The algebraic kernel is a complete canonical carrier and complete closed single-valued operation table, with identity, association, returns, special properties and maps admitted only by exhaustive witnesses."

def generationRule : String := "Generate the complete product of carrier, operation coverage, closure, identity, association, return, property-admission, structure-map and extra-law status."
def grammarBoundary : String := "All finite operation structures generated from canonical carriers, complete pair-cell relations, canonical path composition, held reversal and exhaustive property witnesses."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Association.rejected,Association.admitted]).flatMap fun association =>
  ([Return.rejected,Return.admitted]).flatMap fun returns =>
  ([Properties.rejected,Properties.admitted]).flatMap fun properties =>
  ([Maps.rejected,Maps.admitted]).flatMap fun maps =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨carrier,operation,closure,identity,association,returns,properties,maps,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier operation closure identity association returns properties maps addition =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hassociation : association ∈ [Association.rejected,Association.admitted] := by
      cases association <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturns : returns ∈ [Return.rejected,Return.admitted] := by
      cases returns <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproperties : properties ∈ [Properties.rejected,Properties.admitted] := by
      cases properties <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmaps : maps ∈ [Maps.rejected,Maps.admitted] := by
      cases maps <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ association _ hassociation
    apply CommonRefinement.memFlatMap _ _ returns _ hreturns
    apply CommonRefinement.memFlatMap _ _ properties _ hproperties
    apply CommonRefinement.memFlatMap _ _ maps _ hmaps
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier operation closure identity association returns properties maps addition =>
    cases carrier <;> cases operation <;> cases closure <;> cases identity <;> cases association <;> cases returns <;> cases properties <;> cases maps <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier operation closure identity association returns properties maps addition =>
    cases carrier <;> cases operation <;> cases closure <;> cases identity <;> cases association <;> cases returns <;> cases properties <;> cases maps <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.operation = .admitted ∧ c.closure = .admitted ∧ c.identity = .admitted ∧ c.association = .admitted ∧ c.returns = .admitted ∧ c.properties = .admitted ∧ c.maps = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier operation closure identity association returns properties maps addition =>
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

theorem operation_rejected_rejected (c : Candidate) (h : c.operation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.operation eq
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem association_rejected_rejected (c : Candidate) (h : c.association = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.association eq
    rw [h] at field
    cases field

theorem returns_rejected_rejected (c : Candidate) (h : c.returns = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.returns eq
    rw [h] at field
    cases field

theorem properties_rejected_rejected (c : Candidate) (h : c.properties = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.properties eq
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

end SFT.Mathematics.AlgebraGrammar
