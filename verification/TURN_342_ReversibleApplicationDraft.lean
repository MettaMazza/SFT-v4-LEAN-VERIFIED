import verification.TURN_342_ReversiblePhaseDraft
import SFT.InformationScience.EncodingMaps
namespace SFT.QuantumComputation.ReversibleApplication
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversiblePhase
open SFT.InformationScience.EncodingMaps SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

def domainMatches (state : State) (gate : Gate) : Bool :=
  (gate.wordMap.map Prod.fst).all (has (support state)) &&
    (support state).all (has (gate.wordMap.map Prod.fst))

def transformBranches (gate : Gate) (cycle : List String) (amount : Nat) :
    List (Word × String) → Option (List (Word × String))
  | [] => some []
  | (word,phase)::rest => match lookupFirst gate.wordMap word with
    | none => none
    | some target => match shiftPhase cycle amount phase with
      | none => none
      | some shifted => match transformBranches gate cycle amount rest with
        | none => none
        | some tail => some ((target,shifted)::tail)

def applyGate (state : State) (gate : Gate) (inversePhase : Bool := false) : Except String State :=
  if domainMatches state gate then
    let amount := gate.phaseSuccessors.length % state.phaseCycle.length
    let shift := if inversePhase then inverseShift amount state.phaseCycle.length else amount
    match transformBranches gate state.phaseCycle shift state.branches with
    | none => .error "unregistered word or phase"
    | some branches => makeState branches state.phaseCycle
  else .error "gate domain must equal complete state support"

theorem inverseWordImage (gate : Gate) (uniqueTargets : distinct (gate.wordMap.map Prod.snd) = true)
    (word target : Word) (forward : lookupFirst gate.wordMap word = some target) :
    lookupFirst (inverse gate).wordMap target = some word := by
  have row := lookupRow _ _ _ forward
  apply lookupUnique
  · exact (congrArg distinct (inverseSources gate.wordMap)).trans uniqueTargets
  · exact memMap (fun pair : Word × Word => (pair.2,pair.1)) (word,target) gate.wordMap row

theorem transformedBranchesInverse (gate : Gate)
    (uniqueTargets : distinct (gate.wordMap.map Prod.snd) = true)
    (cycle : List String) (uniqueCycle : distinct cycle = true) (positive : 0 < cycle.length)
    (amount : Nat) (amountBound : amount < cycle.length) (branches transformed : List (Word × String))
    (held : ∀ row, row ∈ branches → row.2 ∈ cycle)
    (forward : transformBranches gate cycle amount branches = some transformed) :
    transformBranches (inverse gate) cycle (inverseShift amount cycle.length) transformed = some branches := by
  induction branches generalizing transformed with
  | nil => cases forward; rfl
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    unfold transformBranches at forward
    cases w : lookupFirst gate.wordMap word with
    | none => rw [w] at forward; cases forward
    | some target =>
      rw [w] at forward
      cases p : shiftPhase cycle amount phase with
      | none => rw [p] at forward; cases forward
      | some shifted =>
        rw [p] at forward
        cases t : transformBranches gate cycle amount rest with
        | none => rw [t] at forward; cases forward
        | some tail =>
          rw [t] at forward
          cases forward
          have wordBack := inverseWordImage gate uniqueTargets word target w
          have phaseBack := phaseInverse cycle uniqueCycle positive phase shifted amount
            (held _ (.head _)) amountBound p
          have tailBack := ih tail (fun row member => held row (.tail _ member)) t
          unfold transformBranches
          rw [wordBack,phaseBack,tailBack]

end SFT.QuantumComputation.ReversibleApplication
