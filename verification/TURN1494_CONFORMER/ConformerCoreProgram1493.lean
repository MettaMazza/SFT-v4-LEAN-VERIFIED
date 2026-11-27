import SFT.Chemistry.ConformerCensus
open SFT.Host SFT.Physics.CapabilityValues
open SFT.Chemistry.ConformerCarrier SFT.Chemistry.ConformerAssignments SFT.Chemistry.ConformerCensus
abbrev J := Canonical.Value
def label (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def positive (x : PositiveCount) : J := .object [("value",.integer (.ofNat x.value))]
def graphValue (g : Graph) : J := .object [("atom_types",.array (g.atomTypes.map label)),
 ("bonds",.array (g.bonds.map fun (a,b) => .array [positive a,positive b]))]
def alphabetValue (a : Alphabet) : J := .object [("states",.array (a.states.map label)),
 ("reversal",.array (a.reversal.map fun (x,y) => .array [label x,label y]))]
def actionValue (a : Action) : J := .object [("image",.array (a.image.map positive))]
def assignmentValue (a : Assignment) : J := .object [("states",.array (a.map label))]
def censusValue (c : Census) : J := .object [
 ("graph",graphValue c.graph),("rotors",.array (c.rotors.map fun r => .object [("ordered_sites",.array (r.orderedSites.map positive))])),
 ("alphabets",.array (c.alphabets.map alphabetValue)),("automorphisms",.array (c.automorphisms.map actionValue)),
 ("generated_assignments",.array (c.generatedAssignments.map assignmentValue)),
 ("equivalence_classes",.array (c.equivalenceClasses.map fun group => .array (group.map assignmentValue)))]
def result {α : Type} (encode : α → J) (value : Except String α) : J := match value with
 | .ok value => .object [("ok",encode value)]
 | .error error => .object [("error",.text error)]
def row {α : Type} (name : String) (encode : α → J) (value : Except String α) : J :=
 .object [("case",.text name),("result",result encode value)]
def carbon : HeldLabel := ⟨"atom-type","carbon",rfl,rfl⟩
def graphCase (pairs : List (Nat × Nat)) : Except String Graph := do
 let bonds ← pairs.mapM fun (a,b) => do return (← count a,← count b)
 graph [carbon,carbon,carbon,carbon] bonds
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def witnesses : J := .array [.array [.text "complete-raw-generation",.text "Three held torsion assignments are generated exactly once.",.boolean generationWitness],.array [.text "complete-automorphism-census",.text "The four-site path has identity and reversal and no selected action.",.boolean automorphismWitness],.array [.text "exact-orbit-quotient",.text "Anti is self-equivalent and the two opposed gauche orientations form one class.",.boolean quotientWitness],.array [.text "partition-certificate",.text "Every assignment occurs in exactly one nonempty conformer class.",.boolean partitionWitness],.array [.text "incomplete-reversal-control",.text "A torsion alphabet without complete involution halts.",.boolean reversalWitness],.array [.text "missing-path-control",.text "A rotor without its complete bonded path halts.",.boolean pathWitness]]
def main : IO Unit := do
 let c ← IO.ofExcept butane
 let basic := [row "original_butane_census" censusValue butane,
  row "original_six_witnesses" id (.ok witnesses),
  row "empty_atoms" graphValue (graph [] []),
  row "self_bond" graphValue (graphCase [(1,1)]),
  row "duplicate_reversed_bond" graphValue (graphCase [(1,2),(2,1)]),
  row "disconnected" graphValue (graphCase [(1,2),(3,4)]),
  row "incomplete_reversal" alphabetValue (alphabet [anti,gaucheForward] [(anti,anti)]),
  row "duplicate_reversal_key_last_value" alphabetValue (alphabet [anti] [(anti,gaucheForward),(anti,anti)]),
  row "empty_action" actionValue (action []),
  row "duplicate_action_position" actionValue (action [⟨1,by decide⟩,⟨1,by decide⟩]),
  row "empty_rotor_product" (fun xs => .array (xs.map assignmentValue)) (generate []),
  row "original_cartesian_product" (fun xs => .array (xs.map assignmentValue)) (generate c.alphabets)]
 let actions := (c.automorphisms.zipIdx).flatMap fun (a,i) =>
  (c.generatedAssignments.zipIdx).map fun (assignment,j) =>
   row ("action_"++toString i++"_assignment_"++toString j) assignmentValue (applyAction assignment a c.rotors c.alphabets)
 IO.println (Canonical.render (.array (basic++actions)))
