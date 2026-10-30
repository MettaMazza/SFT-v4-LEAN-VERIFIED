import SFT.Computation.Convergence
open SFT.Computation.Convergence SFT.Computation.ExactApproximate
set_option maxRecDepth 1000000
def ledgerView (r : Report) : List (String × Nat × Nat × String) := r.errorLedger.map fun row => (row.1,row.2.1.numerator,row.2.1.denominator,row.2.2)
def pairView (x : Report × Report) := (ledgerView x.1,ledgerView x.2)
def stepView (x : Option (Report × Report)) := x.map pairView
def traceView (x : Option (Report × List (Report × Report))) := x.map fun p => (ledgerView p.1,p.2.map pairView)
def fullRelation : List (String × String) := [("n0","n0"),("n0","n1"),("n0","n2"),("n0","n3"),("n0","n4"),("n0","n5"),("n0","n6"),("n0","n7"),("n0","n8"),("n0","n9"),("n0","n10"),("n1","n0"),("n1","n1"),("n1","n2"),("n1","n3"),("n1","n4"),("n1","n5"),("n1","n6"),("n1","n7"),("n1","n8"),("n1","n9"),("n1","n10"),("n2","n0"),("n2","n1"),("n2","n2"),("n2","n3"),("n2","n4"),("n2","n5"),("n2","n6"),("n2","n7"),("n2","n8"),("n2","n9"),("n2","n10"),("n3","n0"),("n3","n1"),("n3","n2"),("n3","n3"),("n3","n4"),("n3","n5"),("n3","n6"),("n3","n7"),("n3","n8"),("n3","n9"),("n3","n10"),("n4","n0"),("n4","n1"),("n4","n2"),("n4","n3"),("n4","n4"),("n4","n5"),("n4","n6"),("n4","n7"),("n4","n8"),("n4","n9"),("n4","n10"),("n5","n0"),("n5","n1"),("n5","n2"),("n5","n3"),("n5","n4"),("n5","n5"),("n5","n6"),("n5","n7"),("n5","n8"),("n5","n9"),("n5","n10"),("n6","n0"),("n6","n1"),("n6","n2"),("n6","n3"),("n6","n4"),("n6","n5"),("n6","n6"),("n6","n7"),("n6","n8"),("n6","n9"),("n6","n10"),("n7","n0"),("n7","n1"),("n7","n2"),("n7","n3"),("n7","n4"),("n7","n5"),("n7","n6"),("n7","n7"),("n7","n8"),("n7","n9"),("n7","n10"),("n8","n0"),("n8","n1"),("n8","n2"),("n8","n3"),("n8","n4"),("n8","n5"),("n8","n6"),("n8","n7"),("n8","n8"),("n8","n9"),("n8","n10"),("n9","n0"),("n9","n1"),("n9","n2"),("n9","n3"),("n9","n4"),("n9","n5"),("n9","n6"),("n9","n7"),("n9","n8"),("n9","n9"),("n9","n10"),("n10","n0"),("n10","n1"),("n10","n2"),("n10","n3"),("n10","n4"),("n10","n5"),("n10","n6"),("n10","n7"),("n10","n8"),("n10","n9"),("n10","n10")]
def baseModel : Model := ⟨[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide)))],[("n0",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide)))]),("n1",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 3 (by decide) (by decide)))]),("n2",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 2 3 (by decide) (by decide)))]),("n3",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 3 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide)))]),("n4",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 3 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 3 (by decide) (by decide)))]),("n5",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 3 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 2 3 (by decide) (by decide)))]),("n6",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 2 3 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide)))]),("n7",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 2 3 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 3 (by decide) (by decide)))]),("n8",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 2 3 (by decide) (by decide))),(.positive (SFT.Foundation.ExactOperations.normalizePositive 2 3 (by decide) (by decide)))]),("n9",[]),("n10",[(.zero),(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide)))])],fullRelation,fullRelation,["n0","n8"]⟩
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n0") = some ([("cell-1",1,1,"equal"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n0" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n0" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n0" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n0" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n0") = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n1") = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n2") = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n1" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n1" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n1" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n1" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n0") = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n1") = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n2") = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n2" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n2" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n2" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n2" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n0") = some ([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n3") = some ([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n6") = some ([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n3" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n3" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n3" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n3" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n0") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n1") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n2") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n3") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n4") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n5") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n6") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n7") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n8") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n4" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n4" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n4" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n4" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n0") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n1") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n2") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n3") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n4") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n5") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n6") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n7") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n8") = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n5" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n5" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n5" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n5" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n0") = some ([("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n3") = some ([("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n6") = some ([("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n6" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n6" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n6" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n6" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n0") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n1") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n2") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n3") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n4") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n5") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n6") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n7") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n8") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n7" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n7" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n7" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n7" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n0") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n1") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n2") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n3") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n4") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n5") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n6") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,1,"equal")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n7") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-below")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n8") = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]) := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n8" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n8" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n8" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n8" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n9" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n9" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n9" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n9" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n0") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n0") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n1") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n1") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n2") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n2") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n3") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n3") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n4") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n4") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n5") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n5") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n6") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n6") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n7") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n7") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n8") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n8") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n9") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n9") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := [] } "n10" "n10") = none := rfl
example : stepView (step { baseModel with refinements := [], comparisons := fullRelation } "n10" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := [] } "n10" "n10") = none := rfl
example : stepView (step { baseModel with refinements := fullRelation, comparisons := fullRelation } "n10" "n10") = none := rfl
example : traceView (run baseModel "n0" ["n0","n0"]) = some ([("cell-1",1,1,"equal"),("cell-2",1,1,"equal")],[([("cell-1",1,1,"equal"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]),([("cell-1",1,1,"equal"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n0" ["n0","n1"]) = none := rfl
example : traceView (run baseModel "n0" ["n0","n3"]) = none := rfl
example : traceView (run baseModel "n0" ["n0","n4"]) = none := rfl
example : traceView (run baseModel "n0" ["n0","n8"]) = none := rfl
example : traceView (run baseModel "n0" ["n0","n9"]) = none := rfl
example : traceView (run baseModel "n0" ["n1","n0"]) = none := rfl
example : traceView (run baseModel "n0" ["n1","n1"]) = none := rfl
example : traceView (run baseModel "n0" ["n1","n3"]) = none := rfl
example : traceView (run baseModel "n0" ["n1","n4"]) = none := rfl
example : traceView (run baseModel "n0" ["n1","n8"]) = none := rfl
example : traceView (run baseModel "n0" ["n1","n9"]) = none := rfl
example : traceView (run baseModel "n0" ["n3","n0"]) = none := rfl
example : traceView (run baseModel "n0" ["n3","n1"]) = none := rfl
example : traceView (run baseModel "n0" ["n3","n3"]) = none := rfl
example : traceView (run baseModel "n0" ["n3","n4"]) = none := rfl
example : traceView (run baseModel "n0" ["n3","n8"]) = none := rfl
example : traceView (run baseModel "n0" ["n3","n9"]) = none := rfl
example : traceView (run baseModel "n0" ["n4","n0"]) = none := rfl
example : traceView (run baseModel "n0" ["n4","n1"]) = none := rfl
example : traceView (run baseModel "n0" ["n4","n3"]) = none := rfl
example : traceView (run baseModel "n0" ["n4","n4"]) = none := rfl
example : traceView (run baseModel "n0" ["n4","n8"]) = none := rfl
example : traceView (run baseModel "n0" ["n4","n9"]) = none := rfl
example : traceView (run baseModel "n0" ["n8","n0"]) = none := rfl
example : traceView (run baseModel "n0" ["n8","n1"]) = none := rfl
example : traceView (run baseModel "n0" ["n8","n3"]) = none := rfl
example : traceView (run baseModel "n0" ["n8","n4"]) = none := rfl
example : traceView (run baseModel "n0" ["n8","n8"]) = none := rfl
example : traceView (run baseModel "n0" ["n8","n9"]) = none := rfl
example : traceView (run baseModel "n0" ["n9","n0"]) = none := rfl
example : traceView (run baseModel "n0" ["n9","n1"]) = none := rfl
example : traceView (run baseModel "n0" ["n9","n3"]) = none := rfl
example : traceView (run baseModel "n0" ["n9","n4"]) = none := rfl
example : traceView (run baseModel "n0" ["n9","n8"]) = none := rfl
example : traceView (run baseModel "n0" ["n9","n9"]) = none := rfl
example : traceView (run baseModel "n1" ["n0","n0"]) = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]),([("cell-1",1,1,"equal"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n1" ["n0","n1"]) = none := rfl
example : traceView (run baseModel "n1" ["n0","n3"]) = none := rfl
example : traceView (run baseModel "n1" ["n0","n4"]) = none := rfl
example : traceView (run baseModel "n1" ["n0","n8"]) = none := rfl
example : traceView (run baseModel "n1" ["n0","n9"]) = none := rfl
example : traceView (run baseModel "n1" ["n1","n0"]) = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]),([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n1" ["n1","n1"]) = some ([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]),([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n1" ["n1","n3"]) = none := rfl
example : traceView (run baseModel "n1" ["n1","n4"]) = none := rfl
example : traceView (run baseModel "n1" ["n1","n8"]) = none := rfl
example : traceView (run baseModel "n1" ["n1","n9"]) = none := rfl
example : traceView (run baseModel "n1" ["n3","n0"]) = none := rfl
example : traceView (run baseModel "n1" ["n3","n1"]) = none := rfl
example : traceView (run baseModel "n1" ["n3","n3"]) = none := rfl
example : traceView (run baseModel "n1" ["n3","n4"]) = none := rfl
example : traceView (run baseModel "n1" ["n3","n8"]) = none := rfl
example : traceView (run baseModel "n1" ["n3","n9"]) = none := rfl
example : traceView (run baseModel "n1" ["n4","n0"]) = none := rfl
example : traceView (run baseModel "n1" ["n4","n1"]) = none := rfl
example : traceView (run baseModel "n1" ["n4","n3"]) = none := rfl
example : traceView (run baseModel "n1" ["n4","n4"]) = none := rfl
example : traceView (run baseModel "n1" ["n4","n8"]) = none := rfl
example : traceView (run baseModel "n1" ["n4","n9"]) = none := rfl
example : traceView (run baseModel "n1" ["n8","n0"]) = none := rfl
example : traceView (run baseModel "n1" ["n8","n1"]) = none := rfl
example : traceView (run baseModel "n1" ["n8","n3"]) = none := rfl
example : traceView (run baseModel "n1" ["n8","n4"]) = none := rfl
example : traceView (run baseModel "n1" ["n8","n8"]) = none := rfl
example : traceView (run baseModel "n1" ["n8","n9"]) = none := rfl
example : traceView (run baseModel "n1" ["n9","n0"]) = none := rfl
example : traceView (run baseModel "n1" ["n9","n1"]) = none := rfl
example : traceView (run baseModel "n1" ["n9","n3"]) = none := rfl
example : traceView (run baseModel "n1" ["n9","n4"]) = none := rfl
example : traceView (run baseModel "n1" ["n9","n8"]) = none := rfl
example : traceView (run baseModel "n1" ["n9","n9"]) = none := rfl
example : traceView (run baseModel "n3" ["n0","n0"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]),([("cell-1",1,1,"equal"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n3" ["n0","n1"]) = none := rfl
example : traceView (run baseModel "n3" ["n0","n3"]) = none := rfl
example : traceView (run baseModel "n3" ["n0","n4"]) = none := rfl
example : traceView (run baseModel "n3" ["n0","n8"]) = none := rfl
example : traceView (run baseModel "n3" ["n0","n9"]) = none := rfl
example : traceView (run baseModel "n3" ["n1","n0"]) = none := rfl
example : traceView (run baseModel "n3" ["n1","n1"]) = none := rfl
example : traceView (run baseModel "n3" ["n1","n3"]) = none := rfl
example : traceView (run baseModel "n3" ["n1","n4"]) = none := rfl
example : traceView (run baseModel "n3" ["n1","n8"]) = none := rfl
example : traceView (run baseModel "n3" ["n1","n9"]) = none := rfl
example : traceView (run baseModel "n3" ["n3","n0"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]),([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n3" ["n3","n1"]) = none := rfl
example : traceView (run baseModel "n3" ["n3","n3"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]),([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n3" ["n3","n4"]) = none := rfl
example : traceView (run baseModel "n3" ["n3","n8"]) = none := rfl
example : traceView (run baseModel "n3" ["n3","n9"]) = none := rfl
example : traceView (run baseModel "n3" ["n4","n0"]) = none := rfl
example : traceView (run baseModel "n3" ["n4","n1"]) = none := rfl
example : traceView (run baseModel "n3" ["n4","n3"]) = none := rfl
example : traceView (run baseModel "n3" ["n4","n4"]) = none := rfl
example : traceView (run baseModel "n3" ["n4","n8"]) = none := rfl
example : traceView (run baseModel "n3" ["n4","n9"]) = none := rfl
example : traceView (run baseModel "n3" ["n8","n0"]) = none := rfl
example : traceView (run baseModel "n3" ["n8","n1"]) = none := rfl
example : traceView (run baseModel "n3" ["n8","n3"]) = none := rfl
example : traceView (run baseModel "n3" ["n8","n4"]) = none := rfl
example : traceView (run baseModel "n3" ["n8","n8"]) = none := rfl
example : traceView (run baseModel "n3" ["n8","n9"]) = none := rfl
example : traceView (run baseModel "n3" ["n9","n0"]) = none := rfl
example : traceView (run baseModel "n3" ["n9","n1"]) = none := rfl
example : traceView (run baseModel "n3" ["n9","n3"]) = none := rfl
example : traceView (run baseModel "n3" ["n9","n4"]) = none := rfl
example : traceView (run baseModel "n3" ["n9","n8"]) = none := rfl
example : traceView (run baseModel "n3" ["n9","n9"]) = none := rfl
example : traceView (run baseModel "n4" ["n0","n0"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]),([("cell-1",1,1,"equal"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n4" ["n0","n1"]) = none := rfl
example : traceView (run baseModel "n4" ["n0","n3"]) = none := rfl
example : traceView (run baseModel "n4" ["n0","n4"]) = none := rfl
example : traceView (run baseModel "n4" ["n0","n8"]) = none := rfl
example : traceView (run baseModel "n4" ["n0","n9"]) = none := rfl
example : traceView (run baseModel "n4" ["n1","n0"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]),([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n4" ["n1","n1"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]),([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n4" ["n1","n3"]) = none := rfl
example : traceView (run baseModel "n4" ["n1","n4"]) = none := rfl
example : traceView (run baseModel "n4" ["n1","n8"]) = none := rfl
example : traceView (run baseModel "n4" ["n1","n9"]) = none := rfl
example : traceView (run baseModel "n4" ["n3","n0"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]),([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n4" ["n3","n1"]) = none := rfl
example : traceView (run baseModel "n4" ["n3","n3"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]),([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n4" ["n3","n4"]) = none := rfl
example : traceView (run baseModel "n4" ["n3","n8"]) = none := rfl
example : traceView (run baseModel "n4" ["n3","n9"]) = none := rfl
example : traceView (run baseModel "n4" ["n4","n0"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n4" ["n4","n1"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n4" ["n4","n3"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n4" ["n4","n4"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n4" ["n4","n8"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")])]) := rfl
example : traceView (run baseModel "n4" ["n4","n9"]) = none := rfl
example : traceView (run baseModel "n4" ["n8","n0"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n4" ["n8","n1"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n4" ["n8","n3"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n4" ["n8","n4"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n4" ["n8","n8"]) = some ([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")])]) := rfl
example : traceView (run baseModel "n4" ["n8","n9"]) = none := rfl
example : traceView (run baseModel "n4" ["n9","n0"]) = none := rfl
example : traceView (run baseModel "n4" ["n9","n1"]) = none := rfl
example : traceView (run baseModel "n4" ["n9","n3"]) = none := rfl
example : traceView (run baseModel "n4" ["n9","n4"]) = none := rfl
example : traceView (run baseModel "n4" ["n9","n8"]) = none := rfl
example : traceView (run baseModel "n4" ["n9","n9"]) = none := rfl
example : traceView (run baseModel "n8" ["n0","n0"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")]),([("cell-1",1,1,"equal"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n8" ["n0","n1"]) = none := rfl
example : traceView (run baseModel "n8" ["n0","n3"]) = none := rfl
example : traceView (run baseModel "n8" ["n0","n4"]) = none := rfl
example : traceView (run baseModel "n8" ["n0","n8"]) = none := rfl
example : traceView (run baseModel "n8" ["n0","n9"]) = none := rfl
example : traceView (run baseModel "n8" ["n1","n0"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]),([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n8" ["n1","n1"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")]),([("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n8" ["n1","n3"]) = none := rfl
example : traceView (run baseModel "n8" ["n1","n4"]) = none := rfl
example : traceView (run baseModel "n8" ["n1","n8"]) = none := rfl
example : traceView (run baseModel "n8" ["n1","n9"]) = none := rfl
example : traceView (run baseModel "n8" ["n3","n0"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]),([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n8" ["n3","n1"]) = none := rfl
example : traceView (run baseModel "n8" ["n3","n3"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")]),([("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n8" ["n3","n4"]) = none := rfl
example : traceView (run baseModel "n8" ["n3","n8"]) = none := rfl
example : traceView (run baseModel "n8" ["n3","n9"]) = none := rfl
example : traceView (run baseModel "n8" ["n4","n0"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n8" ["n4","n1"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n8" ["n4","n3"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n8" ["n4","n4"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n8" ["n4","n8"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")]),([("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")])]) := rfl
example : traceView (run baseModel "n8" ["n4","n9"]) = none := rfl
example : traceView (run baseModel "n8" ["n8","n0"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n8" ["n8","n1"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,1,"equal"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n8" ["n8","n3"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,1,"equal")])]) := rfl
example : traceView (run baseModel "n8" ["n8","n4"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-below"),("cell-2",1,6,"held-below")])]) := rfl
example : traceView (run baseModel "n8" ["n8","n8"]) = some ([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")]),([("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")],[("cell-1",1,6,"held-above"),("cell-2",1,6,"held-above")])]) := rfl
example : traceView (run baseModel "n8" ["n8","n9"]) = none := rfl
example : traceView (run baseModel "n8" ["n9","n0"]) = none := rfl
example : traceView (run baseModel "n8" ["n9","n1"]) = none := rfl
example : traceView (run baseModel "n8" ["n9","n3"]) = none := rfl
example : traceView (run baseModel "n8" ["n9","n4"]) = none := rfl
example : traceView (run baseModel "n8" ["n9","n8"]) = none := rfl
example : traceView (run baseModel "n8" ["n9","n9"]) = none := rfl
example : traceView (run baseModel "n9" ["n0","n0"]) = none := rfl
example : traceView (run baseModel "n9" ["n0","n1"]) = none := rfl
example : traceView (run baseModel "n9" ["n0","n3"]) = none := rfl
example : traceView (run baseModel "n9" ["n0","n4"]) = none := rfl
example : traceView (run baseModel "n9" ["n0","n8"]) = none := rfl
example : traceView (run baseModel "n9" ["n0","n9"]) = none := rfl
example : traceView (run baseModel "n9" ["n1","n0"]) = none := rfl
example : traceView (run baseModel "n9" ["n1","n1"]) = none := rfl
example : traceView (run baseModel "n9" ["n1","n3"]) = none := rfl
example : traceView (run baseModel "n9" ["n1","n4"]) = none := rfl
example : traceView (run baseModel "n9" ["n1","n8"]) = none := rfl
example : traceView (run baseModel "n9" ["n1","n9"]) = none := rfl
example : traceView (run baseModel "n9" ["n3","n0"]) = none := rfl
example : traceView (run baseModel "n9" ["n3","n1"]) = none := rfl
example : traceView (run baseModel "n9" ["n3","n3"]) = none := rfl
example : traceView (run baseModel "n9" ["n3","n4"]) = none := rfl
example : traceView (run baseModel "n9" ["n3","n8"]) = none := rfl
example : traceView (run baseModel "n9" ["n3","n9"]) = none := rfl
example : traceView (run baseModel "n9" ["n4","n0"]) = none := rfl
example : traceView (run baseModel "n9" ["n4","n1"]) = none := rfl
example : traceView (run baseModel "n9" ["n4","n3"]) = none := rfl
example : traceView (run baseModel "n9" ["n4","n4"]) = none := rfl
example : traceView (run baseModel "n9" ["n4","n8"]) = none := rfl
example : traceView (run baseModel "n9" ["n4","n9"]) = none := rfl
example : traceView (run baseModel "n9" ["n8","n0"]) = none := rfl
example : traceView (run baseModel "n9" ["n8","n1"]) = none := rfl
example : traceView (run baseModel "n9" ["n8","n3"]) = none := rfl
example : traceView (run baseModel "n9" ["n8","n4"]) = none := rfl
example : traceView (run baseModel "n9" ["n8","n8"]) = none := rfl
example : traceView (run baseModel "n9" ["n8","n9"]) = none := rfl
example : traceView (run baseModel "n9" ["n9","n0"]) = none := rfl
example : traceView (run baseModel "n9" ["n9","n1"]) = none := rfl
example : traceView (run baseModel "n9" ["n9","n3"]) = none := rfl
example : traceView (run baseModel "n9" ["n9","n4"]) = none := rfl
example : traceView (run baseModel "n9" ["n9","n8"]) = none := rfl
example : traceView (run baseModel "n9" ["n9","n9"]) = none := rfl
example : targetReached baseModel "n0" = true := rfl
example : targetReached baseModel "n1" = false := rfl
example : targetReached baseModel "n2" = false := rfl
example : targetReached baseModel "n3" = false := rfl
example : targetReached baseModel "n4" = false := rfl
example : targetReached baseModel "n5" = false := rfl
example : targetReached baseModel "n6" = false := rfl
example : targetReached baseModel "n7" = false := rfl
example : targetReached baseModel "n8" = true := rfl
example : targetReached baseModel "n9" = false := rfl
example : targetReached baseModel "n10" = false := rfl
example : targetReached baseModel "n11" = false := rfl
example : (step baseModel "n0" "n0").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n0" "n1").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n0" "n2").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n0" "n3").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n0" "n4").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n0" "n5").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n0" "n6").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n0" "n7").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n0" "n8").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n1" "n0").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n1" "n1").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n1" "n2").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n1" "n3").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n1" "n4").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n1" "n5").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n1" "n6").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n1" "n7").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n1" "n8").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n2" "n0").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n2" "n1").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n2" "n2").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n2" "n3").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n2" "n4").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n2" "n5").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n2" "n6").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n2" "n7").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n2" "n8").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n3" "n0").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n3" "n1").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n3" "n2").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n3" "n3").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n3" "n4").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n3" "n5").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n3" "n6").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n3" "n7").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n3" "n8").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n4" "n0").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n4" "n1").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n4" "n2").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n4" "n3").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n4" "n4").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n4" "n5").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n4" "n6").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n4" "n7").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n4" "n8").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n5" "n0").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n5" "n1").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n5" "n2").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n5" "n3").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n5" "n4").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n5" "n5").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n5" "n6").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n5" "n7").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n5" "n8").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n6" "n0").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n6" "n1").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n6" "n2").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n6" "n3").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n6" "n4").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n6" "n5").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n6" "n6").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n6" "n7").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n6" "n8").map (fun p => strictClassDescent p.1 p.2) = none := rfl
example : (step baseModel "n7" "n0").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n7" "n1").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n7" "n2").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n7" "n3").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n7" "n4").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n7" "n5").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n7" "n6").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n7" "n7").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n7" "n8").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n8" "n0").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n8" "n1").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n8" "n2").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n8" "n3").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n8" "n4").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n8" "n5").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n8" "n6").map (fun p => strictClassDescent p.1 p.2) = some true := rfl
example : (step baseModel "n8" "n7").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
example : (step baseModel "n8" "n8").map (fun p => strictClassDescent p.1 p.2) = some false := rfl
