import SFT.Chemistry.ConformerCensus
namespace SFT.Chemistry.ConformerPartition
open ConformerCarrier ConformerAssignments ConformerCensus

-- ExactConformerCensus.__post_init__: preserve the six supplied fields and
-- the original three constructor guards, including the full flattened census.
theorem acceptedFields (g : Graph) (rotors : List Rotor) (alphabets : List Alphabet)
 (actions : List Action) (assignments : List Assignment) (classes : List (List Assignment))
 (out : Census) (accepted : construct g rotors alphabets actions assignments classes = .ok out) :
 out.graph = g ∧ out.rotors = rotors ∧ out.alphabets = alphabets ∧
 out.automorphisms = actions ∧ out.generatedAssignments = assignments ∧
 out.equivalenceClasses = classes := by
 unfold construct at accepted
 cases first : (rotors.isEmpty || rotors.length != alphabets.length) <;> rw [first] at accepted
 · dsimp at accepted
   cases second : (assignments.isEmpty || classes.isEmpty) <;> rw [second] at accepted
   · dsimp at accepted
     split at accepted
     · cases accepted
     · cases accepted; exact ⟨rfl,rfl,rfl,rfl,rfl,rfl⟩
   · cases accepted
 · cases accepted

theorem acceptedRotorGuard (g : Graph) (rotors : List Rotor) (alphabets : List Alphabet)
 (actions : List Action) (assignments : List Assignment) (classes : List (List Assignment))
 (out : Census) (accepted : construct g rotors alphabets actions assignments classes = .ok out) :
 (rotors.isEmpty || rotors.length != alphabets.length) = false := by
 cases guard : (rotors.isEmpty || rotors.length != alphabets.length) with
 | false => rfl
 | true =>
  unfold construct at accepted
  rw [guard] at accepted
  cases accepted

theorem acceptedNonemptyGuard (g : Graph) (rotors : List Rotor) (alphabets : List Alphabet)
 (actions : List Action) (assignments : List Assignment) (classes : List (List Assignment))
 (out : Census) (accepted : construct g rotors alphabets actions assignments classes = .ok out) :
 (assignments.isEmpty || classes.isEmpty) = false := by
 have first := acceptedRotorGuard g rotors alphabets actions assignments classes out accepted
 cases guard : (assignments.isEmpty || classes.isEmpty) with
 | false => rfl
 | true =>
  unfold construct at accepted
  rw [first] at accepted
  dsimp at accepted
  rw [guard] at accepted
  cases accepted

theorem acceptedPartitionGuard (g : Graph) (rotors : List Rotor) (alphabets : List Alphabet)
 (actions : List Action) (assignments : List Assignment) (classes : List (List Assignment))
 (out : Census) (accepted : construct g rotors alphabets actions assignments classes = .ok out) :
 ((uniqueAssignments classes.flatten).length != classes.flatten.length ||
 !(classes.flatten.all (containsAssignment assignments)) ||
 !(assignments.all (containsAssignment classes.flatten))) = false := by
 have first := acceptedRotorGuard g rotors alphabets actions assignments classes out accepted
 have second := acceptedNonemptyGuard g rotors alphabets actions assignments classes out accepted
 cases guard : ((uniqueAssignments classes.flatten).length != classes.flatten.length ||
  !(classes.flatten.all (containsAssignment assignments)) ||
  !(assignments.all (containsAssignment classes.flatten))) with
 | false => rfl
 | true =>
  unfold construct at accepted
  rw [first] at accepted
  dsimp at accepted
  rw [second] at accepted
  dsimp at accepted
  rw [guard] at accepted
  cases accepted
end SFT.Chemistry.ConformerPartition
