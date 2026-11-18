import SFT.Host.Text
namespace SFT.Medicine.StructuralCounts
-- V3 sft/medicine/structural_counts.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
def conditionLabels : List String := ["condition-held", "condition-absence-held"]
def testLabels : List String := ["test-held", "test-absence-held"]
def arms : List String := ["intervention", "comparator"]
def outcomes : List String := ["outcome-held", "outcome-absence-held"]
def orderedProduct (left right : List String) : List (String × String) :=
 left.flatMap fun a => right.map fun b => (a,b)
def distinctCells : List (String × String) → Bool
 | [] => true
 | x :: xs => !(xs.any fun y => SFT.Host.Text.equal x.1 y.1 && SFT.Host.Text.equal x.2 y.2) && distinctCells xs
structure DiagnosticCertificate where
 conditionLabels : List String
 testLabels : List String
 cells : List (String × String)
 cellCount : Nat
 complete : Bool
 absenceSemantics : String
structure TwoArmCertificate where
 arms : List String
 outcomes : List String
 cells : List (String × String)
 cellCount : Nat
 complete : Bool
 absenceSemantics : String
def diagnosticTableCertificate : DiagnosticCertificate :=
 let cells := orderedProduct conditionLabels testLabels
 ⟨conditionLabels,testLabels,cells,cells.length,cells.length == 4 && distinctCells cells,
 "held label; never numerical-zero ontology"⟩
def twoArmOutcomeCertificate : TwoArmCertificate :=
 let cells := orderedProduct arms outcomes
 ⟨arms,outcomes,cells,cells.length,cells.length == 4 && distinctCells cells,
 "held label; never numerical-zero ontology"⟩
def exactShare (part whole : Int) : Except String (Int × Int) :=
 if @decide (Int.lt part 1) (Int.decLt _ _) ||
    @decide (Int.lt whole 1) (Int.decLt _ _) ||
    @decide (Int.lt whole part) (Int.decLt _ _) then
  .error "SFT exact shares require positive finite counts with part no greater than whole"
 else .ok (part,whole)
theorem diagnosticCells : diagnosticTableCertificate.cells =
 [("condition-held","test-held"),("condition-held","test-absence-held"),
  ("condition-absence-held","test-held"),("condition-absence-held","test-absence-held")] := rfl
theorem diagnosticFourCells : diagnosticTableCertificate.cellCount = 4 := rfl
theorem diagnosticComplete : diagnosticTableCertificate.complete = true := rfl
theorem twoArmCells : twoArmOutcomeCertificate.cells =
 [("intervention","outcome-held"),("intervention","outcome-absence-held"),
  ("comparator","outcome-held"),("comparator","outcome-absence-held")] := rfl
theorem twoArmFourCells : twoArmOutcomeCertificate.cellCount = 4 := rfl
theorem twoArmComplete : twoArmOutcomeCertificate.complete = true := rfl
end SFT.Medicine.StructuralCounts
