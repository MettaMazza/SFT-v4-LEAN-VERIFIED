import SFT.QuantumComputation.ReversibleExecution
namespace SFT.QuantumComputation.GateLaw
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversiblePhase
open SFT.QuantumComputation.ReversibleApplication
open SFT.InformationScience.EncodingMaps SFT.Mathematics.DiscreteObjects

theorem transformedRowsExactly (gate : Gate) (cycle : List String) (amount : Nat)
    (branches transformed : List (Word × String))
    (executed : transformBranches gate cycle amount branches = some transformed)
    (target : Word × String) : target ∈ transformed ↔
      ∃ source, source ∈ branches ∧ lookupFirst gate.wordMap source.1 = some target.1 ∧
        shiftPhase cycle amount source.2 = some target.2 := by
  induction branches generalizing transformed with
  | nil =>
    cases executed
    constructor
    · intro held; cases held
    · intro ⟨source,held,_⟩; cases held
  | cons source rest ih =>
    obtain ⟨word,phase⟩ := source
    unfold transformBranches at executed
    cases w : lookupFirst gate.wordMap word with
    | none => rw [w] at executed; cases executed
    | some image =>
      rw [w] at executed
      cases p : shiftPhase cycle amount phase with
      | none => rw [p] at executed; cases executed
      | some shifted =>
        rw [p] at executed
        cases t : transformBranches gate cycle amount rest with
        | none => rw [t] at executed; cases executed
        | some tail =>
          rw [t] at executed
          cases executed
          constructor
          · intro held
            cases held with
            | head => exact ⟨(word,phase),.head _,w,p⟩
            | tail _ held =>
              obtain ⟨source,member,lookup,shift⟩ := (ih tail t).mp held
              exact ⟨source,.tail _ member,lookup,shift⟩
          · intro ⟨source,held,lookup,shift⟩
            cases held with
            | head =>
              rw [w] at lookup
              rw [p] at shift
              have eqWord := Option.some.inj lookup
              have eqPhase := Option.some.inj shift
              obtain ⟨targetWord,targetPhase⟩ := target
              dsimp only at eqWord eqPhase
              cases eqWord
              cases eqPhase
              exact .head _
            | tail _ held => exact .tail _ ((ih tail t).mpr ⟨source,held,lookup,shift⟩)

theorem exactGateBranch (state result : State) (gate : Gate)
    (executed : applyGate state gate false = .ok result) (target : Word × String) :
    target ∈ result.branches ↔ ∃ source, source ∈ state.branches ∧
      lookupFirst gate.wordMap source.1 = some target.1 ∧
      shiftPhase state.phaseCycle (gate.phaseSuccessors.length % state.phaseCycle.length) source.2 = some target.2 :=
  transformedRowsExactly gate state.phaseCycle _ state.branches result.branches
    (applicationSource state result gate false executed).2.2 target

theorem completeImageSupport (state result : State) (gate : Gate)
    (admitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (executed : applyGate state gate false = .ok result) (word : Word) :
    word ∈ support result ↔ word ∈ gate.wordMap.map Prod.snd := by
  have domain := (domainExactly result (inverse gate)).mp
    (inverseDomainFromApplication state result gate false admitted executed) word
  change word ∈ (invertRows gate.wordMap).map Prod.fst ↔ word ∈ support result at domain
  rw [inverseSources] at domain
  exact domain.symm

theorem branchMapInjective (gate : Gate)
    (admitted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
    (left right image : Word) (leftMap : lookupFirst gate.wordMap left = some image)
    (rightMap : lookupFirst gate.wordMap right = some image) : left = right := by
  have l := inverseWordImage gate (admittedGateTargets gate admitted) left image leftMap
  have r := inverseWordImage gate (admittedGateTargets gate admitted) right image rightMap
  rw [l] at r
  exact Option.some.inj r
end SFT.QuantumComputation.GateLaw
