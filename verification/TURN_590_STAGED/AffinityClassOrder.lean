import SFT.Chemistry.AffinityObservationBinding
import SFT.Mathematics.OrderMeaning
namespace SFT.Chemistry.AffinityClassOrder
open SFT.Mathematics.OrderOperations SFT.Mathematics.DiscreteObjects
open AffinityObservationBinding

-- The registered class relation is the comparison input, not a new scalar
-- ordering. Only the compared pair needs a comparability witness.
structure Compared (observation : SFT.InformationScience.SymbolObservation.Observation) where
 first : Endpoint observation
 second : Endpoint observation
 carrier : List String
 relation : SFT.Mathematics.OrderOperations.Relation
 checked : isPartialOrder carrier relation=true
 compared : comparable relation first.label second.label=true

theorem endpointsBelong {observation} (c : Compared observation) :
 c.first.label∈c.carrier ∧ c.second.label∈c.carrier := by
 have endpoints := ((partialOrderMeaning c.carrier c.relation).mp c.checked).2.2.2.1
 cases (comparableIff _ _ _).mp c.compared with
 | inl forward => exact endpoints _ forward
 | inr backward =>
   have pair := endpoints _ backward
   exact ⟨pair.2,pair.1⟩

inductive Outcome where
 | tied | first | second
 deriving DecidableEq

def outcome {observation} (c : Compared observation) : Outcome :=
 if c.first.label=c.second.label then .tied
 else if has c.relation (c.first.label,c.second.label) then .second else .first

def Meaning {observation} (c : Compared observation) : Outcome → Prop
 | .tied => c.first.label=c.second.label
 | .first => c.first.label≠c.second.label ∧ (c.second.label,c.first.label)∈c.relation
 | .second => c.first.label≠c.second.label ∧ (c.first.label,c.second.label)∈c.relation

theorem decisionSound {observation} (c : Compared observation) : Meaning c (outcome c) := by
 unfold outcome
 split
 · assumption
 · rename_i unequal
   split
   · rename_i forward
     exact ⟨unequal,(hasIff _ _).mp forward⟩
   · rename_i notForward
     have pair := (comparableIff _ _ _).mp c.compared
     cases pair with
     | inl forward => exact False.elim (notForward ((hasIff _ _).mpr forward))
     | inr backward => exact ⟨unequal,backward⟩

theorem decisionUnique {observation} (c : Compared observation) (a b : Outcome)
 (ha : Meaning c a) (hb : Meaning c b) : a=b := by
 have anti := ((partialOrderMeaning c.carrier c.relation).mp c.checked).2.2.2.2.2.1
 cases a <;> cases b
 · rfl
 · exact False.elim (hb.1 ha)
 · exact False.elim (hb.1 ha)
 · exact False.elim (ha.1 hb)
 · rfl
 · exact False.elim (ha.1 (anti _ _ hb.2 ha.2))
 · exact False.elim (ha.1 hb)
 · exact False.elim (ha.1 (anti _ _ ha.2 hb.2))
 · rfl

theorem decisionExactly {observation} (c : Compared observation) (answer : Outcome) :
 outcome c=answer ↔ Meaning c answer :=
 ⟨fun same => same ▸ decisionSound c,fun valid => decisionUnique c _ _ (decisionSound c) valid⟩

theorem tiedExactlySourceClass {observation} (c : Compared observation) :
 outcome c=.tied ↔ SFT.InformationScience.SymbolObservation.distinguishable observation
 c.first.symbol c.second.symbol=.ok false :=
 ⟨fun same => (sourceClassExactly c.first c.second).mp ((decisionExactly c .tied).mp same),
 fun same => (decisionExactly c .tied).mpr ((sourceClassExactly c.first c.second).mpr same)⟩

-- Endpoint names cannot choose among outcomes: changing only them changes
-- none of the registered class comparison cells.
def rename {observation} (c : Compared observation) (firstName secondName : String) : Compared observation :=
 {c with first := {c.first with atom := firstName}, second := {c.second with atom := secondName}}

theorem namesDoNotSelect {observation} (c : Compared observation) (firstName secondName : String) :
 outcome (rename c firstName secondName)=outcome c := rfl
end SFT.Chemistry.AffinityClassOrder
