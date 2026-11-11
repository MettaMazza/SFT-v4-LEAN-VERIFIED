import SFT.Chemistry.BondClosure
import SFT.Physics.MechanicalLocation
namespace SFT.Chemistry.BondLengthStrength
open SFT.Physics SFT.Host.Canonical SFT.Foundation.ExactOperations

structure Distance (bond : BondClosure.Record) where
 displacement : MechanicalLocation.Displacement String
 leftBinding : displacement.first.referenceIdentity=bond.support.raw.left
 rightBinding : displacement.second.referenceIdentity=bond.support.raw.right
 method : Value
 state : Value
 uncertainty : Value
 source : Value
 observedValue : Value

structure Dissociation (bond : BondClosure.Record) where
 transfer : PositiveFraction
 phase : Value
 state : Value
 cleavagePath : Value
 method : Value
 uncertainty : Value
 source : Value
 observedValue : Value
 transferRecords : List Value
 completeTransfers : transferRecords=bond.transfers

structure Pair (bond : BondClosure.Record) where
 distance : Distance bond
 strength : Dissociation bond

def distanceRecord {bond : BondClosure.Record} (distance : Distance bond) :=
 (bond.entity,distance.displacement,distance.method,distance.state,distance.uncertainty,distance.source,distance.observedValue)

def strengthRecord {bond : BondClosure.Record} (strength : Dissociation bond) :=
 (bond.entity,strength.transfer,strength.phase,strength.state,strength.cleavagePath,strength.method,strength.uncertainty,strength.source,strength.observedValue,strength.transferRecords)

theorem commonBondIdentity {bond : BondClosure.Record} (pair : Pair bond) :
 (distanceRecord pair.distance).1=(strengthRecord pair.strength).1 := rfl

theorem distanceCentresRetained {bond : BondClosure.Record} (pair : Pair bond) :
 pair.distance.displacement.first.referenceIdentity=bond.support.raw.left ∧
 pair.distance.displacement.second.referenceIdentity=bond.support.raw.right :=
 ⟨pair.distance.leftBinding,pair.distance.rightBinding⟩

theorem positiveDistance {bond : BondClosure.Record} (pair : Pair bond) :
 0<pair.distance.displacement.separation.numerator := MechanicalLocation.separationPositive _

theorem positiveDissociation {bond : BondClosure.Record} (pair : Pair bond) :
 0<pair.strength.transfer.numerator := pair.strength.transfer.positive

theorem openingRetainsDissociationTrace {bond : BondClosure.Record} (pair : Pair bond) :
 (BondClosure.openedRecord bond).2.2.1=pair.strength.transferRecords := pair.strength.completeTransfers.symm

def pairedRecord {bond : BondClosure.Record} (pair : Pair bond) :=
 (distanceRecord pair.distance,strengthRecord pair.strength,BondClosure.openedRecord bond)

theorem sourceAndMethodsRetained {bond : BondClosure.Record} (pair : Pair bond) :
 (distanceRecord pair.distance).2.2.1=pair.distance.method ∧
 (distanceRecord pair.distance).2.2.2.2.2.1=pair.distance.source ∧
 (strengthRecord pair.strength).2.2.2.2.2.1=pair.strength.method := ⟨rfl,rfl,rfl⟩

structure History (bond : BondClosure.Record) where
 first : Pair bond
 rest : List (Pair bond)

def observations {bond : BondClosure.Record} (history : History bond) := history.first::history.rest

def append {bond : BondClosure.Record} (history : History bond) (next : Pair bond) : History bond :=
 ⟨history.first,history.rest++[next]⟩

theorem everyPriorObservationRetained {bond : BondClosure.Record} (history : History bond)
 (next prior : Pair bond) (held : prior ∈ observations history) :
 prior ∈ observations (append history next) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem newObservationRetained {bond : BondClosure.Record} (history : History bond) (next : Pair bond) :
 next ∈ observations (append history next) :=
 SFT.Foundation.Count.TraceDerivation.memAppendRight next (observations history) [next] (.head [])

def completeRecords {bond : BondClosure.Record} (history : History bond) := (observations history).map pairedRecord

theorem completeRecordAppend {bond : BondClosure.Record} (history : History bond) (next : Pair bond) :
 completeRecords (append history next)=completeRecords history++[pairedRecord next] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend pairedRecord (observations history) [next]

def structuralLaw {bond : BondClosure.Record} (_history : History bond) := BondClosure.structuralClass bond

theorem measurementAppendPreservesLaw {bond : BondClosure.Record} (history : History bond) (next : Pair bond) :
 structuralLaw (append history next)=structuralLaw history := rfl

-- Both measured payloads stay external to the source structural classifier.
theorem observationPayloadsDoNotSelect {bond : BondClosure.Record} (first second : History bond) :
 structuralLaw first=structuralLaw second := rfl

end SFT.Chemistry.BondLengthStrength
