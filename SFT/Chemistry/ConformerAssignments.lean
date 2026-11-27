import SFT.Chemistry.ConformerCarrier
namespace SFT.Chemistry.ConformerAssignments
open SFT.Host SFT.Physics.CapabilityValues ConformerCarrier
open MulticentreSupport (sameLabel sameWord)
abbrev Assignment := List HeldLabel

def productStates : List Alphabet → List Assignment
 | [] => [[]]
 | a::rest => a.states.flatMap fun state => (productStates rest).map (List.cons state)
def generate (alphabets : List Alphabet) : Except String (List Assignment) :=
 if alphabets.isEmpty then .error "conformer generation requires at least one retained rotor"
 else .ok (productStates alphabets)
def sameSites (a b : List PositiveCount) : Bool :=
 a.length==b.length && (a.zip b).all (fun (x,y) => x.value==y.value)
def targetMatches (mapped : List PositiveCount) (rotors : List Rotor) : List (Nat × Bool) :=
 (rotors.zipIdx).filterMap (fun (target,i) => if sameSites mapped target.orderedSites then some (i,false) else none) ++
 (rotors.zipIdx).filterMap (fun (target,i) => if sameSites mapped (reversedSites target) then some (i,true) else none)

def transformRotor (a : Action) (rotors : List Rotor) (alphabets : List Alphabet)
 (transformed : List (Nat × HeldLabel)) (row : (Rotor × HeldLabel) × Alphabet) :
 Except String (List (Nat × HeldLabel)) := do
 let ((rotor,state),sourceAlphabet) := row
 let mapped ← rotor.orderedSites.mapM (ConformerCarrier.apply a)
 let matchedRows := targetMatches mapped rotors
 let (targetIndex,reversedOrientation) ← match matchedRows with
  | [pair] => pure pair
  | [] | _::_::_ => throw "graph action does not induce one complete rotor action"
 if transformed.any (fun (i,_) => i==targetIndex) then
  throw "graph action changes or duplicates a registered rotor alphabet"
 let targetAlphabet ← match MolecularGraphEnumeration.atIndex alphabets targetIndex with
  | none => throw "tuple index out of range"
  | some target => pure target
 if !sameWord targetAlphabet.states sourceAlphabet.states then
  throw "graph action changes or duplicates a registered rotor alphabet"
 let value ← if reversedOrientation then reverseState sourceAlphabet state else pure state
 return transformed++[(targetIndex,value)]

def readback (size : Nat) (transformed : List (Nat × HeldLabel)) : Except String Assignment :=
 (List.range size).mapM fun i =>
  match transformed.find? (fun pair => pair.1==i) with
  | none => .error "target rotor index not found"
  | some pair => .ok pair.2

def applyAction (assignment : Assignment) (a : Action) (rotors : List Rotor)
 (alphabets : List Alphabet) : Except String Assignment := do
 if assignment.length != rotors.length then throw "conformer assignment omits a rotor state"
 let transformed ← ((rotors.zip assignment).zip alphabets).foldlM
  (transformRotor a rotors alphabets) ([] : List (Nat × HeldLabel))
 if transformed.length != rotors.length then throw "graph action omits a target rotor"
 readback rotors.length transformed

-- The exact product extension used by generate_conformer_assignments.
theorem productEmpty : productStates [] = [[]] := rfl
theorem productStep (a : Alphabet) (rest : List Alphabet) :
 productStates (a::rest) = a.states.flatMap (fun state => (productStates rest).map (List.cons state)) := rfl
end SFT.Chemistry.ConformerAssignments
