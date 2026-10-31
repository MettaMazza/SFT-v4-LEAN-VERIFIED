import SFT.Physics.MatterExchange
namespace SFT.Physics.MatterConservedLabels

inductive Destination (Carrier : Type) where
  | output : Carrier → Destination Carrier
  | boundary : String → Carrier → Destination Carrier

structure Flow (Label Carrier : Type) where
  label : Label
  input : Carrier
  destination : Destination Carrier

def inputs {Label Carrier : Type} (rows : List (Flow Label Carrier)) :=
  rows.map (fun r => (r.label,r.input))

def destinations {Label Carrier : Type} (rows : List (Flow Label Carrier)) :=
  rows.map (fun r => (r.label,r.destination))

def inputCount {Label Carrier : Type} (test : Label → Bool) : List (Flow Label Carrier) → Nat
  | [] => 0
  | row::rest => if test row.label then inputCount test rest + 1 else inputCount test rest

def outputCount {Label Carrier : Type} (test : Label → Bool) : List (Flow Label Carrier) → Nat
  | [] => 0
  | row::rest => match row.destination with
    | .output _ => if test row.label then outputCount test rest + 1 else outputCount test rest
    | .boundary _ _ => outputCount test rest

def boundaryCount {Label Carrier : Type} (test : Label → Bool) : List (Flow Label Carrier) → Nat
  | [] => 0
  | row::rest => match row.destination with
    | .output _ => boundaryCount test rest
    | .boundary _ _ => if test row.label then boundaryCount test rest + 1 else boundaryCount test rest

theorem exactCompleteLabelContinuity {Label Carrier : Type} (test : Label → Bool)
    (rows : List (Flow Label Carrier)) : inputCount test rows = outputCount test rows + boundaryCount test rows := by
  induction rows with
  | nil => rfl
  | cons row rest ih =>
    cases row with
    | mk label input destination =>
      cases destination with
      | output carrier =>
        change (if test label then inputCount test rest + 1 else inputCount test rest) =
          (if test label then outputCount test rest + 1 else outputCount test rest) + boundaryCount test rest
        cases h : test label with
        | false => exact ih
        | true =>
          change inputCount test rest + 1 = (outputCount test rest + 1) + boundaryCount test rest
          rw [ih]
          exact Nat.add_right_comm _ _ _
      | boundary name carrier =>
        change (if test label then inputCount test rest + 1 else inputCount test rest) =
          outputCount test rest + (if test label then boundaryCount test rest + 1 else boundaryCount test rest)
        cases h : test label with
        | false => exact ih
        | true =>
          change inputCount test rest + 1 = outputCount test rest + (boundaryCount test rest + 1)
          rw [ih]
          exact Nat.add_assoc _ _ _

theorem fullLabelSequenceRetained {Label Carrier : Type} (rows : List (Flow Label Carrier)) :
    (inputs rows).map Prod.fst = (destinations rows).map Prod.fst := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.label) ih

theorem everyTargetHasItsOriginalInput {Label Carrier : Type} (rows : List (Flow Label Carrier))
    (label : Label) (destination : Destination Carrier) (held : (label,destination) ∈ destinations rows) :
    ∃ row ∈ rows, row.label = label ∧ row.destination = destination ∧ (row.label,row.input) ∈ inputs rows := by
  obtain ⟨row,member,equal⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage
    (fun r : Flow Label Carrier => (r.label,r.destination)) (label,destination) rows held
  have parts := Prod.mk.inj equal
  exact ⟨row,member,parts.1,parts.2,SFT.Foundation.Count.TraceDerivation.memMap _ _ _ member⟩

theorem everyOriginalInputHasItsTarget {Label Carrier : Type} (rows : List (Flow Label Carrier))
    (row : Flow Label Carrier) (held : row ∈ rows) : (row.label,row.destination) ∈ destinations rows :=
  SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held
end SFT.Physics.MatterConservedLabels
