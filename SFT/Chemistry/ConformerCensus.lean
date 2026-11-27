import SFT.Chemistry.ConformerAssignments
namespace SFT.Chemistry.ConformerCensus
open SFT.Host SFT.Physics.CapabilityValues ConformerCarrier ConformerAssignments
open MulticentreSupport (sameLabel sameWord)

def containsAssignment (xs : List Assignment) (x : Assignment) : Bool := xs.any (sameWord x)
def uniqueAssignments (xs : List Assignment) : List Assignment :=
 xs.foldl (fun seen x => if containsAssignment seen x then seen else seen++[x]) []
structure Census where
 graph : Graph
 rotors : List Rotor
 alphabets : List Alphabet
 automorphisms : List Action
 generatedAssignments : List Assignment
 equivalenceClasses : List (List Assignment)

def construct (g : Graph) (rotors : List Rotor) (alphabets : List Alphabet) (actions : List Action)
 (assignments : List Assignment) (classes : List (List Assignment)) : Except String Census := do
 if rotors.isEmpty || rotors.length != alphabets.length then
  throw "conformer census requires every rotor and its exact held alphabet"
 if assignments.isEmpty || classes.isEmpty then
  throw "conformer census cannot omit generated assignments or classes"
 let flat := classes.flatten
 if (uniqueAssignments flat).length != flat.length ||
   !(flat.all (containsAssignment assignments)) || !(assignments.all (containsAssignment flat)) then
  throw "each generated assignment must occur in exactly one equivalence class"
 return ⟨g,rotors,alphabets,actions,assignments,classes⟩

-- Iterate anchors in generated order; previously removed anchors are skipped.
-- The source's assignment_order determines this same order.
def quotientStep (assignments : List Assignment) (actions : List Action)
 (rotors : List Rotor) (alphabets : List Alphabet)
 (state : List Assignment × List (List Assignment)) (anchor : Assignment) :
 Except String (List Assignment × List (List Assignment)) := do
 let (remaining,classes) := state
 if !containsAssignment remaining anchor then return (remaining,classes)
 let images ← actions.mapM fun action => applyAction anchor action rotors alphabets
 let orbit := uniqueAssignments images
 if !(orbit.all (containsAssignment assignments)) then
  throw "symmetry orbit leaves the complete generated assignment space"
 let orderedOrbit := (uniqueAssignments assignments).filter (containsAssignment orbit)
 return (remaining.filter fun row => !containsAssignment orbit row,classes++[orderedOrbit])

def quotient (assignments : List Assignment) (actions : List Action)
 (rotors : List Rotor) (alphabets : List Alphabet) : Except String (List (List Assignment)) := do
 let (_,classes) ← assignments.foldlM (quotientStep assignments actions rotors alphabets)
  (uniqueAssignments assignments,[])
 return classes

def census (g : Graph) (rotors : List Rotor) (alphabets : List Alphabet) : Except String Census := do
 rotors.forM fun rotor => validateRotor rotor g
 let actions ← allActions g
 let assignments ← generate alphabets
 let classes ← quotient assignments actions rotors alphabets
 construct g rotors alphabets actions assignments classes

def anti : HeldLabel := ⟨"torsion-state","anti",rfl,rfl⟩
def gaucheForward : HeldLabel := ⟨"torsion-state","gauche-forward",rfl,rfl⟩
def gaucheReverse : HeldLabel := ⟨"torsion-state","gauche-reverse",rfl,rfl⟩
def butane : Except String Census := do
 let carbon ← heldLabel "atom-type" "carbon"
 let bonds ← [1,2,3].mapM fun n => do return (← count n,← count (n+1))
 let g ← graph [carbon,carbon,carbon,carbon] bonds
 let rotor : Rotor := ⟨positions 4⟩
 let a ← alphabet [anti,gaucheForward,gaucheReverse]
  [(anti,anti),(gaucheForward,gaucheReverse),(gaucheReverse,gaucheForward)]
 census g [rotor] [a]

def generationWitness : Bool := match butane with
 | .error _ => false
 | .ok c => c.generatedAssignments.length==3 && (uniqueAssignments c.generatedAssignments).length==3
def automorphismWitness : Bool := match butane with
 | .error _ => false | .ok c => c.automorphisms.length==2
def quotientWitness : Bool := match butane with
 | .error _ => false
 | .ok c => c.equivalenceClasses.length==2 &&
  c.equivalenceClasses.any (fun group => group.length==1 && containsAssignment group [anti]) &&
  c.equivalenceClasses.any (fun group =>
   (group.all fun row => sameWord row [gaucheForward] || sameWord row [gaucheReverse]) &&
   containsAssignment group [gaucheForward] && containsAssignment group [gaucheReverse])
def partitionWitness : Bool := match butane with
 | .error _ => false | .ok c => (c.equivalenceClasses.map List.length).foldl Nat.add 0 == 3
def reversalWitness : Bool := match alphabet [anti,gaucheForward] [(anti,anti)] with
 | .error _ => true | .ok _ => false
def pathWitness : Bool := match (do
 let carbon ← heldLabel "atom-type" "carbon"
 let g ← graph [carbon,carbon,carbon,carbon] [(← count 1,← count 2),(← count 3,← count 4)]
 validateRotor ⟨positions 4⟩ g) with
 | .error _ => true | .ok _ => false
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem generationPassed : generationWitness = true := rfl
theorem automorphismPassed : automorphismWitness = true := rfl
theorem quotientPassed : quotientWitness = true := rfl
theorem partitionPassed : partitionWitness = true := rfl
theorem reversalPassed : reversalWitness = true := rfl
theorem pathPassed : pathWitness = true := rfl
end SFT.Chemistry.ConformerCensus
