import SFT.Physics.CapabilityValues
import SFT.Physics.GrandLockDependency
namespace SFT.Chemistry.MolecularElectronicState
open SFT.Host SFT.Physics.CapabilityValues
set_option maxRecDepth 100000
structure State where
 molecularCarrierId : String
 electronOccurrenceIds : List String
 heldSpinLabels : List HeldLabel
 jointSupport : List (String × HeldLabel)
 observationSignature : HeldLabel

def valid (state : State) : Except String State := do
 if !nonblank state.molecularCarrierId then throw "an electronic state requires one identified molecular carrier"
 let ids := state.electronOccurrenceIds
 let member := SFT.Physics.GrandLockDependency.member
 let unique := SFT.Physics.GrandLockDependency.unique
 if ids.isEmpty || (unique ids).length != ids.length then throw "electron occurrences must be a nonempty exact finite set"
 if state.heldSpinLabels.length != ids.length then throw "every electron occurrence requires one held spin label"
 if !(state.heldSpinLabels.all (fun label=>Text.equal label.family "electron-spin")) then throw "spin must remain a held electron label"
 let supportIds := state.jointSupport.map Prod.fst
 if (unique supportIds).length != supportIds.length || !(supportIds.all (fun n=>member n ids) && ids.all (fun n=>member n supportIds)) then throw "joint support must contain every electron occurrence exactly once"
 if !(state.jointSupport.all (fun (_,label)=>Text.equal label.family "molecular-electronic-support")) then throw "every support coordinate requires the molecular electronic family"
 if !Text.equal state.observationSignature.family "molecular-electronic-state" then throw "the state requires a retained molecular observation signature"
 pure state

def electronicCount (state : State) : Except String PositiveCount := count state.electronOccurrenceIds.length

def pairLe (a b : String × String) : Bool :=
 if Text.equal a.1 b.1 then Text.le a.2 b.2 else Text.le a.1 b.1
def insert (x : String × String) : List (String × String) → List (String × String)
 | []=>[x]
 | y::ys=>if pairLe x y then x::y::ys else y::insert x ys
def sorted : List (String × String) → List (String × String)
 | []=>[]
 | x::xs=>insert x (sorted xs)
def arrangement (state : State) : List (String × String) :=
 sorted ((state.jointSupport.zip state.heldSpinLabels).map fun (row,spin)=>(row.2.label,spin.label))
def pairsEqual : List (String × String) → List (String × String) → Bool
 | [],[]=>true
 | x::xs,y::ys=>Text.equal x.1 y.1 && Text.equal x.2 y.2 && pairsEqual xs ys
 | [],_::_ | _::_,[]=>false
def sameElectronicState (left right : State) : Bool :=
 Text.equal left.molecularCarrierId right.molecularCarrierId &&
 pairsEqual (arrangement left) (arrangement right) &&
 Text.equal left.observationSignature.family right.observationSignature.family &&
 Text.equal left.observationSignature.label right.observationSignature.label

def distinguishableElectronicStates (left right : State) : Except String Bool :=
 if Text.equal left.molecularCarrierId right.molecularCarrierId then .ok (!sameElectronicState left right)
 else .error "electronic-state distinction requires one retained molecular carrier"

#print axioms valid
#print axioms electronicCount
#print axioms sameElectronicState
#print axioms distinguishableElectronicStates
end SFT.Chemistry.MolecularElectronicState
