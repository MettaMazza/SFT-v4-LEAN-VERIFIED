import SFT.Computation.Stability
set_option maxRecDepth 1000000
open SFT.Computation.Stability SFT.Computation.StateTransition
def system : System := ⟨["a","b","c"],["s"],[("a","s","b"),("b","s","c"),("c","s","c")]⟩
def view : Option Observation → Option (List String × List String × LedgerForm × LedgerForm) | none => none | some o => some (o.referenceTrace,o.changedTrace,ledgerForm o.inputLedger,ledgerForm o.outputLedger)
def table0 : List (String × List SFT.Computation.NumericalError.Number) := [("a",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide)))]),("b",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 3 (by decide) (by decide)))]),("c",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 2 3 (by decide) (by decide)))])]
def table1 : List (String × List SFT.Computation.NumericalError.Number) := [("a",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide)))]),("b",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 3 (by decide) (by decide)))])]
def table2 : List (String × List SFT.Computation.NumericalError.Number) := [("a",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 1 2 (by decide) (by decide)))]),("b",[(.zero)]),("c",[(.positive (SFT.Foundation.ExactOperations.normalizePositive 2 3 (by decide) (by decide)))])]
def request0 : Perturbation := ⟨"a","a",[],[]⟩
example : view (observe system table0 [] request0) = none := rfl
def request1 : Perturbation := ⟨"a","a",[],[]⟩
example : view (observe system table0 [request1] request1) = some (["a"],["a"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request2 : Perturbation := ⟨"a","a",[],["s"]⟩
example : view (observe system table0 [] request2) = none := rfl
def request3 : Perturbation := ⟨"a","a",[],["s"]⟩
example : view (observe system table0 [request3] request3) = some (["a"],["a","b"],[("cell-1",1,1,"equal")],[("cell-1",1,6,"held-below")]) := rfl
def request4 : Perturbation := ⟨"a","a",[],["s","s"]⟩
example : view (observe system table0 [] request4) = none := rfl
def request5 : Perturbation := ⟨"a","a",[],["s","s"]⟩
example : view (observe system table0 [request5] request5) = some (["a"],["a","b","c"],[("cell-1",1,1,"equal")],[("cell-1",1,6,"held-above")]) := rfl
def request6 : Perturbation := ⟨"a","a",[],["bad"]⟩
example : view (observe system table0 [] request6) = none := rfl
def request7 : Perturbation := ⟨"a","a",[],["bad"]⟩
example : view (observe system table0 [request7] request7) = none := rfl
def request8 : Perturbation := ⟨"a","a",["s"],[]⟩
example : view (observe system table0 [] request8) = none := rfl
def request9 : Perturbation := ⟨"a","a",["s"],[]⟩
example : view (observe system table0 [request9] request9) = some (["a","b"],["a"],[("cell-1",1,1,"equal")],[("cell-1",1,6,"held-above")]) := rfl
def request10 : Perturbation := ⟨"a","a",["s"],["s"]⟩
example : view (observe system table0 [] request10) = none := rfl
def request11 : Perturbation := ⟨"a","a",["s"],["s"]⟩
example : view (observe system table0 [request11] request11) = some (["a","b"],["a","b"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request12 : Perturbation := ⟨"a","a",["s"],["s","s"]⟩
example : view (observe system table0 [] request12) = none := rfl
def request13 : Perturbation := ⟨"a","a",["s"],["s","s"]⟩
example : view (observe system table0 [request13] request13) = some (["a","b"],["a","b","c"],[("cell-1",1,1,"equal")],[("cell-1",1,3,"held-above")]) := rfl
def request14 : Perturbation := ⟨"a","a",["s"],["bad"]⟩
example : view (observe system table0 [] request14) = none := rfl
def request15 : Perturbation := ⟨"a","a",["s"],["bad"]⟩
example : view (observe system table0 [request15] request15) = none := rfl
def request16 : Perturbation := ⟨"a","a",["s","s"],[]⟩
example : view (observe system table0 [] request16) = none := rfl
def request17 : Perturbation := ⟨"a","a",["s","s"],[]⟩
example : view (observe system table0 [request17] request17) = some (["a","b","c"],["a"],[("cell-1",1,1,"equal")],[("cell-1",1,6,"held-below")]) := rfl
def request18 : Perturbation := ⟨"a","a",["s","s"],["s"]⟩
example : view (observe system table0 [] request18) = none := rfl
def request19 : Perturbation := ⟨"a","a",["s","s"],["s"]⟩
example : view (observe system table0 [request19] request19) = some (["a","b","c"],["a","b"],[("cell-1",1,1,"equal")],[("cell-1",1,3,"held-below")]) := rfl
def request20 : Perturbation := ⟨"a","a",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request20) = none := rfl
def request21 : Perturbation := ⟨"a","a",["s","s"],["s","s"]⟩
example : view (observe system table0 [request21] request21) = some (["a","b","c"],["a","b","c"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request22 : Perturbation := ⟨"a","a",["s","s"],["bad"]⟩
example : view (observe system table0 [] request22) = none := rfl
def request23 : Perturbation := ⟨"a","a",["s","s"],["bad"]⟩
example : view (observe system table0 [request23] request23) = none := rfl
def request24 : Perturbation := ⟨"a","a",["bad"],[]⟩
example : view (observe system table0 [] request24) = none := rfl
def request25 : Perturbation := ⟨"a","a",["bad"],[]⟩
example : view (observe system table0 [request25] request25) = none := rfl
def request26 : Perturbation := ⟨"a","a",["bad"],["s"]⟩
example : view (observe system table0 [] request26) = none := rfl
def request27 : Perturbation := ⟨"a","a",["bad"],["s"]⟩
example : view (observe system table0 [request27] request27) = none := rfl
def request28 : Perturbation := ⟨"a","a",["bad"],["s","s"]⟩
example : view (observe system table0 [] request28) = none := rfl
def request29 : Perturbation := ⟨"a","a",["bad"],["s","s"]⟩
example : view (observe system table0 [request29] request29) = none := rfl
def request30 : Perturbation := ⟨"a","a",["bad"],["bad"]⟩
example : view (observe system table0 [] request30) = none := rfl
def request31 : Perturbation := ⟨"a","a",["bad"],["bad"]⟩
example : view (observe system table0 [request31] request31) = none := rfl
def request32 : Perturbation := ⟨"a","b",[],[]⟩
example : view (observe system table0 [] request32) = none := rfl
def request33 : Perturbation := ⟨"a","b",[],[]⟩
example : view (observe system table0 [request33] request33) = some (["a"],["b"],[("cell-1",1,6,"held-below")],[("cell-1",1,6,"held-below")]) := rfl
def request34 : Perturbation := ⟨"a","b",[],["s"]⟩
example : view (observe system table0 [] request34) = none := rfl
def request35 : Perturbation := ⟨"a","b",[],["s"]⟩
example : view (observe system table0 [request35] request35) = some (["a"],["b","c"],[("cell-1",1,6,"held-below")],[("cell-1",1,6,"held-above")]) := rfl
def request36 : Perturbation := ⟨"a","b",[],["s","s"]⟩
example : view (observe system table0 [] request36) = none := rfl
def request37 : Perturbation := ⟨"a","b",[],["s","s"]⟩
example : view (observe system table0 [request37] request37) = some (["a"],["b","c","c"],[("cell-1",1,6,"held-below")],[("cell-1",1,6,"held-above")]) := rfl
def request38 : Perturbation := ⟨"a","b",[],["bad"]⟩
example : view (observe system table0 [] request38) = none := rfl
def request39 : Perturbation := ⟨"a","b",[],["bad"]⟩
example : view (observe system table0 [request39] request39) = none := rfl
def request40 : Perturbation := ⟨"a","b",["s"],[]⟩
example : view (observe system table0 [] request40) = none := rfl
def request41 : Perturbation := ⟨"a","b",["s"],[]⟩
example : view (observe system table0 [request41] request41) = some (["a","b"],["b"],[("cell-1",1,6,"held-below")],[("cell-1",1,1,"equal")]) := rfl
def request42 : Perturbation := ⟨"a","b",["s"],["s"]⟩
example : view (observe system table0 [] request42) = none := rfl
def request43 : Perturbation := ⟨"a","b",["s"],["s"]⟩
example : view (observe system table0 [request43] request43) = some (["a","b"],["b","c"],[("cell-1",1,6,"held-below")],[("cell-1",1,3,"held-above")]) := rfl
def request44 : Perturbation := ⟨"a","b",["s"],["s","s"]⟩
example : view (observe system table0 [] request44) = none := rfl
def request45 : Perturbation := ⟨"a","b",["s"],["s","s"]⟩
example : view (observe system table0 [request45] request45) = some (["a","b"],["b","c","c"],[("cell-1",1,6,"held-below")],[("cell-1",1,3,"held-above")]) := rfl
def request46 : Perturbation := ⟨"a","b",["s"],["bad"]⟩
example : view (observe system table0 [] request46) = none := rfl
def request47 : Perturbation := ⟨"a","b",["s"],["bad"]⟩
example : view (observe system table0 [request47] request47) = none := rfl
def request48 : Perturbation := ⟨"a","b",["s","s"],[]⟩
example : view (observe system table0 [] request48) = none := rfl
def request49 : Perturbation := ⟨"a","b",["s","s"],[]⟩
example : view (observe system table0 [request49] request49) = some (["a","b","c"],["b"],[("cell-1",1,6,"held-below")],[("cell-1",1,3,"held-below")]) := rfl
def request50 : Perturbation := ⟨"a","b",["s","s"],["s"]⟩
example : view (observe system table0 [] request50) = none := rfl
def request51 : Perturbation := ⟨"a","b",["s","s"],["s"]⟩
example : view (observe system table0 [request51] request51) = some (["a","b","c"],["b","c"],[("cell-1",1,6,"held-below")],[("cell-1",1,1,"equal")]) := rfl
def request52 : Perturbation := ⟨"a","b",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request52) = none := rfl
def request53 : Perturbation := ⟨"a","b",["s","s"],["s","s"]⟩
example : view (observe system table0 [request53] request53) = some (["a","b","c"],["b","c","c"],[("cell-1",1,6,"held-below")],[("cell-1",1,1,"equal")]) := rfl
def request54 : Perturbation := ⟨"a","b",["s","s"],["bad"]⟩
example : view (observe system table0 [] request54) = none := rfl
def request55 : Perturbation := ⟨"a","b",["s","s"],["bad"]⟩
example : view (observe system table0 [request55] request55) = none := rfl
def request56 : Perturbation := ⟨"a","b",["bad"],[]⟩
example : view (observe system table0 [] request56) = none := rfl
def request57 : Perturbation := ⟨"a","b",["bad"],[]⟩
example : view (observe system table0 [request57] request57) = none := rfl
def request58 : Perturbation := ⟨"a","b",["bad"],["s"]⟩
example : view (observe system table0 [] request58) = none := rfl
def request59 : Perturbation := ⟨"a","b",["bad"],["s"]⟩
example : view (observe system table0 [request59] request59) = none := rfl
def request60 : Perturbation := ⟨"a","b",["bad"],["s","s"]⟩
example : view (observe system table0 [] request60) = none := rfl
def request61 : Perturbation := ⟨"a","b",["bad"],["s","s"]⟩
example : view (observe system table0 [request61] request61) = none := rfl
def request62 : Perturbation := ⟨"a","b",["bad"],["bad"]⟩
example : view (observe system table0 [] request62) = none := rfl
def request63 : Perturbation := ⟨"a","b",["bad"],["bad"]⟩
example : view (observe system table0 [request63] request63) = none := rfl
def request64 : Perturbation := ⟨"a","outside",[],[]⟩
example : view (observe system table0 [] request64) = none := rfl
def request65 : Perturbation := ⟨"a","outside",[],[]⟩
example : view (observe system table0 [request65] request65) = none := rfl
def request66 : Perturbation := ⟨"a","outside",[],["s"]⟩
example : view (observe system table0 [] request66) = none := rfl
def request67 : Perturbation := ⟨"a","outside",[],["s"]⟩
example : view (observe system table0 [request67] request67) = none := rfl
def request68 : Perturbation := ⟨"a","outside",[],["s","s"]⟩
example : view (observe system table0 [] request68) = none := rfl
def request69 : Perturbation := ⟨"a","outside",[],["s","s"]⟩
example : view (observe system table0 [request69] request69) = none := rfl
def request70 : Perturbation := ⟨"a","outside",[],["bad"]⟩
example : view (observe system table0 [] request70) = none := rfl
def request71 : Perturbation := ⟨"a","outside",[],["bad"]⟩
example : view (observe system table0 [request71] request71) = none := rfl
def request72 : Perturbation := ⟨"a","outside",["s"],[]⟩
example : view (observe system table0 [] request72) = none := rfl
def request73 : Perturbation := ⟨"a","outside",["s"],[]⟩
example : view (observe system table0 [request73] request73) = none := rfl
def request74 : Perturbation := ⟨"a","outside",["s"],["s"]⟩
example : view (observe system table0 [] request74) = none := rfl
def request75 : Perturbation := ⟨"a","outside",["s"],["s"]⟩
example : view (observe system table0 [request75] request75) = none := rfl
def request76 : Perturbation := ⟨"a","outside",["s"],["s","s"]⟩
example : view (observe system table0 [] request76) = none := rfl
def request77 : Perturbation := ⟨"a","outside",["s"],["s","s"]⟩
example : view (observe system table0 [request77] request77) = none := rfl
def request78 : Perturbation := ⟨"a","outside",["s"],["bad"]⟩
example : view (observe system table0 [] request78) = none := rfl
def request79 : Perturbation := ⟨"a","outside",["s"],["bad"]⟩
example : view (observe system table0 [request79] request79) = none := rfl
def request80 : Perturbation := ⟨"a","outside",["s","s"],[]⟩
example : view (observe system table0 [] request80) = none := rfl
def request81 : Perturbation := ⟨"a","outside",["s","s"],[]⟩
example : view (observe system table0 [request81] request81) = none := rfl
def request82 : Perturbation := ⟨"a","outside",["s","s"],["s"]⟩
example : view (observe system table0 [] request82) = none := rfl
def request83 : Perturbation := ⟨"a","outside",["s","s"],["s"]⟩
example : view (observe system table0 [request83] request83) = none := rfl
def request84 : Perturbation := ⟨"a","outside",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request84) = none := rfl
def request85 : Perturbation := ⟨"a","outside",["s","s"],["s","s"]⟩
example : view (observe system table0 [request85] request85) = none := rfl
def request86 : Perturbation := ⟨"a","outside",["s","s"],["bad"]⟩
example : view (observe system table0 [] request86) = none := rfl
def request87 : Perturbation := ⟨"a","outside",["s","s"],["bad"]⟩
example : view (observe system table0 [request87] request87) = none := rfl
def request88 : Perturbation := ⟨"a","outside",["bad"],[]⟩
example : view (observe system table0 [] request88) = none := rfl
def request89 : Perturbation := ⟨"a","outside",["bad"],[]⟩
example : view (observe system table0 [request89] request89) = none := rfl
def request90 : Perturbation := ⟨"a","outside",["bad"],["s"]⟩
example : view (observe system table0 [] request90) = none := rfl
def request91 : Perturbation := ⟨"a","outside",["bad"],["s"]⟩
example : view (observe system table0 [request91] request91) = none := rfl
def request92 : Perturbation := ⟨"a","outside",["bad"],["s","s"]⟩
example : view (observe system table0 [] request92) = none := rfl
def request93 : Perturbation := ⟨"a","outside",["bad"],["s","s"]⟩
example : view (observe system table0 [request93] request93) = none := rfl
def request94 : Perturbation := ⟨"a","outside",["bad"],["bad"]⟩
example : view (observe system table0 [] request94) = none := rfl
def request95 : Perturbation := ⟨"a","outside",["bad"],["bad"]⟩
example : view (observe system table0 [request95] request95) = none := rfl
def request96 : Perturbation := ⟨"b","a",[],[]⟩
example : view (observe system table0 [] request96) = none := rfl
def request97 : Perturbation := ⟨"b","a",[],[]⟩
example : view (observe system table0 [request97] request97) = some (["b"],["a"],[("cell-1",1,6,"held-above")],[("cell-1",1,6,"held-above")]) := rfl
def request98 : Perturbation := ⟨"b","a",[],["s"]⟩
example : view (observe system table0 [] request98) = none := rfl
def request99 : Perturbation := ⟨"b","a",[],["s"]⟩
example : view (observe system table0 [request99] request99) = some (["b"],["a","b"],[("cell-1",1,6,"held-above")],[("cell-1",1,1,"equal")]) := rfl
def request100 : Perturbation := ⟨"b","a",[],["s","s"]⟩
example : view (observe system table0 [] request100) = none := rfl
def request101 : Perturbation := ⟨"b","a",[],["s","s"]⟩
example : view (observe system table0 [request101] request101) = some (["b"],["a","b","c"],[("cell-1",1,6,"held-above")],[("cell-1",1,3,"held-above")]) := rfl
def request102 : Perturbation := ⟨"b","a",[],["bad"]⟩
example : view (observe system table0 [] request102) = none := rfl
def request103 : Perturbation := ⟨"b","a",[],["bad"]⟩
example : view (observe system table0 [request103] request103) = none := rfl
def request104 : Perturbation := ⟨"b","a",["s"],[]⟩
example : view (observe system table0 [] request104) = none := rfl
def request105 : Perturbation := ⟨"b","a",["s"],[]⟩
example : view (observe system table0 [request105] request105) = some (["b","c"],["a"],[("cell-1",1,6,"held-above")],[("cell-1",1,6,"held-below")]) := rfl
def request106 : Perturbation := ⟨"b","a",["s"],["s"]⟩
example : view (observe system table0 [] request106) = none := rfl
def request107 : Perturbation := ⟨"b","a",["s"],["s"]⟩
example : view (observe system table0 [request107] request107) = some (["b","c"],["a","b"],[("cell-1",1,6,"held-above")],[("cell-1",1,3,"held-below")]) := rfl
def request108 : Perturbation := ⟨"b","a",["s"],["s","s"]⟩
example : view (observe system table0 [] request108) = none := rfl
def request109 : Perturbation := ⟨"b","a",["s"],["s","s"]⟩
example : view (observe system table0 [request109] request109) = some (["b","c"],["a","b","c"],[("cell-1",1,6,"held-above")],[("cell-1",1,1,"equal")]) := rfl
def request110 : Perturbation := ⟨"b","a",["s"],["bad"]⟩
example : view (observe system table0 [] request110) = none := rfl
def request111 : Perturbation := ⟨"b","a",["s"],["bad"]⟩
example : view (observe system table0 [request111] request111) = none := rfl
def request112 : Perturbation := ⟨"b","a",["s","s"],[]⟩
example : view (observe system table0 [] request112) = none := rfl
def request113 : Perturbation := ⟨"b","a",["s","s"],[]⟩
example : view (observe system table0 [request113] request113) = some (["b","c","c"],["a"],[("cell-1",1,6,"held-above")],[("cell-1",1,6,"held-below")]) := rfl
def request114 : Perturbation := ⟨"b","a",["s","s"],["s"]⟩
example : view (observe system table0 [] request114) = none := rfl
def request115 : Perturbation := ⟨"b","a",["s","s"],["s"]⟩
example : view (observe system table0 [request115] request115) = some (["b","c","c"],["a","b"],[("cell-1",1,6,"held-above")],[("cell-1",1,3,"held-below")]) := rfl
def request116 : Perturbation := ⟨"b","a",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request116) = none := rfl
def request117 : Perturbation := ⟨"b","a",["s","s"],["s","s"]⟩
example : view (observe system table0 [request117] request117) = some (["b","c","c"],["a","b","c"],[("cell-1",1,6,"held-above")],[("cell-1",1,1,"equal")]) := rfl
def request118 : Perturbation := ⟨"b","a",["s","s"],["bad"]⟩
example : view (observe system table0 [] request118) = none := rfl
def request119 : Perturbation := ⟨"b","a",["s","s"],["bad"]⟩
example : view (observe system table0 [request119] request119) = none := rfl
def request120 : Perturbation := ⟨"b","a",["bad"],[]⟩
example : view (observe system table0 [] request120) = none := rfl
def request121 : Perturbation := ⟨"b","a",["bad"],[]⟩
example : view (observe system table0 [request121] request121) = none := rfl
def request122 : Perturbation := ⟨"b","a",["bad"],["s"]⟩
example : view (observe system table0 [] request122) = none := rfl
def request123 : Perturbation := ⟨"b","a",["bad"],["s"]⟩
example : view (observe system table0 [request123] request123) = none := rfl
def request124 : Perturbation := ⟨"b","a",["bad"],["s","s"]⟩
example : view (observe system table0 [] request124) = none := rfl
def request125 : Perturbation := ⟨"b","a",["bad"],["s","s"]⟩
example : view (observe system table0 [request125] request125) = none := rfl
def request126 : Perturbation := ⟨"b","a",["bad"],["bad"]⟩
example : view (observe system table0 [] request126) = none := rfl
def request127 : Perturbation := ⟨"b","a",["bad"],["bad"]⟩
example : view (observe system table0 [request127] request127) = none := rfl
def request128 : Perturbation := ⟨"b","b",[],[]⟩
example : view (observe system table0 [] request128) = none := rfl
def request129 : Perturbation := ⟨"b","b",[],[]⟩
example : view (observe system table0 [request129] request129) = some (["b"],["b"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request130 : Perturbation := ⟨"b","b",[],["s"]⟩
example : view (observe system table0 [] request130) = none := rfl
def request131 : Perturbation := ⟨"b","b",[],["s"]⟩
example : view (observe system table0 [request131] request131) = some (["b"],["b","c"],[("cell-1",1,1,"equal")],[("cell-1",1,3,"held-above")]) := rfl
def request132 : Perturbation := ⟨"b","b",[],["s","s"]⟩
example : view (observe system table0 [] request132) = none := rfl
def request133 : Perturbation := ⟨"b","b",[],["s","s"]⟩
example : view (observe system table0 [request133] request133) = some (["b"],["b","c","c"],[("cell-1",1,1,"equal")],[("cell-1",1,3,"held-above")]) := rfl
def request134 : Perturbation := ⟨"b","b",[],["bad"]⟩
example : view (observe system table0 [] request134) = none := rfl
def request135 : Perturbation := ⟨"b","b",[],["bad"]⟩
example : view (observe system table0 [request135] request135) = none := rfl
def request136 : Perturbation := ⟨"b","b",["s"],[]⟩
example : view (observe system table0 [] request136) = none := rfl
def request137 : Perturbation := ⟨"b","b",["s"],[]⟩
example : view (observe system table0 [request137] request137) = some (["b","c"],["b"],[("cell-1",1,1,"equal")],[("cell-1",1,3,"held-below")]) := rfl
def request138 : Perturbation := ⟨"b","b",["s"],["s"]⟩
example : view (observe system table0 [] request138) = none := rfl
def request139 : Perturbation := ⟨"b","b",["s"],["s"]⟩
example : view (observe system table0 [request139] request139) = some (["b","c"],["b","c"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request140 : Perturbation := ⟨"b","b",["s"],["s","s"]⟩
example : view (observe system table0 [] request140) = none := rfl
def request141 : Perturbation := ⟨"b","b",["s"],["s","s"]⟩
example : view (observe system table0 [request141] request141) = some (["b","c"],["b","c","c"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request142 : Perturbation := ⟨"b","b",["s"],["bad"]⟩
example : view (observe system table0 [] request142) = none := rfl
def request143 : Perturbation := ⟨"b","b",["s"],["bad"]⟩
example : view (observe system table0 [request143] request143) = none := rfl
def request144 : Perturbation := ⟨"b","b",["s","s"],[]⟩
example : view (observe system table0 [] request144) = none := rfl
def request145 : Perturbation := ⟨"b","b",["s","s"],[]⟩
example : view (observe system table0 [request145] request145) = some (["b","c","c"],["b"],[("cell-1",1,1,"equal")],[("cell-1",1,3,"held-below")]) := rfl
def request146 : Perturbation := ⟨"b","b",["s","s"],["s"]⟩
example : view (observe system table0 [] request146) = none := rfl
def request147 : Perturbation := ⟨"b","b",["s","s"],["s"]⟩
example : view (observe system table0 [request147] request147) = some (["b","c","c"],["b","c"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request148 : Perturbation := ⟨"b","b",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request148) = none := rfl
def request149 : Perturbation := ⟨"b","b",["s","s"],["s","s"]⟩
example : view (observe system table0 [request149] request149) = some (["b","c","c"],["b","c","c"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request150 : Perturbation := ⟨"b","b",["s","s"],["bad"]⟩
example : view (observe system table0 [] request150) = none := rfl
def request151 : Perturbation := ⟨"b","b",["s","s"],["bad"]⟩
example : view (observe system table0 [request151] request151) = none := rfl
def request152 : Perturbation := ⟨"b","b",["bad"],[]⟩
example : view (observe system table0 [] request152) = none := rfl
def request153 : Perturbation := ⟨"b","b",["bad"],[]⟩
example : view (observe system table0 [request153] request153) = none := rfl
def request154 : Perturbation := ⟨"b","b",["bad"],["s"]⟩
example : view (observe system table0 [] request154) = none := rfl
def request155 : Perturbation := ⟨"b","b",["bad"],["s"]⟩
example : view (observe system table0 [request155] request155) = none := rfl
def request156 : Perturbation := ⟨"b","b",["bad"],["s","s"]⟩
example : view (observe system table0 [] request156) = none := rfl
def request157 : Perturbation := ⟨"b","b",["bad"],["s","s"]⟩
example : view (observe system table0 [request157] request157) = none := rfl
def request158 : Perturbation := ⟨"b","b",["bad"],["bad"]⟩
example : view (observe system table0 [] request158) = none := rfl
def request159 : Perturbation := ⟨"b","b",["bad"],["bad"]⟩
example : view (observe system table0 [request159] request159) = none := rfl
def request160 : Perturbation := ⟨"b","outside",[],[]⟩
example : view (observe system table0 [] request160) = none := rfl
def request161 : Perturbation := ⟨"b","outside",[],[]⟩
example : view (observe system table0 [request161] request161) = none := rfl
def request162 : Perturbation := ⟨"b","outside",[],["s"]⟩
example : view (observe system table0 [] request162) = none := rfl
def request163 : Perturbation := ⟨"b","outside",[],["s"]⟩
example : view (observe system table0 [request163] request163) = none := rfl
def request164 : Perturbation := ⟨"b","outside",[],["s","s"]⟩
example : view (observe system table0 [] request164) = none := rfl
def request165 : Perturbation := ⟨"b","outside",[],["s","s"]⟩
example : view (observe system table0 [request165] request165) = none := rfl
def request166 : Perturbation := ⟨"b","outside",[],["bad"]⟩
example : view (observe system table0 [] request166) = none := rfl
def request167 : Perturbation := ⟨"b","outside",[],["bad"]⟩
example : view (observe system table0 [request167] request167) = none := rfl
def request168 : Perturbation := ⟨"b","outside",["s"],[]⟩
example : view (observe system table0 [] request168) = none := rfl
def request169 : Perturbation := ⟨"b","outside",["s"],[]⟩
example : view (observe system table0 [request169] request169) = none := rfl
def request170 : Perturbation := ⟨"b","outside",["s"],["s"]⟩
example : view (observe system table0 [] request170) = none := rfl
def request171 : Perturbation := ⟨"b","outside",["s"],["s"]⟩
example : view (observe system table0 [request171] request171) = none := rfl
def request172 : Perturbation := ⟨"b","outside",["s"],["s","s"]⟩
example : view (observe system table0 [] request172) = none := rfl
def request173 : Perturbation := ⟨"b","outside",["s"],["s","s"]⟩
example : view (observe system table0 [request173] request173) = none := rfl
def request174 : Perturbation := ⟨"b","outside",["s"],["bad"]⟩
example : view (observe system table0 [] request174) = none := rfl
def request175 : Perturbation := ⟨"b","outside",["s"],["bad"]⟩
example : view (observe system table0 [request175] request175) = none := rfl
def request176 : Perturbation := ⟨"b","outside",["s","s"],[]⟩
example : view (observe system table0 [] request176) = none := rfl
def request177 : Perturbation := ⟨"b","outside",["s","s"],[]⟩
example : view (observe system table0 [request177] request177) = none := rfl
def request178 : Perturbation := ⟨"b","outside",["s","s"],["s"]⟩
example : view (observe system table0 [] request178) = none := rfl
def request179 : Perturbation := ⟨"b","outside",["s","s"],["s"]⟩
example : view (observe system table0 [request179] request179) = none := rfl
def request180 : Perturbation := ⟨"b","outside",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request180) = none := rfl
def request181 : Perturbation := ⟨"b","outside",["s","s"],["s","s"]⟩
example : view (observe system table0 [request181] request181) = none := rfl
def request182 : Perturbation := ⟨"b","outside",["s","s"],["bad"]⟩
example : view (observe system table0 [] request182) = none := rfl
def request183 : Perturbation := ⟨"b","outside",["s","s"],["bad"]⟩
example : view (observe system table0 [request183] request183) = none := rfl
def request184 : Perturbation := ⟨"b","outside",["bad"],[]⟩
example : view (observe system table0 [] request184) = none := rfl
def request185 : Perturbation := ⟨"b","outside",["bad"],[]⟩
example : view (observe system table0 [request185] request185) = none := rfl
def request186 : Perturbation := ⟨"b","outside",["bad"],["s"]⟩
example : view (observe system table0 [] request186) = none := rfl
def request187 : Perturbation := ⟨"b","outside",["bad"],["s"]⟩
example : view (observe system table0 [request187] request187) = none := rfl
def request188 : Perturbation := ⟨"b","outside",["bad"],["s","s"]⟩
example : view (observe system table0 [] request188) = none := rfl
def request189 : Perturbation := ⟨"b","outside",["bad"],["s","s"]⟩
example : view (observe system table0 [request189] request189) = none := rfl
def request190 : Perturbation := ⟨"b","outside",["bad"],["bad"]⟩
example : view (observe system table0 [] request190) = none := rfl
def request191 : Perturbation := ⟨"b","outside",["bad"],["bad"]⟩
example : view (observe system table0 [request191] request191) = none := rfl
def request192 : Perturbation := ⟨"outside","a",[],[]⟩
example : view (observe system table0 [] request192) = none := rfl
def request193 : Perturbation := ⟨"outside","a",[],[]⟩
example : view (observe system table0 [request193] request193) = none := rfl
def request194 : Perturbation := ⟨"outside","a",[],["s"]⟩
example : view (observe system table0 [] request194) = none := rfl
def request195 : Perturbation := ⟨"outside","a",[],["s"]⟩
example : view (observe system table0 [request195] request195) = none := rfl
def request196 : Perturbation := ⟨"outside","a",[],["s","s"]⟩
example : view (observe system table0 [] request196) = none := rfl
def request197 : Perturbation := ⟨"outside","a",[],["s","s"]⟩
example : view (observe system table0 [request197] request197) = none := rfl
def request198 : Perturbation := ⟨"outside","a",[],["bad"]⟩
example : view (observe system table0 [] request198) = none := rfl
def request199 : Perturbation := ⟨"outside","a",[],["bad"]⟩
example : view (observe system table0 [request199] request199) = none := rfl
def request200 : Perturbation := ⟨"outside","a",["s"],[]⟩
example : view (observe system table0 [] request200) = none := rfl
def request201 : Perturbation := ⟨"outside","a",["s"],[]⟩
example : view (observe system table0 [request201] request201) = none := rfl
def request202 : Perturbation := ⟨"outside","a",["s"],["s"]⟩
example : view (observe system table0 [] request202) = none := rfl
def request203 : Perturbation := ⟨"outside","a",["s"],["s"]⟩
example : view (observe system table0 [request203] request203) = none := rfl
def request204 : Perturbation := ⟨"outside","a",["s"],["s","s"]⟩
example : view (observe system table0 [] request204) = none := rfl
def request205 : Perturbation := ⟨"outside","a",["s"],["s","s"]⟩
example : view (observe system table0 [request205] request205) = none := rfl
def request206 : Perturbation := ⟨"outside","a",["s"],["bad"]⟩
example : view (observe system table0 [] request206) = none := rfl
def request207 : Perturbation := ⟨"outside","a",["s"],["bad"]⟩
example : view (observe system table0 [request207] request207) = none := rfl
def request208 : Perturbation := ⟨"outside","a",["s","s"],[]⟩
example : view (observe system table0 [] request208) = none := rfl
def request209 : Perturbation := ⟨"outside","a",["s","s"],[]⟩
example : view (observe system table0 [request209] request209) = none := rfl
def request210 : Perturbation := ⟨"outside","a",["s","s"],["s"]⟩
example : view (observe system table0 [] request210) = none := rfl
def request211 : Perturbation := ⟨"outside","a",["s","s"],["s"]⟩
example : view (observe system table0 [request211] request211) = none := rfl
def request212 : Perturbation := ⟨"outside","a",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request212) = none := rfl
def request213 : Perturbation := ⟨"outside","a",["s","s"],["s","s"]⟩
example : view (observe system table0 [request213] request213) = none := rfl
def request214 : Perturbation := ⟨"outside","a",["s","s"],["bad"]⟩
example : view (observe system table0 [] request214) = none := rfl
def request215 : Perturbation := ⟨"outside","a",["s","s"],["bad"]⟩
example : view (observe system table0 [request215] request215) = none := rfl
def request216 : Perturbation := ⟨"outside","a",["bad"],[]⟩
example : view (observe system table0 [] request216) = none := rfl
def request217 : Perturbation := ⟨"outside","a",["bad"],[]⟩
example : view (observe system table0 [request217] request217) = none := rfl
def request218 : Perturbation := ⟨"outside","a",["bad"],["s"]⟩
example : view (observe system table0 [] request218) = none := rfl
def request219 : Perturbation := ⟨"outside","a",["bad"],["s"]⟩
example : view (observe system table0 [request219] request219) = none := rfl
def request220 : Perturbation := ⟨"outside","a",["bad"],["s","s"]⟩
example : view (observe system table0 [] request220) = none := rfl
def request221 : Perturbation := ⟨"outside","a",["bad"],["s","s"]⟩
example : view (observe system table0 [request221] request221) = none := rfl
def request222 : Perturbation := ⟨"outside","a",["bad"],["bad"]⟩
example : view (observe system table0 [] request222) = none := rfl
def request223 : Perturbation := ⟨"outside","a",["bad"],["bad"]⟩
example : view (observe system table0 [request223] request223) = none := rfl
def request224 : Perturbation := ⟨"outside","b",[],[]⟩
example : view (observe system table0 [] request224) = none := rfl
def request225 : Perturbation := ⟨"outside","b",[],[]⟩
example : view (observe system table0 [request225] request225) = none := rfl
def request226 : Perturbation := ⟨"outside","b",[],["s"]⟩
example : view (observe system table0 [] request226) = none := rfl
def request227 : Perturbation := ⟨"outside","b",[],["s"]⟩
example : view (observe system table0 [request227] request227) = none := rfl
def request228 : Perturbation := ⟨"outside","b",[],["s","s"]⟩
example : view (observe system table0 [] request228) = none := rfl
def request229 : Perturbation := ⟨"outside","b",[],["s","s"]⟩
example : view (observe system table0 [request229] request229) = none := rfl
def request230 : Perturbation := ⟨"outside","b",[],["bad"]⟩
example : view (observe system table0 [] request230) = none := rfl
def request231 : Perturbation := ⟨"outside","b",[],["bad"]⟩
example : view (observe system table0 [request231] request231) = none := rfl
def request232 : Perturbation := ⟨"outside","b",["s"],[]⟩
example : view (observe system table0 [] request232) = none := rfl
def request233 : Perturbation := ⟨"outside","b",["s"],[]⟩
example : view (observe system table0 [request233] request233) = none := rfl
def request234 : Perturbation := ⟨"outside","b",["s"],["s"]⟩
example : view (observe system table0 [] request234) = none := rfl
def request235 : Perturbation := ⟨"outside","b",["s"],["s"]⟩
example : view (observe system table0 [request235] request235) = none := rfl
def request236 : Perturbation := ⟨"outside","b",["s"],["s","s"]⟩
example : view (observe system table0 [] request236) = none := rfl
def request237 : Perturbation := ⟨"outside","b",["s"],["s","s"]⟩
example : view (observe system table0 [request237] request237) = none := rfl
def request238 : Perturbation := ⟨"outside","b",["s"],["bad"]⟩
example : view (observe system table0 [] request238) = none := rfl
def request239 : Perturbation := ⟨"outside","b",["s"],["bad"]⟩
example : view (observe system table0 [request239] request239) = none := rfl
def request240 : Perturbation := ⟨"outside","b",["s","s"],[]⟩
example : view (observe system table0 [] request240) = none := rfl
def request241 : Perturbation := ⟨"outside","b",["s","s"],[]⟩
example : view (observe system table0 [request241] request241) = none := rfl
def request242 : Perturbation := ⟨"outside","b",["s","s"],["s"]⟩
example : view (observe system table0 [] request242) = none := rfl
def request243 : Perturbation := ⟨"outside","b",["s","s"],["s"]⟩
example : view (observe system table0 [request243] request243) = none := rfl
def request244 : Perturbation := ⟨"outside","b",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request244) = none := rfl
def request245 : Perturbation := ⟨"outside","b",["s","s"],["s","s"]⟩
example : view (observe system table0 [request245] request245) = none := rfl
def request246 : Perturbation := ⟨"outside","b",["s","s"],["bad"]⟩
example : view (observe system table0 [] request246) = none := rfl
def request247 : Perturbation := ⟨"outside","b",["s","s"],["bad"]⟩
example : view (observe system table0 [request247] request247) = none := rfl
def request248 : Perturbation := ⟨"outside","b",["bad"],[]⟩
example : view (observe system table0 [] request248) = none := rfl
def request249 : Perturbation := ⟨"outside","b",["bad"],[]⟩
example : view (observe system table0 [request249] request249) = none := rfl
def request250 : Perturbation := ⟨"outside","b",["bad"],["s"]⟩
example : view (observe system table0 [] request250) = none := rfl
def request251 : Perturbation := ⟨"outside","b",["bad"],["s"]⟩
example : view (observe system table0 [request251] request251) = none := rfl
def request252 : Perturbation := ⟨"outside","b",["bad"],["s","s"]⟩
example : view (observe system table0 [] request252) = none := rfl
def request253 : Perturbation := ⟨"outside","b",["bad"],["s","s"]⟩
example : view (observe system table0 [request253] request253) = none := rfl
def request254 : Perturbation := ⟨"outside","b",["bad"],["bad"]⟩
example : view (observe system table0 [] request254) = none := rfl
def request255 : Perturbation := ⟨"outside","b",["bad"],["bad"]⟩
example : view (observe system table0 [request255] request255) = none := rfl
def request256 : Perturbation := ⟨"outside","outside",[],[]⟩
example : view (observe system table0 [] request256) = none := rfl
def request257 : Perturbation := ⟨"outside","outside",[],[]⟩
example : view (observe system table0 [request257] request257) = none := rfl
def request258 : Perturbation := ⟨"outside","outside",[],["s"]⟩
example : view (observe system table0 [] request258) = none := rfl
def request259 : Perturbation := ⟨"outside","outside",[],["s"]⟩
example : view (observe system table0 [request259] request259) = none := rfl
def request260 : Perturbation := ⟨"outside","outside",[],["s","s"]⟩
example : view (observe system table0 [] request260) = none := rfl
def request261 : Perturbation := ⟨"outside","outside",[],["s","s"]⟩
example : view (observe system table0 [request261] request261) = none := rfl
def request262 : Perturbation := ⟨"outside","outside",[],["bad"]⟩
example : view (observe system table0 [] request262) = none := rfl
def request263 : Perturbation := ⟨"outside","outside",[],["bad"]⟩
example : view (observe system table0 [request263] request263) = none := rfl
def request264 : Perturbation := ⟨"outside","outside",["s"],[]⟩
example : view (observe system table0 [] request264) = none := rfl
def request265 : Perturbation := ⟨"outside","outside",["s"],[]⟩
example : view (observe system table0 [request265] request265) = none := rfl
def request266 : Perturbation := ⟨"outside","outside",["s"],["s"]⟩
example : view (observe system table0 [] request266) = none := rfl
def request267 : Perturbation := ⟨"outside","outside",["s"],["s"]⟩
example : view (observe system table0 [request267] request267) = none := rfl
def request268 : Perturbation := ⟨"outside","outside",["s"],["s","s"]⟩
example : view (observe system table0 [] request268) = none := rfl
def request269 : Perturbation := ⟨"outside","outside",["s"],["s","s"]⟩
example : view (observe system table0 [request269] request269) = none := rfl
def request270 : Perturbation := ⟨"outside","outside",["s"],["bad"]⟩
example : view (observe system table0 [] request270) = none := rfl
def request271 : Perturbation := ⟨"outside","outside",["s"],["bad"]⟩
example : view (observe system table0 [request271] request271) = none := rfl
def request272 : Perturbation := ⟨"outside","outside",["s","s"],[]⟩
example : view (observe system table0 [] request272) = none := rfl
def request273 : Perturbation := ⟨"outside","outside",["s","s"],[]⟩
example : view (observe system table0 [request273] request273) = none := rfl
def request274 : Perturbation := ⟨"outside","outside",["s","s"],["s"]⟩
example : view (observe system table0 [] request274) = none := rfl
def request275 : Perturbation := ⟨"outside","outside",["s","s"],["s"]⟩
example : view (observe system table0 [request275] request275) = none := rfl
def request276 : Perturbation := ⟨"outside","outside",["s","s"],["s","s"]⟩
example : view (observe system table0 [] request276) = none := rfl
def request277 : Perturbation := ⟨"outside","outside",["s","s"],["s","s"]⟩
example : view (observe system table0 [request277] request277) = none := rfl
def request278 : Perturbation := ⟨"outside","outside",["s","s"],["bad"]⟩
example : view (observe system table0 [] request278) = none := rfl
def request279 : Perturbation := ⟨"outside","outside",["s","s"],["bad"]⟩
example : view (observe system table0 [request279] request279) = none := rfl
def request280 : Perturbation := ⟨"outside","outside",["bad"],[]⟩
example : view (observe system table0 [] request280) = none := rfl
def request281 : Perturbation := ⟨"outside","outside",["bad"],[]⟩
example : view (observe system table0 [request281] request281) = none := rfl
def request282 : Perturbation := ⟨"outside","outside",["bad"],["s"]⟩
example : view (observe system table0 [] request282) = none := rfl
def request283 : Perturbation := ⟨"outside","outside",["bad"],["s"]⟩
example : view (observe system table0 [request283] request283) = none := rfl
def request284 : Perturbation := ⟨"outside","outside",["bad"],["s","s"]⟩
example : view (observe system table0 [] request284) = none := rfl
def request285 : Perturbation := ⟨"outside","outside",["bad"],["s","s"]⟩
example : view (observe system table0 [request285] request285) = none := rfl
def request286 : Perturbation := ⟨"outside","outside",["bad"],["bad"]⟩
example : view (observe system table0 [] request286) = none := rfl
def request287 : Perturbation := ⟨"outside","outside",["bad"],["bad"]⟩
example : view (observe system table0 [request287] request287) = none := rfl
def request288 : Perturbation := ⟨"a","a",[],[]⟩
example : view (observe system table1 [] request288) = none := rfl
def request289 : Perturbation := ⟨"a","a",[],[]⟩
example : view (observe system table1 [request289] request289) = some (["a"],["a"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request290 : Perturbation := ⟨"a","a",[],["s"]⟩
example : view (observe system table1 [] request290) = none := rfl
def request291 : Perturbation := ⟨"a","a",[],["s"]⟩
example : view (observe system table1 [request291] request291) = some (["a"],["a","b"],[("cell-1",1,1,"equal")],[("cell-1",1,6,"held-below")]) := rfl
def request292 : Perturbation := ⟨"a","a",[],["s","s"]⟩
example : view (observe system table1 [] request292) = none := rfl
def request293 : Perturbation := ⟨"a","a",[],["s","s"]⟩
example : view (observe system table1 [request293] request293) = none := rfl
def request294 : Perturbation := ⟨"a","a",[],["bad"]⟩
example : view (observe system table1 [] request294) = none := rfl
def request295 : Perturbation := ⟨"a","a",[],["bad"]⟩
example : view (observe system table1 [request295] request295) = none := rfl
def request296 : Perturbation := ⟨"a","a",["s"],[]⟩
example : view (observe system table1 [] request296) = none := rfl
def request297 : Perturbation := ⟨"a","a",["s"],[]⟩
example : view (observe system table1 [request297] request297) = some (["a","b"],["a"],[("cell-1",1,1,"equal")],[("cell-1",1,6,"held-above")]) := rfl
def request298 : Perturbation := ⟨"a","a",["s"],["s"]⟩
example : view (observe system table1 [] request298) = none := rfl
def request299 : Perturbation := ⟨"a","a",["s"],["s"]⟩
example : view (observe system table1 [request299] request299) = some (["a","b"],["a","b"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request300 : Perturbation := ⟨"a","a",["s"],["s","s"]⟩
example : view (observe system table1 [] request300) = none := rfl
def request301 : Perturbation := ⟨"a","a",["s"],["s","s"]⟩
example : view (observe system table1 [request301] request301) = none := rfl
def request302 : Perturbation := ⟨"a","a",["s"],["bad"]⟩
example : view (observe system table1 [] request302) = none := rfl
def request303 : Perturbation := ⟨"a","a",["s"],["bad"]⟩
example : view (observe system table1 [request303] request303) = none := rfl
def request304 : Perturbation := ⟨"a","a",["s","s"],[]⟩
example : view (observe system table1 [] request304) = none := rfl
def request305 : Perturbation := ⟨"a","a",["s","s"],[]⟩
example : view (observe system table1 [request305] request305) = none := rfl
def request306 : Perturbation := ⟨"a","a",["s","s"],["s"]⟩
example : view (observe system table1 [] request306) = none := rfl
def request307 : Perturbation := ⟨"a","a",["s","s"],["s"]⟩
example : view (observe system table1 [request307] request307) = none := rfl
def request308 : Perturbation := ⟨"a","a",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request308) = none := rfl
def request309 : Perturbation := ⟨"a","a",["s","s"],["s","s"]⟩
example : view (observe system table1 [request309] request309) = none := rfl
def request310 : Perturbation := ⟨"a","a",["s","s"],["bad"]⟩
example : view (observe system table1 [] request310) = none := rfl
def request311 : Perturbation := ⟨"a","a",["s","s"],["bad"]⟩
example : view (observe system table1 [request311] request311) = none := rfl
def request312 : Perturbation := ⟨"a","a",["bad"],[]⟩
example : view (observe system table1 [] request312) = none := rfl
def request313 : Perturbation := ⟨"a","a",["bad"],[]⟩
example : view (observe system table1 [request313] request313) = none := rfl
def request314 : Perturbation := ⟨"a","a",["bad"],["s"]⟩
example : view (observe system table1 [] request314) = none := rfl
def request315 : Perturbation := ⟨"a","a",["bad"],["s"]⟩
example : view (observe system table1 [request315] request315) = none := rfl
def request316 : Perturbation := ⟨"a","a",["bad"],["s","s"]⟩
example : view (observe system table1 [] request316) = none := rfl
def request317 : Perturbation := ⟨"a","a",["bad"],["s","s"]⟩
example : view (observe system table1 [request317] request317) = none := rfl
def request318 : Perturbation := ⟨"a","a",["bad"],["bad"]⟩
example : view (observe system table1 [] request318) = none := rfl
def request319 : Perturbation := ⟨"a","a",["bad"],["bad"]⟩
example : view (observe system table1 [request319] request319) = none := rfl
def request320 : Perturbation := ⟨"a","b",[],[]⟩
example : view (observe system table1 [] request320) = none := rfl
def request321 : Perturbation := ⟨"a","b",[],[]⟩
example : view (observe system table1 [request321] request321) = some (["a"],["b"],[("cell-1",1,6,"held-below")],[("cell-1",1,6,"held-below")]) := rfl
def request322 : Perturbation := ⟨"a","b",[],["s"]⟩
example : view (observe system table1 [] request322) = none := rfl
def request323 : Perturbation := ⟨"a","b",[],["s"]⟩
example : view (observe system table1 [request323] request323) = none := rfl
def request324 : Perturbation := ⟨"a","b",[],["s","s"]⟩
example : view (observe system table1 [] request324) = none := rfl
def request325 : Perturbation := ⟨"a","b",[],["s","s"]⟩
example : view (observe system table1 [request325] request325) = none := rfl
def request326 : Perturbation := ⟨"a","b",[],["bad"]⟩
example : view (observe system table1 [] request326) = none := rfl
def request327 : Perturbation := ⟨"a","b",[],["bad"]⟩
example : view (observe system table1 [request327] request327) = none := rfl
def request328 : Perturbation := ⟨"a","b",["s"],[]⟩
example : view (observe system table1 [] request328) = none := rfl
def request329 : Perturbation := ⟨"a","b",["s"],[]⟩
example : view (observe system table1 [request329] request329) = some (["a","b"],["b"],[("cell-1",1,6,"held-below")],[("cell-1",1,1,"equal")]) := rfl
def request330 : Perturbation := ⟨"a","b",["s"],["s"]⟩
example : view (observe system table1 [] request330) = none := rfl
def request331 : Perturbation := ⟨"a","b",["s"],["s"]⟩
example : view (observe system table1 [request331] request331) = none := rfl
def request332 : Perturbation := ⟨"a","b",["s"],["s","s"]⟩
example : view (observe system table1 [] request332) = none := rfl
def request333 : Perturbation := ⟨"a","b",["s"],["s","s"]⟩
example : view (observe system table1 [request333] request333) = none := rfl
def request334 : Perturbation := ⟨"a","b",["s"],["bad"]⟩
example : view (observe system table1 [] request334) = none := rfl
def request335 : Perturbation := ⟨"a","b",["s"],["bad"]⟩
example : view (observe system table1 [request335] request335) = none := rfl
def request336 : Perturbation := ⟨"a","b",["s","s"],[]⟩
example : view (observe system table1 [] request336) = none := rfl
def request337 : Perturbation := ⟨"a","b",["s","s"],[]⟩
example : view (observe system table1 [request337] request337) = none := rfl
def request338 : Perturbation := ⟨"a","b",["s","s"],["s"]⟩
example : view (observe system table1 [] request338) = none := rfl
def request339 : Perturbation := ⟨"a","b",["s","s"],["s"]⟩
example : view (observe system table1 [request339] request339) = none := rfl
def request340 : Perturbation := ⟨"a","b",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request340) = none := rfl
def request341 : Perturbation := ⟨"a","b",["s","s"],["s","s"]⟩
example : view (observe system table1 [request341] request341) = none := rfl
def request342 : Perturbation := ⟨"a","b",["s","s"],["bad"]⟩
example : view (observe system table1 [] request342) = none := rfl
def request343 : Perturbation := ⟨"a","b",["s","s"],["bad"]⟩
example : view (observe system table1 [request343] request343) = none := rfl
def request344 : Perturbation := ⟨"a","b",["bad"],[]⟩
example : view (observe system table1 [] request344) = none := rfl
def request345 : Perturbation := ⟨"a","b",["bad"],[]⟩
example : view (observe system table1 [request345] request345) = none := rfl
def request346 : Perturbation := ⟨"a","b",["bad"],["s"]⟩
example : view (observe system table1 [] request346) = none := rfl
def request347 : Perturbation := ⟨"a","b",["bad"],["s"]⟩
example : view (observe system table1 [request347] request347) = none := rfl
def request348 : Perturbation := ⟨"a","b",["bad"],["s","s"]⟩
example : view (observe system table1 [] request348) = none := rfl
def request349 : Perturbation := ⟨"a","b",["bad"],["s","s"]⟩
example : view (observe system table1 [request349] request349) = none := rfl
def request350 : Perturbation := ⟨"a","b",["bad"],["bad"]⟩
example : view (observe system table1 [] request350) = none := rfl
def request351 : Perturbation := ⟨"a","b",["bad"],["bad"]⟩
example : view (observe system table1 [request351] request351) = none := rfl
def request352 : Perturbation := ⟨"a","outside",[],[]⟩
example : view (observe system table1 [] request352) = none := rfl
def request353 : Perturbation := ⟨"a","outside",[],[]⟩
example : view (observe system table1 [request353] request353) = none := rfl
def request354 : Perturbation := ⟨"a","outside",[],["s"]⟩
example : view (observe system table1 [] request354) = none := rfl
def request355 : Perturbation := ⟨"a","outside",[],["s"]⟩
example : view (observe system table1 [request355] request355) = none := rfl
def request356 : Perturbation := ⟨"a","outside",[],["s","s"]⟩
example : view (observe system table1 [] request356) = none := rfl
def request357 : Perturbation := ⟨"a","outside",[],["s","s"]⟩
example : view (observe system table1 [request357] request357) = none := rfl
def request358 : Perturbation := ⟨"a","outside",[],["bad"]⟩
example : view (observe system table1 [] request358) = none := rfl
def request359 : Perturbation := ⟨"a","outside",[],["bad"]⟩
example : view (observe system table1 [request359] request359) = none := rfl
def request360 : Perturbation := ⟨"a","outside",["s"],[]⟩
example : view (observe system table1 [] request360) = none := rfl
def request361 : Perturbation := ⟨"a","outside",["s"],[]⟩
example : view (observe system table1 [request361] request361) = none := rfl
def request362 : Perturbation := ⟨"a","outside",["s"],["s"]⟩
example : view (observe system table1 [] request362) = none := rfl
def request363 : Perturbation := ⟨"a","outside",["s"],["s"]⟩
example : view (observe system table1 [request363] request363) = none := rfl
def request364 : Perturbation := ⟨"a","outside",["s"],["s","s"]⟩
example : view (observe system table1 [] request364) = none := rfl
def request365 : Perturbation := ⟨"a","outside",["s"],["s","s"]⟩
example : view (observe system table1 [request365] request365) = none := rfl
def request366 : Perturbation := ⟨"a","outside",["s"],["bad"]⟩
example : view (observe system table1 [] request366) = none := rfl
def request367 : Perturbation := ⟨"a","outside",["s"],["bad"]⟩
example : view (observe system table1 [request367] request367) = none := rfl
def request368 : Perturbation := ⟨"a","outside",["s","s"],[]⟩
example : view (observe system table1 [] request368) = none := rfl
def request369 : Perturbation := ⟨"a","outside",["s","s"],[]⟩
example : view (observe system table1 [request369] request369) = none := rfl
def request370 : Perturbation := ⟨"a","outside",["s","s"],["s"]⟩
example : view (observe system table1 [] request370) = none := rfl
def request371 : Perturbation := ⟨"a","outside",["s","s"],["s"]⟩
example : view (observe system table1 [request371] request371) = none := rfl
def request372 : Perturbation := ⟨"a","outside",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request372) = none := rfl
def request373 : Perturbation := ⟨"a","outside",["s","s"],["s","s"]⟩
example : view (observe system table1 [request373] request373) = none := rfl
def request374 : Perturbation := ⟨"a","outside",["s","s"],["bad"]⟩
example : view (observe system table1 [] request374) = none := rfl
def request375 : Perturbation := ⟨"a","outside",["s","s"],["bad"]⟩
example : view (observe system table1 [request375] request375) = none := rfl
def request376 : Perturbation := ⟨"a","outside",["bad"],[]⟩
example : view (observe system table1 [] request376) = none := rfl
def request377 : Perturbation := ⟨"a","outside",["bad"],[]⟩
example : view (observe system table1 [request377] request377) = none := rfl
def request378 : Perturbation := ⟨"a","outside",["bad"],["s"]⟩
example : view (observe system table1 [] request378) = none := rfl
def request379 : Perturbation := ⟨"a","outside",["bad"],["s"]⟩
example : view (observe system table1 [request379] request379) = none := rfl
def request380 : Perturbation := ⟨"a","outside",["bad"],["s","s"]⟩
example : view (observe system table1 [] request380) = none := rfl
def request381 : Perturbation := ⟨"a","outside",["bad"],["s","s"]⟩
example : view (observe system table1 [request381] request381) = none := rfl
def request382 : Perturbation := ⟨"a","outside",["bad"],["bad"]⟩
example : view (observe system table1 [] request382) = none := rfl
def request383 : Perturbation := ⟨"a","outside",["bad"],["bad"]⟩
example : view (observe system table1 [request383] request383) = none := rfl
def request384 : Perturbation := ⟨"b","a",[],[]⟩
example : view (observe system table1 [] request384) = none := rfl
def request385 : Perturbation := ⟨"b","a",[],[]⟩
example : view (observe system table1 [request385] request385) = some (["b"],["a"],[("cell-1",1,6,"held-above")],[("cell-1",1,6,"held-above")]) := rfl
def request386 : Perturbation := ⟨"b","a",[],["s"]⟩
example : view (observe system table1 [] request386) = none := rfl
def request387 : Perturbation := ⟨"b","a",[],["s"]⟩
example : view (observe system table1 [request387] request387) = some (["b"],["a","b"],[("cell-1",1,6,"held-above")],[("cell-1",1,1,"equal")]) := rfl
def request388 : Perturbation := ⟨"b","a",[],["s","s"]⟩
example : view (observe system table1 [] request388) = none := rfl
def request389 : Perturbation := ⟨"b","a",[],["s","s"]⟩
example : view (observe system table1 [request389] request389) = none := rfl
def request390 : Perturbation := ⟨"b","a",[],["bad"]⟩
example : view (observe system table1 [] request390) = none := rfl
def request391 : Perturbation := ⟨"b","a",[],["bad"]⟩
example : view (observe system table1 [request391] request391) = none := rfl
def request392 : Perturbation := ⟨"b","a",["s"],[]⟩
example : view (observe system table1 [] request392) = none := rfl
def request393 : Perturbation := ⟨"b","a",["s"],[]⟩
example : view (observe system table1 [request393] request393) = none := rfl
def request394 : Perturbation := ⟨"b","a",["s"],["s"]⟩
example : view (observe system table1 [] request394) = none := rfl
def request395 : Perturbation := ⟨"b","a",["s"],["s"]⟩
example : view (observe system table1 [request395] request395) = none := rfl
def request396 : Perturbation := ⟨"b","a",["s"],["s","s"]⟩
example : view (observe system table1 [] request396) = none := rfl
def request397 : Perturbation := ⟨"b","a",["s"],["s","s"]⟩
example : view (observe system table1 [request397] request397) = none := rfl
def request398 : Perturbation := ⟨"b","a",["s"],["bad"]⟩
example : view (observe system table1 [] request398) = none := rfl
def request399 : Perturbation := ⟨"b","a",["s"],["bad"]⟩
example : view (observe system table1 [request399] request399) = none := rfl
def request400 : Perturbation := ⟨"b","a",["s","s"],[]⟩
example : view (observe system table1 [] request400) = none := rfl
def request401 : Perturbation := ⟨"b","a",["s","s"],[]⟩
example : view (observe system table1 [request401] request401) = none := rfl
def request402 : Perturbation := ⟨"b","a",["s","s"],["s"]⟩
example : view (observe system table1 [] request402) = none := rfl
def request403 : Perturbation := ⟨"b","a",["s","s"],["s"]⟩
example : view (observe system table1 [request403] request403) = none := rfl
def request404 : Perturbation := ⟨"b","a",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request404) = none := rfl
def request405 : Perturbation := ⟨"b","a",["s","s"],["s","s"]⟩
example : view (observe system table1 [request405] request405) = none := rfl
def request406 : Perturbation := ⟨"b","a",["s","s"],["bad"]⟩
example : view (observe system table1 [] request406) = none := rfl
def request407 : Perturbation := ⟨"b","a",["s","s"],["bad"]⟩
example : view (observe system table1 [request407] request407) = none := rfl
def request408 : Perturbation := ⟨"b","a",["bad"],[]⟩
example : view (observe system table1 [] request408) = none := rfl
def request409 : Perturbation := ⟨"b","a",["bad"],[]⟩
example : view (observe system table1 [request409] request409) = none := rfl
def request410 : Perturbation := ⟨"b","a",["bad"],["s"]⟩
example : view (observe system table1 [] request410) = none := rfl
def request411 : Perturbation := ⟨"b","a",["bad"],["s"]⟩
example : view (observe system table1 [request411] request411) = none := rfl
def request412 : Perturbation := ⟨"b","a",["bad"],["s","s"]⟩
example : view (observe system table1 [] request412) = none := rfl
def request413 : Perturbation := ⟨"b","a",["bad"],["s","s"]⟩
example : view (observe system table1 [request413] request413) = none := rfl
def request414 : Perturbation := ⟨"b","a",["bad"],["bad"]⟩
example : view (observe system table1 [] request414) = none := rfl
def request415 : Perturbation := ⟨"b","a",["bad"],["bad"]⟩
example : view (observe system table1 [request415] request415) = none := rfl
def request416 : Perturbation := ⟨"b","b",[],[]⟩
example : view (observe system table1 [] request416) = none := rfl
def request417 : Perturbation := ⟨"b","b",[],[]⟩
example : view (observe system table1 [request417] request417) = some (["b"],["b"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request418 : Perturbation := ⟨"b","b",[],["s"]⟩
example : view (observe system table1 [] request418) = none := rfl
def request419 : Perturbation := ⟨"b","b",[],["s"]⟩
example : view (observe system table1 [request419] request419) = none := rfl
def request420 : Perturbation := ⟨"b","b",[],["s","s"]⟩
example : view (observe system table1 [] request420) = none := rfl
def request421 : Perturbation := ⟨"b","b",[],["s","s"]⟩
example : view (observe system table1 [request421] request421) = none := rfl
def request422 : Perturbation := ⟨"b","b",[],["bad"]⟩
example : view (observe system table1 [] request422) = none := rfl
def request423 : Perturbation := ⟨"b","b",[],["bad"]⟩
example : view (observe system table1 [request423] request423) = none := rfl
def request424 : Perturbation := ⟨"b","b",["s"],[]⟩
example : view (observe system table1 [] request424) = none := rfl
def request425 : Perturbation := ⟨"b","b",["s"],[]⟩
example : view (observe system table1 [request425] request425) = none := rfl
def request426 : Perturbation := ⟨"b","b",["s"],["s"]⟩
example : view (observe system table1 [] request426) = none := rfl
def request427 : Perturbation := ⟨"b","b",["s"],["s"]⟩
example : view (observe system table1 [request427] request427) = none := rfl
def request428 : Perturbation := ⟨"b","b",["s"],["s","s"]⟩
example : view (observe system table1 [] request428) = none := rfl
def request429 : Perturbation := ⟨"b","b",["s"],["s","s"]⟩
example : view (observe system table1 [request429] request429) = none := rfl
def request430 : Perturbation := ⟨"b","b",["s"],["bad"]⟩
example : view (observe system table1 [] request430) = none := rfl
def request431 : Perturbation := ⟨"b","b",["s"],["bad"]⟩
example : view (observe system table1 [request431] request431) = none := rfl
def request432 : Perturbation := ⟨"b","b",["s","s"],[]⟩
example : view (observe system table1 [] request432) = none := rfl
def request433 : Perturbation := ⟨"b","b",["s","s"],[]⟩
example : view (observe system table1 [request433] request433) = none := rfl
def request434 : Perturbation := ⟨"b","b",["s","s"],["s"]⟩
example : view (observe system table1 [] request434) = none := rfl
def request435 : Perturbation := ⟨"b","b",["s","s"],["s"]⟩
example : view (observe system table1 [request435] request435) = none := rfl
def request436 : Perturbation := ⟨"b","b",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request436) = none := rfl
def request437 : Perturbation := ⟨"b","b",["s","s"],["s","s"]⟩
example : view (observe system table1 [request437] request437) = none := rfl
def request438 : Perturbation := ⟨"b","b",["s","s"],["bad"]⟩
example : view (observe system table1 [] request438) = none := rfl
def request439 : Perturbation := ⟨"b","b",["s","s"],["bad"]⟩
example : view (observe system table1 [request439] request439) = none := rfl
def request440 : Perturbation := ⟨"b","b",["bad"],[]⟩
example : view (observe system table1 [] request440) = none := rfl
def request441 : Perturbation := ⟨"b","b",["bad"],[]⟩
example : view (observe system table1 [request441] request441) = none := rfl
def request442 : Perturbation := ⟨"b","b",["bad"],["s"]⟩
example : view (observe system table1 [] request442) = none := rfl
def request443 : Perturbation := ⟨"b","b",["bad"],["s"]⟩
example : view (observe system table1 [request443] request443) = none := rfl
def request444 : Perturbation := ⟨"b","b",["bad"],["s","s"]⟩
example : view (observe system table1 [] request444) = none := rfl
def request445 : Perturbation := ⟨"b","b",["bad"],["s","s"]⟩
example : view (observe system table1 [request445] request445) = none := rfl
def request446 : Perturbation := ⟨"b","b",["bad"],["bad"]⟩
example : view (observe system table1 [] request446) = none := rfl
def request447 : Perturbation := ⟨"b","b",["bad"],["bad"]⟩
example : view (observe system table1 [request447] request447) = none := rfl
def request448 : Perturbation := ⟨"b","outside",[],[]⟩
example : view (observe system table1 [] request448) = none := rfl
def request449 : Perturbation := ⟨"b","outside",[],[]⟩
example : view (observe system table1 [request449] request449) = none := rfl
def request450 : Perturbation := ⟨"b","outside",[],["s"]⟩
example : view (observe system table1 [] request450) = none := rfl
def request451 : Perturbation := ⟨"b","outside",[],["s"]⟩
example : view (observe system table1 [request451] request451) = none := rfl
def request452 : Perturbation := ⟨"b","outside",[],["s","s"]⟩
example : view (observe system table1 [] request452) = none := rfl
def request453 : Perturbation := ⟨"b","outside",[],["s","s"]⟩
example : view (observe system table1 [request453] request453) = none := rfl
def request454 : Perturbation := ⟨"b","outside",[],["bad"]⟩
example : view (observe system table1 [] request454) = none := rfl
def request455 : Perturbation := ⟨"b","outside",[],["bad"]⟩
example : view (observe system table1 [request455] request455) = none := rfl
def request456 : Perturbation := ⟨"b","outside",["s"],[]⟩
example : view (observe system table1 [] request456) = none := rfl
def request457 : Perturbation := ⟨"b","outside",["s"],[]⟩
example : view (observe system table1 [request457] request457) = none := rfl
def request458 : Perturbation := ⟨"b","outside",["s"],["s"]⟩
example : view (observe system table1 [] request458) = none := rfl
def request459 : Perturbation := ⟨"b","outside",["s"],["s"]⟩
example : view (observe system table1 [request459] request459) = none := rfl
def request460 : Perturbation := ⟨"b","outside",["s"],["s","s"]⟩
example : view (observe system table1 [] request460) = none := rfl
def request461 : Perturbation := ⟨"b","outside",["s"],["s","s"]⟩
example : view (observe system table1 [request461] request461) = none := rfl
def request462 : Perturbation := ⟨"b","outside",["s"],["bad"]⟩
example : view (observe system table1 [] request462) = none := rfl
def request463 : Perturbation := ⟨"b","outside",["s"],["bad"]⟩
example : view (observe system table1 [request463] request463) = none := rfl
def request464 : Perturbation := ⟨"b","outside",["s","s"],[]⟩
example : view (observe system table1 [] request464) = none := rfl
def request465 : Perturbation := ⟨"b","outside",["s","s"],[]⟩
example : view (observe system table1 [request465] request465) = none := rfl
def request466 : Perturbation := ⟨"b","outside",["s","s"],["s"]⟩
example : view (observe system table1 [] request466) = none := rfl
def request467 : Perturbation := ⟨"b","outside",["s","s"],["s"]⟩
example : view (observe system table1 [request467] request467) = none := rfl
def request468 : Perturbation := ⟨"b","outside",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request468) = none := rfl
def request469 : Perturbation := ⟨"b","outside",["s","s"],["s","s"]⟩
example : view (observe system table1 [request469] request469) = none := rfl
def request470 : Perturbation := ⟨"b","outside",["s","s"],["bad"]⟩
example : view (observe system table1 [] request470) = none := rfl
def request471 : Perturbation := ⟨"b","outside",["s","s"],["bad"]⟩
example : view (observe system table1 [request471] request471) = none := rfl
def request472 : Perturbation := ⟨"b","outside",["bad"],[]⟩
example : view (observe system table1 [] request472) = none := rfl
def request473 : Perturbation := ⟨"b","outside",["bad"],[]⟩
example : view (observe system table1 [request473] request473) = none := rfl
def request474 : Perturbation := ⟨"b","outside",["bad"],["s"]⟩
example : view (observe system table1 [] request474) = none := rfl
def request475 : Perturbation := ⟨"b","outside",["bad"],["s"]⟩
example : view (observe system table1 [request475] request475) = none := rfl
def request476 : Perturbation := ⟨"b","outside",["bad"],["s","s"]⟩
example : view (observe system table1 [] request476) = none := rfl
def request477 : Perturbation := ⟨"b","outside",["bad"],["s","s"]⟩
example : view (observe system table1 [request477] request477) = none := rfl
def request478 : Perturbation := ⟨"b","outside",["bad"],["bad"]⟩
example : view (observe system table1 [] request478) = none := rfl
def request479 : Perturbation := ⟨"b","outside",["bad"],["bad"]⟩
example : view (observe system table1 [request479] request479) = none := rfl
def request480 : Perturbation := ⟨"outside","a",[],[]⟩
example : view (observe system table1 [] request480) = none := rfl
def request481 : Perturbation := ⟨"outside","a",[],[]⟩
example : view (observe system table1 [request481] request481) = none := rfl
def request482 : Perturbation := ⟨"outside","a",[],["s"]⟩
example : view (observe system table1 [] request482) = none := rfl
def request483 : Perturbation := ⟨"outside","a",[],["s"]⟩
example : view (observe system table1 [request483] request483) = none := rfl
def request484 : Perturbation := ⟨"outside","a",[],["s","s"]⟩
example : view (observe system table1 [] request484) = none := rfl
def request485 : Perturbation := ⟨"outside","a",[],["s","s"]⟩
example : view (observe system table1 [request485] request485) = none := rfl
def request486 : Perturbation := ⟨"outside","a",[],["bad"]⟩
example : view (observe system table1 [] request486) = none := rfl
def request487 : Perturbation := ⟨"outside","a",[],["bad"]⟩
example : view (observe system table1 [request487] request487) = none := rfl
def request488 : Perturbation := ⟨"outside","a",["s"],[]⟩
example : view (observe system table1 [] request488) = none := rfl
def request489 : Perturbation := ⟨"outside","a",["s"],[]⟩
example : view (observe system table1 [request489] request489) = none := rfl
def request490 : Perturbation := ⟨"outside","a",["s"],["s"]⟩
example : view (observe system table1 [] request490) = none := rfl
def request491 : Perturbation := ⟨"outside","a",["s"],["s"]⟩
example : view (observe system table1 [request491] request491) = none := rfl
def request492 : Perturbation := ⟨"outside","a",["s"],["s","s"]⟩
example : view (observe system table1 [] request492) = none := rfl
def request493 : Perturbation := ⟨"outside","a",["s"],["s","s"]⟩
example : view (observe system table1 [request493] request493) = none := rfl
def request494 : Perturbation := ⟨"outside","a",["s"],["bad"]⟩
example : view (observe system table1 [] request494) = none := rfl
def request495 : Perturbation := ⟨"outside","a",["s"],["bad"]⟩
example : view (observe system table1 [request495] request495) = none := rfl
def request496 : Perturbation := ⟨"outside","a",["s","s"],[]⟩
example : view (observe system table1 [] request496) = none := rfl
def request497 : Perturbation := ⟨"outside","a",["s","s"],[]⟩
example : view (observe system table1 [request497] request497) = none := rfl
def request498 : Perturbation := ⟨"outside","a",["s","s"],["s"]⟩
example : view (observe system table1 [] request498) = none := rfl
def request499 : Perturbation := ⟨"outside","a",["s","s"],["s"]⟩
example : view (observe system table1 [request499] request499) = none := rfl
def request500 : Perturbation := ⟨"outside","a",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request500) = none := rfl
def request501 : Perturbation := ⟨"outside","a",["s","s"],["s","s"]⟩
example : view (observe system table1 [request501] request501) = none := rfl
def request502 : Perturbation := ⟨"outside","a",["s","s"],["bad"]⟩
example : view (observe system table1 [] request502) = none := rfl
def request503 : Perturbation := ⟨"outside","a",["s","s"],["bad"]⟩
example : view (observe system table1 [request503] request503) = none := rfl
def request504 : Perturbation := ⟨"outside","a",["bad"],[]⟩
example : view (observe system table1 [] request504) = none := rfl
def request505 : Perturbation := ⟨"outside","a",["bad"],[]⟩
example : view (observe system table1 [request505] request505) = none := rfl
def request506 : Perturbation := ⟨"outside","a",["bad"],["s"]⟩
example : view (observe system table1 [] request506) = none := rfl
def request507 : Perturbation := ⟨"outside","a",["bad"],["s"]⟩
example : view (observe system table1 [request507] request507) = none := rfl
def request508 : Perturbation := ⟨"outside","a",["bad"],["s","s"]⟩
example : view (observe system table1 [] request508) = none := rfl
def request509 : Perturbation := ⟨"outside","a",["bad"],["s","s"]⟩
example : view (observe system table1 [request509] request509) = none := rfl
def request510 : Perturbation := ⟨"outside","a",["bad"],["bad"]⟩
example : view (observe system table1 [] request510) = none := rfl
def request511 : Perturbation := ⟨"outside","a",["bad"],["bad"]⟩
example : view (observe system table1 [request511] request511) = none := rfl
def request512 : Perturbation := ⟨"outside","b",[],[]⟩
example : view (observe system table1 [] request512) = none := rfl
def request513 : Perturbation := ⟨"outside","b",[],[]⟩
example : view (observe system table1 [request513] request513) = none := rfl
def request514 : Perturbation := ⟨"outside","b",[],["s"]⟩
example : view (observe system table1 [] request514) = none := rfl
def request515 : Perturbation := ⟨"outside","b",[],["s"]⟩
example : view (observe system table1 [request515] request515) = none := rfl
def request516 : Perturbation := ⟨"outside","b",[],["s","s"]⟩
example : view (observe system table1 [] request516) = none := rfl
def request517 : Perturbation := ⟨"outside","b",[],["s","s"]⟩
example : view (observe system table1 [request517] request517) = none := rfl
def request518 : Perturbation := ⟨"outside","b",[],["bad"]⟩
example : view (observe system table1 [] request518) = none := rfl
def request519 : Perturbation := ⟨"outside","b",[],["bad"]⟩
example : view (observe system table1 [request519] request519) = none := rfl
def request520 : Perturbation := ⟨"outside","b",["s"],[]⟩
example : view (observe system table1 [] request520) = none := rfl
def request521 : Perturbation := ⟨"outside","b",["s"],[]⟩
example : view (observe system table1 [request521] request521) = none := rfl
def request522 : Perturbation := ⟨"outside","b",["s"],["s"]⟩
example : view (observe system table1 [] request522) = none := rfl
def request523 : Perturbation := ⟨"outside","b",["s"],["s"]⟩
example : view (observe system table1 [request523] request523) = none := rfl
def request524 : Perturbation := ⟨"outside","b",["s"],["s","s"]⟩
example : view (observe system table1 [] request524) = none := rfl
def request525 : Perturbation := ⟨"outside","b",["s"],["s","s"]⟩
example : view (observe system table1 [request525] request525) = none := rfl
def request526 : Perturbation := ⟨"outside","b",["s"],["bad"]⟩
example : view (observe system table1 [] request526) = none := rfl
def request527 : Perturbation := ⟨"outside","b",["s"],["bad"]⟩
example : view (observe system table1 [request527] request527) = none := rfl
def request528 : Perturbation := ⟨"outside","b",["s","s"],[]⟩
example : view (observe system table1 [] request528) = none := rfl
def request529 : Perturbation := ⟨"outside","b",["s","s"],[]⟩
example : view (observe system table1 [request529] request529) = none := rfl
def request530 : Perturbation := ⟨"outside","b",["s","s"],["s"]⟩
example : view (observe system table1 [] request530) = none := rfl
def request531 : Perturbation := ⟨"outside","b",["s","s"],["s"]⟩
example : view (observe system table1 [request531] request531) = none := rfl
def request532 : Perturbation := ⟨"outside","b",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request532) = none := rfl
def request533 : Perturbation := ⟨"outside","b",["s","s"],["s","s"]⟩
example : view (observe system table1 [request533] request533) = none := rfl
def request534 : Perturbation := ⟨"outside","b",["s","s"],["bad"]⟩
example : view (observe system table1 [] request534) = none := rfl
def request535 : Perturbation := ⟨"outside","b",["s","s"],["bad"]⟩
example : view (observe system table1 [request535] request535) = none := rfl
def request536 : Perturbation := ⟨"outside","b",["bad"],[]⟩
example : view (observe system table1 [] request536) = none := rfl
def request537 : Perturbation := ⟨"outside","b",["bad"],[]⟩
example : view (observe system table1 [request537] request537) = none := rfl
def request538 : Perturbation := ⟨"outside","b",["bad"],["s"]⟩
example : view (observe system table1 [] request538) = none := rfl
def request539 : Perturbation := ⟨"outside","b",["bad"],["s"]⟩
example : view (observe system table1 [request539] request539) = none := rfl
def request540 : Perturbation := ⟨"outside","b",["bad"],["s","s"]⟩
example : view (observe system table1 [] request540) = none := rfl
def request541 : Perturbation := ⟨"outside","b",["bad"],["s","s"]⟩
example : view (observe system table1 [request541] request541) = none := rfl
def request542 : Perturbation := ⟨"outside","b",["bad"],["bad"]⟩
example : view (observe system table1 [] request542) = none := rfl
def request543 : Perturbation := ⟨"outside","b",["bad"],["bad"]⟩
example : view (observe system table1 [request543] request543) = none := rfl
def request544 : Perturbation := ⟨"outside","outside",[],[]⟩
example : view (observe system table1 [] request544) = none := rfl
def request545 : Perturbation := ⟨"outside","outside",[],[]⟩
example : view (observe system table1 [request545] request545) = none := rfl
def request546 : Perturbation := ⟨"outside","outside",[],["s"]⟩
example : view (observe system table1 [] request546) = none := rfl
def request547 : Perturbation := ⟨"outside","outside",[],["s"]⟩
example : view (observe system table1 [request547] request547) = none := rfl
def request548 : Perturbation := ⟨"outside","outside",[],["s","s"]⟩
example : view (observe system table1 [] request548) = none := rfl
def request549 : Perturbation := ⟨"outside","outside",[],["s","s"]⟩
example : view (observe system table1 [request549] request549) = none := rfl
def request550 : Perturbation := ⟨"outside","outside",[],["bad"]⟩
example : view (observe system table1 [] request550) = none := rfl
def request551 : Perturbation := ⟨"outside","outside",[],["bad"]⟩
example : view (observe system table1 [request551] request551) = none := rfl
def request552 : Perturbation := ⟨"outside","outside",["s"],[]⟩
example : view (observe system table1 [] request552) = none := rfl
def request553 : Perturbation := ⟨"outside","outside",["s"],[]⟩
example : view (observe system table1 [request553] request553) = none := rfl
def request554 : Perturbation := ⟨"outside","outside",["s"],["s"]⟩
example : view (observe system table1 [] request554) = none := rfl
def request555 : Perturbation := ⟨"outside","outside",["s"],["s"]⟩
example : view (observe system table1 [request555] request555) = none := rfl
def request556 : Perturbation := ⟨"outside","outside",["s"],["s","s"]⟩
example : view (observe system table1 [] request556) = none := rfl
def request557 : Perturbation := ⟨"outside","outside",["s"],["s","s"]⟩
example : view (observe system table1 [request557] request557) = none := rfl
def request558 : Perturbation := ⟨"outside","outside",["s"],["bad"]⟩
example : view (observe system table1 [] request558) = none := rfl
def request559 : Perturbation := ⟨"outside","outside",["s"],["bad"]⟩
example : view (observe system table1 [request559] request559) = none := rfl
def request560 : Perturbation := ⟨"outside","outside",["s","s"],[]⟩
example : view (observe system table1 [] request560) = none := rfl
def request561 : Perturbation := ⟨"outside","outside",["s","s"],[]⟩
example : view (observe system table1 [request561] request561) = none := rfl
def request562 : Perturbation := ⟨"outside","outside",["s","s"],["s"]⟩
example : view (observe system table1 [] request562) = none := rfl
def request563 : Perturbation := ⟨"outside","outside",["s","s"],["s"]⟩
example : view (observe system table1 [request563] request563) = none := rfl
def request564 : Perturbation := ⟨"outside","outside",["s","s"],["s","s"]⟩
example : view (observe system table1 [] request564) = none := rfl
def request565 : Perturbation := ⟨"outside","outside",["s","s"],["s","s"]⟩
example : view (observe system table1 [request565] request565) = none := rfl
def request566 : Perturbation := ⟨"outside","outside",["s","s"],["bad"]⟩
example : view (observe system table1 [] request566) = none := rfl
def request567 : Perturbation := ⟨"outside","outside",["s","s"],["bad"]⟩
example : view (observe system table1 [request567] request567) = none := rfl
def request568 : Perturbation := ⟨"outside","outside",["bad"],[]⟩
example : view (observe system table1 [] request568) = none := rfl
def request569 : Perturbation := ⟨"outside","outside",["bad"],[]⟩
example : view (observe system table1 [request569] request569) = none := rfl
def request570 : Perturbation := ⟨"outside","outside",["bad"],["s"]⟩
example : view (observe system table1 [] request570) = none := rfl
def request571 : Perturbation := ⟨"outside","outside",["bad"],["s"]⟩
example : view (observe system table1 [request571] request571) = none := rfl
def request572 : Perturbation := ⟨"outside","outside",["bad"],["s","s"]⟩
example : view (observe system table1 [] request572) = none := rfl
def request573 : Perturbation := ⟨"outside","outside",["bad"],["s","s"]⟩
example : view (observe system table1 [request573] request573) = none := rfl
def request574 : Perturbation := ⟨"outside","outside",["bad"],["bad"]⟩
example : view (observe system table1 [] request574) = none := rfl
def request575 : Perturbation := ⟨"outside","outside",["bad"],["bad"]⟩
example : view (observe system table1 [request575] request575) = none := rfl
def request576 : Perturbation := ⟨"a","a",[],[]⟩
example : view (observe system table2 [] request576) = none := rfl
def request577 : Perturbation := ⟨"a","a",[],[]⟩
example : view (observe system table2 [request577] request577) = some (["a"],["a"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request578 : Perturbation := ⟨"a","a",[],["s"]⟩
example : view (observe system table2 [] request578) = none := rfl
def request579 : Perturbation := ⟨"a","a",[],["s"]⟩
example : view (observe system table2 [request579] request579) = none := rfl
def request580 : Perturbation := ⟨"a","a",[],["s","s"]⟩
example : view (observe system table2 [] request580) = none := rfl
def request581 : Perturbation := ⟨"a","a",[],["s","s"]⟩
example : view (observe system table2 [request581] request581) = some (["a"],["a","b","c"],[("cell-1",1,1,"equal")],[("cell-1",1,6,"held-above")]) := rfl
def request582 : Perturbation := ⟨"a","a",[],["bad"]⟩
example : view (observe system table2 [] request582) = none := rfl
def request583 : Perturbation := ⟨"a","a",[],["bad"]⟩
example : view (observe system table2 [request583] request583) = none := rfl
def request584 : Perturbation := ⟨"a","a",["s"],[]⟩
example : view (observe system table2 [] request584) = none := rfl
def request585 : Perturbation := ⟨"a","a",["s"],[]⟩
example : view (observe system table2 [request585] request585) = none := rfl
def request586 : Perturbation := ⟨"a","a",["s"],["s"]⟩
example : view (observe system table2 [] request586) = none := rfl
def request587 : Perturbation := ⟨"a","a",["s"],["s"]⟩
example : view (observe system table2 [request587] request587) = none := rfl
def request588 : Perturbation := ⟨"a","a",["s"],["s","s"]⟩
example : view (observe system table2 [] request588) = none := rfl
def request589 : Perturbation := ⟨"a","a",["s"],["s","s"]⟩
example : view (observe system table2 [request589] request589) = none := rfl
def request590 : Perturbation := ⟨"a","a",["s"],["bad"]⟩
example : view (observe system table2 [] request590) = none := rfl
def request591 : Perturbation := ⟨"a","a",["s"],["bad"]⟩
example : view (observe system table2 [request591] request591) = none := rfl
def request592 : Perturbation := ⟨"a","a",["s","s"],[]⟩
example : view (observe system table2 [] request592) = none := rfl
def request593 : Perturbation := ⟨"a","a",["s","s"],[]⟩
example : view (observe system table2 [request593] request593) = some (["a","b","c"],["a"],[("cell-1",1,1,"equal")],[("cell-1",1,6,"held-below")]) := rfl
def request594 : Perturbation := ⟨"a","a",["s","s"],["s"]⟩
example : view (observe system table2 [] request594) = none := rfl
def request595 : Perturbation := ⟨"a","a",["s","s"],["s"]⟩
example : view (observe system table2 [request595] request595) = none := rfl
def request596 : Perturbation := ⟨"a","a",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request596) = none := rfl
def request597 : Perturbation := ⟨"a","a",["s","s"],["s","s"]⟩
example : view (observe system table2 [request597] request597) = some (["a","b","c"],["a","b","c"],[("cell-1",1,1,"equal")],[("cell-1",1,1,"equal")]) := rfl
def request598 : Perturbation := ⟨"a","a",["s","s"],["bad"]⟩
example : view (observe system table2 [] request598) = none := rfl
def request599 : Perturbation := ⟨"a","a",["s","s"],["bad"]⟩
example : view (observe system table2 [request599] request599) = none := rfl
def request600 : Perturbation := ⟨"a","a",["bad"],[]⟩
example : view (observe system table2 [] request600) = none := rfl
def request601 : Perturbation := ⟨"a","a",["bad"],[]⟩
example : view (observe system table2 [request601] request601) = none := rfl
def request602 : Perturbation := ⟨"a","a",["bad"],["s"]⟩
example : view (observe system table2 [] request602) = none := rfl
def request603 : Perturbation := ⟨"a","a",["bad"],["s"]⟩
example : view (observe system table2 [request603] request603) = none := rfl
def request604 : Perturbation := ⟨"a","a",["bad"],["s","s"]⟩
example : view (observe system table2 [] request604) = none := rfl
def request605 : Perturbation := ⟨"a","a",["bad"],["s","s"]⟩
example : view (observe system table2 [request605] request605) = none := rfl
def request606 : Perturbation := ⟨"a","a",["bad"],["bad"]⟩
example : view (observe system table2 [] request606) = none := rfl
def request607 : Perturbation := ⟨"a","a",["bad"],["bad"]⟩
example : view (observe system table2 [request607] request607) = none := rfl
def request608 : Perturbation := ⟨"a","b",[],[]⟩
example : view (observe system table2 [] request608) = none := rfl
def request609 : Perturbation := ⟨"a","b",[],[]⟩
example : view (observe system table2 [request609] request609) = none := rfl
def request610 : Perturbation := ⟨"a","b",[],["s"]⟩
example : view (observe system table2 [] request610) = none := rfl
def request611 : Perturbation := ⟨"a","b",[],["s"]⟩
example : view (observe system table2 [request611] request611) = none := rfl
def request612 : Perturbation := ⟨"a","b",[],["s","s"]⟩
example : view (observe system table2 [] request612) = none := rfl
def request613 : Perturbation := ⟨"a","b",[],["s","s"]⟩
example : view (observe system table2 [request613] request613) = none := rfl
def request614 : Perturbation := ⟨"a","b",[],["bad"]⟩
example : view (observe system table2 [] request614) = none := rfl
def request615 : Perturbation := ⟨"a","b",[],["bad"]⟩
example : view (observe system table2 [request615] request615) = none := rfl
def request616 : Perturbation := ⟨"a","b",["s"],[]⟩
example : view (observe system table2 [] request616) = none := rfl
def request617 : Perturbation := ⟨"a","b",["s"],[]⟩
example : view (observe system table2 [request617] request617) = none := rfl
def request618 : Perturbation := ⟨"a","b",["s"],["s"]⟩
example : view (observe system table2 [] request618) = none := rfl
def request619 : Perturbation := ⟨"a","b",["s"],["s"]⟩
example : view (observe system table2 [request619] request619) = none := rfl
def request620 : Perturbation := ⟨"a","b",["s"],["s","s"]⟩
example : view (observe system table2 [] request620) = none := rfl
def request621 : Perturbation := ⟨"a","b",["s"],["s","s"]⟩
example : view (observe system table2 [request621] request621) = none := rfl
def request622 : Perturbation := ⟨"a","b",["s"],["bad"]⟩
example : view (observe system table2 [] request622) = none := rfl
def request623 : Perturbation := ⟨"a","b",["s"],["bad"]⟩
example : view (observe system table2 [request623] request623) = none := rfl
def request624 : Perturbation := ⟨"a","b",["s","s"],[]⟩
example : view (observe system table2 [] request624) = none := rfl
def request625 : Perturbation := ⟨"a","b",["s","s"],[]⟩
example : view (observe system table2 [request625] request625) = none := rfl
def request626 : Perturbation := ⟨"a","b",["s","s"],["s"]⟩
example : view (observe system table2 [] request626) = none := rfl
def request627 : Perturbation := ⟨"a","b",["s","s"],["s"]⟩
example : view (observe system table2 [request627] request627) = none := rfl
def request628 : Perturbation := ⟨"a","b",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request628) = none := rfl
def request629 : Perturbation := ⟨"a","b",["s","s"],["s","s"]⟩
example : view (observe system table2 [request629] request629) = none := rfl
def request630 : Perturbation := ⟨"a","b",["s","s"],["bad"]⟩
example : view (observe system table2 [] request630) = none := rfl
def request631 : Perturbation := ⟨"a","b",["s","s"],["bad"]⟩
example : view (observe system table2 [request631] request631) = none := rfl
def request632 : Perturbation := ⟨"a","b",["bad"],[]⟩
example : view (observe system table2 [] request632) = none := rfl
def request633 : Perturbation := ⟨"a","b",["bad"],[]⟩
example : view (observe system table2 [request633] request633) = none := rfl
def request634 : Perturbation := ⟨"a","b",["bad"],["s"]⟩
example : view (observe system table2 [] request634) = none := rfl
def request635 : Perturbation := ⟨"a","b",["bad"],["s"]⟩
example : view (observe system table2 [request635] request635) = none := rfl
def request636 : Perturbation := ⟨"a","b",["bad"],["s","s"]⟩
example : view (observe system table2 [] request636) = none := rfl
def request637 : Perturbation := ⟨"a","b",["bad"],["s","s"]⟩
example : view (observe system table2 [request637] request637) = none := rfl
def request638 : Perturbation := ⟨"a","b",["bad"],["bad"]⟩
example : view (observe system table2 [] request638) = none := rfl
def request639 : Perturbation := ⟨"a","b",["bad"],["bad"]⟩
example : view (observe system table2 [request639] request639) = none := rfl
def request640 : Perturbation := ⟨"a","outside",[],[]⟩
example : view (observe system table2 [] request640) = none := rfl
def request641 : Perturbation := ⟨"a","outside",[],[]⟩
example : view (observe system table2 [request641] request641) = none := rfl
def request642 : Perturbation := ⟨"a","outside",[],["s"]⟩
example : view (observe system table2 [] request642) = none := rfl
def request643 : Perturbation := ⟨"a","outside",[],["s"]⟩
example : view (observe system table2 [request643] request643) = none := rfl
def request644 : Perturbation := ⟨"a","outside",[],["s","s"]⟩
example : view (observe system table2 [] request644) = none := rfl
def request645 : Perturbation := ⟨"a","outside",[],["s","s"]⟩
example : view (observe system table2 [request645] request645) = none := rfl
def request646 : Perturbation := ⟨"a","outside",[],["bad"]⟩
example : view (observe system table2 [] request646) = none := rfl
def request647 : Perturbation := ⟨"a","outside",[],["bad"]⟩
example : view (observe system table2 [request647] request647) = none := rfl
def request648 : Perturbation := ⟨"a","outside",["s"],[]⟩
example : view (observe system table2 [] request648) = none := rfl
def request649 : Perturbation := ⟨"a","outside",["s"],[]⟩
example : view (observe system table2 [request649] request649) = none := rfl
def request650 : Perturbation := ⟨"a","outside",["s"],["s"]⟩
example : view (observe system table2 [] request650) = none := rfl
def request651 : Perturbation := ⟨"a","outside",["s"],["s"]⟩
example : view (observe system table2 [request651] request651) = none := rfl
def request652 : Perturbation := ⟨"a","outside",["s"],["s","s"]⟩
example : view (observe system table2 [] request652) = none := rfl
def request653 : Perturbation := ⟨"a","outside",["s"],["s","s"]⟩
example : view (observe system table2 [request653] request653) = none := rfl
def request654 : Perturbation := ⟨"a","outside",["s"],["bad"]⟩
example : view (observe system table2 [] request654) = none := rfl
def request655 : Perturbation := ⟨"a","outside",["s"],["bad"]⟩
example : view (observe system table2 [request655] request655) = none := rfl
def request656 : Perturbation := ⟨"a","outside",["s","s"],[]⟩
example : view (observe system table2 [] request656) = none := rfl
def request657 : Perturbation := ⟨"a","outside",["s","s"],[]⟩
example : view (observe system table2 [request657] request657) = none := rfl
def request658 : Perturbation := ⟨"a","outside",["s","s"],["s"]⟩
example : view (observe system table2 [] request658) = none := rfl
def request659 : Perturbation := ⟨"a","outside",["s","s"],["s"]⟩
example : view (observe system table2 [request659] request659) = none := rfl
def request660 : Perturbation := ⟨"a","outside",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request660) = none := rfl
def request661 : Perturbation := ⟨"a","outside",["s","s"],["s","s"]⟩
example : view (observe system table2 [request661] request661) = none := rfl
def request662 : Perturbation := ⟨"a","outside",["s","s"],["bad"]⟩
example : view (observe system table2 [] request662) = none := rfl
def request663 : Perturbation := ⟨"a","outside",["s","s"],["bad"]⟩
example : view (observe system table2 [request663] request663) = none := rfl
def request664 : Perturbation := ⟨"a","outside",["bad"],[]⟩
example : view (observe system table2 [] request664) = none := rfl
def request665 : Perturbation := ⟨"a","outside",["bad"],[]⟩
example : view (observe system table2 [request665] request665) = none := rfl
def request666 : Perturbation := ⟨"a","outside",["bad"],["s"]⟩
example : view (observe system table2 [] request666) = none := rfl
def request667 : Perturbation := ⟨"a","outside",["bad"],["s"]⟩
example : view (observe system table2 [request667] request667) = none := rfl
def request668 : Perturbation := ⟨"a","outside",["bad"],["s","s"]⟩
example : view (observe system table2 [] request668) = none := rfl
def request669 : Perturbation := ⟨"a","outside",["bad"],["s","s"]⟩
example : view (observe system table2 [request669] request669) = none := rfl
def request670 : Perturbation := ⟨"a","outside",["bad"],["bad"]⟩
example : view (observe system table2 [] request670) = none := rfl
def request671 : Perturbation := ⟨"a","outside",["bad"],["bad"]⟩
example : view (observe system table2 [request671] request671) = none := rfl
def request672 : Perturbation := ⟨"b","a",[],[]⟩
example : view (observe system table2 [] request672) = none := rfl
def request673 : Perturbation := ⟨"b","a",[],[]⟩
example : view (observe system table2 [request673] request673) = none := rfl
def request674 : Perturbation := ⟨"b","a",[],["s"]⟩
example : view (observe system table2 [] request674) = none := rfl
def request675 : Perturbation := ⟨"b","a",[],["s"]⟩
example : view (observe system table2 [request675] request675) = none := rfl
def request676 : Perturbation := ⟨"b","a",[],["s","s"]⟩
example : view (observe system table2 [] request676) = none := rfl
def request677 : Perturbation := ⟨"b","a",[],["s","s"]⟩
example : view (observe system table2 [request677] request677) = none := rfl
def request678 : Perturbation := ⟨"b","a",[],["bad"]⟩
example : view (observe system table2 [] request678) = none := rfl
def request679 : Perturbation := ⟨"b","a",[],["bad"]⟩
example : view (observe system table2 [request679] request679) = none := rfl
def request680 : Perturbation := ⟨"b","a",["s"],[]⟩
example : view (observe system table2 [] request680) = none := rfl
def request681 : Perturbation := ⟨"b","a",["s"],[]⟩
example : view (observe system table2 [request681] request681) = none := rfl
def request682 : Perturbation := ⟨"b","a",["s"],["s"]⟩
example : view (observe system table2 [] request682) = none := rfl
def request683 : Perturbation := ⟨"b","a",["s"],["s"]⟩
example : view (observe system table2 [request683] request683) = none := rfl
def request684 : Perturbation := ⟨"b","a",["s"],["s","s"]⟩
example : view (observe system table2 [] request684) = none := rfl
def request685 : Perturbation := ⟨"b","a",["s"],["s","s"]⟩
example : view (observe system table2 [request685] request685) = none := rfl
def request686 : Perturbation := ⟨"b","a",["s"],["bad"]⟩
example : view (observe system table2 [] request686) = none := rfl
def request687 : Perturbation := ⟨"b","a",["s"],["bad"]⟩
example : view (observe system table2 [request687] request687) = none := rfl
def request688 : Perturbation := ⟨"b","a",["s","s"],[]⟩
example : view (observe system table2 [] request688) = none := rfl
def request689 : Perturbation := ⟨"b","a",["s","s"],[]⟩
example : view (observe system table2 [request689] request689) = none := rfl
def request690 : Perturbation := ⟨"b","a",["s","s"],["s"]⟩
example : view (observe system table2 [] request690) = none := rfl
def request691 : Perturbation := ⟨"b","a",["s","s"],["s"]⟩
example : view (observe system table2 [request691] request691) = none := rfl
def request692 : Perturbation := ⟨"b","a",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request692) = none := rfl
def request693 : Perturbation := ⟨"b","a",["s","s"],["s","s"]⟩
example : view (observe system table2 [request693] request693) = none := rfl
def request694 : Perturbation := ⟨"b","a",["s","s"],["bad"]⟩
example : view (observe system table2 [] request694) = none := rfl
def request695 : Perturbation := ⟨"b","a",["s","s"],["bad"]⟩
example : view (observe system table2 [request695] request695) = none := rfl
def request696 : Perturbation := ⟨"b","a",["bad"],[]⟩
example : view (observe system table2 [] request696) = none := rfl
def request697 : Perturbation := ⟨"b","a",["bad"],[]⟩
example : view (observe system table2 [request697] request697) = none := rfl
def request698 : Perturbation := ⟨"b","a",["bad"],["s"]⟩
example : view (observe system table2 [] request698) = none := rfl
def request699 : Perturbation := ⟨"b","a",["bad"],["s"]⟩
example : view (observe system table2 [request699] request699) = none := rfl
def request700 : Perturbation := ⟨"b","a",["bad"],["s","s"]⟩
example : view (observe system table2 [] request700) = none := rfl
def request701 : Perturbation := ⟨"b","a",["bad"],["s","s"]⟩
example : view (observe system table2 [request701] request701) = none := rfl
def request702 : Perturbation := ⟨"b","a",["bad"],["bad"]⟩
example : view (observe system table2 [] request702) = none := rfl
def request703 : Perturbation := ⟨"b","a",["bad"],["bad"]⟩
example : view (observe system table2 [request703] request703) = none := rfl
def request704 : Perturbation := ⟨"b","b",[],[]⟩
example : view (observe system table2 [] request704) = none := rfl
def request705 : Perturbation := ⟨"b","b",[],[]⟩
example : view (observe system table2 [request705] request705) = none := rfl
def request706 : Perturbation := ⟨"b","b",[],["s"]⟩
example : view (observe system table2 [] request706) = none := rfl
def request707 : Perturbation := ⟨"b","b",[],["s"]⟩
example : view (observe system table2 [request707] request707) = none := rfl
def request708 : Perturbation := ⟨"b","b",[],["s","s"]⟩
example : view (observe system table2 [] request708) = none := rfl
def request709 : Perturbation := ⟨"b","b",[],["s","s"]⟩
example : view (observe system table2 [request709] request709) = none := rfl
def request710 : Perturbation := ⟨"b","b",[],["bad"]⟩
example : view (observe system table2 [] request710) = none := rfl
def request711 : Perturbation := ⟨"b","b",[],["bad"]⟩
example : view (observe system table2 [request711] request711) = none := rfl
def request712 : Perturbation := ⟨"b","b",["s"],[]⟩
example : view (observe system table2 [] request712) = none := rfl
def request713 : Perturbation := ⟨"b","b",["s"],[]⟩
example : view (observe system table2 [request713] request713) = none := rfl
def request714 : Perturbation := ⟨"b","b",["s"],["s"]⟩
example : view (observe system table2 [] request714) = none := rfl
def request715 : Perturbation := ⟨"b","b",["s"],["s"]⟩
example : view (observe system table2 [request715] request715) = none := rfl
def request716 : Perturbation := ⟨"b","b",["s"],["s","s"]⟩
example : view (observe system table2 [] request716) = none := rfl
def request717 : Perturbation := ⟨"b","b",["s"],["s","s"]⟩
example : view (observe system table2 [request717] request717) = none := rfl
def request718 : Perturbation := ⟨"b","b",["s"],["bad"]⟩
example : view (observe system table2 [] request718) = none := rfl
def request719 : Perturbation := ⟨"b","b",["s"],["bad"]⟩
example : view (observe system table2 [request719] request719) = none := rfl
def request720 : Perturbation := ⟨"b","b",["s","s"],[]⟩
example : view (observe system table2 [] request720) = none := rfl
def request721 : Perturbation := ⟨"b","b",["s","s"],[]⟩
example : view (observe system table2 [request721] request721) = none := rfl
def request722 : Perturbation := ⟨"b","b",["s","s"],["s"]⟩
example : view (observe system table2 [] request722) = none := rfl
def request723 : Perturbation := ⟨"b","b",["s","s"],["s"]⟩
example : view (observe system table2 [request723] request723) = none := rfl
def request724 : Perturbation := ⟨"b","b",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request724) = none := rfl
def request725 : Perturbation := ⟨"b","b",["s","s"],["s","s"]⟩
example : view (observe system table2 [request725] request725) = none := rfl
def request726 : Perturbation := ⟨"b","b",["s","s"],["bad"]⟩
example : view (observe system table2 [] request726) = none := rfl
def request727 : Perturbation := ⟨"b","b",["s","s"],["bad"]⟩
example : view (observe system table2 [request727] request727) = none := rfl
def request728 : Perturbation := ⟨"b","b",["bad"],[]⟩
example : view (observe system table2 [] request728) = none := rfl
def request729 : Perturbation := ⟨"b","b",["bad"],[]⟩
example : view (observe system table2 [request729] request729) = none := rfl
def request730 : Perturbation := ⟨"b","b",["bad"],["s"]⟩
example : view (observe system table2 [] request730) = none := rfl
def request731 : Perturbation := ⟨"b","b",["bad"],["s"]⟩
example : view (observe system table2 [request731] request731) = none := rfl
def request732 : Perturbation := ⟨"b","b",["bad"],["s","s"]⟩
example : view (observe system table2 [] request732) = none := rfl
def request733 : Perturbation := ⟨"b","b",["bad"],["s","s"]⟩
example : view (observe system table2 [request733] request733) = none := rfl
def request734 : Perturbation := ⟨"b","b",["bad"],["bad"]⟩
example : view (observe system table2 [] request734) = none := rfl
def request735 : Perturbation := ⟨"b","b",["bad"],["bad"]⟩
example : view (observe system table2 [request735] request735) = none := rfl
def request736 : Perturbation := ⟨"b","outside",[],[]⟩
example : view (observe system table2 [] request736) = none := rfl
def request737 : Perturbation := ⟨"b","outside",[],[]⟩
example : view (observe system table2 [request737] request737) = none := rfl
def request738 : Perturbation := ⟨"b","outside",[],["s"]⟩
example : view (observe system table2 [] request738) = none := rfl
def request739 : Perturbation := ⟨"b","outside",[],["s"]⟩
example : view (observe system table2 [request739] request739) = none := rfl
def request740 : Perturbation := ⟨"b","outside",[],["s","s"]⟩
example : view (observe system table2 [] request740) = none := rfl
def request741 : Perturbation := ⟨"b","outside",[],["s","s"]⟩
example : view (observe system table2 [request741] request741) = none := rfl
def request742 : Perturbation := ⟨"b","outside",[],["bad"]⟩
example : view (observe system table2 [] request742) = none := rfl
def request743 : Perturbation := ⟨"b","outside",[],["bad"]⟩
example : view (observe system table2 [request743] request743) = none := rfl
def request744 : Perturbation := ⟨"b","outside",["s"],[]⟩
example : view (observe system table2 [] request744) = none := rfl
def request745 : Perturbation := ⟨"b","outside",["s"],[]⟩
example : view (observe system table2 [request745] request745) = none := rfl
def request746 : Perturbation := ⟨"b","outside",["s"],["s"]⟩
example : view (observe system table2 [] request746) = none := rfl
def request747 : Perturbation := ⟨"b","outside",["s"],["s"]⟩
example : view (observe system table2 [request747] request747) = none := rfl
def request748 : Perturbation := ⟨"b","outside",["s"],["s","s"]⟩
example : view (observe system table2 [] request748) = none := rfl
def request749 : Perturbation := ⟨"b","outside",["s"],["s","s"]⟩
example : view (observe system table2 [request749] request749) = none := rfl
def request750 : Perturbation := ⟨"b","outside",["s"],["bad"]⟩
example : view (observe system table2 [] request750) = none := rfl
def request751 : Perturbation := ⟨"b","outside",["s"],["bad"]⟩
example : view (observe system table2 [request751] request751) = none := rfl
def request752 : Perturbation := ⟨"b","outside",["s","s"],[]⟩
example : view (observe system table2 [] request752) = none := rfl
def request753 : Perturbation := ⟨"b","outside",["s","s"],[]⟩
example : view (observe system table2 [request753] request753) = none := rfl
def request754 : Perturbation := ⟨"b","outside",["s","s"],["s"]⟩
example : view (observe system table2 [] request754) = none := rfl
def request755 : Perturbation := ⟨"b","outside",["s","s"],["s"]⟩
example : view (observe system table2 [request755] request755) = none := rfl
def request756 : Perturbation := ⟨"b","outside",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request756) = none := rfl
def request757 : Perturbation := ⟨"b","outside",["s","s"],["s","s"]⟩
example : view (observe system table2 [request757] request757) = none := rfl
def request758 : Perturbation := ⟨"b","outside",["s","s"],["bad"]⟩
example : view (observe system table2 [] request758) = none := rfl
def request759 : Perturbation := ⟨"b","outside",["s","s"],["bad"]⟩
example : view (observe system table2 [request759] request759) = none := rfl
def request760 : Perturbation := ⟨"b","outside",["bad"],[]⟩
example : view (observe system table2 [] request760) = none := rfl
def request761 : Perturbation := ⟨"b","outside",["bad"],[]⟩
example : view (observe system table2 [request761] request761) = none := rfl
def request762 : Perturbation := ⟨"b","outside",["bad"],["s"]⟩
example : view (observe system table2 [] request762) = none := rfl
def request763 : Perturbation := ⟨"b","outside",["bad"],["s"]⟩
example : view (observe system table2 [request763] request763) = none := rfl
def request764 : Perturbation := ⟨"b","outside",["bad"],["s","s"]⟩
example : view (observe system table2 [] request764) = none := rfl
def request765 : Perturbation := ⟨"b","outside",["bad"],["s","s"]⟩
example : view (observe system table2 [request765] request765) = none := rfl
def request766 : Perturbation := ⟨"b","outside",["bad"],["bad"]⟩
example : view (observe system table2 [] request766) = none := rfl
def request767 : Perturbation := ⟨"b","outside",["bad"],["bad"]⟩
example : view (observe system table2 [request767] request767) = none := rfl
def request768 : Perturbation := ⟨"outside","a",[],[]⟩
example : view (observe system table2 [] request768) = none := rfl
def request769 : Perturbation := ⟨"outside","a",[],[]⟩
example : view (observe system table2 [request769] request769) = none := rfl
def request770 : Perturbation := ⟨"outside","a",[],["s"]⟩
example : view (observe system table2 [] request770) = none := rfl
def request771 : Perturbation := ⟨"outside","a",[],["s"]⟩
example : view (observe system table2 [request771] request771) = none := rfl
def request772 : Perturbation := ⟨"outside","a",[],["s","s"]⟩
example : view (observe system table2 [] request772) = none := rfl
def request773 : Perturbation := ⟨"outside","a",[],["s","s"]⟩
example : view (observe system table2 [request773] request773) = none := rfl
def request774 : Perturbation := ⟨"outside","a",[],["bad"]⟩
example : view (observe system table2 [] request774) = none := rfl
def request775 : Perturbation := ⟨"outside","a",[],["bad"]⟩
example : view (observe system table2 [request775] request775) = none := rfl
def request776 : Perturbation := ⟨"outside","a",["s"],[]⟩
example : view (observe system table2 [] request776) = none := rfl
def request777 : Perturbation := ⟨"outside","a",["s"],[]⟩
example : view (observe system table2 [request777] request777) = none := rfl
def request778 : Perturbation := ⟨"outside","a",["s"],["s"]⟩
example : view (observe system table2 [] request778) = none := rfl
def request779 : Perturbation := ⟨"outside","a",["s"],["s"]⟩
example : view (observe system table2 [request779] request779) = none := rfl
def request780 : Perturbation := ⟨"outside","a",["s"],["s","s"]⟩
example : view (observe system table2 [] request780) = none := rfl
def request781 : Perturbation := ⟨"outside","a",["s"],["s","s"]⟩
example : view (observe system table2 [request781] request781) = none := rfl
def request782 : Perturbation := ⟨"outside","a",["s"],["bad"]⟩
example : view (observe system table2 [] request782) = none := rfl
def request783 : Perturbation := ⟨"outside","a",["s"],["bad"]⟩
example : view (observe system table2 [request783] request783) = none := rfl
def request784 : Perturbation := ⟨"outside","a",["s","s"],[]⟩
example : view (observe system table2 [] request784) = none := rfl
def request785 : Perturbation := ⟨"outside","a",["s","s"],[]⟩
example : view (observe system table2 [request785] request785) = none := rfl
def request786 : Perturbation := ⟨"outside","a",["s","s"],["s"]⟩
example : view (observe system table2 [] request786) = none := rfl
def request787 : Perturbation := ⟨"outside","a",["s","s"],["s"]⟩
example : view (observe system table2 [request787] request787) = none := rfl
def request788 : Perturbation := ⟨"outside","a",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request788) = none := rfl
def request789 : Perturbation := ⟨"outside","a",["s","s"],["s","s"]⟩
example : view (observe system table2 [request789] request789) = none := rfl
def request790 : Perturbation := ⟨"outside","a",["s","s"],["bad"]⟩
example : view (observe system table2 [] request790) = none := rfl
def request791 : Perturbation := ⟨"outside","a",["s","s"],["bad"]⟩
example : view (observe system table2 [request791] request791) = none := rfl
def request792 : Perturbation := ⟨"outside","a",["bad"],[]⟩
example : view (observe system table2 [] request792) = none := rfl
def request793 : Perturbation := ⟨"outside","a",["bad"],[]⟩
example : view (observe system table2 [request793] request793) = none := rfl
def request794 : Perturbation := ⟨"outside","a",["bad"],["s"]⟩
example : view (observe system table2 [] request794) = none := rfl
def request795 : Perturbation := ⟨"outside","a",["bad"],["s"]⟩
example : view (observe system table2 [request795] request795) = none := rfl
def request796 : Perturbation := ⟨"outside","a",["bad"],["s","s"]⟩
example : view (observe system table2 [] request796) = none := rfl
def request797 : Perturbation := ⟨"outside","a",["bad"],["s","s"]⟩
example : view (observe system table2 [request797] request797) = none := rfl
def request798 : Perturbation := ⟨"outside","a",["bad"],["bad"]⟩
example : view (observe system table2 [] request798) = none := rfl
def request799 : Perturbation := ⟨"outside","a",["bad"],["bad"]⟩
example : view (observe system table2 [request799] request799) = none := rfl
def request800 : Perturbation := ⟨"outside","b",[],[]⟩
example : view (observe system table2 [] request800) = none := rfl
def request801 : Perturbation := ⟨"outside","b",[],[]⟩
example : view (observe system table2 [request801] request801) = none := rfl
def request802 : Perturbation := ⟨"outside","b",[],["s"]⟩
example : view (observe system table2 [] request802) = none := rfl
def request803 : Perturbation := ⟨"outside","b",[],["s"]⟩
example : view (observe system table2 [request803] request803) = none := rfl
def request804 : Perturbation := ⟨"outside","b",[],["s","s"]⟩
example : view (observe system table2 [] request804) = none := rfl
def request805 : Perturbation := ⟨"outside","b",[],["s","s"]⟩
example : view (observe system table2 [request805] request805) = none := rfl
def request806 : Perturbation := ⟨"outside","b",[],["bad"]⟩
example : view (observe system table2 [] request806) = none := rfl
def request807 : Perturbation := ⟨"outside","b",[],["bad"]⟩
example : view (observe system table2 [request807] request807) = none := rfl
def request808 : Perturbation := ⟨"outside","b",["s"],[]⟩
example : view (observe system table2 [] request808) = none := rfl
def request809 : Perturbation := ⟨"outside","b",["s"],[]⟩
example : view (observe system table2 [request809] request809) = none := rfl
def request810 : Perturbation := ⟨"outside","b",["s"],["s"]⟩
example : view (observe system table2 [] request810) = none := rfl
def request811 : Perturbation := ⟨"outside","b",["s"],["s"]⟩
example : view (observe system table2 [request811] request811) = none := rfl
def request812 : Perturbation := ⟨"outside","b",["s"],["s","s"]⟩
example : view (observe system table2 [] request812) = none := rfl
def request813 : Perturbation := ⟨"outside","b",["s"],["s","s"]⟩
example : view (observe system table2 [request813] request813) = none := rfl
def request814 : Perturbation := ⟨"outside","b",["s"],["bad"]⟩
example : view (observe system table2 [] request814) = none := rfl
def request815 : Perturbation := ⟨"outside","b",["s"],["bad"]⟩
example : view (observe system table2 [request815] request815) = none := rfl
def request816 : Perturbation := ⟨"outside","b",["s","s"],[]⟩
example : view (observe system table2 [] request816) = none := rfl
def request817 : Perturbation := ⟨"outside","b",["s","s"],[]⟩
example : view (observe system table2 [request817] request817) = none := rfl
def request818 : Perturbation := ⟨"outside","b",["s","s"],["s"]⟩
example : view (observe system table2 [] request818) = none := rfl
def request819 : Perturbation := ⟨"outside","b",["s","s"],["s"]⟩
example : view (observe system table2 [request819] request819) = none := rfl
def request820 : Perturbation := ⟨"outside","b",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request820) = none := rfl
def request821 : Perturbation := ⟨"outside","b",["s","s"],["s","s"]⟩
example : view (observe system table2 [request821] request821) = none := rfl
def request822 : Perturbation := ⟨"outside","b",["s","s"],["bad"]⟩
example : view (observe system table2 [] request822) = none := rfl
def request823 : Perturbation := ⟨"outside","b",["s","s"],["bad"]⟩
example : view (observe system table2 [request823] request823) = none := rfl
def request824 : Perturbation := ⟨"outside","b",["bad"],[]⟩
example : view (observe system table2 [] request824) = none := rfl
def request825 : Perturbation := ⟨"outside","b",["bad"],[]⟩
example : view (observe system table2 [request825] request825) = none := rfl
def request826 : Perturbation := ⟨"outside","b",["bad"],["s"]⟩
example : view (observe system table2 [] request826) = none := rfl
def request827 : Perturbation := ⟨"outside","b",["bad"],["s"]⟩
example : view (observe system table2 [request827] request827) = none := rfl
def request828 : Perturbation := ⟨"outside","b",["bad"],["s","s"]⟩
example : view (observe system table2 [] request828) = none := rfl
def request829 : Perturbation := ⟨"outside","b",["bad"],["s","s"]⟩
example : view (observe system table2 [request829] request829) = none := rfl
def request830 : Perturbation := ⟨"outside","b",["bad"],["bad"]⟩
example : view (observe system table2 [] request830) = none := rfl
def request831 : Perturbation := ⟨"outside","b",["bad"],["bad"]⟩
example : view (observe system table2 [request831] request831) = none := rfl
def request832 : Perturbation := ⟨"outside","outside",[],[]⟩
example : view (observe system table2 [] request832) = none := rfl
def request833 : Perturbation := ⟨"outside","outside",[],[]⟩
example : view (observe system table2 [request833] request833) = none := rfl
def request834 : Perturbation := ⟨"outside","outside",[],["s"]⟩
example : view (observe system table2 [] request834) = none := rfl
def request835 : Perturbation := ⟨"outside","outside",[],["s"]⟩
example : view (observe system table2 [request835] request835) = none := rfl
def request836 : Perturbation := ⟨"outside","outside",[],["s","s"]⟩
example : view (observe system table2 [] request836) = none := rfl
def request837 : Perturbation := ⟨"outside","outside",[],["s","s"]⟩
example : view (observe system table2 [request837] request837) = none := rfl
def request838 : Perturbation := ⟨"outside","outside",[],["bad"]⟩
example : view (observe system table2 [] request838) = none := rfl
def request839 : Perturbation := ⟨"outside","outside",[],["bad"]⟩
example : view (observe system table2 [request839] request839) = none := rfl
def request840 : Perturbation := ⟨"outside","outside",["s"],[]⟩
example : view (observe system table2 [] request840) = none := rfl
def request841 : Perturbation := ⟨"outside","outside",["s"],[]⟩
example : view (observe system table2 [request841] request841) = none := rfl
def request842 : Perturbation := ⟨"outside","outside",["s"],["s"]⟩
example : view (observe system table2 [] request842) = none := rfl
def request843 : Perturbation := ⟨"outside","outside",["s"],["s"]⟩
example : view (observe system table2 [request843] request843) = none := rfl
def request844 : Perturbation := ⟨"outside","outside",["s"],["s","s"]⟩
example : view (observe system table2 [] request844) = none := rfl
def request845 : Perturbation := ⟨"outside","outside",["s"],["s","s"]⟩
example : view (observe system table2 [request845] request845) = none := rfl
def request846 : Perturbation := ⟨"outside","outside",["s"],["bad"]⟩
example : view (observe system table2 [] request846) = none := rfl
def request847 : Perturbation := ⟨"outside","outside",["s"],["bad"]⟩
example : view (observe system table2 [request847] request847) = none := rfl
def request848 : Perturbation := ⟨"outside","outside",["s","s"],[]⟩
example : view (observe system table2 [] request848) = none := rfl
def request849 : Perturbation := ⟨"outside","outside",["s","s"],[]⟩
example : view (observe system table2 [request849] request849) = none := rfl
def request850 : Perturbation := ⟨"outside","outside",["s","s"],["s"]⟩
example : view (observe system table2 [] request850) = none := rfl
def request851 : Perturbation := ⟨"outside","outside",["s","s"],["s"]⟩
example : view (observe system table2 [request851] request851) = none := rfl
def request852 : Perturbation := ⟨"outside","outside",["s","s"],["s","s"]⟩
example : view (observe system table2 [] request852) = none := rfl
def request853 : Perturbation := ⟨"outside","outside",["s","s"],["s","s"]⟩
example : view (observe system table2 [request853] request853) = none := rfl
def request854 : Perturbation := ⟨"outside","outside",["s","s"],["bad"]⟩
example : view (observe system table2 [] request854) = none := rfl
def request855 : Perturbation := ⟨"outside","outside",["s","s"],["bad"]⟩
example : view (observe system table2 [request855] request855) = none := rfl
def request856 : Perturbation := ⟨"outside","outside",["bad"],[]⟩
example : view (observe system table2 [] request856) = none := rfl
def request857 : Perturbation := ⟨"outside","outside",["bad"],[]⟩
example : view (observe system table2 [request857] request857) = none := rfl
def request858 : Perturbation := ⟨"outside","outside",["bad"],["s"]⟩
example : view (observe system table2 [] request858) = none := rfl
def request859 : Perturbation := ⟨"outside","outside",["bad"],["s"]⟩
example : view (observe system table2 [request859] request859) = none := rfl
def request860 : Perturbation := ⟨"outside","outside",["bad"],["s","s"]⟩
example : view (observe system table2 [] request860) = none := rfl
def request861 : Perturbation := ⟨"outside","outside",["bad"],["s","s"]⟩
example : view (observe system table2 [request861] request861) = none := rfl
def request862 : Perturbation := ⟨"outside","outside",["bad"],["bad"]⟩
example : view (observe system table2 [] request862) = none := rfl
def request863 : Perturbation := ⟨"outside","outside",["bad"],["bad"]⟩
example : view (observe system table2 [request863] request863) = none := rfl

def nativeRequest : Perturbation := ⟨"a","b",["s"],["s"]⟩
def nativeRelation : List Amplification := [⟨[("cell-1",1,6,"held-below")],[("cell-1",1,3,"held-above")]⟩]
def nativeModel : Model := ⟨system,by rfl,table0,[nativeRequest],nativeRelation⟩
theorem nativeStable : outcome nativeModel nativeRequest = .stable := rfl
theorem nativeUnstable : classify [] (evaluate nativeModel nativeRequest) = .unstable := rfl
theorem nativeRejected : outcome nativeModel ⟨"a","outside",[],[]⟩ = .rejected := rfl
#print axioms nativeStable
#print axioms nativeUnstable
#print axioms nativeRejected
