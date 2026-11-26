import SFT.Chemistry.PhaseRule
namespace SFT.Chemistry.OneComponentPhaseBoundary
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Exact operations from pinned one_component_phase_boundary_law_v1.py.
structure OneComponentCoexistencePoint where
 componentIdentity : HeldLabel
 firstPhaseIdentity : HeldLabel
 secondPhaseIdentity : HeldLabel
 temperatureSupport : PositiveCount
 pressureSupport : PositiveCount
 firstPhaseExchangeSupport : PositiveCount
 secondPhaseExchangeSupport : PositiveCount
inductive CountInput where
 | count (value : PositiveCount)
 | other
def identityField (v : LabelInput) (family : String) : Except String HeldLabel := match v with
 | .held label => if Text.equal label.family family then .ok label else .error "coexistence point lost its held component or phase identity"
 | .other => .error "coexistence point lost its held component or phase identity"
def supportCount (v : CountInput) : Except String PositiveCount := match v with
 | .count n => .ok n
 | .other => .error "coexistence point requires exact positive support"
def makePoint (component first second : LabelInput) (temperature pressure firstExchange secondExchange : CountInput) : Except String OneComponentCoexistencePoint := do
 let component ← identityField component "chemical-component"
 let first ← identityField first "chemical-phase"
 let second ← identityField second "chemical-phase"
 if equalLabel first second then throw "coexistence requires two distinct held phases"
 let t ← supportCount temperature
 let p ← supportCount pressure
 let a ← supportCount firstExchange
 let b ← supportCount secondExchange
 pure ⟨component,first,second,t,p,a,b⟩
inductive PointInput where
 | point (value : OneComponentCoexistencePoint)
 | other
inductive Separation where
 | count (value : PositiveCount)
 | emptyOne
structure ExchangeBalanceResult where
 relation : HeldLabel
 separation : Separation
def coexistenceExchangeBalance (input : PointInput) : Except String ExchangeBalanceResult := do
 let point ← match input with
 | .point p => pure p
 | .other => throw "exchange balance requires a complete coexistence point"
 let first := point.firstPhaseExchangeSupport.value
 let second := point.secondPhaseExchangeSupport.value
 if first==second then pure ⟨⟨"phase-exchange","balanced",rfl,rfl⟩,.emptyOne⟩
 else if h : first<second then pure ⟨⟨"phase-exchange","second-expanded",rfl,rfl⟩,.count ⟨second-first,SFT.Foundation.ExactCast.subtractPositive second first h⟩⟩
 else if h : second<first then pure ⟨⟨"phase-exchange","first-expanded",rfl,rfl⟩,.count ⟨first-second,SFT.Foundation.ExactCast.subtractPositive first second h⟩⟩
 else throw "an SFT count must be a positive counted value"
def oneComponentTwoPhaseDegreeSupportIsOne (point : OneComponentCoexistencePoint) : Except String Bool := do
 let account ← PhaseRule.makeAccount [.held point.componentIdentity] [.held point.firstPhaseIdentity,.held point.secondPhaseIdentity]
  (PhaseRule.environment.map MolecularFormationEnergy.LabelInput.held)
 let support ← PhaseRule.independentDegreeSupport (.account account)
 pure (match support with | .positive _ n => n.value==1 | .emptyOne => false)
def isOrderedCoexistenceSuccessor (prior successor : PointInput) : Except String Bool := do
 let (prior,successor) ← match prior,successor with
 | .point p,.point s => pure (p,s)
 | .other,.other | .other,.point _ | .point _,.other => throw "coexistence succession requires two complete points"
 if !equalLabel prior.componentIdentity successor.componentIdentity ||
  !equalLabel prior.firstPhaseIdentity successor.firstPhaseIdentity ||
  !equalLabel prior.secondPhaseIdentity successor.secondPhaseIdentity then
  throw "coexistence succession changed its component or phase pair"
 let a ← coexistenceExchangeBalance (.point prior)
 let b ← coexistenceExchangeBalance (.point successor)
 if !Text.equal a.relation.label "balanced" || !Text.equal b.relation.label "balanced" then
  throw "coexistence succession requires exact exchange balance at both points"
 pure (successor.temperatureSupport.value>prior.temperatureSupport.value && successor.pressureSupport.value>prior.pressureSupport.value)
structure FiniteOneComponentBoundary where
 points : List OneComponentCoexistencePoint
