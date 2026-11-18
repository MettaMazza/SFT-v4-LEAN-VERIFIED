import SFT.Medicine.StructuralCounts
import SFT.Host.Canonical
open SFT.Medicine.StructuralCounts SFT.Host.Canonical
def cellsValue (xs : List (String × String)) : Value := .array (xs.map fun (a,b) => .array [.text a,.text b])
def diagnosticValue : Value :=
 let d := diagnosticTableCertificate
 .object [("condition_labels",.array (d.conditionLabels.map .text)),("test_labels",.array (d.testLabels.map .text)),
 ("cells",cellsValue d.cells),("cell_count",.integer (Int.ofNat d.cellCount)),("complete",.boolean d.complete),("absence_semantics",.text d.absenceSemantics)]
def armValue : Value :=
 let d := twoArmOutcomeCertificate
 .object [("arms",.array (d.arms.map .text)),("outcomes",.array (d.outcomes.map .text)),
 ("cells",cellsValue d.cells),("cell_count",.integer (Int.ofNat d.cellCount)),("complete",.boolean d.complete),("absence_semantics",.text d.absenceSemantics)]
def shareValue (p : Int × Int) : Value := match exactShare p.1 p.2 with
 | .ok (a,b) => .array [.text "ok",.integer a,.integer b]
 | .error e => .array [.text "error",.text e]
def main : IO Unit := IO.println (render (.object [("diagnostic",diagnosticValue),("arms",armValue),
 ("shares",.array (([(-1,1),(0,1),(1,0),(2,1),(1,1),(1,2),(2,4),(100000000000000000000,100000000000000000001)] : List (Int × Int)).map shareValue))]))
