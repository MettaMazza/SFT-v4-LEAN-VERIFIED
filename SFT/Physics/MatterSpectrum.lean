import SFT.Physics.MatterConservedLabels
namespace SFT.Physics.MatterSpectrum

-- A row retains the source's complete recurrent constituent and its registered
-- observable transition signature. Decompositions are the generated proper
-- recurrent constituent decompositions, not external particle names.
structure Description (Trace : Type) where
  constituent : MatterAntiparticle.Constituent
  returnTrace : List String
  fullPeriod : returnTrace.length = constituent.word.state.phaseCycle.length
  name : String
  observableTrace : Trace
  properDecompositions : List (List MatterAntiparticle.Constituent)

def minimal {Trace : Type} (d : Description Trace) : Bool := d.properDecompositions.isEmpty

def elementary {Trace : Type} : List (Description Trace) → List (Description Trace)
  | [] => []
  | d::rest => if minimal d then d::elementary rest else elementary rest

theorem minimalExactly {Trace : Type} (d : Description Trace) : minimal d = true ↔ d.properDecompositions = [] := by
  cases d with
  | mk c r p n t parts =>
    cases parts <;> constructor <;> intro h
    all_goals first | rfl | cases h

theorem elementaryExactly {Trace : Type} (rows : List (Description Trace)) (d : Description Trace) :
    d ∈ elementary rows ↔ d ∈ rows ∧ minimal d = true := by
  induction rows with
  | nil => constructor
           · intro h; cases h
           · intro h; cases h.1
  | cons a rest ih =>
    cases h : minimal a with
    | false =>
      rw [elementary,h]
      change d ∈ elementary rest ↔ d ∈ a::rest ∧ minimal d = true
      constructor
      · intro hd; have z := ih.mp hd; exact ⟨.tail _ z.1,z.2⟩
      · intro hd; cases hd.1 with
        | head => exact Bool.noConfusion (h.symm.trans hd.2)
        | tail _ hm => exact ih.mpr ⟨hm,hd.2⟩
    | true =>
      rw [elementary,h]
      change d ∈ a::elementary rest ↔ d ∈ a::rest ∧ minimal d = true
      constructor
      · intro hd; cases hd with
        | head => exact ⟨.head _,h⟩
        | tail _ hm => have z := ih.mp hm; exact ⟨.tail _ z.1,z.2⟩
      · intro hd; cases hd.1 with
        | head => exact .head _
        | tail _ hm => exact .tail _ (ih.mpr ⟨hm,hd.2⟩)

theorem properCompositeExcluded {Trace : Type} (rows : List (Description Trace)) (d : Description Trace)
    (decomposition : List MatterAntiparticle.Constituent) (held : decomposition ∈ d.properDecompositions) :
    d ∉ elementary rows := by
  intro included
  have empty := (minimalExactly d).mp ((elementaryExactly rows d).mp included).2
  rw [empty] at held; cases held

def equivalent {Trace : Type} (a b : Description Trace) : Prop := a.observableTrace = b.observableTrace

def classKey {Trace : Type} (d : Description Trace) := d.observableTrace

theorem classExactlyTraceEquivalence {Trace : Type} (a b : Description Trace) :
    classKey a = classKey b ↔ equivalent a b := ⟨fun h => h,fun h => h⟩

theorem namesCannotChangeClass {Trace : Type} (d : Description Trace) (name : String) :
    classKey {d with name := name} = classKey d := rfl

theorem changedFullTraceDistinguishes {Trace : Type} (a b : Description Trace)
    (different : a.observableTrace ≠ b.observableTrace) : ¬ equivalent a b := different

def memberDecision {Trace : Type} [DecidableEq Trace] (t : Trace) : (ts : List Trace) → Decidable (t ∈ ts)
  | [] => .isFalse (fun h => nomatch h)
  | a::rest => match decEq t a with
    | .isTrue equal => .isTrue (by cases equal; exact .head _)
    | .isFalse different => match memberDecision t rest with
      | .isTrue present => .isTrue (.tail _ present)
      | .isFalse absent => .isFalse (by
          intro h
          cases h with
          | head => exact different rfl
          | tail _ ht => exact absent ht)

def unique {Trace : Type} [DecidableEq Trace] : List Trace → List Trace
  | [] => []
  | t::ts => @ite (List Trace) (t ∈ unique ts) (memberDecision t (unique ts)) (unique ts) (t::unique ts)

theorem uniqueMembership {Trace : Type} [DecidableEq Trace] (ts : List Trace) (t : Trace) :
    t ∈ unique ts ↔ t ∈ ts := by
  induction ts with
  | nil => exact ⟨fun h => h,fun h => h⟩
  | cons a rest ih =>
    unfold unique
    split
    · rename_i present
      constructor
      · intro h; exact .tail _ (ih.mp h)
      · intro h; cases h with
        | head => exact present
        | tail _ ht => exact ih.mpr ht
    · constructor
      · intro h; cases h with
        | head => exact .head _
        | tail _ ht => exact .tail _ (ih.mp ht)
      · intro h; cases h with
        | head => exact .head _
        | tail _ ht => exact .tail _ (ih.mpr ht)

def distinct {Trace : Type} : List Trace → Prop
  | [] => True
  | a::rest => a ∉ rest ∧ distinct rest

theorem uniqueDistinct {Trace : Type} [DecidableEq Trace] (ts : List Trace) : distinct (unique ts) := by
  induction ts with
  | nil => exact True.intro
  | cons a rest ih =>
    unfold unique
    split
    · exact ih
    · rename_i absent; exact ⟨absent,ih⟩

def spectrum {Trace : Type} [DecidableEq Trace] (rows : List (Description Trace)) :=
  unique ((elementary rows).map classKey)

theorem spectrumExactly {Trace : Type} [DecidableEq Trace] (rows : List (Description Trace)) (trace : Trace) :
    trace ∈ spectrum rows ↔ ∃ d ∈ rows, minimal d = true ∧ classKey d = trace := by
  constructor
  · intro h
    obtain ⟨d,held,equal⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage classKey trace _
      ((uniqueMembership _ trace).mp h)
    have z := (elementaryExactly rows d).mp held
    exact ⟨d,z.1,z.2,equal⟩
  · intro h; obtain ⟨d,held,small,equal⟩ := h
    apply (uniqueMembership _ trace).mpr
    rw [← equal]
    exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ ((elementaryExactly rows d).mpr ⟨held,small⟩)

theorem spectrumNonEquivalent {Trace : Type} [DecidableEq Trace] (rows : List (Description Trace)) :
    distinct (spectrum rows) := uniqueDistinct _

theorem recurrentSourceRetained {Trace : Type} (d : Description Trace) :
    SFT.QuantumComputation.ReversibleModel.phaseAction d.constituent.word.state d.returnTrace =
      .ok d.constituent.word.state := QuantumPhysicalSpin.fullOrientationRecurrenceReturns _ _ d.fullPeriod
end SFT.Physics.MatterSpectrum
