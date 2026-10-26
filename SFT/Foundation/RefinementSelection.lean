import SFT.Foundation.PartEquivalence
/-! Source closure_record complete lifting and source-origin grouping.
Cells retain origin pairs before the source's printable label serialization. -/
namespace SFT.Foundation.RefinementSelection
open CommonRefinement Count.TraceDerivation

def liftedAOrigins (heldA allB : List String) : List (String × String) := originCells heldA allB

def liftedBOrigins (allA heldB : List String) : List (String × String) := originCells allA heldB

theorem completeALift (heldA allB : List String) (a b : String) :
    (a,b) ∈ liftedAOrigins heldA allB ↔ a ∈ heldA ∧ b ∈ allB :=
  originCellIffSources heldA allB a b

theorem completeBLift (allA heldB : List String) (a b : String) :
    (a,b) ∈ liftedBOrigins allA heldB ↔ a ∈ allA ∧ b ∈ heldB :=
  originCellIffSources allA heldB a b

theorem aLiftContained (heldA allA allB : List String)
    (contained : ∀ a, a ∈ heldA → a ∈ allA) (cell : String × String)
    (h : cell ∈ liftedAOrigins heldA allB) : cell ∈ originCells allA allB := by
  cases cell with
  | mk a b =>
    have origins := (completeALift heldA allB a b).mp h
    exact (originCellIffSources allA allB a b).mpr ⟨contained a origins.1,origins.2⟩

theorem bLiftContained (allA heldB allB : List String)
    (contained : ∀ b, b ∈ heldB → b ∈ allB) (cell : String × String)
    (h : cell ∈ liftedBOrigins allA heldB) : cell ∈ originCells allA allB := by
  cases cell with
  | mk a b =>
    have origins := (completeBLift allA heldB a b).mp h
    exact (originCellIffSources allA allB a b).mpr ⟨origins.1,contained b origins.2⟩

theorem selectedAHasEveryDescendant (heldA allB : List String) (a b : String)
    (ha : a ∈ heldA) (hb : b ∈ allB) : pairLabel a b ∈ liftedA heldA allB :=
  pairLabelGenerated heldA allB a b ha hb

theorem selectedBHasEveryOrigin (allA heldB : List String) (a b : String)
    (ha : a ∈ allA) (hb : b ∈ heldB) : pairLabel a b ∈ liftedB allA heldB :=
  pairLabelGenerated allA heldB a b ha hb

def liftedSelectionPairing (heldA allB allA heldB : List String)
    (h : hasGeneratedBijection (liftedA heldA allB) (liftedB allA heldB) = true) :
    ExactPairing (Fin (liftedA heldA allB).length) (Fin (liftedB allA heldB).length) :=
  acceptedIndexPairing _ _ h

theorem liftedPairingOneToOne (heldA allB allA heldB : List String)
    (h : hasGeneratedBijection (liftedA heldA allB) (liftedB allA heldB) = true)
    (i j : Fin (liftedA heldA allB).length)
    (eq : (liftedSelectionPairing heldA allB allA heldB h).forward i =
      (liftedSelectionPairing heldA allB allA heldB h).forward j) : i = j :=
  pairingInjective _ i j eq

theorem liftedPairingOnto (heldA allB allA heldB : List String)
    (h : hasGeneratedBijection (liftedA heldA allB) (liftedB allA heldB) = true)
    (j : Fin (liftedB allA heldB).length) :
    ∃ i, (liftedSelectionPairing heldA allB allA heldB h).forward i = j :=
  pairingOnto _ j

end SFT.Foundation.RefinementSelection
