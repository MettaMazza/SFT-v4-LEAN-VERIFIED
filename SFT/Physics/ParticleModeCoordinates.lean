import SFT.Physics.ParticleModeFixedDerivation
namespace SFT.Physics.ParticleModeCoordinates
open ParticleModeFibres LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Coordinates where
 labels : List Nat
 halfFibre : List Rat
 oneFibre : List Rat
 fixedFive : List Rat
 quarterModes : List Rat
 allThree : Bool
 orderIsomorphic : Bool
 coordinatesAreMassValues : Bool

def insertSorted (value : Rat) : List Rat → List Rat
 | [] => [value]
 | x::xs => if value.blt x then value::x::xs else x::insertSorted value xs
def sorted : List Rat → List Rat
 | [] => []
 | x::xs => insertSorted x (sorted xs)

def generationCoordinates : Except String Coordinates := do
 let labels := [1,2,3]
 let halfFibre ← (List.range 3).mapM (fibreValue 3 (normalize 1 2 (by decide)))
 let oneFibre ← labels.mapM (fun i=>LeptonRatios.divide (wholeRatio i) (wholeRatio 3))
 let fixedFive ← interiorFixedModes (.integer 5)
 let quarter ← labels.mapM (fun i=>LeptonRatios.divide (wholeRatio i) (wholeRatio 4))
 let rows := [halfFibre,oneFibre,fixedFive,quarter]
 pure ⟨labels,halfFibre,oneFibre,fixedFive,quarter,
  rows.all (fun row => row.length==3 && sorted row==row),
  rows.all (fun row => ((row.zip row.tail).map (fun (a,b) => a.blt b))==[true,true]),false⟩
def originalCoordinates : Coordinates := ⟨[1,2,3],
 [normalize 1 6 (by decide),normalize 1 2 (by decide),normalize 5 6 (by decide)],
 [normalize 1 3 (by decide),normalize 2 3 (by decide),wholeRatio 1],
 [normalize 1 4 (by decide),normalize 1 2 (by decide),normalize 3 4 (by decide)],
 [normalize 1 4 (by decide),normalize 1 2 (by decide),normalize 3 4 (by decide)],true,true,false⟩
theorem originalCompleteCoordinates : generationCoordinates=.ok originalCoordinates := rfl
structure Transition where
 sites : List Rat
 adjacent : List Rat
 outer : Rat
 separationUnits : List Nat
 squaredMultiplicity : List Nat
 universalObservedMixingRates : Bool
 terminalMixingCarriersRequired : Bool
 complete : Bool

def transitionModeCertificate : Except String Transition := do
 let coordinates ← generationCoordinates
 let sites := coordinates.quarterModes
 match sites with
 | [] => throw "tuple index out of range"
 | [_] => throw "tuple index out of range"
 | [_,_] => throw "tuple index out of range"
 | a::b::c::_ =>
  let adjacent := [subtract b a,subtract c b]
  let outer := subtract c a
  pure ⟨sites,adjacent,outer,[1,1,2],[1,1,4],false,true,
   adjacent==[normalize 1 4 (by decide),normalize 1 4 (by decide)] && outer==normalize 1 2 (by decide)⟩

theorem originalCompleteTransition : transitionModeCertificate=.ok
 ⟨originalCoordinates.quarterModes,[normalize 1 4 (by decide),normalize 1 4 (by decide)],
 normalize 1 2 (by decide),[1,1,2],[1,1,4],false,true,true⟩ := rfl
#print axioms generationCoordinates
#print axioms originalCompleteCoordinates
#print axioms transitionModeCertificate
#print axioms originalCompleteTransition
end SFT.Physics.ParticleModeCoordinates
