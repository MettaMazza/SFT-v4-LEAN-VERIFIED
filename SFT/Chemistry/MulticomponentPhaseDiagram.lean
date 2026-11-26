import SFT.Chemistry.PhaseRule
namespace SFT.Chemistry.MulticomponentPhaseDiagram
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Pinned multicomponent_phase_diagram_law_v1.py, exact finite operations.
structure PhaseCompositionCoordinate where
 componentIdentity : HeldLabel
 coordinate : Height
def makeCoordinate (component : LabelInput) (coordinate : Height) : Except String PhaseCompositionCoordinate := do
 let component ← match component with
  | .held c => if Text.equal c.family "chemical-component" then pure c else throw "phase composition lost its held component identity"
  | .other => throw "phase composition lost its held component identity"
 match coordinate with
 | .invalid => throw "phase composition requires an exact positive ratio or structural EmptyOne"
 | .ratio _ | .emptyOne | .otherEmptyOne _ => pure ⟨component,coordinate⟩
def positiveCoordinateSum (coordinates : List PhaseCompositionCoordinate) : Except String SFT.Foundation.ExactOperations.PositiveFraction := do
 let positives := coordinates.filterMap fun row => match row.coordinate with
  | .ratio r => some (fraction r)
  | .emptyOne | .otherEmptyOne _ | .invalid => none
 match positives with
 | [] => throw "a phase composition cannot contain only structural absence"
 | first::rest => pure (rest.foldl AlphaRatio.add first)
inductive CoordinateInput where
 | coordinate (value : PhaseCompositionCoordinate)
 | other
structure ExactPhaseCompositionWord where
 phaseIdentity : HeldLabel
 coordinates : List PhaseCompositionCoordinate
def makeWord (phase : LabelInput) (inputs : List CoordinateInput) : Except String ExactPhaseCompositionWord := do
 let phase ← match phase with
  | .held p => if Text.equal p.family "chemical-phase" then pure p else throw "composition word lost its held phase identity"
  | .other => throw "composition word lost its held phase identity"
 if inputs.length<2 then throw "multicomponent composition requires at least two complete coordinates"
 let coordinates ← inputs.mapM fun row => match row with
  | .coordinate c => pure c
  | .other => throw "multicomponent composition requires at least two complete coordinates"
 if !distinctAtoms (coordinates.map PhaseCompositionCoordinate.componentIdentity) then throw "phase composition duplicated a component"
 let sum ← positiveCoordinateSum coordinates
 if sum.numerator != sum.denominator then throw "exact phase-composition support does not close to the One"
 pure ⟨phase,coordinates⟩
structure ComponentExchangeSupport where
 componentIdentity : HeldLabel
 firstPhaseSupport : PositiveCount
 secondPhaseSupport : PositiveCount
def makeExchange (component : LabelInput) (first second : DihedralTorsion.CountInput) : Except String ComponentExchangeSupport := do
 let component ← match component with
  | .held c => if Text.equal c.family "chemical-component" then pure c else throw "exchange support lost component identity"
  | .other => throw "exchange support lost component identity"
 match first,second with
 | .count a,.count b => pure ⟨component,a,b⟩
 | .other,.other | .other,.count _ | .count _,.other => throw "component exchange requires exact positive support"
def balanced (row : ComponentExchangeSupport) : Bool := row.firstPhaseSupport.value==row.secondPhaseSupport.value
inductive WordInput where
 | word (value : ExactPhaseCompositionWord)
 | other
structure MulticomponentCoexistencePoint where
 firstPhase : ExactPhaseCompositionWord
 secondPhase : ExactPhaseCompositionWord
 temperatureSupport : Ratio
 pressureSupport : Ratio
 exchangeSupports : List ComponentExchangeSupport
