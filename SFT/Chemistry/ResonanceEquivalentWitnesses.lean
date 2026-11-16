import SFT.Chemistry.ResonanceEquivalent
namespace SFT.Chemistry.ResonanceEquivalent

def baseFirst := encoding "first" "carrier" ["a","b","c"] [(1,2),(2,3)] ["fold-fibre-one","fold-fibre-two"]
def baseSecond := encoding "second" "carrier" ["a","b","c"] [(1,2),(2,3)] ["fold-fibre-two","fold-fibre-one"]
def basePair : Except String ExactEquivalentRepresentationPair := do
 let first ← baseFirst
 let second ← baseSecond
 equivalentPair "carrier" first second

def baseWitness : Bool := match basePair with
 | .error _ => false
 | .ok pair => match representationCount pair with
  | .error _ => false
  | .ok n => n.value==2

def successorWitness : Bool := match basePair with
 | .error _ => false
 | .ok pair => match appendSharedSuccessor pair "d" with
  | .error _ => false
  | .ok successor =>
   sameLabels (successor.first.atoms.take (successor.first.atoms.length-1)) pair.first.atoms &&
   (match complementLabels successor.first.fibres with
    | .error _ => false
    | .ok complement => sameLabels complement successor.second.fibres)

def carrierTrial : Except String ExactEquivalentRepresentationPair := do
 let first ← baseFirst
 let other ← encoding "other" "other-carrier" ["a","b","c"] [(1,2),(2,3)] ["fold-fibre-two","fold-fibre-one"]
 equivalentPair "carrier" first other

def adjacencyTrial : Except String ExactEquivalentRepresentationPair := do
 let first ← baseFirst
 let changed ← encoding "changed" "carrier" ["a","b","c"] [(1,3),(2,3)] ["fold-fibre-two","fold-fibre-one"]
 equivalentPair "carrier" first changed

def partialTrial : Except String ExactEquivalentRepresentationPair := do
 let first ← baseFirst
 let partialEncoding ← encoding "partial" "carrier" ["a","b","c"] [(1,2),(2,3)] ["fold-fibre-one","fold-fibre-one"]
 equivalentPair "carrier" first partialEncoding

def rejected : Except String ExactEquivalentRepresentationPair → Bool
 | .error _ => true
 | .ok _ => false
def carrierWitness := rejected carrierTrial
def adjacencyWitness := rejected adjacencyTrial
def partialWitness := rejected partialTrial

theorem basePairPassed : baseWitness = true := rfl
theorem sharedSuccessorPassed : successorWitness = true := rfl
theorem changedCarrierRejected : carrierTrial = .error "different carriers cannot be representation-equivalent" := rfl
theorem changedAdjacencyRejected : adjacencyTrial = .error "representation equivalence must retain complete adjacency" := rfl
theorem partialComplementRejected : partialTrial = .error "alternative encoding must be the complete Fold-fibre complement" := rfl

#print axioms baseFirst
#print axioms baseSecond
#print axioms basePair
#print axioms baseWitness
#print axioms successorWitness
#print axioms carrierTrial
#print axioms adjacencyTrial
#print axioms partialTrial
#print axioms rejected
#print axioms carrierWitness
#print axioms adjacencyWitness
#print axioms partialWitness
#print axioms basePairPassed
#print axioms sharedSuccessorPassed
#print axioms changedCarrierRejected
#print axioms changedAdjacencyRejected
#print axioms partialComplementRejected
end SFT.Chemistry.ResonanceEquivalent
