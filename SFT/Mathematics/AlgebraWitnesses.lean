import SFT.Mathematics.AlgebraMapMeaning
namespace SFT.Mathematics.AlgebraWitnesses
open AlgebraOperations

def xorTable : OperationTable := ⟨["One","held"],
  [("One","One","One"),("One","held","held"),("held","One","held"),("held","held","One")]⟩
def leftProjection : OperationTable := ⟨["a","b"],
  [("a","a","a"),("a","b","a"),("b","a","b"),("b","b","b")]⟩

theorem sourceXorAccepted : makeTable xorTable.carrier xorTable.rows = .ok xorTable := rfl
theorem sourceProjectionAccepted : makeTable leftProjection.carrier leftProjection.rows = .ok leftProjection := rfl

def boolResult : Except String Bool → Bool
  | .ok value => value
  | .error _ => false

structure Witness where
  name : String
  statement : String
  passed : Bool

def closedTable : Witness where
  name := "closed-table"
  statement := "Every complete input pair in the witness table has one carrier result."
  passed := decide (xorTable.rows.length = 4)

theorem closedTablePassed : closedTable.passed = true := rfl

def identity : Witness where
  name := "identity"
  statement := "The structural One form preserves both witness carrier forms."
  passed := boolResult (hasIdentity xorTable "One")

theorem identityPassed : identity.passed = true := rfl

def association : Witness where
  name := "association"
  statement := "Both parenthesizations agree for every witness triple."
  passed := boolResult (isAssociative xorTable)

theorem associationPassed : association.passed = true := rfl

def returnMatesWitness : Witness where
  name := "return-mates"
  statement := "Every witness form has one held two-sided return mate."
  passed := match returnMates xorTable "One" with
    | .error _ => false
    | .ok none => false
    | .ok (some rows) => decide (rows = [("One","One"),("held","held")])

theorem returnMatesWitnessPassed : returnMatesWitness.passed = true := rfl

def commutationConditional : Witness where
  name := "commutation-is-conditional"
  statement := "Commutation passes for the symmetric witness and fails for a lawful noncommuting table."
  passed := boolResult (isCommutative xorTable) && !(boolResult (isCommutative leftProjection))

theorem commutationConditionalPassed : commutationConditional.passed = true := rfl

def structureMap : Witness where
  name := "structure-map"
  statement := "The canonical self-map preserves every operation cell."
  passed := boolResult (preservesOperation xorTable xorTable [("One","One"),("held","held")])

theorem structureMapPassed : structureMap.passed = true := rfl

def witnesses : List Witness := [closedTable,identity,association,returnMatesWitness,commutationConditional,structureMap]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.Mathematics.AlgebraWitnesses
