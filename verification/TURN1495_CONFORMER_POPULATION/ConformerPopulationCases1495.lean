import SFT.Chemistry.ConformerPopulation
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

open SFT.Chemistry

open SFT.Chemistry.DihedralTorsion (Ratio Height)
def ratioValue (r : Ratio) : J := .object [("numerator",positive r.numerator),("denominator",positive r.denominator)]
def heightValue : Height → J
 | .emptyOne => .object [("identity",.text "empty-One")]
 | .otherEmptyOne s => .object [("identity",.text s)]
 | .ratio r => ratioValue r
 | .invalid => .null
def occurrenceValue : ConformerPopulation.Occurrence → J
 | .emptyOne => .object [("identity",.text "empty-One")]
 | .otherEmptyOne s => .object [("identity",.text s)]
 | .count n => positive n
 | .invalid => .null
def classesValue (groups : List (List Assignment)) : J := .array (groups.map fun g => .array (g.map assignmentValue))
def observationValue (x : ConformerPopulation.Observation) : J := .object [("condition",label x.condition),("observation_boundary",positive x.boundary),("trace",.array (x.trace.map assignmentValue))]
def rowValue (x : ConformerPopulation.Row) : J := .object [("equivalence_class",.array (x.equivalenceClass.map assignmentValue)),("occurrence_count",occurrenceValue x.occurrence),("population",heightValue x.population),("relative_energy",heightValue x.relativeEnergy)]
def populationValue (x : ConformerPopulation.PopulationCensus) : J := .object [("conformers",censusValue x.conformers),("observation",observationValue x.observation),("rows",.array (x.rows.map rowValue))]
def test {α : Type} (name : String) (encode : α→J) (value : Except String α) : J :=
 .object [("case",.text name),("result",match value with | .ok x => .object [("ok",encode x)] | .error e => .object [("error",.text e)])]
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let c ← IO.ofExcept butane
 let a := [anti]; let g := [gaucheForward]; let h := [gaucheReverse]
 let condition : HeldLabel := ⟨"observation-condition","fixed-condition-and-timescale",rfl,rfl⟩
 let badCondition : HeldLabel := ⟨"other","fixed",rfl,rfl⟩
 let foreign : HeldLabel := ⟨"torsion-state","foreign",rfl,rfl⟩
 IO.println (Canonical.render (.array [
test "take_empty_empty" ratioValue (ConformerPopulation.orderedTake (.emptyOne) (.emptyOne)),
test "take_empty_other_empty" ratioValue (ConformerPopulation.orderedTake (.emptyOne) (.otherEmptyOne "empty-One")),
test "take_empty_one" ratioValue (ConformerPopulation.orderedTake (.emptyOne) (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩)),
test "take_empty_three" ratioValue (ConformerPopulation.orderedTake (.emptyOne) (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩)),
test "take_empty_half_raw" ratioValue (ConformerPopulation.orderedTake (.emptyOne) (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩)),
test "take_other_empty_empty" ratioValue (ConformerPopulation.orderedTake (.otherEmptyOne "empty-One") (.emptyOne)),
test "take_other_empty_other_empty" ratioValue (ConformerPopulation.orderedTake (.otherEmptyOne "empty-One") (.otherEmptyOne "empty-One")),
test "take_other_empty_one" ratioValue (ConformerPopulation.orderedTake (.otherEmptyOne "empty-One") (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩)),
test "take_other_empty_three" ratioValue (ConformerPopulation.orderedTake (.otherEmptyOne "empty-One") (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩)),
test "take_other_empty_half_raw" ratioValue (ConformerPopulation.orderedTake (.otherEmptyOne "empty-One") (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩)),
test "take_one_empty" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) (.emptyOne)),
test "take_one_other_empty" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) (.otherEmptyOne "empty-One")),
test "take_one_one" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩)),
test "take_one_three" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩)),
test "take_one_half_raw" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩)),
test "take_three_empty" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.emptyOne)),
test "take_three_other_empty" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.otherEmptyOne "empty-One")),
test "take_three_one" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩)),
test "take_three_three" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩)),
test "take_three_half_raw" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩)),
test "take_half_raw_empty" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩) (.emptyOne)),
test "take_half_raw_other_empty" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩) (.otherEmptyOne "empty-One")),
test "take_half_raw_one" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩) (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩)),
test "take_half_raw_three" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩) (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩)),
test "take_half_raw_half_raw" ratioValue (ConformerPopulation.orderedTake (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩) (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩)),
test "base" populationValue (ConformerPopulation.conditioned c condition [a,a,g,a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]),
test "base_population_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,a,g,a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.populationOrder x),
test "base_energy_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,a,g,a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.energyOrder x),
test "anti_only" populationValue (ConformerPopulation.conditioned c condition [a,a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]),
test "anti_only_population_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.populationOrder x),
test "anti_only_energy_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.energyOrder x),
test "gauche_only" populationValue (ConformerPopulation.conditioned c condition [g,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]),
test "gauche_only_population_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [g,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.populationOrder x),
test "gauche_only_energy_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [g,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.energyOrder x),
test "tie" populationValue (ConformerPopulation.conditioned c condition [a,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]),
test "tie_population_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.populationOrder x),
test "tie_energy_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.energyOrder x),
test "successor" populationValue (ConformerPopulation.conditioned c condition [a,a,g,a,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]),
test "successor_population_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,a,g,a,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.populationOrder x),
test "successor_energy_order" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,a,g,a,h] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.energyOrder x),
test "empty" populationValue (ConformerPopulation.conditioned c condition [] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]),
test "foreign" populationValue (ConformerPopulation.conditioned c condition [[foreign]] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]),
test "append" populationValue (do let x ← ConformerPopulation.conditioned c condition [a,a,g,a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; ConformerPopulation.appendObservation x h),
test "energy_length" populationValue (ConformerPopulation.conditioned c condition [a] []),
test "bad_condition" populationValue (ConformerPopulation.conditioned c badCondition [a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]),
test "observation_length" observationValue (ConformerPopulation.observation condition (.count ⟨2,by decide⟩) [a]),
test "observation_invalid_boundary" observationValue (ConformerPopulation.observation condition .other [a]),
test "empty_class" rowValue (ConformerPopulation.row [] .emptyOne .emptyOne .emptyOne),
test "absent_positive_population" rowValue (ConformerPopulation.row [a] .emptyOne (.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩) .emptyOne),
test "observed_empty_population" rowValue (ConformerPopulation.row [a] (.count ⟨1,by decide⟩) .emptyOne .emptyOne),
test "raw_ratio_retained" rowValue (ConformerPopulation.row [a] (.count ⟨2,by decide⟩) (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩) .emptyOne),
test "other_empty_occurrence" rowValue (ConformerPopulation.row [a] (.otherEmptyOne "empty-One") .emptyOne .emptyOne),
test "other_empty_energy" rowValue (ConformerPopulation.row [a] .emptyOne .emptyOne (.otherEmptyOne "empty-One")),
test "other_empty_energy_sort" classesValue (do let x ← ConformerPopulation.conditioned c condition [a] [.emptyOne,.otherEmptyOne "empty-One"]; ConformerPopulation.energyOrder x),
test "all_energy_tied" classesValue (do let x ← ConformerPopulation.conditioned c condition [a,g] [.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩,.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩]; ConformerPopulation.energyOrder x)]))
