import SFT.Materials.CrystalTranslationBasis
namespace SFT.Materials.CrystalTranslationInteger
open Lattice CrystalTranslationOrientation
-- Typed meaning of the source's admitted integer-translation basis.
-- These fields describe that input domain; they add no executable V3 guard.
structure IntegerBasis (carrier : Record) extends CrystalTranslationBasis.Basis carrier where
 inverse : Record → String → String
 inverseHeld : ∀ d, d ∈ directions → ∀ x, x ∈ carrier.cells.graph.nodes →
   inverse d x ∈ carrier.cells.graph.nodes
 forwardInverse : ∀ d, d ∈ directions → ∀ x, x ∈ carrier.cells.graph.nodes →
   d.shift (inverse d x) = x
 inverseForward : ∀ d, d ∈ directions → ∀ x, x ∈ carrier.cells.graph.nodes →
   inverse d (d.shift x) = x
 commute : ∀ d e, d ∈ directions → e ∈ directions → ∀ x,
   x ∈ carrier.cells.graph.nodes → d.shift (e.shift x) = e.shift (d.shift x)

variable {carrier : Record}
inductive Orientation where | forward | opposed
structure Instruction (basis : IntegerBasis carrier) where
 direction : Record
 held : direction ∈ basis.directions
 orientation : Orientation
 count : Nat

def move (basis : IntegerBasis carrier) (i : Instruction basis) (x : String) : String :=
 match i.orientation with
 | .forward => i.direction.shift x
 | .opposed => basis.inverse i.direction x

theorem moveHeld (basis : IntegerBasis carrier) (i : Instruction basis) (x : String)
 (hx : x ∈ carrier.cells.graph.nodes) : move basis i x ∈ carrier.cells.graph.nodes := by
 cases hi : i.orientation with
 | forward =>
   have h := i.direction.supported x
   rw [basis.sameGraph i.direction i.held] at h
   simpa only [move,hi] using h hx
 | opposed => simpa only [move,hi] using basis.inverseHeld i.direction i.held x hx

theorem moveTrace (basis : IntegerBasis carrier) (i : Instruction basis) (a b : String)
 (ha : a ∈ carrier.cells.graph.nodes) (hb : b ∈ carrier.cells.graph.nodes) :
 CrystalTranslationBasis.Trace basis.toBasis (a,b) (move basis i a,move basis i b) := by
 have ga : a ∈ i.direction.cells.graph.nodes := by rw [basis.sameGraph _ i.held]; exact ha
 have gb : b ∈ i.direction.cells.graph.nodes := by rw [basis.sameGraph _ i.held]; exact hb
 cases hi : i.orientation with
 | forward =>
   exact .append (.initial _) (.generated i.direction i.held (by
     simpa only [move,hi] using CrystalTranslationOrientation.Step.forward a b ga gb))
 | opposed =>
   have ia := basis.inverseHeld i.direction i.held a ha
   have ib := basis.inverseHeld i.direction i.held b hb
   rw [← basis.sameGraph i.direction i.held] at ia ib
   have h := CrystalTranslationOrientation.Step.opposed
     (basis.inverse i.direction a) (basis.inverse i.direction b) ia ib
   rw [basis.forwardInverse i.direction i.held a ha,
       basis.forwardInverse i.direction i.held b hb] at h
   exact .append (.initial _) (.generated i.direction i.held (by simpa only [move,hi] using h))

def iterate (basis : IntegerBasis carrier) (i : Instruction basis) : Nat → String → String
 | 0,x => x
 | n+1,x => move basis i (iterate basis i n x)

theorem repeatHeld (basis : IntegerBasis carrier) (i : Instruction basis) (n : Nat)
 (x : String) (hx : x ∈ carrier.cells.graph.nodes) :
 iterate basis i n x ∈ carrier.cells.graph.nodes := by
 induction n with
 | zero => exact hx
 | succ n ih => exact moveHeld basis i _ ih

theorem repeatTrace (basis : IntegerBasis carrier) (i : Instruction basis) (n : Nat)
 (a b : String) (ha : a ∈ carrier.cells.graph.nodes) (hb : b ∈ carrier.cells.graph.nodes) :
 CrystalTranslationBasis.Trace basis.toBasis (a,b) (iterate basis i n a,iterate basis i n b) := by
 induction n with
 | zero => exact .initial _
 | succ n ih => exact CrystalTranslationBasis.compose ih (moveTrace basis i _ _ (repeatHeld basis i n a ha) (repeatHeld basis i n b hb))

def run (basis : IntegerBasis carrier) : List (Instruction basis) → String → String
 | [],x => x
 | i::rest,x => run basis rest (iterate basis i i.count x)

theorem runTrace (basis : IntegerBasis carrier) (instructions : List (Instruction basis))
 (a b : String) (ha : a ∈ carrier.cells.graph.nodes) (hb : b ∈ carrier.cells.graph.nodes) :
 CrystalTranslationBasis.Trace basis.toBasis (a,b) (run basis instructions a,run basis instructions b) := by
 induction instructions generalizing a b with
 | nil => exact .initial _
 | cons i rest ih => exact CrystalTranslationBasis.compose (repeatTrace basis i i.count a b ha hb) (ih _ _ (repeatHeld basis i i.count a ha) (repeatHeld basis i i.count b hb))

theorem integerTranslationInvariant (basis : IntegerBasis carrier)
 (instructions : List (Instruction basis)) (a b : String)
 (ha : a ∈ carrier.cells.graph.nodes) (hb : b ∈ carrier.cells.graph.nodes) :
 Invariant carrier (a,b) (run basis instructions a,run basis instructions b) :=
 CrystalTranslationBasis.allGeneratedTraversals (runTrace basis instructions a b ha hb)

theorem threeGeneratedDirections (basis : IntegerBasis carrier) : basis.directions.length = 3 :=
 CrystalTranslationBasis.directionCount basis.toBasis
end SFT.Materials.CrystalTranslationInteger
