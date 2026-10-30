import SFT.Computation.Simulation
open SFT.Computation.Simulation SFT.Computation.StateTransition
set_option maxRecDepth 1000000
def view (result : Option Report) := result.map fun r => (r.states,r.observations)
def system0 : System := ⟨["a","b","c"],["s","t"],[("a","s","b"),("b","s","c"),("c","s","a"),("a","t","a"),("b","t","b"),("c","t","c")]⟩
def model00 : Model := ⟨system0,by rfl,[("a","A"),("b","B"),("c","C")],by rfl⟩
def model01 : Model := ⟨system0,by rfl,[("a","same"),("b","same"),("c","same")],by rfl⟩
def model02 : Model := ⟨system0,by rfl,[("a","A"),("c","C")],by rfl⟩
def model03 : Model := ⟨system0,by rfl,[],by rfl⟩
def system1 : System := ⟨["a","b","c"],["s","t"],[("a","s","b"),("b","s","c"),("c","s","a"),("a","t","a"),("b","t","b")]⟩
def model10 : Model := ⟨system1,by rfl,[("a","A"),("b","B"),("c","C")],by rfl⟩
def model11 : Model := ⟨system1,by rfl,[("a","same"),("b","same"),("c","same")],by rfl⟩
def model12 : Model := ⟨system1,by rfl,[("a","A"),("c","C")],by rfl⟩
def model13 : Model := ⟨system1,by rfl,[],by rfl⟩
example : view (simulate model00 "a" []) = some (["a"],["A"]) := rfl
example : view (simulate model00 "a" ["s"]) = some (["a","b"],["A","B"]) := rfl
example : view (simulate model00 "a" ["t"]) = some (["a","a"],["A","A"]) := rfl
example : view (simulate model00 "a" ["bad"]) = none := rfl
example : view (simulate model00 "a" ["s","s"]) = some (["a","b","c"],["A","B","C"]) := rfl
example : view (simulate model00 "a" ["s","t"]) = some (["a","b","b"],["A","B","B"]) := rfl
example : view (simulate model00 "a" ["s","bad"]) = none := rfl
example : view (simulate model00 "a" ["t","s"]) = some (["a","a","b"],["A","A","B"]) := rfl
example : view (simulate model00 "a" ["t","t"]) = some (["a","a","a"],["A","A","A"]) := rfl
example : view (simulate model00 "a" ["t","bad"]) = none := rfl
example : view (simulate model00 "a" ["bad","s"]) = none := rfl
example : view (simulate model00 "a" ["bad","t"]) = none := rfl
example : view (simulate model00 "a" ["bad","bad"]) = none := rfl
example : view (simulate model00 "a" ["s","s","s"]) = some (["a","b","c","a"],["A","B","C","A"]) := rfl
example : view (simulate model00 "a" ["s","s","t"]) = some (["a","b","c","c"],["A","B","C","C"]) := rfl
example : view (simulate model00 "a" ["s","s","bad"]) = none := rfl
example : view (simulate model00 "a" ["s","t","s"]) = some (["a","b","b","c"],["A","B","B","C"]) := rfl
example : view (simulate model00 "a" ["s","t","t"]) = some (["a","b","b","b"],["A","B","B","B"]) := rfl
example : view (simulate model00 "a" ["s","t","bad"]) = none := rfl
example : view (simulate model00 "a" ["s","bad","s"]) = none := rfl
example : view (simulate model00 "a" ["s","bad","t"]) = none := rfl
example : view (simulate model00 "a" ["s","bad","bad"]) = none := rfl
example : view (simulate model00 "a" ["t","s","s"]) = some (["a","a","b","c"],["A","A","B","C"]) := rfl
example : view (simulate model00 "a" ["t","s","t"]) = some (["a","a","b","b"],["A","A","B","B"]) := rfl
example : view (simulate model00 "a" ["t","s","bad"]) = none := rfl
example : view (simulate model00 "a" ["t","t","s"]) = some (["a","a","a","b"],["A","A","A","B"]) := rfl
example : view (simulate model00 "a" ["t","t","t"]) = some (["a","a","a","a"],["A","A","A","A"]) := rfl
example : view (simulate model00 "a" ["t","t","bad"]) = none := rfl
example : view (simulate model00 "a" ["t","bad","s"]) = none := rfl
example : view (simulate model00 "a" ["t","bad","t"]) = none := rfl
example : view (simulate model00 "a" ["t","bad","bad"]) = none := rfl
example : view (simulate model00 "a" ["bad","s","s"]) = none := rfl
example : view (simulate model00 "a" ["bad","s","t"]) = none := rfl
example : view (simulate model00 "a" ["bad","s","bad"]) = none := rfl
example : view (simulate model00 "a" ["bad","t","s"]) = none := rfl
example : view (simulate model00 "a" ["bad","t","t"]) = none := rfl
example : view (simulate model00 "a" ["bad","t","bad"]) = none := rfl
example : view (simulate model00 "a" ["bad","bad","s"]) = none := rfl
example : view (simulate model00 "a" ["bad","bad","t"]) = none := rfl
example : view (simulate model00 "a" ["bad","bad","bad"]) = none := rfl
example : view (simulate model00 "b" []) = some (["b"],["B"]) := rfl
example : view (simulate model00 "b" ["s"]) = some (["b","c"],["B","C"]) := rfl
example : view (simulate model00 "b" ["t"]) = some (["b","b"],["B","B"]) := rfl
example : view (simulate model00 "b" ["bad"]) = none := rfl
example : view (simulate model00 "b" ["s","s"]) = some (["b","c","a"],["B","C","A"]) := rfl
example : view (simulate model00 "b" ["s","t"]) = some (["b","c","c"],["B","C","C"]) := rfl
example : view (simulate model00 "b" ["s","bad"]) = none := rfl
example : view (simulate model00 "b" ["t","s"]) = some (["b","b","c"],["B","B","C"]) := rfl
example : view (simulate model00 "b" ["t","t"]) = some (["b","b","b"],["B","B","B"]) := rfl
example : view (simulate model00 "b" ["t","bad"]) = none := rfl
example : view (simulate model00 "b" ["bad","s"]) = none := rfl
example : view (simulate model00 "b" ["bad","t"]) = none := rfl
example : view (simulate model00 "b" ["bad","bad"]) = none := rfl
example : view (simulate model00 "b" ["s","s","s"]) = some (["b","c","a","b"],["B","C","A","B"]) := rfl
example : view (simulate model00 "b" ["s","s","t"]) = some (["b","c","a","a"],["B","C","A","A"]) := rfl
example : view (simulate model00 "b" ["s","s","bad"]) = none := rfl
example : view (simulate model00 "b" ["s","t","s"]) = some (["b","c","c","a"],["B","C","C","A"]) := rfl
example : view (simulate model00 "b" ["s","t","t"]) = some (["b","c","c","c"],["B","C","C","C"]) := rfl
example : view (simulate model00 "b" ["s","t","bad"]) = none := rfl
example : view (simulate model00 "b" ["s","bad","s"]) = none := rfl
example : view (simulate model00 "b" ["s","bad","t"]) = none := rfl
example : view (simulate model00 "b" ["s","bad","bad"]) = none := rfl
example : view (simulate model00 "b" ["t","s","s"]) = some (["b","b","c","a"],["B","B","C","A"]) := rfl
example : view (simulate model00 "b" ["t","s","t"]) = some (["b","b","c","c"],["B","B","C","C"]) := rfl
example : view (simulate model00 "b" ["t","s","bad"]) = none := rfl
example : view (simulate model00 "b" ["t","t","s"]) = some (["b","b","b","c"],["B","B","B","C"]) := rfl
example : view (simulate model00 "b" ["t","t","t"]) = some (["b","b","b","b"],["B","B","B","B"]) := rfl
example : view (simulate model00 "b" ["t","t","bad"]) = none := rfl
example : view (simulate model00 "b" ["t","bad","s"]) = none := rfl
example : view (simulate model00 "b" ["t","bad","t"]) = none := rfl
example : view (simulate model00 "b" ["t","bad","bad"]) = none := rfl
example : view (simulate model00 "b" ["bad","s","s"]) = none := rfl
example : view (simulate model00 "b" ["bad","s","t"]) = none := rfl
example : view (simulate model00 "b" ["bad","s","bad"]) = none := rfl
example : view (simulate model00 "b" ["bad","t","s"]) = none := rfl
example : view (simulate model00 "b" ["bad","t","t"]) = none := rfl
example : view (simulate model00 "b" ["bad","t","bad"]) = none := rfl
example : view (simulate model00 "b" ["bad","bad","s"]) = none := rfl
example : view (simulate model00 "b" ["bad","bad","t"]) = none := rfl
example : view (simulate model00 "b" ["bad","bad","bad"]) = none := rfl
example : view (simulate model00 "c" []) = some (["c"],["C"]) := rfl
example : view (simulate model00 "c" ["s"]) = some (["c","a"],["C","A"]) := rfl
example : view (simulate model00 "c" ["t"]) = some (["c","c"],["C","C"]) := rfl
example : view (simulate model00 "c" ["bad"]) = none := rfl
example : view (simulate model00 "c" ["s","s"]) = some (["c","a","b"],["C","A","B"]) := rfl
example : view (simulate model00 "c" ["s","t"]) = some (["c","a","a"],["C","A","A"]) := rfl
example : view (simulate model00 "c" ["s","bad"]) = none := rfl
example : view (simulate model00 "c" ["t","s"]) = some (["c","c","a"],["C","C","A"]) := rfl
example : view (simulate model00 "c" ["t","t"]) = some (["c","c","c"],["C","C","C"]) := rfl
example : view (simulate model00 "c" ["t","bad"]) = none := rfl
example : view (simulate model00 "c" ["bad","s"]) = none := rfl
example : view (simulate model00 "c" ["bad","t"]) = none := rfl
example : view (simulate model00 "c" ["bad","bad"]) = none := rfl
example : view (simulate model00 "c" ["s","s","s"]) = some (["c","a","b","c"],["C","A","B","C"]) := rfl
example : view (simulate model00 "c" ["s","s","t"]) = some (["c","a","b","b"],["C","A","B","B"]) := rfl
example : view (simulate model00 "c" ["s","s","bad"]) = none := rfl
example : view (simulate model00 "c" ["s","t","s"]) = some (["c","a","a","b"],["C","A","A","B"]) := rfl
example : view (simulate model00 "c" ["s","t","t"]) = some (["c","a","a","a"],["C","A","A","A"]) := rfl
example : view (simulate model00 "c" ["s","t","bad"]) = none := rfl
example : view (simulate model00 "c" ["s","bad","s"]) = none := rfl
example : view (simulate model00 "c" ["s","bad","t"]) = none := rfl
example : view (simulate model00 "c" ["s","bad","bad"]) = none := rfl
example : view (simulate model00 "c" ["t","s","s"]) = some (["c","c","a","b"],["C","C","A","B"]) := rfl
example : view (simulate model00 "c" ["t","s","t"]) = some (["c","c","a","a"],["C","C","A","A"]) := rfl
example : view (simulate model00 "c" ["t","s","bad"]) = none := rfl
example : view (simulate model00 "c" ["t","t","s"]) = some (["c","c","c","a"],["C","C","C","A"]) := rfl
example : view (simulate model00 "c" ["t","t","t"]) = some (["c","c","c","c"],["C","C","C","C"]) := rfl
example : view (simulate model00 "c" ["t","t","bad"]) = none := rfl
example : view (simulate model00 "c" ["t","bad","s"]) = none := rfl
example : view (simulate model00 "c" ["t","bad","t"]) = none := rfl
example : view (simulate model00 "c" ["t","bad","bad"]) = none := rfl
example : view (simulate model00 "c" ["bad","s","s"]) = none := rfl
example : view (simulate model00 "c" ["bad","s","t"]) = none := rfl
example : view (simulate model00 "c" ["bad","s","bad"]) = none := rfl
example : view (simulate model00 "c" ["bad","t","s"]) = none := rfl
example : view (simulate model00 "c" ["bad","t","t"]) = none := rfl
example : view (simulate model00 "c" ["bad","t","bad"]) = none := rfl
example : view (simulate model00 "c" ["bad","bad","s"]) = none := rfl
example : view (simulate model00 "c" ["bad","bad","t"]) = none := rfl
example : view (simulate model00 "c" ["bad","bad","bad"]) = none := rfl
example : view (simulate model00 "outside" []) = none := rfl
example : view (simulate model00 "outside" ["s"]) = none := rfl
example : view (simulate model00 "outside" ["t"]) = none := rfl
example : view (simulate model00 "outside" ["bad"]) = none := rfl
example : view (simulate model00 "outside" ["s","s"]) = none := rfl
example : view (simulate model00 "outside" ["s","t"]) = none := rfl
example : view (simulate model00 "outside" ["s","bad"]) = none := rfl
example : view (simulate model00 "outside" ["t","s"]) = none := rfl
example : view (simulate model00 "outside" ["t","t"]) = none := rfl
example : view (simulate model00 "outside" ["t","bad"]) = none := rfl
example : view (simulate model00 "outside" ["bad","s"]) = none := rfl
example : view (simulate model00 "outside" ["bad","t"]) = none := rfl
example : view (simulate model00 "outside" ["bad","bad"]) = none := rfl
example : view (simulate model00 "outside" ["s","s","s"]) = none := rfl
example : view (simulate model00 "outside" ["s","s","t"]) = none := rfl
example : view (simulate model00 "outside" ["s","s","bad"]) = none := rfl
example : view (simulate model00 "outside" ["s","t","s"]) = none := rfl
example : view (simulate model00 "outside" ["s","t","t"]) = none := rfl
example : view (simulate model00 "outside" ["s","t","bad"]) = none := rfl
example : view (simulate model00 "outside" ["s","bad","s"]) = none := rfl
example : view (simulate model00 "outside" ["s","bad","t"]) = none := rfl
example : view (simulate model00 "outside" ["s","bad","bad"]) = none := rfl
example : view (simulate model00 "outside" ["t","s","s"]) = none := rfl
example : view (simulate model00 "outside" ["t","s","t"]) = none := rfl
example : view (simulate model00 "outside" ["t","s","bad"]) = none := rfl
example : view (simulate model00 "outside" ["t","t","s"]) = none := rfl
example : view (simulate model00 "outside" ["t","t","t"]) = none := rfl
example : view (simulate model00 "outside" ["t","t","bad"]) = none := rfl
example : view (simulate model00 "outside" ["t","bad","s"]) = none := rfl
example : view (simulate model00 "outside" ["t","bad","t"]) = none := rfl
example : view (simulate model00 "outside" ["t","bad","bad"]) = none := rfl
example : view (simulate model00 "outside" ["bad","s","s"]) = none := rfl
example : view (simulate model00 "outside" ["bad","s","t"]) = none := rfl
example : view (simulate model00 "outside" ["bad","s","bad"]) = none := rfl
example : view (simulate model00 "outside" ["bad","t","s"]) = none := rfl
example : view (simulate model00 "outside" ["bad","t","t"]) = none := rfl
example : view (simulate model00 "outside" ["bad","t","bad"]) = none := rfl
example : view (simulate model00 "outside" ["bad","bad","s"]) = none := rfl
example : view (simulate model00 "outside" ["bad","bad","t"]) = none := rfl
example : view (simulate model00 "outside" ["bad","bad","bad"]) = none := rfl
example : view (simulate model01 "a" []) = some (["a"],["same"]) := rfl
example : view (simulate model01 "a" ["s"]) = some (["a","b"],["same","same"]) := rfl
example : view (simulate model01 "a" ["t"]) = some (["a","a"],["same","same"]) := rfl
example : view (simulate model01 "a" ["bad"]) = none := rfl
example : view (simulate model01 "a" ["s","s"]) = some (["a","b","c"],["same","same","same"]) := rfl
example : view (simulate model01 "a" ["s","t"]) = some (["a","b","b"],["same","same","same"]) := rfl
example : view (simulate model01 "a" ["s","bad"]) = none := rfl
example : view (simulate model01 "a" ["t","s"]) = some (["a","a","b"],["same","same","same"]) := rfl
example : view (simulate model01 "a" ["t","t"]) = some (["a","a","a"],["same","same","same"]) := rfl
example : view (simulate model01 "a" ["t","bad"]) = none := rfl
example : view (simulate model01 "a" ["bad","s"]) = none := rfl
example : view (simulate model01 "a" ["bad","t"]) = none := rfl
example : view (simulate model01 "a" ["bad","bad"]) = none := rfl
example : view (simulate model01 "a" ["s","s","s"]) = some (["a","b","c","a"],["same","same","same","same"]) := rfl
example : view (simulate model01 "a" ["s","s","t"]) = some (["a","b","c","c"],["same","same","same","same"]) := rfl
example : view (simulate model01 "a" ["s","s","bad"]) = none := rfl
example : view (simulate model01 "a" ["s","t","s"]) = some (["a","b","b","c"],["same","same","same","same"]) := rfl
example : view (simulate model01 "a" ["s","t","t"]) = some (["a","b","b","b"],["same","same","same","same"]) := rfl
example : view (simulate model01 "a" ["s","t","bad"]) = none := rfl
example : view (simulate model01 "a" ["s","bad","s"]) = none := rfl
example : view (simulate model01 "a" ["s","bad","t"]) = none := rfl
example : view (simulate model01 "a" ["s","bad","bad"]) = none := rfl
example : view (simulate model01 "a" ["t","s","s"]) = some (["a","a","b","c"],["same","same","same","same"]) := rfl
example : view (simulate model01 "a" ["t","s","t"]) = some (["a","a","b","b"],["same","same","same","same"]) := rfl
example : view (simulate model01 "a" ["t","s","bad"]) = none := rfl
example : view (simulate model01 "a" ["t","t","s"]) = some (["a","a","a","b"],["same","same","same","same"]) := rfl
example : view (simulate model01 "a" ["t","t","t"]) = some (["a","a","a","a"],["same","same","same","same"]) := rfl
example : view (simulate model01 "a" ["t","t","bad"]) = none := rfl
example : view (simulate model01 "a" ["t","bad","s"]) = none := rfl
example : view (simulate model01 "a" ["t","bad","t"]) = none := rfl
example : view (simulate model01 "a" ["t","bad","bad"]) = none := rfl
example : view (simulate model01 "a" ["bad","s","s"]) = none := rfl
example : view (simulate model01 "a" ["bad","s","t"]) = none := rfl
example : view (simulate model01 "a" ["bad","s","bad"]) = none := rfl
example : view (simulate model01 "a" ["bad","t","s"]) = none := rfl
example : view (simulate model01 "a" ["bad","t","t"]) = none := rfl
example : view (simulate model01 "a" ["bad","t","bad"]) = none := rfl
example : view (simulate model01 "a" ["bad","bad","s"]) = none := rfl
example : view (simulate model01 "a" ["bad","bad","t"]) = none := rfl
example : view (simulate model01 "a" ["bad","bad","bad"]) = none := rfl
example : view (simulate model01 "b" []) = some (["b"],["same"]) := rfl
example : view (simulate model01 "b" ["s"]) = some (["b","c"],["same","same"]) := rfl
example : view (simulate model01 "b" ["t"]) = some (["b","b"],["same","same"]) := rfl
example : view (simulate model01 "b" ["bad"]) = none := rfl
example : view (simulate model01 "b" ["s","s"]) = some (["b","c","a"],["same","same","same"]) := rfl
example : view (simulate model01 "b" ["s","t"]) = some (["b","c","c"],["same","same","same"]) := rfl
example : view (simulate model01 "b" ["s","bad"]) = none := rfl
example : view (simulate model01 "b" ["t","s"]) = some (["b","b","c"],["same","same","same"]) := rfl
example : view (simulate model01 "b" ["t","t"]) = some (["b","b","b"],["same","same","same"]) := rfl
example : view (simulate model01 "b" ["t","bad"]) = none := rfl
example : view (simulate model01 "b" ["bad","s"]) = none := rfl
example : view (simulate model01 "b" ["bad","t"]) = none := rfl
example : view (simulate model01 "b" ["bad","bad"]) = none := rfl
example : view (simulate model01 "b" ["s","s","s"]) = some (["b","c","a","b"],["same","same","same","same"]) := rfl
example : view (simulate model01 "b" ["s","s","t"]) = some (["b","c","a","a"],["same","same","same","same"]) := rfl
example : view (simulate model01 "b" ["s","s","bad"]) = none := rfl
example : view (simulate model01 "b" ["s","t","s"]) = some (["b","c","c","a"],["same","same","same","same"]) := rfl
example : view (simulate model01 "b" ["s","t","t"]) = some (["b","c","c","c"],["same","same","same","same"]) := rfl
example : view (simulate model01 "b" ["s","t","bad"]) = none := rfl
example : view (simulate model01 "b" ["s","bad","s"]) = none := rfl
example : view (simulate model01 "b" ["s","bad","t"]) = none := rfl
example : view (simulate model01 "b" ["s","bad","bad"]) = none := rfl
example : view (simulate model01 "b" ["t","s","s"]) = some (["b","b","c","a"],["same","same","same","same"]) := rfl
example : view (simulate model01 "b" ["t","s","t"]) = some (["b","b","c","c"],["same","same","same","same"]) := rfl
example : view (simulate model01 "b" ["t","s","bad"]) = none := rfl
example : view (simulate model01 "b" ["t","t","s"]) = some (["b","b","b","c"],["same","same","same","same"]) := rfl
example : view (simulate model01 "b" ["t","t","t"]) = some (["b","b","b","b"],["same","same","same","same"]) := rfl
example : view (simulate model01 "b" ["t","t","bad"]) = none := rfl
example : view (simulate model01 "b" ["t","bad","s"]) = none := rfl
example : view (simulate model01 "b" ["t","bad","t"]) = none := rfl
example : view (simulate model01 "b" ["t","bad","bad"]) = none := rfl
example : view (simulate model01 "b" ["bad","s","s"]) = none := rfl
example : view (simulate model01 "b" ["bad","s","t"]) = none := rfl
example : view (simulate model01 "b" ["bad","s","bad"]) = none := rfl
example : view (simulate model01 "b" ["bad","t","s"]) = none := rfl
example : view (simulate model01 "b" ["bad","t","t"]) = none := rfl
example : view (simulate model01 "b" ["bad","t","bad"]) = none := rfl
example : view (simulate model01 "b" ["bad","bad","s"]) = none := rfl
example : view (simulate model01 "b" ["bad","bad","t"]) = none := rfl
example : view (simulate model01 "b" ["bad","bad","bad"]) = none := rfl
example : view (simulate model01 "c" []) = some (["c"],["same"]) := rfl
example : view (simulate model01 "c" ["s"]) = some (["c","a"],["same","same"]) := rfl
example : view (simulate model01 "c" ["t"]) = some (["c","c"],["same","same"]) := rfl
example : view (simulate model01 "c" ["bad"]) = none := rfl
example : view (simulate model01 "c" ["s","s"]) = some (["c","a","b"],["same","same","same"]) := rfl
example : view (simulate model01 "c" ["s","t"]) = some (["c","a","a"],["same","same","same"]) := rfl
example : view (simulate model01 "c" ["s","bad"]) = none := rfl
example : view (simulate model01 "c" ["t","s"]) = some (["c","c","a"],["same","same","same"]) := rfl
example : view (simulate model01 "c" ["t","t"]) = some (["c","c","c"],["same","same","same"]) := rfl
example : view (simulate model01 "c" ["t","bad"]) = none := rfl
example : view (simulate model01 "c" ["bad","s"]) = none := rfl
example : view (simulate model01 "c" ["bad","t"]) = none := rfl
example : view (simulate model01 "c" ["bad","bad"]) = none := rfl
example : view (simulate model01 "c" ["s","s","s"]) = some (["c","a","b","c"],["same","same","same","same"]) := rfl
example : view (simulate model01 "c" ["s","s","t"]) = some (["c","a","b","b"],["same","same","same","same"]) := rfl
example : view (simulate model01 "c" ["s","s","bad"]) = none := rfl
example : view (simulate model01 "c" ["s","t","s"]) = some (["c","a","a","b"],["same","same","same","same"]) := rfl
example : view (simulate model01 "c" ["s","t","t"]) = some (["c","a","a","a"],["same","same","same","same"]) := rfl
example : view (simulate model01 "c" ["s","t","bad"]) = none := rfl
example : view (simulate model01 "c" ["s","bad","s"]) = none := rfl
example : view (simulate model01 "c" ["s","bad","t"]) = none := rfl
example : view (simulate model01 "c" ["s","bad","bad"]) = none := rfl
example : view (simulate model01 "c" ["t","s","s"]) = some (["c","c","a","b"],["same","same","same","same"]) := rfl
example : view (simulate model01 "c" ["t","s","t"]) = some (["c","c","a","a"],["same","same","same","same"]) := rfl
example : view (simulate model01 "c" ["t","s","bad"]) = none := rfl
example : view (simulate model01 "c" ["t","t","s"]) = some (["c","c","c","a"],["same","same","same","same"]) := rfl
example : view (simulate model01 "c" ["t","t","t"]) = some (["c","c","c","c"],["same","same","same","same"]) := rfl
example : view (simulate model01 "c" ["t","t","bad"]) = none := rfl
example : view (simulate model01 "c" ["t","bad","s"]) = none := rfl
example : view (simulate model01 "c" ["t","bad","t"]) = none := rfl
example : view (simulate model01 "c" ["t","bad","bad"]) = none := rfl
example : view (simulate model01 "c" ["bad","s","s"]) = none := rfl
example : view (simulate model01 "c" ["bad","s","t"]) = none := rfl
example : view (simulate model01 "c" ["bad","s","bad"]) = none := rfl
example : view (simulate model01 "c" ["bad","t","s"]) = none := rfl
example : view (simulate model01 "c" ["bad","t","t"]) = none := rfl
example : view (simulate model01 "c" ["bad","t","bad"]) = none := rfl
example : view (simulate model01 "c" ["bad","bad","s"]) = none := rfl
example : view (simulate model01 "c" ["bad","bad","t"]) = none := rfl
example : view (simulate model01 "c" ["bad","bad","bad"]) = none := rfl
example : view (simulate model01 "outside" []) = none := rfl
example : view (simulate model01 "outside" ["s"]) = none := rfl
example : view (simulate model01 "outside" ["t"]) = none := rfl
example : view (simulate model01 "outside" ["bad"]) = none := rfl
example : view (simulate model01 "outside" ["s","s"]) = none := rfl
example : view (simulate model01 "outside" ["s","t"]) = none := rfl
example : view (simulate model01 "outside" ["s","bad"]) = none := rfl
example : view (simulate model01 "outside" ["t","s"]) = none := rfl
example : view (simulate model01 "outside" ["t","t"]) = none := rfl
example : view (simulate model01 "outside" ["t","bad"]) = none := rfl
example : view (simulate model01 "outside" ["bad","s"]) = none := rfl
example : view (simulate model01 "outside" ["bad","t"]) = none := rfl
example : view (simulate model01 "outside" ["bad","bad"]) = none := rfl
example : view (simulate model01 "outside" ["s","s","s"]) = none := rfl
example : view (simulate model01 "outside" ["s","s","t"]) = none := rfl
example : view (simulate model01 "outside" ["s","s","bad"]) = none := rfl
example : view (simulate model01 "outside" ["s","t","s"]) = none := rfl
example : view (simulate model01 "outside" ["s","t","t"]) = none := rfl
example : view (simulate model01 "outside" ["s","t","bad"]) = none := rfl
example : view (simulate model01 "outside" ["s","bad","s"]) = none := rfl
example : view (simulate model01 "outside" ["s","bad","t"]) = none := rfl
example : view (simulate model01 "outside" ["s","bad","bad"]) = none := rfl
example : view (simulate model01 "outside" ["t","s","s"]) = none := rfl
example : view (simulate model01 "outside" ["t","s","t"]) = none := rfl
example : view (simulate model01 "outside" ["t","s","bad"]) = none := rfl
example : view (simulate model01 "outside" ["t","t","s"]) = none := rfl
example : view (simulate model01 "outside" ["t","t","t"]) = none := rfl
example : view (simulate model01 "outside" ["t","t","bad"]) = none := rfl
example : view (simulate model01 "outside" ["t","bad","s"]) = none := rfl
example : view (simulate model01 "outside" ["t","bad","t"]) = none := rfl
example : view (simulate model01 "outside" ["t","bad","bad"]) = none := rfl
example : view (simulate model01 "outside" ["bad","s","s"]) = none := rfl
example : view (simulate model01 "outside" ["bad","s","t"]) = none := rfl
example : view (simulate model01 "outside" ["bad","s","bad"]) = none := rfl
example : view (simulate model01 "outside" ["bad","t","s"]) = none := rfl
example : view (simulate model01 "outside" ["bad","t","t"]) = none := rfl
example : view (simulate model01 "outside" ["bad","t","bad"]) = none := rfl
example : view (simulate model01 "outside" ["bad","bad","s"]) = none := rfl
example : view (simulate model01 "outside" ["bad","bad","t"]) = none := rfl
example : view (simulate model01 "outside" ["bad","bad","bad"]) = none := rfl
example : view (simulate model02 "a" []) = some (["a"],["A"]) := rfl
example : view (simulate model02 "a" ["s"]) = none := rfl
example : view (simulate model02 "a" ["t"]) = some (["a","a"],["A","A"]) := rfl
example : view (simulate model02 "a" ["bad"]) = none := rfl
example : view (simulate model02 "a" ["s","s"]) = none := rfl
example : view (simulate model02 "a" ["s","t"]) = none := rfl
example : view (simulate model02 "a" ["s","bad"]) = none := rfl
example : view (simulate model02 "a" ["t","s"]) = none := rfl
example : view (simulate model02 "a" ["t","t"]) = some (["a","a","a"],["A","A","A"]) := rfl
example : view (simulate model02 "a" ["t","bad"]) = none := rfl
example : view (simulate model02 "a" ["bad","s"]) = none := rfl
example : view (simulate model02 "a" ["bad","t"]) = none := rfl
example : view (simulate model02 "a" ["bad","bad"]) = none := rfl
example : view (simulate model02 "a" ["s","s","s"]) = none := rfl
example : view (simulate model02 "a" ["s","s","t"]) = none := rfl
example : view (simulate model02 "a" ["s","s","bad"]) = none := rfl
example : view (simulate model02 "a" ["s","t","s"]) = none := rfl
example : view (simulate model02 "a" ["s","t","t"]) = none := rfl
example : view (simulate model02 "a" ["s","t","bad"]) = none := rfl
example : view (simulate model02 "a" ["s","bad","s"]) = none := rfl
example : view (simulate model02 "a" ["s","bad","t"]) = none := rfl
example : view (simulate model02 "a" ["s","bad","bad"]) = none := rfl
example : view (simulate model02 "a" ["t","s","s"]) = none := rfl
example : view (simulate model02 "a" ["t","s","t"]) = none := rfl
example : view (simulate model02 "a" ["t","s","bad"]) = none := rfl
example : view (simulate model02 "a" ["t","t","s"]) = none := rfl
example : view (simulate model02 "a" ["t","t","t"]) = some (["a","a","a","a"],["A","A","A","A"]) := rfl
example : view (simulate model02 "a" ["t","t","bad"]) = none := rfl
example : view (simulate model02 "a" ["t","bad","s"]) = none := rfl
example : view (simulate model02 "a" ["t","bad","t"]) = none := rfl
example : view (simulate model02 "a" ["t","bad","bad"]) = none := rfl
example : view (simulate model02 "a" ["bad","s","s"]) = none := rfl
example : view (simulate model02 "a" ["bad","s","t"]) = none := rfl
example : view (simulate model02 "a" ["bad","s","bad"]) = none := rfl
example : view (simulate model02 "a" ["bad","t","s"]) = none := rfl
example : view (simulate model02 "a" ["bad","t","t"]) = none := rfl
example : view (simulate model02 "a" ["bad","t","bad"]) = none := rfl
example : view (simulate model02 "a" ["bad","bad","s"]) = none := rfl
example : view (simulate model02 "a" ["bad","bad","t"]) = none := rfl
example : view (simulate model02 "a" ["bad","bad","bad"]) = none := rfl
example : view (simulate model02 "b" []) = none := rfl
example : view (simulate model02 "b" ["s"]) = none := rfl
example : view (simulate model02 "b" ["t"]) = none := rfl
example : view (simulate model02 "b" ["bad"]) = none := rfl
example : view (simulate model02 "b" ["s","s"]) = none := rfl
example : view (simulate model02 "b" ["s","t"]) = none := rfl
example : view (simulate model02 "b" ["s","bad"]) = none := rfl
example : view (simulate model02 "b" ["t","s"]) = none := rfl
example : view (simulate model02 "b" ["t","t"]) = none := rfl
example : view (simulate model02 "b" ["t","bad"]) = none := rfl
example : view (simulate model02 "b" ["bad","s"]) = none := rfl
example : view (simulate model02 "b" ["bad","t"]) = none := rfl
example : view (simulate model02 "b" ["bad","bad"]) = none := rfl
example : view (simulate model02 "b" ["s","s","s"]) = none := rfl
example : view (simulate model02 "b" ["s","s","t"]) = none := rfl
example : view (simulate model02 "b" ["s","s","bad"]) = none := rfl
example : view (simulate model02 "b" ["s","t","s"]) = none := rfl
example : view (simulate model02 "b" ["s","t","t"]) = none := rfl
example : view (simulate model02 "b" ["s","t","bad"]) = none := rfl
example : view (simulate model02 "b" ["s","bad","s"]) = none := rfl
example : view (simulate model02 "b" ["s","bad","t"]) = none := rfl
example : view (simulate model02 "b" ["s","bad","bad"]) = none := rfl
example : view (simulate model02 "b" ["t","s","s"]) = none := rfl
example : view (simulate model02 "b" ["t","s","t"]) = none := rfl
example : view (simulate model02 "b" ["t","s","bad"]) = none := rfl
example : view (simulate model02 "b" ["t","t","s"]) = none := rfl
example : view (simulate model02 "b" ["t","t","t"]) = none := rfl
example : view (simulate model02 "b" ["t","t","bad"]) = none := rfl
example : view (simulate model02 "b" ["t","bad","s"]) = none := rfl
example : view (simulate model02 "b" ["t","bad","t"]) = none := rfl
example : view (simulate model02 "b" ["t","bad","bad"]) = none := rfl
example : view (simulate model02 "b" ["bad","s","s"]) = none := rfl
example : view (simulate model02 "b" ["bad","s","t"]) = none := rfl
example : view (simulate model02 "b" ["bad","s","bad"]) = none := rfl
example : view (simulate model02 "b" ["bad","t","s"]) = none := rfl
example : view (simulate model02 "b" ["bad","t","t"]) = none := rfl
example : view (simulate model02 "b" ["bad","t","bad"]) = none := rfl
example : view (simulate model02 "b" ["bad","bad","s"]) = none := rfl
example : view (simulate model02 "b" ["bad","bad","t"]) = none := rfl
example : view (simulate model02 "b" ["bad","bad","bad"]) = none := rfl
example : view (simulate model02 "c" []) = some (["c"],["C"]) := rfl
example : view (simulate model02 "c" ["s"]) = some (["c","a"],["C","A"]) := rfl
example : view (simulate model02 "c" ["t"]) = some (["c","c"],["C","C"]) := rfl
example : view (simulate model02 "c" ["bad"]) = none := rfl
example : view (simulate model02 "c" ["s","s"]) = none := rfl
example : view (simulate model02 "c" ["s","t"]) = some (["c","a","a"],["C","A","A"]) := rfl
example : view (simulate model02 "c" ["s","bad"]) = none := rfl
example : view (simulate model02 "c" ["t","s"]) = some (["c","c","a"],["C","C","A"]) := rfl
example : view (simulate model02 "c" ["t","t"]) = some (["c","c","c"],["C","C","C"]) := rfl
example : view (simulate model02 "c" ["t","bad"]) = none := rfl
example : view (simulate model02 "c" ["bad","s"]) = none := rfl
example : view (simulate model02 "c" ["bad","t"]) = none := rfl
example : view (simulate model02 "c" ["bad","bad"]) = none := rfl
example : view (simulate model02 "c" ["s","s","s"]) = none := rfl
example : view (simulate model02 "c" ["s","s","t"]) = none := rfl
example : view (simulate model02 "c" ["s","s","bad"]) = none := rfl
example : view (simulate model02 "c" ["s","t","s"]) = none := rfl
example : view (simulate model02 "c" ["s","t","t"]) = some (["c","a","a","a"],["C","A","A","A"]) := rfl
example : view (simulate model02 "c" ["s","t","bad"]) = none := rfl
example : view (simulate model02 "c" ["s","bad","s"]) = none := rfl
example : view (simulate model02 "c" ["s","bad","t"]) = none := rfl
example : view (simulate model02 "c" ["s","bad","bad"]) = none := rfl
example : view (simulate model02 "c" ["t","s","s"]) = none := rfl
example : view (simulate model02 "c" ["t","s","t"]) = some (["c","c","a","a"],["C","C","A","A"]) := rfl
example : view (simulate model02 "c" ["t","s","bad"]) = none := rfl
example : view (simulate model02 "c" ["t","t","s"]) = some (["c","c","c","a"],["C","C","C","A"]) := rfl
example : view (simulate model02 "c" ["t","t","t"]) = some (["c","c","c","c"],["C","C","C","C"]) := rfl
example : view (simulate model02 "c" ["t","t","bad"]) = none := rfl
example : view (simulate model02 "c" ["t","bad","s"]) = none := rfl
example : view (simulate model02 "c" ["t","bad","t"]) = none := rfl
example : view (simulate model02 "c" ["t","bad","bad"]) = none := rfl
example : view (simulate model02 "c" ["bad","s","s"]) = none := rfl
example : view (simulate model02 "c" ["bad","s","t"]) = none := rfl
example : view (simulate model02 "c" ["bad","s","bad"]) = none := rfl
example : view (simulate model02 "c" ["bad","t","s"]) = none := rfl
example : view (simulate model02 "c" ["bad","t","t"]) = none := rfl
example : view (simulate model02 "c" ["bad","t","bad"]) = none := rfl
example : view (simulate model02 "c" ["bad","bad","s"]) = none := rfl
example : view (simulate model02 "c" ["bad","bad","t"]) = none := rfl
example : view (simulate model02 "c" ["bad","bad","bad"]) = none := rfl
example : view (simulate model02 "outside" []) = none := rfl
example : view (simulate model02 "outside" ["s"]) = none := rfl
example : view (simulate model02 "outside" ["t"]) = none := rfl
example : view (simulate model02 "outside" ["bad"]) = none := rfl
example : view (simulate model02 "outside" ["s","s"]) = none := rfl
example : view (simulate model02 "outside" ["s","t"]) = none := rfl
example : view (simulate model02 "outside" ["s","bad"]) = none := rfl
example : view (simulate model02 "outside" ["t","s"]) = none := rfl
example : view (simulate model02 "outside" ["t","t"]) = none := rfl
example : view (simulate model02 "outside" ["t","bad"]) = none := rfl
example : view (simulate model02 "outside" ["bad","s"]) = none := rfl
example : view (simulate model02 "outside" ["bad","t"]) = none := rfl
example : view (simulate model02 "outside" ["bad","bad"]) = none := rfl
example : view (simulate model02 "outside" ["s","s","s"]) = none := rfl
example : view (simulate model02 "outside" ["s","s","t"]) = none := rfl
example : view (simulate model02 "outside" ["s","s","bad"]) = none := rfl
example : view (simulate model02 "outside" ["s","t","s"]) = none := rfl
example : view (simulate model02 "outside" ["s","t","t"]) = none := rfl
example : view (simulate model02 "outside" ["s","t","bad"]) = none := rfl
example : view (simulate model02 "outside" ["s","bad","s"]) = none := rfl
example : view (simulate model02 "outside" ["s","bad","t"]) = none := rfl
example : view (simulate model02 "outside" ["s","bad","bad"]) = none := rfl
example : view (simulate model02 "outside" ["t","s","s"]) = none := rfl
example : view (simulate model02 "outside" ["t","s","t"]) = none := rfl
example : view (simulate model02 "outside" ["t","s","bad"]) = none := rfl
example : view (simulate model02 "outside" ["t","t","s"]) = none := rfl
example : view (simulate model02 "outside" ["t","t","t"]) = none := rfl
example : view (simulate model02 "outside" ["t","t","bad"]) = none := rfl
example : view (simulate model02 "outside" ["t","bad","s"]) = none := rfl
example : view (simulate model02 "outside" ["t","bad","t"]) = none := rfl
example : view (simulate model02 "outside" ["t","bad","bad"]) = none := rfl
example : view (simulate model02 "outside" ["bad","s","s"]) = none := rfl
example : view (simulate model02 "outside" ["bad","s","t"]) = none := rfl
example : view (simulate model02 "outside" ["bad","s","bad"]) = none := rfl
example : view (simulate model02 "outside" ["bad","t","s"]) = none := rfl
example : view (simulate model02 "outside" ["bad","t","t"]) = none := rfl
example : view (simulate model02 "outside" ["bad","t","bad"]) = none := rfl
example : view (simulate model02 "outside" ["bad","bad","s"]) = none := rfl
example : view (simulate model02 "outside" ["bad","bad","t"]) = none := rfl
example : view (simulate model02 "outside" ["bad","bad","bad"]) = none := rfl
example : view (simulate model03 "a" []) = none := rfl
example : view (simulate model03 "a" ["s"]) = none := rfl
example : view (simulate model03 "a" ["t"]) = none := rfl
example : view (simulate model03 "a" ["bad"]) = none := rfl
example : view (simulate model03 "a" ["s","s"]) = none := rfl
example : view (simulate model03 "a" ["s","t"]) = none := rfl
example : view (simulate model03 "a" ["s","bad"]) = none := rfl
example : view (simulate model03 "a" ["t","s"]) = none := rfl
example : view (simulate model03 "a" ["t","t"]) = none := rfl
example : view (simulate model03 "a" ["t","bad"]) = none := rfl
example : view (simulate model03 "a" ["bad","s"]) = none := rfl
example : view (simulate model03 "a" ["bad","t"]) = none := rfl
example : view (simulate model03 "a" ["bad","bad"]) = none := rfl
example : view (simulate model03 "a" ["s","s","s"]) = none := rfl
example : view (simulate model03 "a" ["s","s","t"]) = none := rfl
example : view (simulate model03 "a" ["s","s","bad"]) = none := rfl
example : view (simulate model03 "a" ["s","t","s"]) = none := rfl
example : view (simulate model03 "a" ["s","t","t"]) = none := rfl
example : view (simulate model03 "a" ["s","t","bad"]) = none := rfl
example : view (simulate model03 "a" ["s","bad","s"]) = none := rfl
example : view (simulate model03 "a" ["s","bad","t"]) = none := rfl
example : view (simulate model03 "a" ["s","bad","bad"]) = none := rfl
example : view (simulate model03 "a" ["t","s","s"]) = none := rfl
example : view (simulate model03 "a" ["t","s","t"]) = none := rfl
example : view (simulate model03 "a" ["t","s","bad"]) = none := rfl
example : view (simulate model03 "a" ["t","t","s"]) = none := rfl
example : view (simulate model03 "a" ["t","t","t"]) = none := rfl
example : view (simulate model03 "a" ["t","t","bad"]) = none := rfl
example : view (simulate model03 "a" ["t","bad","s"]) = none := rfl
example : view (simulate model03 "a" ["t","bad","t"]) = none := rfl
example : view (simulate model03 "a" ["t","bad","bad"]) = none := rfl
example : view (simulate model03 "a" ["bad","s","s"]) = none := rfl
example : view (simulate model03 "a" ["bad","s","t"]) = none := rfl
example : view (simulate model03 "a" ["bad","s","bad"]) = none := rfl
example : view (simulate model03 "a" ["bad","t","s"]) = none := rfl
example : view (simulate model03 "a" ["bad","t","t"]) = none := rfl
example : view (simulate model03 "a" ["bad","t","bad"]) = none := rfl
example : view (simulate model03 "a" ["bad","bad","s"]) = none := rfl
example : view (simulate model03 "a" ["bad","bad","t"]) = none := rfl
example : view (simulate model03 "a" ["bad","bad","bad"]) = none := rfl
example : view (simulate model03 "b" []) = none := rfl
example : view (simulate model03 "b" ["s"]) = none := rfl
example : view (simulate model03 "b" ["t"]) = none := rfl
example : view (simulate model03 "b" ["bad"]) = none := rfl
example : view (simulate model03 "b" ["s","s"]) = none := rfl
example : view (simulate model03 "b" ["s","t"]) = none := rfl
example : view (simulate model03 "b" ["s","bad"]) = none := rfl
example : view (simulate model03 "b" ["t","s"]) = none := rfl
example : view (simulate model03 "b" ["t","t"]) = none := rfl
example : view (simulate model03 "b" ["t","bad"]) = none := rfl
example : view (simulate model03 "b" ["bad","s"]) = none := rfl
example : view (simulate model03 "b" ["bad","t"]) = none := rfl
example : view (simulate model03 "b" ["bad","bad"]) = none := rfl
example : view (simulate model03 "b" ["s","s","s"]) = none := rfl
example : view (simulate model03 "b" ["s","s","t"]) = none := rfl
example : view (simulate model03 "b" ["s","s","bad"]) = none := rfl
example : view (simulate model03 "b" ["s","t","s"]) = none := rfl
example : view (simulate model03 "b" ["s","t","t"]) = none := rfl
example : view (simulate model03 "b" ["s","t","bad"]) = none := rfl
example : view (simulate model03 "b" ["s","bad","s"]) = none := rfl
example : view (simulate model03 "b" ["s","bad","t"]) = none := rfl
example : view (simulate model03 "b" ["s","bad","bad"]) = none := rfl
example : view (simulate model03 "b" ["t","s","s"]) = none := rfl
example : view (simulate model03 "b" ["t","s","t"]) = none := rfl
example : view (simulate model03 "b" ["t","s","bad"]) = none := rfl
example : view (simulate model03 "b" ["t","t","s"]) = none := rfl
example : view (simulate model03 "b" ["t","t","t"]) = none := rfl
example : view (simulate model03 "b" ["t","t","bad"]) = none := rfl
example : view (simulate model03 "b" ["t","bad","s"]) = none := rfl
example : view (simulate model03 "b" ["t","bad","t"]) = none := rfl
example : view (simulate model03 "b" ["t","bad","bad"]) = none := rfl
example : view (simulate model03 "b" ["bad","s","s"]) = none := rfl
example : view (simulate model03 "b" ["bad","s","t"]) = none := rfl
example : view (simulate model03 "b" ["bad","s","bad"]) = none := rfl
example : view (simulate model03 "b" ["bad","t","s"]) = none := rfl
example : view (simulate model03 "b" ["bad","t","t"]) = none := rfl
example : view (simulate model03 "b" ["bad","t","bad"]) = none := rfl
example : view (simulate model03 "b" ["bad","bad","s"]) = none := rfl
example : view (simulate model03 "b" ["bad","bad","t"]) = none := rfl
example : view (simulate model03 "b" ["bad","bad","bad"]) = none := rfl
example : view (simulate model03 "c" []) = none := rfl
example : view (simulate model03 "c" ["s"]) = none := rfl
example : view (simulate model03 "c" ["t"]) = none := rfl
example : view (simulate model03 "c" ["bad"]) = none := rfl
example : view (simulate model03 "c" ["s","s"]) = none := rfl
example : view (simulate model03 "c" ["s","t"]) = none := rfl
example : view (simulate model03 "c" ["s","bad"]) = none := rfl
example : view (simulate model03 "c" ["t","s"]) = none := rfl
example : view (simulate model03 "c" ["t","t"]) = none := rfl
example : view (simulate model03 "c" ["t","bad"]) = none := rfl
example : view (simulate model03 "c" ["bad","s"]) = none := rfl
example : view (simulate model03 "c" ["bad","t"]) = none := rfl
example : view (simulate model03 "c" ["bad","bad"]) = none := rfl
example : view (simulate model03 "c" ["s","s","s"]) = none := rfl
example : view (simulate model03 "c" ["s","s","t"]) = none := rfl
example : view (simulate model03 "c" ["s","s","bad"]) = none := rfl
example : view (simulate model03 "c" ["s","t","s"]) = none := rfl
example : view (simulate model03 "c" ["s","t","t"]) = none := rfl
example : view (simulate model03 "c" ["s","t","bad"]) = none := rfl
example : view (simulate model03 "c" ["s","bad","s"]) = none := rfl
example : view (simulate model03 "c" ["s","bad","t"]) = none := rfl
example : view (simulate model03 "c" ["s","bad","bad"]) = none := rfl
example : view (simulate model03 "c" ["t","s","s"]) = none := rfl
example : view (simulate model03 "c" ["t","s","t"]) = none := rfl
example : view (simulate model03 "c" ["t","s","bad"]) = none := rfl
example : view (simulate model03 "c" ["t","t","s"]) = none := rfl
example : view (simulate model03 "c" ["t","t","t"]) = none := rfl
example : view (simulate model03 "c" ["t","t","bad"]) = none := rfl
example : view (simulate model03 "c" ["t","bad","s"]) = none := rfl
example : view (simulate model03 "c" ["t","bad","t"]) = none := rfl
example : view (simulate model03 "c" ["t","bad","bad"]) = none := rfl
example : view (simulate model03 "c" ["bad","s","s"]) = none := rfl
example : view (simulate model03 "c" ["bad","s","t"]) = none := rfl
example : view (simulate model03 "c" ["bad","s","bad"]) = none := rfl
example : view (simulate model03 "c" ["bad","t","s"]) = none := rfl
example : view (simulate model03 "c" ["bad","t","t"]) = none := rfl
example : view (simulate model03 "c" ["bad","t","bad"]) = none := rfl
example : view (simulate model03 "c" ["bad","bad","s"]) = none := rfl
example : view (simulate model03 "c" ["bad","bad","t"]) = none := rfl
example : view (simulate model03 "c" ["bad","bad","bad"]) = none := rfl
example : view (simulate model03 "outside" []) = none := rfl
example : view (simulate model03 "outside" ["s"]) = none := rfl
example : view (simulate model03 "outside" ["t"]) = none := rfl
example : view (simulate model03 "outside" ["bad"]) = none := rfl
example : view (simulate model03 "outside" ["s","s"]) = none := rfl
example : view (simulate model03 "outside" ["s","t"]) = none := rfl
example : view (simulate model03 "outside" ["s","bad"]) = none := rfl
example : view (simulate model03 "outside" ["t","s"]) = none := rfl
example : view (simulate model03 "outside" ["t","t"]) = none := rfl
example : view (simulate model03 "outside" ["t","bad"]) = none := rfl
example : view (simulate model03 "outside" ["bad","s"]) = none := rfl
example : view (simulate model03 "outside" ["bad","t"]) = none := rfl
example : view (simulate model03 "outside" ["bad","bad"]) = none := rfl
example : view (simulate model03 "outside" ["s","s","s"]) = none := rfl
example : view (simulate model03 "outside" ["s","s","t"]) = none := rfl
example : view (simulate model03 "outside" ["s","s","bad"]) = none := rfl
example : view (simulate model03 "outside" ["s","t","s"]) = none := rfl
example : view (simulate model03 "outside" ["s","t","t"]) = none := rfl
example : view (simulate model03 "outside" ["s","t","bad"]) = none := rfl
example : view (simulate model03 "outside" ["s","bad","s"]) = none := rfl
example : view (simulate model03 "outside" ["s","bad","t"]) = none := rfl
example : view (simulate model03 "outside" ["s","bad","bad"]) = none := rfl
example : view (simulate model03 "outside" ["t","s","s"]) = none := rfl
example : view (simulate model03 "outside" ["t","s","t"]) = none := rfl
example : view (simulate model03 "outside" ["t","s","bad"]) = none := rfl
example : view (simulate model03 "outside" ["t","t","s"]) = none := rfl
example : view (simulate model03 "outside" ["t","t","t"]) = none := rfl
example : view (simulate model03 "outside" ["t","t","bad"]) = none := rfl
example : view (simulate model03 "outside" ["t","bad","s"]) = none := rfl
example : view (simulate model03 "outside" ["t","bad","t"]) = none := rfl
example : view (simulate model03 "outside" ["t","bad","bad"]) = none := rfl
example : view (simulate model03 "outside" ["bad","s","s"]) = none := rfl
example : view (simulate model03 "outside" ["bad","s","t"]) = none := rfl
example : view (simulate model03 "outside" ["bad","s","bad"]) = none := rfl
example : view (simulate model03 "outside" ["bad","t","s"]) = none := rfl
example : view (simulate model03 "outside" ["bad","t","t"]) = none := rfl
example : view (simulate model03 "outside" ["bad","t","bad"]) = none := rfl
example : view (simulate model03 "outside" ["bad","bad","s"]) = none := rfl
example : view (simulate model03 "outside" ["bad","bad","t"]) = none := rfl
example : view (simulate model03 "outside" ["bad","bad","bad"]) = none := rfl
example : view (simulate model10 "a" []) = some (["a"],["A"]) := rfl
example : view (simulate model10 "a" ["s"]) = some (["a","b"],["A","B"]) := rfl
example : view (simulate model10 "a" ["t"]) = some (["a","a"],["A","A"]) := rfl
example : view (simulate model10 "a" ["bad"]) = none := rfl
example : view (simulate model10 "a" ["s","s"]) = some (["a","b","c"],["A","B","C"]) := rfl
example : view (simulate model10 "a" ["s","t"]) = some (["a","b","b"],["A","B","B"]) := rfl
example : view (simulate model10 "a" ["s","bad"]) = none := rfl
example : view (simulate model10 "a" ["t","s"]) = some (["a","a","b"],["A","A","B"]) := rfl
example : view (simulate model10 "a" ["t","t"]) = some (["a","a","a"],["A","A","A"]) := rfl
example : view (simulate model10 "a" ["t","bad"]) = none := rfl
example : view (simulate model10 "a" ["bad","s"]) = none := rfl
example : view (simulate model10 "a" ["bad","t"]) = none := rfl
example : view (simulate model10 "a" ["bad","bad"]) = none := rfl
example : view (simulate model10 "a" ["s","s","s"]) = some (["a","b","c","a"],["A","B","C","A"]) := rfl
example : view (simulate model10 "a" ["s","s","t"]) = none := rfl
example : view (simulate model10 "a" ["s","s","bad"]) = none := rfl
example : view (simulate model10 "a" ["s","t","s"]) = some (["a","b","b","c"],["A","B","B","C"]) := rfl
example : view (simulate model10 "a" ["s","t","t"]) = some (["a","b","b","b"],["A","B","B","B"]) := rfl
example : view (simulate model10 "a" ["s","t","bad"]) = none := rfl
example : view (simulate model10 "a" ["s","bad","s"]) = none := rfl
example : view (simulate model10 "a" ["s","bad","t"]) = none := rfl
example : view (simulate model10 "a" ["s","bad","bad"]) = none := rfl
example : view (simulate model10 "a" ["t","s","s"]) = some (["a","a","b","c"],["A","A","B","C"]) := rfl
example : view (simulate model10 "a" ["t","s","t"]) = some (["a","a","b","b"],["A","A","B","B"]) := rfl
example : view (simulate model10 "a" ["t","s","bad"]) = none := rfl
example : view (simulate model10 "a" ["t","t","s"]) = some (["a","a","a","b"],["A","A","A","B"]) := rfl
example : view (simulate model10 "a" ["t","t","t"]) = some (["a","a","a","a"],["A","A","A","A"]) := rfl
example : view (simulate model10 "a" ["t","t","bad"]) = none := rfl
example : view (simulate model10 "a" ["t","bad","s"]) = none := rfl
example : view (simulate model10 "a" ["t","bad","t"]) = none := rfl
example : view (simulate model10 "a" ["t","bad","bad"]) = none := rfl
example : view (simulate model10 "a" ["bad","s","s"]) = none := rfl
example : view (simulate model10 "a" ["bad","s","t"]) = none := rfl
example : view (simulate model10 "a" ["bad","s","bad"]) = none := rfl
example : view (simulate model10 "a" ["bad","t","s"]) = none := rfl
example : view (simulate model10 "a" ["bad","t","t"]) = none := rfl
example : view (simulate model10 "a" ["bad","t","bad"]) = none := rfl
example : view (simulate model10 "a" ["bad","bad","s"]) = none := rfl
example : view (simulate model10 "a" ["bad","bad","t"]) = none := rfl
example : view (simulate model10 "a" ["bad","bad","bad"]) = none := rfl
example : view (simulate model10 "b" []) = some (["b"],["B"]) := rfl
example : view (simulate model10 "b" ["s"]) = some (["b","c"],["B","C"]) := rfl
example : view (simulate model10 "b" ["t"]) = some (["b","b"],["B","B"]) := rfl
example : view (simulate model10 "b" ["bad"]) = none := rfl
example : view (simulate model10 "b" ["s","s"]) = some (["b","c","a"],["B","C","A"]) := rfl
example : view (simulate model10 "b" ["s","t"]) = none := rfl
example : view (simulate model10 "b" ["s","bad"]) = none := rfl
example : view (simulate model10 "b" ["t","s"]) = some (["b","b","c"],["B","B","C"]) := rfl
example : view (simulate model10 "b" ["t","t"]) = some (["b","b","b"],["B","B","B"]) := rfl
example : view (simulate model10 "b" ["t","bad"]) = none := rfl
example : view (simulate model10 "b" ["bad","s"]) = none := rfl
example : view (simulate model10 "b" ["bad","t"]) = none := rfl
example : view (simulate model10 "b" ["bad","bad"]) = none := rfl
example : view (simulate model10 "b" ["s","s","s"]) = some (["b","c","a","b"],["B","C","A","B"]) := rfl
example : view (simulate model10 "b" ["s","s","t"]) = some (["b","c","a","a"],["B","C","A","A"]) := rfl
example : view (simulate model10 "b" ["s","s","bad"]) = none := rfl
example : view (simulate model10 "b" ["s","t","s"]) = none := rfl
example : view (simulate model10 "b" ["s","t","t"]) = none := rfl
example : view (simulate model10 "b" ["s","t","bad"]) = none := rfl
example : view (simulate model10 "b" ["s","bad","s"]) = none := rfl
example : view (simulate model10 "b" ["s","bad","t"]) = none := rfl
example : view (simulate model10 "b" ["s","bad","bad"]) = none := rfl
example : view (simulate model10 "b" ["t","s","s"]) = some (["b","b","c","a"],["B","B","C","A"]) := rfl
example : view (simulate model10 "b" ["t","s","t"]) = none := rfl
example : view (simulate model10 "b" ["t","s","bad"]) = none := rfl
example : view (simulate model10 "b" ["t","t","s"]) = some (["b","b","b","c"],["B","B","B","C"]) := rfl
example : view (simulate model10 "b" ["t","t","t"]) = some (["b","b","b","b"],["B","B","B","B"]) := rfl
example : view (simulate model10 "b" ["t","t","bad"]) = none := rfl
example : view (simulate model10 "b" ["t","bad","s"]) = none := rfl
example : view (simulate model10 "b" ["t","bad","t"]) = none := rfl
example : view (simulate model10 "b" ["t","bad","bad"]) = none := rfl
example : view (simulate model10 "b" ["bad","s","s"]) = none := rfl
example : view (simulate model10 "b" ["bad","s","t"]) = none := rfl
example : view (simulate model10 "b" ["bad","s","bad"]) = none := rfl
example : view (simulate model10 "b" ["bad","t","s"]) = none := rfl
example : view (simulate model10 "b" ["bad","t","t"]) = none := rfl
example : view (simulate model10 "b" ["bad","t","bad"]) = none := rfl
example : view (simulate model10 "b" ["bad","bad","s"]) = none := rfl
example : view (simulate model10 "b" ["bad","bad","t"]) = none := rfl
example : view (simulate model10 "b" ["bad","bad","bad"]) = none := rfl
example : view (simulate model10 "c" []) = some (["c"],["C"]) := rfl
example : view (simulate model10 "c" ["s"]) = some (["c","a"],["C","A"]) := rfl
example : view (simulate model10 "c" ["t"]) = none := rfl
example : view (simulate model10 "c" ["bad"]) = none := rfl
example : view (simulate model10 "c" ["s","s"]) = some (["c","a","b"],["C","A","B"]) := rfl
example : view (simulate model10 "c" ["s","t"]) = some (["c","a","a"],["C","A","A"]) := rfl
example : view (simulate model10 "c" ["s","bad"]) = none := rfl
example : view (simulate model10 "c" ["t","s"]) = none := rfl
example : view (simulate model10 "c" ["t","t"]) = none := rfl
example : view (simulate model10 "c" ["t","bad"]) = none := rfl
example : view (simulate model10 "c" ["bad","s"]) = none := rfl
example : view (simulate model10 "c" ["bad","t"]) = none := rfl
example : view (simulate model10 "c" ["bad","bad"]) = none := rfl
example : view (simulate model10 "c" ["s","s","s"]) = some (["c","a","b","c"],["C","A","B","C"]) := rfl
example : view (simulate model10 "c" ["s","s","t"]) = some (["c","a","b","b"],["C","A","B","B"]) := rfl
example : view (simulate model10 "c" ["s","s","bad"]) = none := rfl
example : view (simulate model10 "c" ["s","t","s"]) = some (["c","a","a","b"],["C","A","A","B"]) := rfl
example : view (simulate model10 "c" ["s","t","t"]) = some (["c","a","a","a"],["C","A","A","A"]) := rfl
example : view (simulate model10 "c" ["s","t","bad"]) = none := rfl
example : view (simulate model10 "c" ["s","bad","s"]) = none := rfl
example : view (simulate model10 "c" ["s","bad","t"]) = none := rfl
example : view (simulate model10 "c" ["s","bad","bad"]) = none := rfl
example : view (simulate model10 "c" ["t","s","s"]) = none := rfl
example : view (simulate model10 "c" ["t","s","t"]) = none := rfl
example : view (simulate model10 "c" ["t","s","bad"]) = none := rfl
example : view (simulate model10 "c" ["t","t","s"]) = none := rfl
example : view (simulate model10 "c" ["t","t","t"]) = none := rfl
example : view (simulate model10 "c" ["t","t","bad"]) = none := rfl
example : view (simulate model10 "c" ["t","bad","s"]) = none := rfl
example : view (simulate model10 "c" ["t","bad","t"]) = none := rfl
example : view (simulate model10 "c" ["t","bad","bad"]) = none := rfl
example : view (simulate model10 "c" ["bad","s","s"]) = none := rfl
example : view (simulate model10 "c" ["bad","s","t"]) = none := rfl
example : view (simulate model10 "c" ["bad","s","bad"]) = none := rfl
example : view (simulate model10 "c" ["bad","t","s"]) = none := rfl
example : view (simulate model10 "c" ["bad","t","t"]) = none := rfl
example : view (simulate model10 "c" ["bad","t","bad"]) = none := rfl
example : view (simulate model10 "c" ["bad","bad","s"]) = none := rfl
example : view (simulate model10 "c" ["bad","bad","t"]) = none := rfl
example : view (simulate model10 "c" ["bad","bad","bad"]) = none := rfl
example : view (simulate model10 "outside" []) = none := rfl
example : view (simulate model10 "outside" ["s"]) = none := rfl
example : view (simulate model10 "outside" ["t"]) = none := rfl
example : view (simulate model10 "outside" ["bad"]) = none := rfl
example : view (simulate model10 "outside" ["s","s"]) = none := rfl
example : view (simulate model10 "outside" ["s","t"]) = none := rfl
example : view (simulate model10 "outside" ["s","bad"]) = none := rfl
example : view (simulate model10 "outside" ["t","s"]) = none := rfl
example : view (simulate model10 "outside" ["t","t"]) = none := rfl
example : view (simulate model10 "outside" ["t","bad"]) = none := rfl
example : view (simulate model10 "outside" ["bad","s"]) = none := rfl
example : view (simulate model10 "outside" ["bad","t"]) = none := rfl
example : view (simulate model10 "outside" ["bad","bad"]) = none := rfl
example : view (simulate model10 "outside" ["s","s","s"]) = none := rfl
example : view (simulate model10 "outside" ["s","s","t"]) = none := rfl
example : view (simulate model10 "outside" ["s","s","bad"]) = none := rfl
example : view (simulate model10 "outside" ["s","t","s"]) = none := rfl
example : view (simulate model10 "outside" ["s","t","t"]) = none := rfl
example : view (simulate model10 "outside" ["s","t","bad"]) = none := rfl
example : view (simulate model10 "outside" ["s","bad","s"]) = none := rfl
example : view (simulate model10 "outside" ["s","bad","t"]) = none := rfl
example : view (simulate model10 "outside" ["s","bad","bad"]) = none := rfl
example : view (simulate model10 "outside" ["t","s","s"]) = none := rfl
example : view (simulate model10 "outside" ["t","s","t"]) = none := rfl
example : view (simulate model10 "outside" ["t","s","bad"]) = none := rfl
example : view (simulate model10 "outside" ["t","t","s"]) = none := rfl
example : view (simulate model10 "outside" ["t","t","t"]) = none := rfl
example : view (simulate model10 "outside" ["t","t","bad"]) = none := rfl
example : view (simulate model10 "outside" ["t","bad","s"]) = none := rfl
example : view (simulate model10 "outside" ["t","bad","t"]) = none := rfl
example : view (simulate model10 "outside" ["t","bad","bad"]) = none := rfl
example : view (simulate model10 "outside" ["bad","s","s"]) = none := rfl
example : view (simulate model10 "outside" ["bad","s","t"]) = none := rfl
example : view (simulate model10 "outside" ["bad","s","bad"]) = none := rfl
example : view (simulate model10 "outside" ["bad","t","s"]) = none := rfl
example : view (simulate model10 "outside" ["bad","t","t"]) = none := rfl
example : view (simulate model10 "outside" ["bad","t","bad"]) = none := rfl
example : view (simulate model10 "outside" ["bad","bad","s"]) = none := rfl
example : view (simulate model10 "outside" ["bad","bad","t"]) = none := rfl
example : view (simulate model10 "outside" ["bad","bad","bad"]) = none := rfl
example : view (simulate model11 "a" []) = some (["a"],["same"]) := rfl
example : view (simulate model11 "a" ["s"]) = some (["a","b"],["same","same"]) := rfl
example : view (simulate model11 "a" ["t"]) = some (["a","a"],["same","same"]) := rfl
example : view (simulate model11 "a" ["bad"]) = none := rfl
example : view (simulate model11 "a" ["s","s"]) = some (["a","b","c"],["same","same","same"]) := rfl
example : view (simulate model11 "a" ["s","t"]) = some (["a","b","b"],["same","same","same"]) := rfl
example : view (simulate model11 "a" ["s","bad"]) = none := rfl
example : view (simulate model11 "a" ["t","s"]) = some (["a","a","b"],["same","same","same"]) := rfl
example : view (simulate model11 "a" ["t","t"]) = some (["a","a","a"],["same","same","same"]) := rfl
example : view (simulate model11 "a" ["t","bad"]) = none := rfl
example : view (simulate model11 "a" ["bad","s"]) = none := rfl
example : view (simulate model11 "a" ["bad","t"]) = none := rfl
example : view (simulate model11 "a" ["bad","bad"]) = none := rfl
example : view (simulate model11 "a" ["s","s","s"]) = some (["a","b","c","a"],["same","same","same","same"]) := rfl
example : view (simulate model11 "a" ["s","s","t"]) = none := rfl
example : view (simulate model11 "a" ["s","s","bad"]) = none := rfl
example : view (simulate model11 "a" ["s","t","s"]) = some (["a","b","b","c"],["same","same","same","same"]) := rfl
example : view (simulate model11 "a" ["s","t","t"]) = some (["a","b","b","b"],["same","same","same","same"]) := rfl
example : view (simulate model11 "a" ["s","t","bad"]) = none := rfl
example : view (simulate model11 "a" ["s","bad","s"]) = none := rfl
example : view (simulate model11 "a" ["s","bad","t"]) = none := rfl
example : view (simulate model11 "a" ["s","bad","bad"]) = none := rfl
example : view (simulate model11 "a" ["t","s","s"]) = some (["a","a","b","c"],["same","same","same","same"]) := rfl
example : view (simulate model11 "a" ["t","s","t"]) = some (["a","a","b","b"],["same","same","same","same"]) := rfl
example : view (simulate model11 "a" ["t","s","bad"]) = none := rfl
example : view (simulate model11 "a" ["t","t","s"]) = some (["a","a","a","b"],["same","same","same","same"]) := rfl
example : view (simulate model11 "a" ["t","t","t"]) = some (["a","a","a","a"],["same","same","same","same"]) := rfl
example : view (simulate model11 "a" ["t","t","bad"]) = none := rfl
example : view (simulate model11 "a" ["t","bad","s"]) = none := rfl
example : view (simulate model11 "a" ["t","bad","t"]) = none := rfl
example : view (simulate model11 "a" ["t","bad","bad"]) = none := rfl
example : view (simulate model11 "a" ["bad","s","s"]) = none := rfl
example : view (simulate model11 "a" ["bad","s","t"]) = none := rfl
example : view (simulate model11 "a" ["bad","s","bad"]) = none := rfl
example : view (simulate model11 "a" ["bad","t","s"]) = none := rfl
example : view (simulate model11 "a" ["bad","t","t"]) = none := rfl
example : view (simulate model11 "a" ["bad","t","bad"]) = none := rfl
example : view (simulate model11 "a" ["bad","bad","s"]) = none := rfl
example : view (simulate model11 "a" ["bad","bad","t"]) = none := rfl
example : view (simulate model11 "a" ["bad","bad","bad"]) = none := rfl
example : view (simulate model11 "b" []) = some (["b"],["same"]) := rfl
example : view (simulate model11 "b" ["s"]) = some (["b","c"],["same","same"]) := rfl
example : view (simulate model11 "b" ["t"]) = some (["b","b"],["same","same"]) := rfl
example : view (simulate model11 "b" ["bad"]) = none := rfl
example : view (simulate model11 "b" ["s","s"]) = some (["b","c","a"],["same","same","same"]) := rfl
example : view (simulate model11 "b" ["s","t"]) = none := rfl
example : view (simulate model11 "b" ["s","bad"]) = none := rfl
example : view (simulate model11 "b" ["t","s"]) = some (["b","b","c"],["same","same","same"]) := rfl
example : view (simulate model11 "b" ["t","t"]) = some (["b","b","b"],["same","same","same"]) := rfl
example : view (simulate model11 "b" ["t","bad"]) = none := rfl
example : view (simulate model11 "b" ["bad","s"]) = none := rfl
example : view (simulate model11 "b" ["bad","t"]) = none := rfl
example : view (simulate model11 "b" ["bad","bad"]) = none := rfl
example : view (simulate model11 "b" ["s","s","s"]) = some (["b","c","a","b"],["same","same","same","same"]) := rfl
example : view (simulate model11 "b" ["s","s","t"]) = some (["b","c","a","a"],["same","same","same","same"]) := rfl
example : view (simulate model11 "b" ["s","s","bad"]) = none := rfl
example : view (simulate model11 "b" ["s","t","s"]) = none := rfl
example : view (simulate model11 "b" ["s","t","t"]) = none := rfl
example : view (simulate model11 "b" ["s","t","bad"]) = none := rfl
example : view (simulate model11 "b" ["s","bad","s"]) = none := rfl
example : view (simulate model11 "b" ["s","bad","t"]) = none := rfl
example : view (simulate model11 "b" ["s","bad","bad"]) = none := rfl
example : view (simulate model11 "b" ["t","s","s"]) = some (["b","b","c","a"],["same","same","same","same"]) := rfl
example : view (simulate model11 "b" ["t","s","t"]) = none := rfl
example : view (simulate model11 "b" ["t","s","bad"]) = none := rfl
example : view (simulate model11 "b" ["t","t","s"]) = some (["b","b","b","c"],["same","same","same","same"]) := rfl
example : view (simulate model11 "b" ["t","t","t"]) = some (["b","b","b","b"],["same","same","same","same"]) := rfl
example : view (simulate model11 "b" ["t","t","bad"]) = none := rfl
example : view (simulate model11 "b" ["t","bad","s"]) = none := rfl
example : view (simulate model11 "b" ["t","bad","t"]) = none := rfl
example : view (simulate model11 "b" ["t","bad","bad"]) = none := rfl
example : view (simulate model11 "b" ["bad","s","s"]) = none := rfl
example : view (simulate model11 "b" ["bad","s","t"]) = none := rfl
example : view (simulate model11 "b" ["bad","s","bad"]) = none := rfl
example : view (simulate model11 "b" ["bad","t","s"]) = none := rfl
example : view (simulate model11 "b" ["bad","t","t"]) = none := rfl
example : view (simulate model11 "b" ["bad","t","bad"]) = none := rfl
example : view (simulate model11 "b" ["bad","bad","s"]) = none := rfl
example : view (simulate model11 "b" ["bad","bad","t"]) = none := rfl
example : view (simulate model11 "b" ["bad","bad","bad"]) = none := rfl
example : view (simulate model11 "c" []) = some (["c"],["same"]) := rfl
example : view (simulate model11 "c" ["s"]) = some (["c","a"],["same","same"]) := rfl
example : view (simulate model11 "c" ["t"]) = none := rfl
example : view (simulate model11 "c" ["bad"]) = none := rfl
example : view (simulate model11 "c" ["s","s"]) = some (["c","a","b"],["same","same","same"]) := rfl
example : view (simulate model11 "c" ["s","t"]) = some (["c","a","a"],["same","same","same"]) := rfl
example : view (simulate model11 "c" ["s","bad"]) = none := rfl
example : view (simulate model11 "c" ["t","s"]) = none := rfl
example : view (simulate model11 "c" ["t","t"]) = none := rfl
example : view (simulate model11 "c" ["t","bad"]) = none := rfl
example : view (simulate model11 "c" ["bad","s"]) = none := rfl
example : view (simulate model11 "c" ["bad","t"]) = none := rfl
example : view (simulate model11 "c" ["bad","bad"]) = none := rfl
example : view (simulate model11 "c" ["s","s","s"]) = some (["c","a","b","c"],["same","same","same","same"]) := rfl
example : view (simulate model11 "c" ["s","s","t"]) = some (["c","a","b","b"],["same","same","same","same"]) := rfl
example : view (simulate model11 "c" ["s","s","bad"]) = none := rfl
example : view (simulate model11 "c" ["s","t","s"]) = some (["c","a","a","b"],["same","same","same","same"]) := rfl
example : view (simulate model11 "c" ["s","t","t"]) = some (["c","a","a","a"],["same","same","same","same"]) := rfl
example : view (simulate model11 "c" ["s","t","bad"]) = none := rfl
example : view (simulate model11 "c" ["s","bad","s"]) = none := rfl
example : view (simulate model11 "c" ["s","bad","t"]) = none := rfl
example : view (simulate model11 "c" ["s","bad","bad"]) = none := rfl
example : view (simulate model11 "c" ["t","s","s"]) = none := rfl
example : view (simulate model11 "c" ["t","s","t"]) = none := rfl
example : view (simulate model11 "c" ["t","s","bad"]) = none := rfl
example : view (simulate model11 "c" ["t","t","s"]) = none := rfl
example : view (simulate model11 "c" ["t","t","t"]) = none := rfl
example : view (simulate model11 "c" ["t","t","bad"]) = none := rfl
example : view (simulate model11 "c" ["t","bad","s"]) = none := rfl
example : view (simulate model11 "c" ["t","bad","t"]) = none := rfl
example : view (simulate model11 "c" ["t","bad","bad"]) = none := rfl
example : view (simulate model11 "c" ["bad","s","s"]) = none := rfl
example : view (simulate model11 "c" ["bad","s","t"]) = none := rfl
example : view (simulate model11 "c" ["bad","s","bad"]) = none := rfl
example : view (simulate model11 "c" ["bad","t","s"]) = none := rfl
example : view (simulate model11 "c" ["bad","t","t"]) = none := rfl
example : view (simulate model11 "c" ["bad","t","bad"]) = none := rfl
example : view (simulate model11 "c" ["bad","bad","s"]) = none := rfl
example : view (simulate model11 "c" ["bad","bad","t"]) = none := rfl
example : view (simulate model11 "c" ["bad","bad","bad"]) = none := rfl
example : view (simulate model11 "outside" []) = none := rfl
example : view (simulate model11 "outside" ["s"]) = none := rfl
example : view (simulate model11 "outside" ["t"]) = none := rfl
example : view (simulate model11 "outside" ["bad"]) = none := rfl
example : view (simulate model11 "outside" ["s","s"]) = none := rfl
example : view (simulate model11 "outside" ["s","t"]) = none := rfl
example : view (simulate model11 "outside" ["s","bad"]) = none := rfl
example : view (simulate model11 "outside" ["t","s"]) = none := rfl
example : view (simulate model11 "outside" ["t","t"]) = none := rfl
example : view (simulate model11 "outside" ["t","bad"]) = none := rfl
example : view (simulate model11 "outside" ["bad","s"]) = none := rfl
example : view (simulate model11 "outside" ["bad","t"]) = none := rfl
example : view (simulate model11 "outside" ["bad","bad"]) = none := rfl
example : view (simulate model11 "outside" ["s","s","s"]) = none := rfl
example : view (simulate model11 "outside" ["s","s","t"]) = none := rfl
example : view (simulate model11 "outside" ["s","s","bad"]) = none := rfl
example : view (simulate model11 "outside" ["s","t","s"]) = none := rfl
example : view (simulate model11 "outside" ["s","t","t"]) = none := rfl
example : view (simulate model11 "outside" ["s","t","bad"]) = none := rfl
example : view (simulate model11 "outside" ["s","bad","s"]) = none := rfl
example : view (simulate model11 "outside" ["s","bad","t"]) = none := rfl
example : view (simulate model11 "outside" ["s","bad","bad"]) = none := rfl
example : view (simulate model11 "outside" ["t","s","s"]) = none := rfl
example : view (simulate model11 "outside" ["t","s","t"]) = none := rfl
example : view (simulate model11 "outside" ["t","s","bad"]) = none := rfl
example : view (simulate model11 "outside" ["t","t","s"]) = none := rfl
example : view (simulate model11 "outside" ["t","t","t"]) = none := rfl
example : view (simulate model11 "outside" ["t","t","bad"]) = none := rfl
example : view (simulate model11 "outside" ["t","bad","s"]) = none := rfl
example : view (simulate model11 "outside" ["t","bad","t"]) = none := rfl
example : view (simulate model11 "outside" ["t","bad","bad"]) = none := rfl
example : view (simulate model11 "outside" ["bad","s","s"]) = none := rfl
example : view (simulate model11 "outside" ["bad","s","t"]) = none := rfl
example : view (simulate model11 "outside" ["bad","s","bad"]) = none := rfl
example : view (simulate model11 "outside" ["bad","t","s"]) = none := rfl
example : view (simulate model11 "outside" ["bad","t","t"]) = none := rfl
example : view (simulate model11 "outside" ["bad","t","bad"]) = none := rfl
example : view (simulate model11 "outside" ["bad","bad","s"]) = none := rfl
example : view (simulate model11 "outside" ["bad","bad","t"]) = none := rfl
example : view (simulate model11 "outside" ["bad","bad","bad"]) = none := rfl
example : view (simulate model12 "a" []) = some (["a"],["A"]) := rfl
example : view (simulate model12 "a" ["s"]) = none := rfl
example : view (simulate model12 "a" ["t"]) = some (["a","a"],["A","A"]) := rfl
example : view (simulate model12 "a" ["bad"]) = none := rfl
example : view (simulate model12 "a" ["s","s"]) = none := rfl
example : view (simulate model12 "a" ["s","t"]) = none := rfl
example : view (simulate model12 "a" ["s","bad"]) = none := rfl
example : view (simulate model12 "a" ["t","s"]) = none := rfl
example : view (simulate model12 "a" ["t","t"]) = some (["a","a","a"],["A","A","A"]) := rfl
example : view (simulate model12 "a" ["t","bad"]) = none := rfl
example : view (simulate model12 "a" ["bad","s"]) = none := rfl
example : view (simulate model12 "a" ["bad","t"]) = none := rfl
example : view (simulate model12 "a" ["bad","bad"]) = none := rfl
example : view (simulate model12 "a" ["s","s","s"]) = none := rfl
example : view (simulate model12 "a" ["s","s","t"]) = none := rfl
example : view (simulate model12 "a" ["s","s","bad"]) = none := rfl
example : view (simulate model12 "a" ["s","t","s"]) = none := rfl
example : view (simulate model12 "a" ["s","t","t"]) = none := rfl
example : view (simulate model12 "a" ["s","t","bad"]) = none := rfl
example : view (simulate model12 "a" ["s","bad","s"]) = none := rfl
example : view (simulate model12 "a" ["s","bad","t"]) = none := rfl
example : view (simulate model12 "a" ["s","bad","bad"]) = none := rfl
example : view (simulate model12 "a" ["t","s","s"]) = none := rfl
example : view (simulate model12 "a" ["t","s","t"]) = none := rfl
example : view (simulate model12 "a" ["t","s","bad"]) = none := rfl
example : view (simulate model12 "a" ["t","t","s"]) = none := rfl
example : view (simulate model12 "a" ["t","t","t"]) = some (["a","a","a","a"],["A","A","A","A"]) := rfl
example : view (simulate model12 "a" ["t","t","bad"]) = none := rfl
example : view (simulate model12 "a" ["t","bad","s"]) = none := rfl
example : view (simulate model12 "a" ["t","bad","t"]) = none := rfl
example : view (simulate model12 "a" ["t","bad","bad"]) = none := rfl
example : view (simulate model12 "a" ["bad","s","s"]) = none := rfl
example : view (simulate model12 "a" ["bad","s","t"]) = none := rfl
example : view (simulate model12 "a" ["bad","s","bad"]) = none := rfl
example : view (simulate model12 "a" ["bad","t","s"]) = none := rfl
example : view (simulate model12 "a" ["bad","t","t"]) = none := rfl
example : view (simulate model12 "a" ["bad","t","bad"]) = none := rfl
example : view (simulate model12 "a" ["bad","bad","s"]) = none := rfl
example : view (simulate model12 "a" ["bad","bad","t"]) = none := rfl
example : view (simulate model12 "a" ["bad","bad","bad"]) = none := rfl
example : view (simulate model12 "b" []) = none := rfl
example : view (simulate model12 "b" ["s"]) = none := rfl
example : view (simulate model12 "b" ["t"]) = none := rfl
example : view (simulate model12 "b" ["bad"]) = none := rfl
example : view (simulate model12 "b" ["s","s"]) = none := rfl
example : view (simulate model12 "b" ["s","t"]) = none := rfl
example : view (simulate model12 "b" ["s","bad"]) = none := rfl
example : view (simulate model12 "b" ["t","s"]) = none := rfl
example : view (simulate model12 "b" ["t","t"]) = none := rfl
example : view (simulate model12 "b" ["t","bad"]) = none := rfl
example : view (simulate model12 "b" ["bad","s"]) = none := rfl
example : view (simulate model12 "b" ["bad","t"]) = none := rfl
example : view (simulate model12 "b" ["bad","bad"]) = none := rfl
example : view (simulate model12 "b" ["s","s","s"]) = none := rfl
example : view (simulate model12 "b" ["s","s","t"]) = none := rfl
example : view (simulate model12 "b" ["s","s","bad"]) = none := rfl
example : view (simulate model12 "b" ["s","t","s"]) = none := rfl
example : view (simulate model12 "b" ["s","t","t"]) = none := rfl
example : view (simulate model12 "b" ["s","t","bad"]) = none := rfl
example : view (simulate model12 "b" ["s","bad","s"]) = none := rfl
example : view (simulate model12 "b" ["s","bad","t"]) = none := rfl
example : view (simulate model12 "b" ["s","bad","bad"]) = none := rfl
example : view (simulate model12 "b" ["t","s","s"]) = none := rfl
example : view (simulate model12 "b" ["t","s","t"]) = none := rfl
example : view (simulate model12 "b" ["t","s","bad"]) = none := rfl
example : view (simulate model12 "b" ["t","t","s"]) = none := rfl
example : view (simulate model12 "b" ["t","t","t"]) = none := rfl
example : view (simulate model12 "b" ["t","t","bad"]) = none := rfl
example : view (simulate model12 "b" ["t","bad","s"]) = none := rfl
example : view (simulate model12 "b" ["t","bad","t"]) = none := rfl
example : view (simulate model12 "b" ["t","bad","bad"]) = none := rfl
example : view (simulate model12 "b" ["bad","s","s"]) = none := rfl
example : view (simulate model12 "b" ["bad","s","t"]) = none := rfl
example : view (simulate model12 "b" ["bad","s","bad"]) = none := rfl
example : view (simulate model12 "b" ["bad","t","s"]) = none := rfl
example : view (simulate model12 "b" ["bad","t","t"]) = none := rfl
example : view (simulate model12 "b" ["bad","t","bad"]) = none := rfl
example : view (simulate model12 "b" ["bad","bad","s"]) = none := rfl
example : view (simulate model12 "b" ["bad","bad","t"]) = none := rfl
example : view (simulate model12 "b" ["bad","bad","bad"]) = none := rfl
example : view (simulate model12 "c" []) = some (["c"],["C"]) := rfl
example : view (simulate model12 "c" ["s"]) = some (["c","a"],["C","A"]) := rfl
example : view (simulate model12 "c" ["t"]) = none := rfl
example : view (simulate model12 "c" ["bad"]) = none := rfl
example : view (simulate model12 "c" ["s","s"]) = none := rfl
example : view (simulate model12 "c" ["s","t"]) = some (["c","a","a"],["C","A","A"]) := rfl
example : view (simulate model12 "c" ["s","bad"]) = none := rfl
example : view (simulate model12 "c" ["t","s"]) = none := rfl
example : view (simulate model12 "c" ["t","t"]) = none := rfl
example : view (simulate model12 "c" ["t","bad"]) = none := rfl
example : view (simulate model12 "c" ["bad","s"]) = none := rfl
example : view (simulate model12 "c" ["bad","t"]) = none := rfl
example : view (simulate model12 "c" ["bad","bad"]) = none := rfl
example : view (simulate model12 "c" ["s","s","s"]) = none := rfl
example : view (simulate model12 "c" ["s","s","t"]) = none := rfl
example : view (simulate model12 "c" ["s","s","bad"]) = none := rfl
example : view (simulate model12 "c" ["s","t","s"]) = none := rfl
example : view (simulate model12 "c" ["s","t","t"]) = some (["c","a","a","a"],["C","A","A","A"]) := rfl
example : view (simulate model12 "c" ["s","t","bad"]) = none := rfl
example : view (simulate model12 "c" ["s","bad","s"]) = none := rfl
example : view (simulate model12 "c" ["s","bad","t"]) = none := rfl
example : view (simulate model12 "c" ["s","bad","bad"]) = none := rfl
example : view (simulate model12 "c" ["t","s","s"]) = none := rfl
example : view (simulate model12 "c" ["t","s","t"]) = none := rfl
example : view (simulate model12 "c" ["t","s","bad"]) = none := rfl
example : view (simulate model12 "c" ["t","t","s"]) = none := rfl
example : view (simulate model12 "c" ["t","t","t"]) = none := rfl
example : view (simulate model12 "c" ["t","t","bad"]) = none := rfl
example : view (simulate model12 "c" ["t","bad","s"]) = none := rfl
example : view (simulate model12 "c" ["t","bad","t"]) = none := rfl
example : view (simulate model12 "c" ["t","bad","bad"]) = none := rfl
example : view (simulate model12 "c" ["bad","s","s"]) = none := rfl
example : view (simulate model12 "c" ["bad","s","t"]) = none := rfl
example : view (simulate model12 "c" ["bad","s","bad"]) = none := rfl
example : view (simulate model12 "c" ["bad","t","s"]) = none := rfl
example : view (simulate model12 "c" ["bad","t","t"]) = none := rfl
example : view (simulate model12 "c" ["bad","t","bad"]) = none := rfl
example : view (simulate model12 "c" ["bad","bad","s"]) = none := rfl
example : view (simulate model12 "c" ["bad","bad","t"]) = none := rfl
example : view (simulate model12 "c" ["bad","bad","bad"]) = none := rfl
example : view (simulate model12 "outside" []) = none := rfl
example : view (simulate model12 "outside" ["s"]) = none := rfl
example : view (simulate model12 "outside" ["t"]) = none := rfl
example : view (simulate model12 "outside" ["bad"]) = none := rfl
example : view (simulate model12 "outside" ["s","s"]) = none := rfl
example : view (simulate model12 "outside" ["s","t"]) = none := rfl
example : view (simulate model12 "outside" ["s","bad"]) = none := rfl
example : view (simulate model12 "outside" ["t","s"]) = none := rfl
example : view (simulate model12 "outside" ["t","t"]) = none := rfl
example : view (simulate model12 "outside" ["t","bad"]) = none := rfl
example : view (simulate model12 "outside" ["bad","s"]) = none := rfl
example : view (simulate model12 "outside" ["bad","t"]) = none := rfl
example : view (simulate model12 "outside" ["bad","bad"]) = none := rfl
example : view (simulate model12 "outside" ["s","s","s"]) = none := rfl
example : view (simulate model12 "outside" ["s","s","t"]) = none := rfl
example : view (simulate model12 "outside" ["s","s","bad"]) = none := rfl
example : view (simulate model12 "outside" ["s","t","s"]) = none := rfl
example : view (simulate model12 "outside" ["s","t","t"]) = none := rfl
example : view (simulate model12 "outside" ["s","t","bad"]) = none := rfl
example : view (simulate model12 "outside" ["s","bad","s"]) = none := rfl
example : view (simulate model12 "outside" ["s","bad","t"]) = none := rfl
example : view (simulate model12 "outside" ["s","bad","bad"]) = none := rfl
example : view (simulate model12 "outside" ["t","s","s"]) = none := rfl
example : view (simulate model12 "outside" ["t","s","t"]) = none := rfl
example : view (simulate model12 "outside" ["t","s","bad"]) = none := rfl
example : view (simulate model12 "outside" ["t","t","s"]) = none := rfl
example : view (simulate model12 "outside" ["t","t","t"]) = none := rfl
example : view (simulate model12 "outside" ["t","t","bad"]) = none := rfl
example : view (simulate model12 "outside" ["t","bad","s"]) = none := rfl
example : view (simulate model12 "outside" ["t","bad","t"]) = none := rfl
example : view (simulate model12 "outside" ["t","bad","bad"]) = none := rfl
example : view (simulate model12 "outside" ["bad","s","s"]) = none := rfl
example : view (simulate model12 "outside" ["bad","s","t"]) = none := rfl
example : view (simulate model12 "outside" ["bad","s","bad"]) = none := rfl
example : view (simulate model12 "outside" ["bad","t","s"]) = none := rfl
example : view (simulate model12 "outside" ["bad","t","t"]) = none := rfl
example : view (simulate model12 "outside" ["bad","t","bad"]) = none := rfl
example : view (simulate model12 "outside" ["bad","bad","s"]) = none := rfl
example : view (simulate model12 "outside" ["bad","bad","t"]) = none := rfl
example : view (simulate model12 "outside" ["bad","bad","bad"]) = none := rfl
example : view (simulate model13 "a" []) = none := rfl
example : view (simulate model13 "a" ["s"]) = none := rfl
example : view (simulate model13 "a" ["t"]) = none := rfl
example : view (simulate model13 "a" ["bad"]) = none := rfl
example : view (simulate model13 "a" ["s","s"]) = none := rfl
example : view (simulate model13 "a" ["s","t"]) = none := rfl
example : view (simulate model13 "a" ["s","bad"]) = none := rfl
example : view (simulate model13 "a" ["t","s"]) = none := rfl
example : view (simulate model13 "a" ["t","t"]) = none := rfl
example : view (simulate model13 "a" ["t","bad"]) = none := rfl
example : view (simulate model13 "a" ["bad","s"]) = none := rfl
example : view (simulate model13 "a" ["bad","t"]) = none := rfl
example : view (simulate model13 "a" ["bad","bad"]) = none := rfl
example : view (simulate model13 "a" ["s","s","s"]) = none := rfl
example : view (simulate model13 "a" ["s","s","t"]) = none := rfl
example : view (simulate model13 "a" ["s","s","bad"]) = none := rfl
example : view (simulate model13 "a" ["s","t","s"]) = none := rfl
example : view (simulate model13 "a" ["s","t","t"]) = none := rfl
example : view (simulate model13 "a" ["s","t","bad"]) = none := rfl
example : view (simulate model13 "a" ["s","bad","s"]) = none := rfl
example : view (simulate model13 "a" ["s","bad","t"]) = none := rfl
example : view (simulate model13 "a" ["s","bad","bad"]) = none := rfl
example : view (simulate model13 "a" ["t","s","s"]) = none := rfl
example : view (simulate model13 "a" ["t","s","t"]) = none := rfl
example : view (simulate model13 "a" ["t","s","bad"]) = none := rfl
example : view (simulate model13 "a" ["t","t","s"]) = none := rfl
example : view (simulate model13 "a" ["t","t","t"]) = none := rfl
example : view (simulate model13 "a" ["t","t","bad"]) = none := rfl
example : view (simulate model13 "a" ["t","bad","s"]) = none := rfl
example : view (simulate model13 "a" ["t","bad","t"]) = none := rfl
example : view (simulate model13 "a" ["t","bad","bad"]) = none := rfl
example : view (simulate model13 "a" ["bad","s","s"]) = none := rfl
example : view (simulate model13 "a" ["bad","s","t"]) = none := rfl
example : view (simulate model13 "a" ["bad","s","bad"]) = none := rfl
example : view (simulate model13 "a" ["bad","t","s"]) = none := rfl
example : view (simulate model13 "a" ["bad","t","t"]) = none := rfl
example : view (simulate model13 "a" ["bad","t","bad"]) = none := rfl
example : view (simulate model13 "a" ["bad","bad","s"]) = none := rfl
example : view (simulate model13 "a" ["bad","bad","t"]) = none := rfl
example : view (simulate model13 "a" ["bad","bad","bad"]) = none := rfl
example : view (simulate model13 "b" []) = none := rfl
example : view (simulate model13 "b" ["s"]) = none := rfl
example : view (simulate model13 "b" ["t"]) = none := rfl
example : view (simulate model13 "b" ["bad"]) = none := rfl
example : view (simulate model13 "b" ["s","s"]) = none := rfl
example : view (simulate model13 "b" ["s","t"]) = none := rfl
example : view (simulate model13 "b" ["s","bad"]) = none := rfl
example : view (simulate model13 "b" ["t","s"]) = none := rfl
example : view (simulate model13 "b" ["t","t"]) = none := rfl
example : view (simulate model13 "b" ["t","bad"]) = none := rfl
example : view (simulate model13 "b" ["bad","s"]) = none := rfl
example : view (simulate model13 "b" ["bad","t"]) = none := rfl
example : view (simulate model13 "b" ["bad","bad"]) = none := rfl
example : view (simulate model13 "b" ["s","s","s"]) = none := rfl
example : view (simulate model13 "b" ["s","s","t"]) = none := rfl
example : view (simulate model13 "b" ["s","s","bad"]) = none := rfl
example : view (simulate model13 "b" ["s","t","s"]) = none := rfl
example : view (simulate model13 "b" ["s","t","t"]) = none := rfl
example : view (simulate model13 "b" ["s","t","bad"]) = none := rfl
example : view (simulate model13 "b" ["s","bad","s"]) = none := rfl
example : view (simulate model13 "b" ["s","bad","t"]) = none := rfl
example : view (simulate model13 "b" ["s","bad","bad"]) = none := rfl
example : view (simulate model13 "b" ["t","s","s"]) = none := rfl
example : view (simulate model13 "b" ["t","s","t"]) = none := rfl
example : view (simulate model13 "b" ["t","s","bad"]) = none := rfl
example : view (simulate model13 "b" ["t","t","s"]) = none := rfl
example : view (simulate model13 "b" ["t","t","t"]) = none := rfl
example : view (simulate model13 "b" ["t","t","bad"]) = none := rfl
example : view (simulate model13 "b" ["t","bad","s"]) = none := rfl
example : view (simulate model13 "b" ["t","bad","t"]) = none := rfl
example : view (simulate model13 "b" ["t","bad","bad"]) = none := rfl
example : view (simulate model13 "b" ["bad","s","s"]) = none := rfl
example : view (simulate model13 "b" ["bad","s","t"]) = none := rfl
example : view (simulate model13 "b" ["bad","s","bad"]) = none := rfl
example : view (simulate model13 "b" ["bad","t","s"]) = none := rfl
example : view (simulate model13 "b" ["bad","t","t"]) = none := rfl
example : view (simulate model13 "b" ["bad","t","bad"]) = none := rfl
example : view (simulate model13 "b" ["bad","bad","s"]) = none := rfl
example : view (simulate model13 "b" ["bad","bad","t"]) = none := rfl
example : view (simulate model13 "b" ["bad","bad","bad"]) = none := rfl
example : view (simulate model13 "c" []) = none := rfl
example : view (simulate model13 "c" ["s"]) = none := rfl
example : view (simulate model13 "c" ["t"]) = none := rfl
example : view (simulate model13 "c" ["bad"]) = none := rfl
example : view (simulate model13 "c" ["s","s"]) = none := rfl
example : view (simulate model13 "c" ["s","t"]) = none := rfl
example : view (simulate model13 "c" ["s","bad"]) = none := rfl
example : view (simulate model13 "c" ["t","s"]) = none := rfl
example : view (simulate model13 "c" ["t","t"]) = none := rfl
example : view (simulate model13 "c" ["t","bad"]) = none := rfl
example : view (simulate model13 "c" ["bad","s"]) = none := rfl
example : view (simulate model13 "c" ["bad","t"]) = none := rfl
example : view (simulate model13 "c" ["bad","bad"]) = none := rfl
example : view (simulate model13 "c" ["s","s","s"]) = none := rfl
example : view (simulate model13 "c" ["s","s","t"]) = none := rfl
example : view (simulate model13 "c" ["s","s","bad"]) = none := rfl
example : view (simulate model13 "c" ["s","t","s"]) = none := rfl
example : view (simulate model13 "c" ["s","t","t"]) = none := rfl
example : view (simulate model13 "c" ["s","t","bad"]) = none := rfl
example : view (simulate model13 "c" ["s","bad","s"]) = none := rfl
example : view (simulate model13 "c" ["s","bad","t"]) = none := rfl
example : view (simulate model13 "c" ["s","bad","bad"]) = none := rfl
example : view (simulate model13 "c" ["t","s","s"]) = none := rfl
example : view (simulate model13 "c" ["t","s","t"]) = none := rfl
example : view (simulate model13 "c" ["t","s","bad"]) = none := rfl
example : view (simulate model13 "c" ["t","t","s"]) = none := rfl
example : view (simulate model13 "c" ["t","t","t"]) = none := rfl
example : view (simulate model13 "c" ["t","t","bad"]) = none := rfl
example : view (simulate model13 "c" ["t","bad","s"]) = none := rfl
example : view (simulate model13 "c" ["t","bad","t"]) = none := rfl
example : view (simulate model13 "c" ["t","bad","bad"]) = none := rfl
example : view (simulate model13 "c" ["bad","s","s"]) = none := rfl
example : view (simulate model13 "c" ["bad","s","t"]) = none := rfl
example : view (simulate model13 "c" ["bad","s","bad"]) = none := rfl
example : view (simulate model13 "c" ["bad","t","s"]) = none := rfl
example : view (simulate model13 "c" ["bad","t","t"]) = none := rfl
example : view (simulate model13 "c" ["bad","t","bad"]) = none := rfl
example : view (simulate model13 "c" ["bad","bad","s"]) = none := rfl
example : view (simulate model13 "c" ["bad","bad","t"]) = none := rfl
example : view (simulate model13 "c" ["bad","bad","bad"]) = none := rfl
example : view (simulate model13 "outside" []) = none := rfl
example : view (simulate model13 "outside" ["s"]) = none := rfl
example : view (simulate model13 "outside" ["t"]) = none := rfl
example : view (simulate model13 "outside" ["bad"]) = none := rfl
example : view (simulate model13 "outside" ["s","s"]) = none := rfl
example : view (simulate model13 "outside" ["s","t"]) = none := rfl
example : view (simulate model13 "outside" ["s","bad"]) = none := rfl
example : view (simulate model13 "outside" ["t","s"]) = none := rfl
example : view (simulate model13 "outside" ["t","t"]) = none := rfl
example : view (simulate model13 "outside" ["t","bad"]) = none := rfl
example : view (simulate model13 "outside" ["bad","s"]) = none := rfl
example : view (simulate model13 "outside" ["bad","t"]) = none := rfl
example : view (simulate model13 "outside" ["bad","bad"]) = none := rfl
example : view (simulate model13 "outside" ["s","s","s"]) = none := rfl
example : view (simulate model13 "outside" ["s","s","t"]) = none := rfl
example : view (simulate model13 "outside" ["s","s","bad"]) = none := rfl
example : view (simulate model13 "outside" ["s","t","s"]) = none := rfl
example : view (simulate model13 "outside" ["s","t","t"]) = none := rfl
example : view (simulate model13 "outside" ["s","t","bad"]) = none := rfl
example : view (simulate model13 "outside" ["s","bad","s"]) = none := rfl
example : view (simulate model13 "outside" ["s","bad","t"]) = none := rfl
example : view (simulate model13 "outside" ["s","bad","bad"]) = none := rfl
example : view (simulate model13 "outside" ["t","s","s"]) = none := rfl
example : view (simulate model13 "outside" ["t","s","t"]) = none := rfl
example : view (simulate model13 "outside" ["t","s","bad"]) = none := rfl
example : view (simulate model13 "outside" ["t","t","s"]) = none := rfl
example : view (simulate model13 "outside" ["t","t","t"]) = none := rfl
example : view (simulate model13 "outside" ["t","t","bad"]) = none := rfl
example : view (simulate model13 "outside" ["t","bad","s"]) = none := rfl
example : view (simulate model13 "outside" ["t","bad","t"]) = none := rfl
example : view (simulate model13 "outside" ["t","bad","bad"]) = none := rfl
example : view (simulate model13 "outside" ["bad","s","s"]) = none := rfl
example : view (simulate model13 "outside" ["bad","s","t"]) = none := rfl
example : view (simulate model13 "outside" ["bad","s","bad"]) = none := rfl
example : view (simulate model13 "outside" ["bad","t","s"]) = none := rfl
example : view (simulate model13 "outside" ["bad","t","t"]) = none := rfl
example : view (simulate model13 "outside" ["bad","t","bad"]) = none := rfl
example : view (simulate model13 "outside" ["bad","bad","s"]) = none := rfl
example : view (simulate model13 "outside" ["bad","bad","t"]) = none := rfl
example : view (simulate model13 "outside" ["bad","bad","bad"]) = none := rfl
