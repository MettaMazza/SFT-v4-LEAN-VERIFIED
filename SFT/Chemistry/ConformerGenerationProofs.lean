import SFT.Chemistry.ConformerAssignments
namespace SFT.Chemistry.ConformerGenerationProofs
open SFT.Physics.CapabilityValues
open ConformerCarrier ConformerAssignments
open SFT.Foundation.CommonRefinement
open SFT.Foundation.Count.TraceDerivation

-- The source product chooses exactly one retained state from each rotor alphabet.
def choices : List Alphabet → Assignment → Prop
 | [],[] => True
 | a::rest,state::suffix => state ∈ a.states ∧ choices rest suffix
 | [],_::_ | _::_,[] => False

theorem generatedHasEveryChoice (alphabets : List Alphabet) (assignment : Assignment)
 (generated : assignment ∈ productStates alphabets) : choices alphabets assignment := by
 induction alphabets generalizing assignment with
 | nil =>
  change assignment ∈ [[]] at generated
  cases generated with
  | head => exact True.intro
  | tail _ impossible => cases impossible
 | cons a rest ih =>
  change assignment ∈ a.states.flatMap (fun state => (productStates rest).map (List.cons state)) at generated
  obtain ⟨state,present,mapped⟩ := memFlatMapOrigin _ _ _ generated
  obtain ⟨suffix,retained,equal⟩ := memMapPreimage _ _ _ mapped
  cases equal
  exact ⟨present,ih suffix retained⟩

theorem everyChoiceIsGenerated (alphabets : List Alphabet) (assignment : Assignment)
 (selected : choices alphabets assignment) : assignment ∈ productStates alphabets := by
 induction alphabets generalizing assignment with
 | nil =>
  cases assignment with
  | nil => exact List.Mem.head _
  | cons state rest => cases selected
 | cons a rest ih =>
  cases assignment with
  | nil => cases selected
  | cons state suffix =>
   obtain ⟨present,remaining⟩ := selected
   exact memFlatMap _ _ state (state::suffix) present
    (memMap (List.cons state) suffix (productStates rest) (ih suffix remaining))

theorem exactGeneratedCarrier (alphabets : List Alphabet) (assignment : Assignment) :
 assignment ∈ productStates alphabets ↔ choices alphabets assignment :=
 ⟨generatedHasEveryChoice alphabets assignment,everyChoiceIsGenerated alphabets assignment⟩

theorem assignmentRetainsEveryRotor (alphabets : List Alphabet) (assignment : Assignment)
 (generated : assignment ∈ productStates alphabets) : assignment.length=alphabets.length := by
 have selected := generatedHasEveryChoice alphabets assignment generated
 clear generated
 induction alphabets generalizing assignment with
 | nil =>
  cases assignment with
  | nil => rfl
  | cons state rest => cases selected
 | cons a rest ih =>
  cases assignment with
  | nil => cases selected
  | cons state suffix =>
   exact congrArg Nat.succ (ih suffix selected.2)

def productCount : List Alphabet → Nat
 | [] => 1
 | a::rest => a.states.length * productCount rest

theorem generatedCardinality (alphabets : List Alphabet) :
 (productStates alphabets).length=productCount alphabets := by
 induction alphabets with
 | nil => rfl
 | cons a rest ih =>
  change (a.states.flatMap (fun state => (productStates rest).map (List.cons state))).length = a.states.length * productCount rest
  have count (states : List HeldLabel) :
   (states.flatMap (fun state => (productStates rest).map (List.cons state))).length = states.length * productCount rest := by
   induction states with
   | nil => exact (Nat.zero_mul _).symm
   | cons state states localIH =>
    change (((productStates rest).map (List.cons state)) ++ states.flatMap (fun s => (productStates rest).map (List.cons s))).length = (states.length+1)*productCount rest
    rw [appendLength,mapLength,ih,localIH]
    exact (Nat.add_comm _ _).trans (Nat.succ_mul states.length (productCount rest)).symm
  exact count a.states
end SFT.Chemistry.ConformerGenerationProofs