def makePoint (first second : WordInput) (temperature pressure : Height) (exchange : List ComponentExchangeSupport) : Except String MulticomponentCoexistencePoint := do
 let (first,second) ← match first,second with
  | .word a,.word b => pure (a,b)
  | .other,.other | .other,.word _ | .word _,.other => throw "coexistence requires two complete phase-composition words"
 if equalLabel first.phaseIdentity second.phaseIdentity then throw "coexistence requires two distinct held phases"
 let components := first.coordinates.map PhaseCompositionCoordinate.componentIdentity
 if !equalLabels components (second.coordinates.map PhaseCompositionCoordinate.componentIdentity) ||
  !equalLabels components (exchange.map ComponentExchangeSupport.componentIdentity) then
  throw "coexisting phase words do not retain the same ordered component support"
 if exchange.any (fun row => !balanced row) then throw "coexistence lost componentwise exchange-support balance"
 match temperature,pressure with
 | .ratio t,.ratio p => pure ⟨first,second,t,p,exchange⟩
 | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_ | .ratio _,.emptyOne | .ratio _,.otherEmptyOne _ | .ratio _,.invalid => throw "coexistence requires exact positive environmental support"
def multicomponentTwoPhaseDegreeSupport (point : MulticomponentCoexistencePoint) : Except String PositiveCount := do
 let components := point.firstPhase.coordinates.map PhaseCompositionCoordinate.componentIdentity
 let account ← PhaseRule.makeAccount (components.map MolecularFormationEnergy.LabelInput.held)
  [.held point.firstPhase.phaseIdentity,.held point.secondPhase.phaseIdentity]
  (PhaseRule.environment.map MolecularFormationEnergy.LabelInput.held)
 let support ← PhaseRule.independentDegreeSupport (.account account)
 match support with
 | .positive _ n => if n.value==components.length then pure n else throw "multicomponent two-phase support lost its exact component-count rank"
 | .emptyOne => throw "multicomponent two-phase support lost its exact component-count rank"
structure FiniteMulticomponentDiagram where
 points : List MulticomponentCoexistencePoint
def makeDiagram (points : List MulticomponentCoexistencePoint) : Except String FiniteMulticomponentDiagram := do
 if points.isEmpty then throw "a finite phase diagram requires positive point support"
 let _ ← points.mapM multicomponentTwoPhaseDegreeSupport
 pure ⟨points⟩
inductive DiagramInput where
 | diagram (value : FiniteMulticomponentDiagram)
 | other
def appendCoexistencePoint (input : DiagramInput) (point : MulticomponentCoexistencePoint) : Except String FiniteMulticomponentDiagram := do
 let diagram ← match input with
  | .diagram d => pure d
  | .other => throw "phase-diagram extension requires a finite exact diagram"
 makeDiagram (diagram.points++[point])
def commonExchangeReplicationPreservesPoint (point : MulticomponentCoexistencePoint) (replication : DihedralTorsion.CountInput) : Except String Bool := do
 let factor ← match replication with
  | .count n => pure n
  | .other => throw "exchange replication requires exact positive support"
 let mul := fun (n : PositiveCount) => (⟨n.value*factor.value,Nat.mul_pos n.positive factor.positive⟩ : PositiveCount)
 let exchange ← point.exchangeSupports.mapM fun row => makeExchange (.held row.componentIdentity)
  (.count (mul row.firstPhaseSupport)) (.count (mul row.secondPhaseSupport))
 let replicated ← makePoint (.word point.firstPhase) (.word point.secondPhase) (.ratio point.temperatureSupport) (.ratio point.pressureSupport) exchange
 pure (replicated.exchangeSupports.all balanced)
