import SFT.Engine.EvidenceGates
import SFT.Mathematics.DiscreteRelations
namespace SFT.Foundation.AdmissionAcceptance
open SFT.Host SFT.Mathematics.DiscreteObjects

-- admission_enforcement.py: exact required dictionary and update semantics.
def required : List (String × Bool) :=
 [("root_bound",true),("parameter_free",true),("complete_census",true),
  ("unique",true),("closed",true),("controls",true),("independent",true),
  ("postseal",true),("preserved",true),("admitted_dependency",true)]

def update (key : String) (value : Bool) : List (String × Bool) → List (String × Bool)
 | [] => [(key,value)]
 | row::rest => if Text.equal row.1 key then (key,value)::rest else row::update key value rest

def applyChanges : List (String × Bool) → List (String × Bool) → List (String × Bool)
 | held,[] => held
 | held,(key,value)::rest => applyChanges (update key value held) rest

def admissionAccepts (changes : List (String × Bool)) : Bool :=
 (applyChanges required changes).all Prod.snd

theorem acceptedExactly (changes : List (String × Bool)) : admissionAccepts changes = true ↔
 ∀ row, row ∈ applyChanges required changes → row.2 = true := allTrueIffMembers _ _

theorem anyFailedGateRejects (changes : List (String × Bool)) (row : String × Bool)
 (held : row ∈ applyChanges required changes) (failed : row.2 = false) : admissionAccepts changes = false := by
 cases h : admissionAccepts changes with
 | false => rfl
 | true =>
   have yes := (acceptedExactly changes).mp h row held
   rw [failed] at yes
   cases yes

theorem completeRoutePasses : admissionAccepts [] = true := rfl

theorem freeParameterRejected : admissionAccepts [("parameter_free",false)] = false := rfl

theorem changedRootRejected : admissionAccepts [("root_bound",false)] = false := rfl

theorem secondSurvivorRejected : admissionAccepts [("unique",false)] = false := rfl

theorem discardedFailureRejected : admissionAccepts [("preserved",false)] = false := rfl

theorem presealTargetRejected : admissionAccepts [("postseal",false)] = false := rfl

theorem unclosedDependencyRejected : admissionAccepts [("admitted_dependency",false)] = false := rfl

theorem extraFalseCoordinateRejected : admissionAccepts [("extra",false)] = false := rfl
end SFT.Foundation.AdmissionAcceptance
