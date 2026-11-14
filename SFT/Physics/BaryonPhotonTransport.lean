import SFT.Physics.MatterIdentityGraphs
import SFT.Physics.CPPhase
namespace SFT.Physics.BaryonPhotonTransport
open LeptonIntervals VacuumLedgerProofs
structure Relation where
 cpMeasure : String
 imbalanceShare : Rat
 etaRelation : String
 rootPolicy : String

def baryonPhotonRelation : Except String Relation := do
 let binary ← AlphaCovers.binaryCount
 let share ← LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
 pure ⟨"jarlskog-square-from-sealed-quark-root-mixing-graph",share,
  "jarlskog-square-times-half-One","exact-polynomials-and-rational-enclosures-only"⟩

def originalRelation : Relation :=
 ⟨"jarlskog-square-from-sealed-quark-root-mixing-graph",normalize 1 2 (by decide),
  "jarlskog-square-times-half-One","exact-polynomials-and-rational-enclosures-only"⟩
theorem completeSourceRelation : baryonPhotonRelation = .ok originalRelation := rfl
theorem exactImbalanceShare : (baryonPhotonRelation.map Relation.imbalanceShare) = .ok (normalize 1 2 (by decide)) := rfl
theorem twoFoldSharesClose : add originalRelation.imbalanceShare originalRelation.imbalanceShare = wholeRatio 1 := rfl
end SFT.Physics.BaryonPhotonTransport
