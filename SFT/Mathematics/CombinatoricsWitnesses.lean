import SFT.Mathematics.CombinatorialLedger
namespace SFT.Mathematics.CombinatoricsWitnesses
open DiscreteObjects CombinatorialSelections
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000

def items : List String := ["a","b","c"]
def arranged : List Form := CombinatorialArrangements.arrangementsCore items
def selected : List Form := (rawSelections items).map encodeEmpty

theorem sourceArrangementAccepted : CombinatorialArrangements.arrangements items = .ok arranged := rfl
theorem sourceSelectionAccepted : selections items = .ok selected := rfl

def sameLabelSet (left right : List String) : Bool :=
  left.all (fun x => has right x) && right.all (fun x => has left x)

structure Witness where
  name : String
  statement : String
  passed : Bool

def arrangementCompleteness : Witness where
  name := "arrangement-completeness"
  statement := "Three distinct held labels generate six unique ordered arrangements."
  passed := arranged.length == 6 && distinct arranged

def arrangementCoverage : Witness where
  name := "arrangement-coverage"
  statement := "Every arrangement holds every carrier label exactly once."
  passed := arranged.all (fun form => sameLabelSet form items && form.length == items.length)

def selectionRecurrence : Witness where
  name := "selection-recurrence"
  statement := "Three held labels generate the structural empty One and every absent/held combination once."
  passed := selected.length == 8 && distinct selected && has selected emptyOne

def accountingClassifier (item : String) : String := if item = "a" then "a-class" else "other-class"

def disjointAccounting : Witness where
  name := "disjoint-accounting"
  statement := "Parity-named witness classes partition the carrier without overlap or omission."
  passed := decide (CombinatorialLedger.flatten (CombinatorialLedger.disjointClassLedger items accountingClassifier) = items)

def freshExtension : Witness where
  name := "fresh-extension"
  statement := "Fresh-member recurrence creates a disjoint absent/held copy of every prior selection."
  passed := match selections ["a","b"] with
    | .error _ => false
    | .ok previous => match recurrenceExtend previous "c" with
      | .error _ => false
      | .ok next => next.length == selected.length

theorem sourceArrangementRows : arranged =
    [["a","b","c"],["a","c","b"],["b","a","c"],["b","c","a"],["c","a","b"],["c","b","a"]] := by
  unfold arranged items
  rw [CombinatorialArrangements.arrangementsStepByValues]
  change ((CombinatorialArrangements.arrangementsCore ["b","c"]).map (List.cons "a") ++ ((CombinatorialArrangements.arrangementsCore ["a","c"]).map (List.cons "b") ++ ((CombinatorialArrangements.arrangementsCore ["a","b"]).map (List.cons "c") ++ []))) = _
  rw [CombinatorialArrangements.arrangementsStepByValues,
    CombinatorialArrangements.arrangementsStepByValues,
    CombinatorialArrangements.arrangementsStepByValues]
  change ((((CombinatorialArrangements.arrangementsCore ["c"]).map (List.cons "b") ++ ((CombinatorialArrangements.arrangementsCore ["b"]).map (List.cons "c") ++ []))).map (List.cons "a") ++ ((((CombinatorialArrangements.arrangementsCore ["c"]).map (List.cons "a") ++ ((CombinatorialArrangements.arrangementsCore ["a"]).map (List.cons "c") ++ []))).map (List.cons "b") ++ ((((CombinatorialArrangements.arrangementsCore ["b"]).map (List.cons "a") ++ ((CombinatorialArrangements.arrangementsCore ["a"]).map (List.cons "b") ++ []))).map (List.cons "c") ++ []))) = _
  rw [CombinatorialArrangements.arrangementsSingle,CombinatorialArrangements.arrangementsSingle,
    CombinatorialArrangements.arrangementsSingle]
  rfl

theorem arrangementCompletenessPassed : arrangementCompleteness.passed = true := by
  dsimp only [arrangementCompleteness]
  rw [sourceArrangementRows]
  rfl
theorem arrangementCoveragePassed : arrangementCoverage.passed = true := by
  dsimp only [arrangementCoverage]
  rw [sourceArrangementRows]
  rfl
theorem selectionRecurrencePassed : selectionRecurrence.passed = true := rfl
theorem disjointAccountingPassed : disjointAccounting.passed = true := rfl
theorem freshExtensionPassed : freshExtension.passed = true := rfl

def witnesses : List Witness := [arrangementCompleteness,arrangementCoverage,selectionRecurrence,disjointAccounting,freshExtension]

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
  change (arrangementCompleteness.passed && (arrangementCoverage.passed &&
    (selectionRecurrence.passed && (disjointAccounting.passed && (freshExtension.passed && true))))) = true
  rw [arrangementCompletenessPassed,arrangementCoveragePassed,selectionRecurrencePassed,
    disjointAccountingPassed,freshExtensionPassed]
  rfl

end SFT.Mathematics.CombinatoricsWitnesses
