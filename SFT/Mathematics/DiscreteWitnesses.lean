import SFT.Mathematics.DiscreteSuccession
namespace SFT.Mathematics.DiscreteWitnesses
open DiscreteObjects SFT.Foundation.FormConstruction

def a : DiscreteObjects.Form := ["a"]
def b : DiscreteObjects.Form := ["b"]
def c : DiscreteObjects.Form := ["c"]
def collection : Collection := [a,b,c]
def mapping : Relation := [(a,b),(b,c),(c,a)]

theorem sourceCollection : generatedCollection [a,b,c] = .ok collection := rfl

def collectionResultEqual (result : Except String Collection) (expected : Collection) : Bool :=
  match result with
  | .error _ => false
  | .ok value => decide (value = expected)

def selectionResultEqual (result : Except String TupleValue) (expected : TupleValue) : Bool :=
  match result with
  | .error _ => false
  | .ok value => SFT.Foundation.FormEquivalenceRaw.valueEqual value expected

def relationResultEqual (result : Except String Relation) (expected : Relation) : Bool :=
  match result with
  | .error _ => false
  | .ok value => decide (value = expected)

structure Witness where
  name : String
  statement : String
  passed : Bool

def uniqueCollection : Witness where
  name := "unique-collection"
  statement := "A generated collection retains each canonical member once."
  passed := decide (collection = [a,b,c]) && distinct collection

def heldMembership : Witness where
  name := "held-membership"
  statement := "A held selection contains only members of its registered source."
  passed := selectionResultEqual (heldSelection collection [a,c]) (collectionValue [a,c])

def emptyOneSelection : Witness where
  name := "empty-One-selection"
  statement := "A held-empty selection returns the empty One form, not numerical zero."
  passed := selectionResultEqual (heldSelection collection []) (formValue emptyOne)

def relationBoundary : Witness where
  name := "relation-boundary"
  statement := "Every retained relation pair belongs to the complete generated pair-cell support."
  passed := relationResultEqual (generatedRelation collection collection mapping) mapping

def totalMap : Witness where
  name := "total-map"
  statement := "The example relation gives every source form exactly one image."
  passed := isTotalSingleValued collection mapping

def freshSuccessor : Witness where
  name := "fresh-successor"
  statement := "A successor appends exactly one fresh canonical form."
  passed := collectionResultEqual (successorTrace [a,b] c) collection

theorem uniqueCollectionPassed : uniqueCollection.passed = true := rfl
theorem heldMembershipPassed : heldMembership.passed = true := rfl
theorem emptyOneSelectionPassed : emptyOneSelection.passed = true := rfl
theorem relationBoundaryPassed : relationBoundary.passed = true := rfl
theorem totalMapPassed : totalMap.passed = true := rfl
theorem freshSuccessorPassed : freshSuccessor.passed = true := rfl

def witnesses : List Witness := [uniqueCollection,heldMembership,emptyOneSelection,relationBoundary,totalMap,freshSuccessor]
theorem allWitnessesPass : witnesses.all (fun w => w.passed) = true := rfl

end SFT.Mathematics.DiscreteWitnesses