def makeBoundary (points : List PointInput) : Except String FiniteOneComponentBoundary := do
 if points.isEmpty then throw "a finite coexistence boundary requires positive point support"
 let rec checkBalance : List PointInput → Except String Unit
  | [] => pure ()
  | point::rest => do
   let balance ← coexistenceExchangeBalance point
   if !Text.equal balance.relation.label "balanced" then throw "every phase-boundary point must preserve exact exchange balance"
   checkBalance rest
 checkBalance points
 let points ← points.mapM fun p => match p with
  | .point p => pure p
  | .other => throw "exchange balance requires a complete coexistence point"
 let rec checkDegrees : List OneComponentCoexistencePoint → Except String Unit
  | [] => pure ()
  | point::rest => do
   let degree ← oneComponentTwoPhaseDegreeSupportIsOne point
   if !degree then throw "one-component two-phase boundary lost its single degree support"
   checkDegrees rest
 checkDegrees points
 let rec checkSuccessors : List (OneComponentCoexistencePoint × OneComponentCoexistencePoint) → Except String Unit
  | [] => pure ()
  | (prior,successor)::rest => do
   let ordered ← isOrderedCoexistenceSuccessor (.point prior) (.point successor)
   if !ordered then throw "finite coexistence points are not exact ordered successors"
   checkSuccessors rest
 checkSuccessors (points.zip (points.drop 1))
 pure ⟨points⟩
inductive BoundaryInput where
 | boundary (value : FiniteOneComponentBoundary)
 | other
def appendCoexistenceSuccessor (input : BoundaryInput) (successor : PointInput) : Except String FiniteOneComponentBoundary := do
 let boundary ← match input with
 | .boundary b => pure b
 | .other => throw "coexistence extension requires a finite boundary"
 makeBoundary ((boundary.points.map PointInput.point) ++ [successor])
def commonSupportReplicationPreservesBoundary (input : BoundaryInput) (replication : CountInput) : Except String Bool := do
 let (boundary,factor) ← match input,replication with
 | .boundary b,.count n => pure (b,n)
 | .other,.other | .other,.count _ | .boundary _,.other => throw "boundary replication requires exact positive support"
 let mul := fun (n : PositiveCount) => (⟨n.value*factor.value,Nat.mul_pos n.positive factor.positive⟩ : PositiveCount)
 let points ← boundary.points.mapM fun point => makePoint (.held point.componentIdentity) (.held point.firstPhaseIdentity) (.held point.secondPhaseIdentity)
  (.count (mul point.temperatureSupport)) (.count (mul point.pressureSupport)) (.count (mul point.firstPhaseExchangeSupport)) (.count (mul point.secondPhaseExchangeSupport))
 let replicated ← makeBoundary (points.map PointInput.point)
 pure (replicated.points.length==boundary.points.length)
def witnessPoint (temperature pressure exchange : PositiveCount) : OneComponentCoexistencePoint :=
 ⟨⟨"chemical-component","component-a",rfl,rfl⟩,⟨"chemical-phase","liquid",rfl,rfl⟩,⟨"chemical-phase","vapor",rfl,rfl⟩,temperature,pressure,exchange,exchange⟩
def first := witnessPoint ⟨3,by decide⟩ ⟨2,by decide⟩ ⟨5,by decide⟩
def second := witnessPoint ⟨5,by decide⟩ ⟨4,by decide⟩ ⟨7,by decide⟩
def third := witnessPoint ⟨8,by decide⟩ ⟨7,by decide⟩ ⟨9,by decide⟩
def balanceWitness : Except String Bool := do
 let b ← coexistenceExchangeBalance (.point first)
 pure (match b.separation with | .emptyOne => true | .count _ => false)
def degreeWitness := oneComponentTwoPhaseDegreeSupportIsOne first
def orderedWitness := isOrderedCoexistenceSuccessor (.point first) (.point second)
def extensionWitness : Except String Bool := do
 let boundary ← makeBoundary [.point first,.point second]
 let appended ← appendCoexistenceSuccessor (.boundary boundary) (.point third)
 let replicated ← commonSupportReplicationPreservesBoundary (.boundary boundary) (.count ⟨6,by decide⟩)
 pure (appended.points.length==3 && replicated)
theorem balancedExchange : balanceWitness=.ok true := rfl
theorem singleDegree : degreeWitness=.ok true := rfl
theorem orderedSuccessor : orderedWitness=.ok true := rfl
theorem appendAndReplicate : extensionWitness=.ok true := rfl
end SFT.Chemistry.OneComponentPhaseBoundary