def componentA : HeldLabel := ⟨"chemical-component","a",rfl,rfl⟩
def componentB : HeldLabel := ⟨"chemical-component","b",rfl,rfl⟩
def componentC : HeldLabel := ⟨"chemical-component","c",rfl,rfl⟩
def binaryFirst : List PhaseCompositionCoordinate := [⟨componentA,.ratio ⟨⟨2,by decide⟩,⟨5,by decide⟩⟩⟩,⟨componentB,.ratio ⟨⟨3,by decide⟩,⟨5,by decide⟩⟩⟩]
def binarySecond : List PhaseCompositionCoordinate := [⟨componentA,.ratio ⟨⟨3,by decide⟩,⟨5,by decide⟩⟩⟩,⟨componentB,.ratio ⟨⟨2,by decide⟩,⟨5,by decide⟩⟩⟩]
def ternaryFirst : List PhaseCompositionCoordinate := [⟨componentA,.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩⟩,⟨componentB,.ratio ⟨⟨1,by decide⟩,⟨3,by decide⟩⟩⟩,⟨componentC,.ratio ⟨⟨1,by decide⟩,⟨6,by decide⟩⟩⟩]
def ternarySecond : List PhaseCompositionCoordinate := [⟨componentA,.ratio ⟨⟨1,by decide⟩,⟨3,by decide⟩⟩⟩,⟨componentB,.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩⟩,⟨componentC,.ratio ⟨⟨1,by decide⟩,⟨6,by decide⟩⟩⟩]
def witnessPoint (componentCount : Int) : Except String MulticomponentCoexistencePoint := do
 let (a,b) ← if @decide (componentCount=2) (Int.decEq _ _) then pure (binaryFirst,binarySecond)
  else if @decide (componentCount=3) (Int.decEq _ _) then pure (ternaryFirst,ternarySecond)
  else throw "witness requires binary or ternary support"
 let first ← makeWord (.held ⟨"chemical-phase","liquid",rfl,rfl⟩) (a.map CoordinateInput.coordinate)
 let second ← makeWord (.held ⟨"chemical-phase","gas",rfl,rfl⟩) (b.map CoordinateInput.coordinate)
 let exchange := a.map fun c => (⟨c.componentIdentity,⟨5,by decide⟩,⟨5,by decide⟩⟩ : ComponentExchangeSupport)
 makePoint (.word first) (.word second) (.ratio ⟨⟨7,by decide⟩,⟨2,by decide⟩⟩) (.ratio ⟨⟨9,by decide⟩,⟨4,by decide⟩⟩) exchange
def closureWitness : Except String Bool := do
 let b ← witnessPoint 2
 let t ← witnessPoint 3
 let x ← positiveCoordinateSum b.firstPhase.coordinates
 let y ← positiveCoordinateSum t.firstPhase.coordinates
 pure (x.numerator==x.denominator && y.numerator==y.denominator)
def balanceWitness : Except String Bool := do
 let b ← witnessPoint 2
 let t ← witnessPoint 3
 pure ((b.exchangeSupports++t.exchangeSupports).all balanced)
def rankWitness : Except String Bool := do
 let b ← witnessPoint 2
 let t ← witnessPoint 3
 let x ← multicomponentTwoPhaseDegreeSupport b
 let y ← multicomponentTwoPhaseDegreeSupport t
 pure (x.value==2 && y.value==3)
def absenceExtensionWitness : Except String Bool := do
 let absent ← makeWord (.held ⟨"chemical-phase","liquid",rfl,rfl⟩) [.coordinate ⟨componentA,.emptyOne⟩,.coordinate ⟨componentB,.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩⟩]
 let b ← witnessPoint 2
 let t ← witnessPoint 3
 let diagram ← makeDiagram [b]
 let extended ← appendCoexistencePoint (.diagram diagram) t
 let replicated ← commonExchangeReplicationPreservesPoint b (.count ⟨7,by decide⟩)
 let absent := match absent.coordinates.head? with
  | some row => match row.coordinate with | .emptyOne | .otherEmptyOne _ => true | .ratio _ | .invalid => false
  | none => false
 pure (absent && extended.points.length==2 && replicated)
theorem compositionsClose : closureWitness=.ok true := rfl
theorem componentwiseBalance : balanceWitness=.ok true := rfl
theorem exactRanks : rankWitness=.ok true := rfl
theorem absenceAppendReplication : absenceExtensionWitness=.ok true := rfl
end SFT.Chemistry.MulticomponentPhaseDiagram
