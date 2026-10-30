import SFT.Computation.ComputationalDynamics
open SFT.Computation.ComputationalDynamics SFT.Mathematics.DynamicsTraces SFT.Mathematics.DynamicsReturns SFT.Mathematics.DynamicsStability
set_option maxRecDepth 1000000
def view (r : Option Orbit) := r.map fun o => (o.trajectory,o.time,o.returnTrace)
def model0 : Model := ⟨["a","b"],[],by rfl⟩
example : view (admitOrbit model0 []) = none := rfl
example : view (admitOrbit model0 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model0 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model0 ["outside"]) = none := rfl
example : view (admitOrbit model0 ["a","a"]) = none := rfl
example : view (admitOrbit model0 ["a","b"]) = none := rfl
example : view (admitOrbit model0 ["a","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","a"]) = none := rfl
example : view (admitOrbit model0 ["b","b"]) = none := rfl
example : view (admitOrbit model0 ["b","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","a","a"]) = none := rfl
example : view (admitOrbit model0 ["a","a","b"]) = none := rfl
example : view (admitOrbit model0 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","b","a"]) = none := rfl
example : view (admitOrbit model0 ["a","b","b"]) = none := rfl
example : view (admitOrbit model0 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","a","a"]) = none := rfl
example : view (admitOrbit model0 ["b","a","b"]) = none := rfl
example : view (admitOrbit model0 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","b","a"]) = none := rfl
example : view (admitOrbit model0 ["b","b","b"]) = none := rfl
example : view (admitOrbit model0 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","a","a","a"]) = none := rfl
example : view (admitOrbit model0 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model0 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model0 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model0 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model0 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model0 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model0 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model0 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model0 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model0 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model0 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model0 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model0 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model0 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model0 ["b","b","b","b"]) = none := rfl
example : view (admitOrbit model0 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model0 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [] = [] := rfl
example : predecessorRecords [] "a" = [] := rfl
example : predecessorRecords [] "b" = [] := rfl
example : predecessorRecords [] "outside" = [] := rfl
def model1 : Model := ⟨["a","b"],[("a","a")],by rfl⟩
example : view (admitOrbit model1 []) = none := rfl
example : view (admitOrbit model1 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model1 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model1 ["outside"]) = none := rfl
example : view (admitOrbit model1 ["a","a"]) = some (["a","a"],.inr [("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model1 ["a","b"]) = none := rfl
example : view (admitOrbit model1 ["a","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","a"]) = none := rfl
example : view (admitOrbit model1 ["b","b"]) = none := rfl
example : view (admitOrbit model1 ["b","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","a","a"]) = some (["a","a","a"],.inr [("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model1 ["a","a","b"]) = none := rfl
example : view (admitOrbit model1 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","b","a"]) = none := rfl
example : view (admitOrbit model1 ["a","b","b"]) = none := rfl
example : view (admitOrbit model1 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","a","a"]) = none := rfl
example : view (admitOrbit model1 ["b","a","b"]) = none := rfl
example : view (admitOrbit model1 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","b","a"]) = none := rfl
example : view (admitOrbit model1 ["b","b","b"]) = none := rfl
example : view (admitOrbit model1 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","a","a","a"]) = some (["a","a","a","a"],.inr [("a","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model1 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model1 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model1 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model1 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model1 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model1 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model1 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model1 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model1 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model1 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model1 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model1 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model1 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model1 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model1 ["b","b","b","b"]) = none := rfl
example : view (admitOrbit model1 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model1 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","a")] = ["a"] := rfl
example : predecessorRecords [("a","a")] "a" = ["a"] := rfl
example : predecessorRecords [("a","a")] "b" = [] := rfl
example : predecessorRecords [("a","a")] "outside" = [] := rfl
def model2 : Model := ⟨["a","b"],[("a","b")],by rfl⟩
example : view (admitOrbit model2 []) = none := rfl
example : view (admitOrbit model2 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model2 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model2 ["outside"]) = none := rfl
example : view (admitOrbit model2 ["a","a"]) = none := rfl
example : view (admitOrbit model2 ["a","b"]) = some (["a","b"],.inr [("a","b")],none) := rfl
example : view (admitOrbit model2 ["a","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","a"]) = none := rfl
example : view (admitOrbit model2 ["b","b"]) = none := rfl
example : view (admitOrbit model2 ["b","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","a","a"]) = none := rfl
example : view (admitOrbit model2 ["a","a","b"]) = none := rfl
example : view (admitOrbit model2 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","b","a"]) = none := rfl
example : view (admitOrbit model2 ["a","b","b"]) = none := rfl
example : view (admitOrbit model2 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","a","a"]) = none := rfl
example : view (admitOrbit model2 ["b","a","b"]) = none := rfl
example : view (admitOrbit model2 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","b","a"]) = none := rfl
example : view (admitOrbit model2 ["b","b","b"]) = none := rfl
example : view (admitOrbit model2 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","a","a","a"]) = none := rfl
example : view (admitOrbit model2 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model2 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model2 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model2 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model2 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model2 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model2 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model2 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model2 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model2 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model2 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model2 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model2 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model2 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model2 ["b","b","b","b"]) = none := rfl
example : view (admitOrbit model2 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model2 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","b")] = [] := rfl
example : predecessorRecords [("a","b")] "a" = [] := rfl
example : predecessorRecords [("a","b")] "b" = ["a"] := rfl
example : predecessorRecords [("a","b")] "outside" = [] := rfl
def model3 : Model := ⟨["a","b"],[("a","a"),("a","b")],by rfl⟩
example : view (admitOrbit model3 []) = none := rfl
example : view (admitOrbit model3 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model3 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model3 ["outside"]) = none := rfl
example : view (admitOrbit model3 ["a","a"]) = some (["a","a"],.inr [("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model3 ["a","b"]) = some (["a","b"],.inr [("a","b")],none) := rfl
example : view (admitOrbit model3 ["a","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","a"]) = none := rfl
example : view (admitOrbit model3 ["b","b"]) = none := rfl
example : view (admitOrbit model3 ["b","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","a","a"]) = some (["a","a","a"],.inr [("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model3 ["a","a","b"]) = some (["a","a","b"],.inr [("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model3 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","b","a"]) = none := rfl
example : view (admitOrbit model3 ["a","b","b"]) = none := rfl
example : view (admitOrbit model3 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","a","a"]) = none := rfl
example : view (admitOrbit model3 ["b","a","b"]) = none := rfl
example : view (admitOrbit model3 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","b","a"]) = none := rfl
example : view (admitOrbit model3 ["b","b","b"]) = none := rfl
example : view (admitOrbit model3 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","a","a","a"]) = some (["a","a","a","a"],.inr [("a","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model3 ["a","a","a","b"]) = some (["a","a","a","b"],.inr [("a","a"),("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model3 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model3 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model3 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model3 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model3 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model3 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model3 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model3 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model3 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model3 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model3 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model3 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model3 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model3 ["b","b","b","b"]) = none := rfl
example : view (admitOrbit model3 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model3 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","a"),("a","b")] = ["a"] := rfl
example : predecessorRecords [("a","a"),("a","b")] "a" = ["a"] := rfl
example : predecessorRecords [("a","a"),("a","b")] "b" = ["a"] := rfl
example : predecessorRecords [("a","a"),("a","b")] "outside" = [] := rfl
def model4 : Model := ⟨["a","b"],[("b","a")],by rfl⟩
example : view (admitOrbit model4 []) = none := rfl
example : view (admitOrbit model4 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model4 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model4 ["outside"]) = none := rfl
example : view (admitOrbit model4 ["a","a"]) = none := rfl
example : view (admitOrbit model4 ["a","b"]) = none := rfl
example : view (admitOrbit model4 ["a","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","a"]) = some (["b","a"],.inr [("b","a")],none) := rfl
example : view (admitOrbit model4 ["b","b"]) = none := rfl
example : view (admitOrbit model4 ["b","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","a","a"]) = none := rfl
example : view (admitOrbit model4 ["a","a","b"]) = none := rfl
example : view (admitOrbit model4 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","b","a"]) = none := rfl
example : view (admitOrbit model4 ["a","b","b"]) = none := rfl
example : view (admitOrbit model4 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","a","a"]) = none := rfl
example : view (admitOrbit model4 ["b","a","b"]) = none := rfl
example : view (admitOrbit model4 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","b","a"]) = none := rfl
example : view (admitOrbit model4 ["b","b","b"]) = none := rfl
example : view (admitOrbit model4 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","a","a","a"]) = none := rfl
example : view (admitOrbit model4 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model4 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model4 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model4 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model4 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model4 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model4 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model4 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model4 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model4 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model4 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model4 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model4 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model4 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model4 ["b","b","b","b"]) = none := rfl
example : view (admitOrbit model4 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model4 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("b","a")] = [] := rfl
example : predecessorRecords [("b","a")] "a" = ["b"] := rfl
example : predecessorRecords [("b","a")] "b" = [] := rfl
example : predecessorRecords [("b","a")] "outside" = [] := rfl
def model5 : Model := ⟨["a","b"],[("a","a"),("b","a")],by rfl⟩
example : view (admitOrbit model5 []) = none := rfl
example : view (admitOrbit model5 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model5 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model5 ["outside"]) = none := rfl
example : view (admitOrbit model5 ["a","a"]) = some (["a","a"],.inr [("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model5 ["a","b"]) = none := rfl
example : view (admitOrbit model5 ["a","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","a"]) = some (["b","a"],.inr [("b","a")],none) := rfl
example : view (admitOrbit model5 ["b","b"]) = none := rfl
example : view (admitOrbit model5 ["b","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","a","a"]) = some (["a","a","a"],.inr [("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model5 ["a","a","b"]) = none := rfl
example : view (admitOrbit model5 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","b","a"]) = none := rfl
example : view (admitOrbit model5 ["a","b","b"]) = none := rfl
example : view (admitOrbit model5 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","a","a"]) = some (["b","a","a"],.inr [("b","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model5 ["b","a","b"]) = none := rfl
example : view (admitOrbit model5 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","b","a"]) = none := rfl
example : view (admitOrbit model5 ["b","b","b"]) = none := rfl
example : view (admitOrbit model5 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","a","a","a"]) = some (["a","a","a","a"],.inr [("a","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model5 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model5 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model5 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model5 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model5 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model5 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model5 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model5 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","a","a","a"]) = some (["b","a","a","a"],.inr [("b","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model5 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model5 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model5 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model5 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model5 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model5 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model5 ["b","b","b","b"]) = none := rfl
example : view (admitOrbit model5 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model5 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","a"),("b","a")] = ["a"] := rfl
example : predecessorRecords [("a","a"),("b","a")] "a" = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("b","a")] "b" = [] := rfl
example : predecessorRecords [("a","a"),("b","a")] "outside" = [] := rfl
def model6 : Model := ⟨["a","b"],[("a","b"),("b","a")],by rfl⟩
example : view (admitOrbit model6 []) = none := rfl
example : view (admitOrbit model6 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model6 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model6 ["outside"]) = none := rfl
example : view (admitOrbit model6 ["a","a"]) = none := rfl
example : view (admitOrbit model6 ["a","b"]) = some (["a","b"],.inr [("a","b")],none) := rfl
example : view (admitOrbit model6 ["a","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","a"]) = some (["b","a"],.inr [("b","a")],none) := rfl
example : view (admitOrbit model6 ["b","b"]) = none := rfl
example : view (admitOrbit model6 ["b","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","a","a"]) = none := rfl
example : view (admitOrbit model6 ["a","a","b"]) = none := rfl
example : view (admitOrbit model6 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","b","a"]) = some (["a","b","a"],.inr [("a","b"),("b","a")],some ["a","b","a"]) := rfl
example : view (admitOrbit model6 ["a","b","b"]) = none := rfl
example : view (admitOrbit model6 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","a","a"]) = none := rfl
example : view (admitOrbit model6 ["b","a","b"]) = some (["b","a","b"],.inr [("b","a"),("a","b")],some ["b","a","b"]) := rfl
example : view (admitOrbit model6 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","b","a"]) = none := rfl
example : view (admitOrbit model6 ["b","b","b"]) = none := rfl
example : view (admitOrbit model6 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","a","a","a"]) = none := rfl
example : view (admitOrbit model6 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model6 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model6 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model6 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model6 ["a","b","a","b"]) = some (["a","b","a","b"],.inr [("a","b"),("b","a"),("a","b")],some ["a","b","a"]) := rfl
example : view (admitOrbit model6 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model6 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model6 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model6 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model6 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","a","b","a"]) = some (["b","a","b","a"],.inr [("b","a"),("a","b"),("b","a")],some ["b","a","b"]) := rfl
example : view (admitOrbit model6 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model6 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model6 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model6 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model6 ["b","b","b","b"]) = none := rfl
example : view (admitOrbit model6 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model6 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","b"),("b","a")] = [] := rfl
example : predecessorRecords [("a","b"),("b","a")] "a" = ["b"] := rfl
example : predecessorRecords [("a","b"),("b","a")] "b" = ["a"] := rfl
example : predecessorRecords [("a","b"),("b","a")] "outside" = [] := rfl
def model7 : Model := ⟨["a","b"],[("a","a"),("a","b"),("b","a")],by rfl⟩
example : view (admitOrbit model7 []) = none := rfl
example : view (admitOrbit model7 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model7 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model7 ["outside"]) = none := rfl
example : view (admitOrbit model7 ["a","a"]) = some (["a","a"],.inr [("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["a","b"]) = some (["a","b"],.inr [("a","b")],none) := rfl
example : view (admitOrbit model7 ["a","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","a"]) = some (["b","a"],.inr [("b","a")],none) := rfl
example : view (admitOrbit model7 ["b","b"]) = none := rfl
example : view (admitOrbit model7 ["b","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","a","a"]) = some (["a","a","a"],.inr [("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["a","a","b"]) = some (["a","a","b"],.inr [("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","b","a"]) = some (["a","b","a"],.inr [("a","b"),("b","a")],some ["a","b","a"]) := rfl
example : view (admitOrbit model7 ["a","b","b"]) = none := rfl
example : view (admitOrbit model7 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","a","a"]) = some (["b","a","a"],.inr [("b","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["b","a","b"]) = some (["b","a","b"],.inr [("b","a"),("a","b")],some ["b","a","b"]) := rfl
example : view (admitOrbit model7 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","b","a"]) = none := rfl
example : view (admitOrbit model7 ["b","b","b"]) = none := rfl
example : view (admitOrbit model7 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","a","a","a"]) = some (["a","a","a","a"],.inr [("a","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["a","a","a","b"]) = some (["a","a","a","b"],.inr [("a","a"),("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","a","b","a"]) = some (["a","a","b","a"],.inr [("a","a"),("a","b"),("b","a")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model7 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","b","a","a"]) = some (["a","b","a","a"],.inr [("a","b"),("b","a"),("a","a")],some ["a","b","a"]) := rfl
example : view (admitOrbit model7 ["a","b","a","b"]) = some (["a","b","a","b"],.inr [("a","b"),("b","a"),("a","b")],some ["a","b","a"]) := rfl
example : view (admitOrbit model7 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model7 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model7 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","a","a","a"]) = some (["b","a","a","a"],.inr [("b","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["b","a","a","b"]) = some (["b","a","a","b"],.inr [("b","a"),("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model7 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","a","b","a"]) = some (["b","a","b","a"],.inr [("b","a"),("a","b"),("b","a")],some ["b","a","b"]) := rfl
example : view (admitOrbit model7 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model7 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model7 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model7 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model7 ["b","b","b","b"]) = none := rfl
example : view (admitOrbit model7 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model7 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","a"),("a","b"),("b","a")] = ["a"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","a")] "a" = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","a")] "b" = ["a"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","a")] "outside" = [] := rfl
def model8 : Model := ⟨["a","b"],[("b","b")],by rfl⟩
example : view (admitOrbit model8 []) = none := rfl
example : view (admitOrbit model8 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model8 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model8 ["outside"]) = none := rfl
example : view (admitOrbit model8 ["a","a"]) = none := rfl
example : view (admitOrbit model8 ["a","b"]) = none := rfl
example : view (admitOrbit model8 ["a","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","a"]) = none := rfl
example : view (admitOrbit model8 ["b","b"]) = some (["b","b"],.inr [("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model8 ["b","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","a","a"]) = none := rfl
example : view (admitOrbit model8 ["a","a","b"]) = none := rfl
example : view (admitOrbit model8 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","b","a"]) = none := rfl
example : view (admitOrbit model8 ["a","b","b"]) = none := rfl
example : view (admitOrbit model8 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","a","a"]) = none := rfl
example : view (admitOrbit model8 ["b","a","b"]) = none := rfl
example : view (admitOrbit model8 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","b","a"]) = none := rfl
example : view (admitOrbit model8 ["b","b","b"]) = some (["b","b","b"],.inr [("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model8 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","a","a","a"]) = none := rfl
example : view (admitOrbit model8 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model8 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model8 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model8 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model8 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model8 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model8 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model8 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model8 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model8 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model8 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model8 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model8 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model8 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model8 ["b","b","b","b"]) = some (["b","b","b","b"],.inr [("b","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model8 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model8 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("b","b")] = ["b"] := rfl
example : predecessorRecords [("b","b")] "a" = [] := rfl
example : predecessorRecords [("b","b")] "b" = ["b"] := rfl
example : predecessorRecords [("b","b")] "outside" = [] := rfl
def model9 : Model := ⟨["a","b"],[("a","a"),("b","b")],by rfl⟩
example : view (admitOrbit model9 []) = none := rfl
example : view (admitOrbit model9 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model9 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model9 ["outside"]) = none := rfl
example : view (admitOrbit model9 ["a","a"]) = some (["a","a"],.inr [("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model9 ["a","b"]) = none := rfl
example : view (admitOrbit model9 ["a","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","a"]) = none := rfl
example : view (admitOrbit model9 ["b","b"]) = some (["b","b"],.inr [("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model9 ["b","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","a","a"]) = some (["a","a","a"],.inr [("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model9 ["a","a","b"]) = none := rfl
example : view (admitOrbit model9 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","b","a"]) = none := rfl
example : view (admitOrbit model9 ["a","b","b"]) = none := rfl
example : view (admitOrbit model9 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","a","a"]) = none := rfl
example : view (admitOrbit model9 ["b","a","b"]) = none := rfl
example : view (admitOrbit model9 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","b","a"]) = none := rfl
example : view (admitOrbit model9 ["b","b","b"]) = some (["b","b","b"],.inr [("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model9 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","a","a","a"]) = some (["a","a","a","a"],.inr [("a","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model9 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model9 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model9 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model9 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model9 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model9 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model9 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model9 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model9 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model9 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model9 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model9 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model9 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model9 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model9 ["b","b","b","b"]) = some (["b","b","b","b"],.inr [("b","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model9 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model9 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","a"),("b","b")] = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("b","b")] "a" = ["a"] := rfl
example : predecessorRecords [("a","a"),("b","b")] "b" = ["b"] := rfl
example : predecessorRecords [("a","a"),("b","b")] "outside" = [] := rfl
def model10 : Model := ⟨["a","b"],[("a","b"),("b","b")],by rfl⟩
example : view (admitOrbit model10 []) = none := rfl
example : view (admitOrbit model10 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model10 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model10 ["outside"]) = none := rfl
example : view (admitOrbit model10 ["a","a"]) = none := rfl
example : view (admitOrbit model10 ["a","b"]) = some (["a","b"],.inr [("a","b")],none) := rfl
example : view (admitOrbit model10 ["a","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","a"]) = none := rfl
example : view (admitOrbit model10 ["b","b"]) = some (["b","b"],.inr [("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model10 ["b","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","a","a"]) = none := rfl
example : view (admitOrbit model10 ["a","a","b"]) = none := rfl
example : view (admitOrbit model10 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","b","a"]) = none := rfl
example : view (admitOrbit model10 ["a","b","b"]) = some (["a","b","b"],.inr [("a","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model10 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","a","a"]) = none := rfl
example : view (admitOrbit model10 ["b","a","b"]) = none := rfl
example : view (admitOrbit model10 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","b","a"]) = none := rfl
example : view (admitOrbit model10 ["b","b","b"]) = some (["b","b","b"],.inr [("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model10 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","a","a","a"]) = none := rfl
example : view (admitOrbit model10 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model10 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model10 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model10 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model10 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model10 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model10 ["a","b","b","b"]) = some (["a","b","b","b"],.inr [("a","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model10 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model10 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model10 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model10 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model10 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model10 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model10 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model10 ["b","b","b","b"]) = some (["b","b","b","b"],.inr [("b","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model10 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model10 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","b"),("b","b")] = ["b"] := rfl
example : predecessorRecords [("a","b"),("b","b")] "a" = [] := rfl
example : predecessorRecords [("a","b"),("b","b")] "b" = ["a","b"] := rfl
example : predecessorRecords [("a","b"),("b","b")] "outside" = [] := rfl
def model11 : Model := ⟨["a","b"],[("a","a"),("a","b"),("b","b")],by rfl⟩
example : view (admitOrbit model11 []) = none := rfl
example : view (admitOrbit model11 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model11 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model11 ["outside"]) = none := rfl
example : view (admitOrbit model11 ["a","a"]) = some (["a","a"],.inr [("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model11 ["a","b"]) = some (["a","b"],.inr [("a","b")],none) := rfl
example : view (admitOrbit model11 ["a","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","a"]) = none := rfl
example : view (admitOrbit model11 ["b","b"]) = some (["b","b"],.inr [("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model11 ["b","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","a","a"]) = some (["a","a","a"],.inr [("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model11 ["a","a","b"]) = some (["a","a","b"],.inr [("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model11 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","b","a"]) = none := rfl
example : view (admitOrbit model11 ["a","b","b"]) = some (["a","b","b"],.inr [("a","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model11 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","a","a"]) = none := rfl
example : view (admitOrbit model11 ["b","a","b"]) = none := rfl
example : view (admitOrbit model11 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","b","a"]) = none := rfl
example : view (admitOrbit model11 ["b","b","b"]) = some (["b","b","b"],.inr [("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model11 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","a","a","a"]) = some (["a","a","a","a"],.inr [("a","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model11 ["a","a","a","b"]) = some (["a","a","a","b"],.inr [("a","a"),("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model11 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model11 ["a","a","b","b"]) = some (["a","a","b","b"],.inr [("a","a"),("a","b"),("b","b")],some ["a","a"]) := rfl
example : view (admitOrbit model11 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model11 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model11 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model11 ["a","b","b","b"]) = some (["a","b","b","b"],.inr [("a","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model11 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model11 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model11 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model11 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model11 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model11 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model11 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","b","b","a"]) = none := rfl
example : view (admitOrbit model11 ["b","b","b","b"]) = some (["b","b","b","b"],.inr [("b","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model11 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model11 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","a"),("a","b"),("b","b")] = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","b")] "a" = ["a"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","b")] "b" = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","b")] "outside" = [] := rfl
def model12 : Model := ⟨["a","b"],[("b","a"),("b","b")],by rfl⟩
example : view (admitOrbit model12 []) = none := rfl
example : view (admitOrbit model12 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model12 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model12 ["outside"]) = none := rfl
example : view (admitOrbit model12 ["a","a"]) = none := rfl
example : view (admitOrbit model12 ["a","b"]) = none := rfl
example : view (admitOrbit model12 ["a","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","a"]) = some (["b","a"],.inr [("b","a")],none) := rfl
example : view (admitOrbit model12 ["b","b"]) = some (["b","b"],.inr [("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model12 ["b","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","a","a"]) = none := rfl
example : view (admitOrbit model12 ["a","a","b"]) = none := rfl
example : view (admitOrbit model12 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","b","a"]) = none := rfl
example : view (admitOrbit model12 ["a","b","b"]) = none := rfl
example : view (admitOrbit model12 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","a","a"]) = none := rfl
example : view (admitOrbit model12 ["b","a","b"]) = none := rfl
example : view (admitOrbit model12 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","b","a"]) = some (["b","b","a"],.inr [("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model12 ["b","b","b"]) = some (["b","b","b"],.inr [("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model12 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","a","a","a"]) = none := rfl
example : view (admitOrbit model12 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model12 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model12 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model12 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model12 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model12 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model12 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model12 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model12 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model12 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model12 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model12 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model12 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model12 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","b","b","a"]) = some (["b","b","b","a"],.inr [("b","b"),("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model12 ["b","b","b","b"]) = some (["b","b","b","b"],.inr [("b","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model12 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model12 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("b","a"),("b","b")] = ["b"] := rfl
example : predecessorRecords [("b","a"),("b","b")] "a" = ["b"] := rfl
example : predecessorRecords [("b","a"),("b","b")] "b" = ["b"] := rfl
example : predecessorRecords [("b","a"),("b","b")] "outside" = [] := rfl
def model13 : Model := ⟨["a","b"],[("a","a"),("b","a"),("b","b")],by rfl⟩
example : view (admitOrbit model13 []) = none := rfl
example : view (admitOrbit model13 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model13 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model13 ["outside"]) = none := rfl
example : view (admitOrbit model13 ["a","a"]) = some (["a","a"],.inr [("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model13 ["a","b"]) = none := rfl
example : view (admitOrbit model13 ["a","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","a"]) = some (["b","a"],.inr [("b","a")],none) := rfl
example : view (admitOrbit model13 ["b","b"]) = some (["b","b"],.inr [("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model13 ["b","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","a","a"]) = some (["a","a","a"],.inr [("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model13 ["a","a","b"]) = none := rfl
example : view (admitOrbit model13 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","b","a"]) = none := rfl
example : view (admitOrbit model13 ["a","b","b"]) = none := rfl
example : view (admitOrbit model13 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","a","a"]) = some (["b","a","a"],.inr [("b","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model13 ["b","a","b"]) = none := rfl
example : view (admitOrbit model13 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","b","a"]) = some (["b","b","a"],.inr [("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model13 ["b","b","b"]) = some (["b","b","b"],.inr [("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model13 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","a","a","a"]) = some (["a","a","a","a"],.inr [("a","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model13 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model13 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model13 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model13 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model13 ["a","b","a","b"]) = none := rfl
example : view (admitOrbit model13 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","b","b","a"]) = none := rfl
example : view (admitOrbit model13 ["a","b","b","b"]) = none := rfl
example : view (admitOrbit model13 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","a","a","a"]) = some (["b","a","a","a"],.inr [("b","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model13 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model13 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","a","b","a"]) = none := rfl
example : view (admitOrbit model13 ["b","a","b","b"]) = none := rfl
example : view (admitOrbit model13 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","b","a","a"]) = some (["b","b","a","a"],.inr [("b","b"),("b","a"),("a","a")],some ["b","b"]) := rfl
example : view (admitOrbit model13 ["b","b","a","b"]) = none := rfl
example : view (admitOrbit model13 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","b","b","a"]) = some (["b","b","b","a"],.inr [("b","b"),("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model13 ["b","b","b","b"]) = some (["b","b","b","b"],.inr [("b","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model13 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model13 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","a"),("b","a"),("b","b")] = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("b","a"),("b","b")] "a" = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("b","a"),("b","b")] "b" = ["b"] := rfl
example : predecessorRecords [("a","a"),("b","a"),("b","b")] "outside" = [] := rfl
def model14 : Model := ⟨["a","b"],[("a","b"),("b","a"),("b","b")],by rfl⟩
example : view (admitOrbit model14 []) = none := rfl
example : view (admitOrbit model14 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model14 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model14 ["outside"]) = none := rfl
example : view (admitOrbit model14 ["a","a"]) = none := rfl
example : view (admitOrbit model14 ["a","b"]) = some (["a","b"],.inr [("a","b")],none) := rfl
example : view (admitOrbit model14 ["a","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","a"]) = some (["b","a"],.inr [("b","a")],none) := rfl
example : view (admitOrbit model14 ["b","b"]) = some (["b","b"],.inr [("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["b","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","a","a"]) = none := rfl
example : view (admitOrbit model14 ["a","a","b"]) = none := rfl
example : view (admitOrbit model14 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","b","a"]) = some (["a","b","a"],.inr [("a","b"),("b","a")],some ["a","b","a"]) := rfl
example : view (admitOrbit model14 ["a","b","b"]) = some (["a","b","b"],.inr [("a","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","a","a"]) = none := rfl
example : view (admitOrbit model14 ["b","a","b"]) = some (["b","a","b"],.inr [("b","a"),("a","b")],some ["b","a","b"]) := rfl
example : view (admitOrbit model14 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","b","a"]) = some (["b","b","a"],.inr [("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["b","b","b"]) = some (["b","b","b"],.inr [("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","a","a","a"]) = none := rfl
example : view (admitOrbit model14 ["a","a","a","b"]) = none := rfl
example : view (admitOrbit model14 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","a","b","a"]) = none := rfl
example : view (admitOrbit model14 ["a","a","b","b"]) = none := rfl
example : view (admitOrbit model14 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","b","a","a"]) = none := rfl
example : view (admitOrbit model14 ["a","b","a","b"]) = some (["a","b","a","b"],.inr [("a","b"),("b","a"),("a","b")],some ["a","b","a"]) := rfl
example : view (admitOrbit model14 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","b","b","a"]) = some (["a","b","b","a"],.inr [("a","b"),("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["a","b","b","b"]) = some (["a","b","b","b"],.inr [("a","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","a","a","a"]) = none := rfl
example : view (admitOrbit model14 ["b","a","a","b"]) = none := rfl
example : view (admitOrbit model14 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","a","b","a"]) = some (["b","a","b","a"],.inr [("b","a"),("a","b"),("b","a")],some ["b","a","b"]) := rfl
example : view (admitOrbit model14 ["b","a","b","b"]) = some (["b","a","b","b"],.inr [("b","a"),("a","b"),("b","b")],some ["b","a","b"]) := rfl
example : view (admitOrbit model14 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","b","a","a"]) = none := rfl
example : view (admitOrbit model14 ["b","b","a","b"]) = some (["b","b","a","b"],.inr [("b","b"),("b","a"),("a","b")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","b","b","a"]) = some (["b","b","b","a"],.inr [("b","b"),("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["b","b","b","b"]) = some (["b","b","b","b"],.inr [("b","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model14 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model14 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","b"),("b","a"),("b","b")] = ["b"] := rfl
example : predecessorRecords [("a","b"),("b","a"),("b","b")] "a" = ["b"] := rfl
example : predecessorRecords [("a","b"),("b","a"),("b","b")] "b" = ["a","b"] := rfl
example : predecessorRecords [("a","b"),("b","a"),("b","b")] "outside" = [] := rfl
def model15 : Model := ⟨["a","b"],[("a","a"),("a","b"),("b","a"),("b","b")],by rfl⟩
example : view (admitOrbit model15 []) = none := rfl
example : view (admitOrbit model15 ["a"]) = some (["a"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model15 ["b"]) = some (["b"],.inl ["empty-One"],none) := rfl
example : view (admitOrbit model15 ["outside"]) = none := rfl
example : view (admitOrbit model15 ["a","a"]) = some (["a","a"],.inr [("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["a","b"]) = some (["a","b"],.inr [("a","b")],none) := rfl
example : view (admitOrbit model15 ["a","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","a"]) = some (["b","a"],.inr [("b","a")],none) := rfl
example : view (admitOrbit model15 ["b","b"]) = some (["b","b"],.inr [("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["b","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","a","a"]) = some (["a","a","a"],.inr [("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["a","a","b"]) = some (["a","a","b"],.inr [("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["a","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","b","a"]) = some (["a","b","a"],.inr [("a","b"),("b","a")],some ["a","b","a"]) := rfl
example : view (admitOrbit model15 ["a","b","b"]) = some (["a","b","b"],.inr [("a","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["a","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","a","a"]) = some (["b","a","a"],.inr [("b","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["b","a","b"]) = some (["b","a","b"],.inr [("b","a"),("a","b")],some ["b","a","b"]) := rfl
example : view (admitOrbit model15 ["b","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","b","a"]) = some (["b","b","a"],.inr [("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["b","b","b"]) = some (["b","b","b"],.inr [("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["b","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","a","a","a"]) = some (["a","a","a","a"],.inr [("a","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["a","a","a","b"]) = some (["a","a","a","b"],.inr [("a","a"),("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["a","a","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","a","b","a"]) = some (["a","a","b","a"],.inr [("a","a"),("a","b"),("b","a")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["a","a","b","b"]) = some (["a","a","b","b"],.inr [("a","a"),("a","b"),("b","b")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["a","a","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","a","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["a","a","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["a","a","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","b","a","a"]) = some (["a","b","a","a"],.inr [("a","b"),("b","a"),("a","a")],some ["a","b","a"]) := rfl
example : view (admitOrbit model15 ["a","b","a","b"]) = some (["a","b","a","b"],.inr [("a","b"),("b","a"),("a","b")],some ["a","b","a"]) := rfl
example : view (admitOrbit model15 ["a","b","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","b","b","a"]) = some (["a","b","b","a"],.inr [("a","b"),("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["a","b","b","b"]) = some (["a","b","b","b"],.inr [("a","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["a","b","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","b","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["a","b","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["a","b","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","a","a"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","a","b"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","b","a"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","b","b"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["a","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","a","a","a"]) = some (["b","a","a","a"],.inr [("b","a"),("a","a"),("a","a")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["b","a","a","b"]) = some (["b","a","a","b"],.inr [("b","a"),("a","a"),("a","b")],some ["a","a"]) := rfl
example : view (admitOrbit model15 ["b","a","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","a","b","a"]) = some (["b","a","b","a"],.inr [("b","a"),("a","b"),("b","a")],some ["b","a","b"]) := rfl
example : view (admitOrbit model15 ["b","a","b","b"]) = some (["b","a","b","b"],.inr [("b","a"),("a","b"),("b","b")],some ["b","a","b"]) := rfl
example : view (admitOrbit model15 ["b","a","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","a","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["b","a","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["b","a","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","b","a","a"]) = some (["b","b","a","a"],.inr [("b","b"),("b","a"),("a","a")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["b","b","a","b"]) = some (["b","b","a","b"],.inr [("b","b"),("b","a"),("a","b")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["b","b","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","b","b","a"]) = some (["b","b","b","a"],.inr [("b","b"),("b","b"),("b","a")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["b","b","b","b"]) = some (["b","b","b","b"],.inr [("b","b"),("b","b"),("b","b")],some ["b","b"]) := rfl
example : view (admitOrbit model15 ["b","b","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","b","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["b","b","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["b","b","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","a","a"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","a","b"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","b","a"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","b","b"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["b","outside","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","a","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","a","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","b","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","b","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","a","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","a","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","a","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","b","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","b","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","b","outside","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","a","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","a","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","a","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","b","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","b","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","b","outside"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","outside","a"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","outside","b"]) = none := rfl
example : view (admitOrbit model15 ["outside","outside","outside","outside"]) = none := rfl
example : fixedForms [("a","a"),("a","b"),("b","a"),("b","b")] = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","a"),("b","b")] "a" = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","a"),("b","b")] "b" = ["a","b"] := rfl
example : predecessorRecords [("a","a"),("a","b"),("b","a"),("b","b")] "outside" = [] := rfl
example : firstReturn [] = none := rfl
example : firstReturn ["a"] = none := rfl
example : firstReturn ["b"] = none := rfl
example : firstReturn ["outside"] = none := rfl
example : firstReturn ["a","a"] = some ["a","a"] := rfl
example : firstReturn ["a","b"] = none := rfl
example : firstReturn ["a","outside"] = none := rfl
example : firstReturn ["b","a"] = none := rfl
example : firstReturn ["b","b"] = some ["b","b"] := rfl
example : firstReturn ["b","outside"] = none := rfl
example : firstReturn ["outside","a"] = none := rfl
example : firstReturn ["outside","b"] = none := rfl
example : firstReturn ["outside","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["a","a","a"] = some ["a","a"] := rfl
example : firstReturn ["a","a","b"] = some ["a","a"] := rfl
example : firstReturn ["a","a","outside"] = some ["a","a"] := rfl
example : firstReturn ["a","b","a"] = some ["a","b","a"] := rfl
example : firstReturn ["a","b","b"] = some ["b","b"] := rfl
example : firstReturn ["a","b","outside"] = none := rfl
example : firstReturn ["a","outside","a"] = some ["a","outside","a"] := rfl
example : firstReturn ["a","outside","b"] = none := rfl
example : firstReturn ["a","outside","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["b","a","a"] = some ["a","a"] := rfl
example : firstReturn ["b","a","b"] = some ["b","a","b"] := rfl
example : firstReturn ["b","a","outside"] = none := rfl
example : firstReturn ["b","b","a"] = some ["b","b"] := rfl
example : firstReturn ["b","b","b"] = some ["b","b"] := rfl
example : firstReturn ["b","b","outside"] = some ["b","b"] := rfl
example : firstReturn ["b","outside","a"] = none := rfl
example : firstReturn ["b","outside","b"] = some ["b","outside","b"] := rfl
example : firstReturn ["b","outside","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","a","a"] = some ["a","a"] := rfl
example : firstReturn ["outside","a","b"] = none := rfl
example : firstReturn ["outside","a","outside"] = some ["outside","a","outside"] := rfl
example : firstReturn ["outside","b","a"] = none := rfl
example : firstReturn ["outside","b","b"] = some ["b","b"] := rfl
example : firstReturn ["outside","b","outside"] = some ["outside","b","outside"] := rfl
example : firstReturn ["outside","outside","a"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","b"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["a","a","a","a"] = some ["a","a"] := rfl
example : firstReturn ["a","a","a","b"] = some ["a","a"] := rfl
example : firstReturn ["a","a","a","outside"] = some ["a","a"] := rfl
example : firstReturn ["a","a","b","a"] = some ["a","a"] := rfl
example : firstReturn ["a","a","b","b"] = some ["a","a"] := rfl
example : firstReturn ["a","a","b","outside"] = some ["a","a"] := rfl
example : firstReturn ["a","a","outside","a"] = some ["a","a"] := rfl
example : firstReturn ["a","a","outside","b"] = some ["a","a"] := rfl
example : firstReturn ["a","a","outside","outside"] = some ["a","a"] := rfl
example : firstReturn ["a","b","a","a"] = some ["a","b","a"] := rfl
example : firstReturn ["a","b","a","b"] = some ["a","b","a"] := rfl
example : firstReturn ["a","b","a","outside"] = some ["a","b","a"] := rfl
example : firstReturn ["a","b","b","a"] = some ["b","b"] := rfl
example : firstReturn ["a","b","b","b"] = some ["b","b"] := rfl
example : firstReturn ["a","b","b","outside"] = some ["b","b"] := rfl
example : firstReturn ["a","b","outside","a"] = some ["a","b","outside","a"] := rfl
example : firstReturn ["a","b","outside","b"] = some ["b","outside","b"] := rfl
example : firstReturn ["a","b","outside","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["a","outside","a","a"] = some ["a","outside","a"] := rfl
example : firstReturn ["a","outside","a","b"] = some ["a","outside","a"] := rfl
example : firstReturn ["a","outside","a","outside"] = some ["a","outside","a"] := rfl
example : firstReturn ["a","outside","b","a"] = some ["a","outside","b","a"] := rfl
example : firstReturn ["a","outside","b","b"] = some ["b","b"] := rfl
example : firstReturn ["a","outside","b","outside"] = some ["outside","b","outside"] := rfl
example : firstReturn ["a","outside","outside","a"] = some ["outside","outside"] := rfl
example : firstReturn ["a","outside","outside","b"] = some ["outside","outside"] := rfl
example : firstReturn ["a","outside","outside","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["b","a","a","a"] = some ["a","a"] := rfl
example : firstReturn ["b","a","a","b"] = some ["a","a"] := rfl
example : firstReturn ["b","a","a","outside"] = some ["a","a"] := rfl
example : firstReturn ["b","a","b","a"] = some ["b","a","b"] := rfl
example : firstReturn ["b","a","b","b"] = some ["b","a","b"] := rfl
example : firstReturn ["b","a","b","outside"] = some ["b","a","b"] := rfl
example : firstReturn ["b","a","outside","a"] = some ["a","outside","a"] := rfl
example : firstReturn ["b","a","outside","b"] = some ["b","a","outside","b"] := rfl
example : firstReturn ["b","a","outside","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["b","b","a","a"] = some ["b","b"] := rfl
example : firstReturn ["b","b","a","b"] = some ["b","b"] := rfl
example : firstReturn ["b","b","a","outside"] = some ["b","b"] := rfl
example : firstReturn ["b","b","b","a"] = some ["b","b"] := rfl
example : firstReturn ["b","b","b","b"] = some ["b","b"] := rfl
example : firstReturn ["b","b","b","outside"] = some ["b","b"] := rfl
example : firstReturn ["b","b","outside","a"] = some ["b","b"] := rfl
example : firstReturn ["b","b","outside","b"] = some ["b","b"] := rfl
example : firstReturn ["b","b","outside","outside"] = some ["b","b"] := rfl
example : firstReturn ["b","outside","a","a"] = some ["a","a"] := rfl
example : firstReturn ["b","outside","a","b"] = some ["b","outside","a","b"] := rfl
example : firstReturn ["b","outside","a","outside"] = some ["outside","a","outside"] := rfl
example : firstReturn ["b","outside","b","a"] = some ["b","outside","b"] := rfl
example : firstReturn ["b","outside","b","b"] = some ["b","outside","b"] := rfl
example : firstReturn ["b","outside","b","outside"] = some ["b","outside","b"] := rfl
example : firstReturn ["b","outside","outside","a"] = some ["outside","outside"] := rfl
example : firstReturn ["b","outside","outside","b"] = some ["outside","outside"] := rfl
example : firstReturn ["b","outside","outside","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","a","a","a"] = some ["a","a"] := rfl
example : firstReturn ["outside","a","a","b"] = some ["a","a"] := rfl
example : firstReturn ["outside","a","a","outside"] = some ["a","a"] := rfl
example : firstReturn ["outside","a","b","a"] = some ["a","b","a"] := rfl
example : firstReturn ["outside","a","b","b"] = some ["b","b"] := rfl
example : firstReturn ["outside","a","b","outside"] = some ["outside","a","b","outside"] := rfl
example : firstReturn ["outside","a","outside","a"] = some ["outside","a","outside"] := rfl
example : firstReturn ["outside","a","outside","b"] = some ["outside","a","outside"] := rfl
example : firstReturn ["outside","a","outside","outside"] = some ["outside","a","outside"] := rfl
example : firstReturn ["outside","b","a","a"] = some ["a","a"] := rfl
example : firstReturn ["outside","b","a","b"] = some ["b","a","b"] := rfl
example : firstReturn ["outside","b","a","outside"] = some ["outside","b","a","outside"] := rfl
example : firstReturn ["outside","b","b","a"] = some ["b","b"] := rfl
example : firstReturn ["outside","b","b","b"] = some ["b","b"] := rfl
example : firstReturn ["outside","b","b","outside"] = some ["b","b"] := rfl
example : firstReturn ["outside","b","outside","a"] = some ["outside","b","outside"] := rfl
example : firstReturn ["outside","b","outside","b"] = some ["outside","b","outside"] := rfl
example : firstReturn ["outside","b","outside","outside"] = some ["outside","b","outside"] := rfl
example : firstReturn ["outside","outside","a","a"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","a","b"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","a","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","b","a"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","b","b"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","b","outside"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","outside","a"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","outside","b"] = some ["outside","outside"] := rfl
example : firstReturn ["outside","outside","outside","outside"] = some ["outside","outside"] := rfl
def stabilityCases : List (Transitions × String × List String × Bool) := [([],"a",[],true),([],"a",["a"],true),([],"a",["b"],false),([],"a",["outside"],false),([],"a",["a","a"],true),([],"a",["a","b"],false),([],"a",["a","outside"],false),([],"a",["b","a"],false),([],"a",["b","b"],false),([],"a",["b","outside"],false),([],"a",["outside","a"],false),([],"a",["outside","b"],false),([],"a",["outside","outside"],false),([],"b",[],true),([],"b",["a"],false),([],"b",["b"],true),([],"b",["outside"],false),([],"b",["a","a"],false),([],"b",["a","b"],false),([],"b",["a","outside"],false),([],"b",["b","a"],false),([],"b",["b","b"],true),([],"b",["b","outside"],false),([],"b",["outside","a"],false),([],"b",["outside","b"],false),([],"b",["outside","outside"],false),([],"outside",[],true),([],"outside",["a"],false),([],"outside",["b"],false),([],"outside",["outside"],true),([],"outside",["a","a"],false),([],"outside",["a","b"],false),([],"outside",["a","outside"],false),([],"outside",["b","a"],false),([],"outside",["b","b"],false),([],"outside",["b","outside"],false),([],"outside",["outside","a"],false),([],"outside",["outside","b"],false),([],"outside",["outside","outside"],true),([("a","a")],"a",[],true),([("a","a")],"a",["a"],true),([("a","a")],"a",["b"],false),([("a","a")],"a",["outside"],false),([("a","a")],"a",["a","a"],true),([("a","a")],"a",["a","b"],false),([("a","a")],"a",["a","outside"],false),([("a","a")],"a",["b","a"],false),([("a","a")],"a",["b","b"],false),([("a","a")],"a",["b","outside"],false),([("a","a")],"a",["outside","a"],false),([("a","a")],"a",["outside","b"],false),([("a","a")],"a",["outside","outside"],false),([("a","a")],"b",[],true),([("a","a")],"b",["a"],false),([("a","a")],"b",["b"],true),([("a","a")],"b",["outside"],false),([("a","a")],"b",["a","a"],false),([("a","a")],"b",["a","b"],false),([("a","a")],"b",["a","outside"],false),([("a","a")],"b",["b","a"],false),([("a","a")],"b",["b","b"],true),([("a","a")],"b",["b","outside"],false),([("a","a")],"b",["outside","a"],false),([("a","a")],"b",["outside","b"],false),([("a","a")],"b",["outside","outside"],false),([("a","a")],"outside",[],true),([("a","a")],"outside",["a"],false),([("a","a")],"outside",["b"],false),([("a","a")],"outside",["outside"],true),([("a","a")],"outside",["a","a"],false),([("a","a")],"outside",["a","b"],false),([("a","a")],"outside",["a","outside"],false),([("a","a")],"outside",["b","a"],false),([("a","a")],"outside",["b","b"],false),([("a","a")],"outside",["b","outside"],false),([("a","a")],"outside",["outside","a"],false),([("a","a")],"outside",["outside","b"],false),([("a","a")],"outside",["outside","outside"],true),([("a","b")],"a",[],true),([("a","b")],"a",["a"],true),([("a","b")],"a",["b"],false),([("a","b")],"a",["outside"],false),([("a","b")],"a",["a","a"],true),([("a","b")],"a",["a","b"],false),([("a","b")],"a",["a","outside"],false),([("a","b")],"a",["b","a"],false),([("a","b")],"a",["b","b"],false),([("a","b")],"a",["b","outside"],false),([("a","b")],"a",["outside","a"],false),([("a","b")],"a",["outside","b"],false),([("a","b")],"a",["outside","outside"],false),([("a","b")],"b",[],true),([("a","b")],"b",["a"],true),([("a","b")],"b",["b"],true),([("a","b")],"b",["outside"],false),([("a","b")],"b",["a","a"],true),([("a","b")],"b",["a","b"],true),([("a","b")],"b",["a","outside"],false),([("a","b")],"b",["b","a"],true),([("a","b")],"b",["b","b"],true),([("a","b")],"b",["b","outside"],false),([("a","b")],"b",["outside","a"],false),([("a","b")],"b",["outside","b"],false),([("a","b")],"b",["outside","outside"],false),([("a","b")],"outside",[],true),([("a","b")],"outside",["a"],false),([("a","b")],"outside",["b"],false),([("a","b")],"outside",["outside"],true),([("a","b")],"outside",["a","a"],false),([("a","b")],"outside",["a","b"],false),([("a","b")],"outside",["a","outside"],false),([("a","b")],"outside",["b","a"],false),([("a","b")],"outside",["b","b"],false),([("a","b")],"outside",["b","outside"],false),([("a","b")],"outside",["outside","a"],false),([("a","b")],"outside",["outside","b"],false),([("a","b")],"outside",["outside","outside"],true),([("a","a"),("a","b")],"a",[],true),([("a","a"),("a","b")],"a",["a"],true),([("a","a"),("a","b")],"a",["b"],false),([("a","a"),("a","b")],"a",["outside"],false),([("a","a"),("a","b")],"a",["a","a"],true),([("a","a"),("a","b")],"a",["a","b"],false),([("a","a"),("a","b")],"a",["a","outside"],false),([("a","a"),("a","b")],"a",["b","a"],false),([("a","a"),("a","b")],"a",["b","b"],false),([("a","a"),("a","b")],"a",["b","outside"],false),([("a","a"),("a","b")],"a",["outside","a"],false),([("a","a"),("a","b")],"a",["outside","b"],false),([("a","a"),("a","b")],"a",["outside","outside"],false),([("a","a"),("a","b")],"b",[],true),([("a","a"),("a","b")],"b",["a"],true),([("a","a"),("a","b")],"b",["b"],true),([("a","a"),("a","b")],"b",["outside"],false),([("a","a"),("a","b")],"b",["a","a"],true),([("a","a"),("a","b")],"b",["a","b"],true),([("a","a"),("a","b")],"b",["a","outside"],false),([("a","a"),("a","b")],"b",["b","a"],true),([("a","a"),("a","b")],"b",["b","b"],true),([("a","a"),("a","b")],"b",["b","outside"],false),([("a","a"),("a","b")],"b",["outside","a"],false),([("a","a"),("a","b")],"b",["outside","b"],false),([("a","a"),("a","b")],"b",["outside","outside"],false),([("a","a"),("a","b")],"outside",[],true),([("a","a"),("a","b")],"outside",["a"],false),([("a","a"),("a","b")],"outside",["b"],false),([("a","a"),("a","b")],"outside",["outside"],true),([("a","a"),("a","b")],"outside",["a","a"],false),([("a","a"),("a","b")],"outside",["a","b"],false),([("a","a"),("a","b")],"outside",["a","outside"],false),([("a","a"),("a","b")],"outside",["b","a"],false),([("a","a"),("a","b")],"outside",["b","b"],false),([("a","a"),("a","b")],"outside",["b","outside"],false),([("a","a"),("a","b")],"outside",["outside","a"],false),([("a","a"),("a","b")],"outside",["outside","b"],false),([("a","a"),("a","b")],"outside",["outside","outside"],true),([("b","a")],"a",[],true),([("b","a")],"a",["a"],true),([("b","a")],"a",["b"],true),([("b","a")],"a",["outside"],false),([("b","a")],"a",["a","a"],true),([("b","a")],"a",["a","b"],true),([("b","a")],"a",["a","outside"],false),([("b","a")],"a",["b","a"],true),([("b","a")],"a",["b","b"],true),([("b","a")],"a",["b","outside"],false),([("b","a")],"a",["outside","a"],false),([("b","a")],"a",["outside","b"],false),([("b","a")],"a",["outside","outside"],false),([("b","a")],"b",[],true),([("b","a")],"b",["a"],false),([("b","a")],"b",["b"],true),([("b","a")],"b",["outside"],false),([("b","a")],"b",["a","a"],false),([("b","a")],"b",["a","b"],false),([("b","a")],"b",["a","outside"],false),([("b","a")],"b",["b","a"],false),([("b","a")],"b",["b","b"],true),([("b","a")],"b",["b","outside"],false),([("b","a")],"b",["outside","a"],false),([("b","a")],"b",["outside","b"],false),([("b","a")],"b",["outside","outside"],false),([("b","a")],"outside",[],true),([("b","a")],"outside",["a"],false),([("b","a")],"outside",["b"],false),([("b","a")],"outside",["outside"],true),([("b","a")],"outside",["a","a"],false),([("b","a")],"outside",["a","b"],false),([("b","a")],"outside",["a","outside"],false),([("b","a")],"outside",["b","a"],false),([("b","a")],"outside",["b","b"],false),([("b","a")],"outside",["b","outside"],false),([("b","a")],"outside",["outside","a"],false),([("b","a")],"outside",["outside","b"],false),([("b","a")],"outside",["outside","outside"],true),([("a","a"),("b","a")],"a",[],true),([("a","a"),("b","a")],"a",["a"],true),([("a","a"),("b","a")],"a",["b"],true),([("a","a"),("b","a")],"a",["outside"],false),([("a","a"),("b","a")],"a",["a","a"],true),([("a","a"),("b","a")],"a",["a","b"],true),([("a","a"),("b","a")],"a",["a","outside"],false),([("a","a"),("b","a")],"a",["b","a"],true),([("a","a"),("b","a")],"a",["b","b"],true),([("a","a"),("b","a")],"a",["b","outside"],false),([("a","a"),("b","a")],"a",["outside","a"],false),([("a","a"),("b","a")],"a",["outside","b"],false),([("a","a"),("b","a")],"a",["outside","outside"],false),([("a","a"),("b","a")],"b",[],true),([("a","a"),("b","a")],"b",["a"],false),([("a","a"),("b","a")],"b",["b"],true),([("a","a"),("b","a")],"b",["outside"],false),([("a","a"),("b","a")],"b",["a","a"],false),([("a","a"),("b","a")],"b",["a","b"],false),([("a","a"),("b","a")],"b",["a","outside"],false),([("a","a"),("b","a")],"b",["b","a"],false),([("a","a"),("b","a")],"b",["b","b"],true),([("a","a"),("b","a")],"b",["b","outside"],false),([("a","a"),("b","a")],"b",["outside","a"],false),([("a","a"),("b","a")],"b",["outside","b"],false),([("a","a"),("b","a")],"b",["outside","outside"],false),([("a","a"),("b","a")],"outside",[],true),([("a","a"),("b","a")],"outside",["a"],false),([("a","a"),("b","a")],"outside",["b"],false),([("a","a"),("b","a")],"outside",["outside"],true),([("a","a"),("b","a")],"outside",["a","a"],false),([("a","a"),("b","a")],"outside",["a","b"],false),([("a","a"),("b","a")],"outside",["a","outside"],false),([("a","a"),("b","a")],"outside",["b","a"],false),([("a","a"),("b","a")],"outside",["b","b"],false),([("a","a"),("b","a")],"outside",["b","outside"],false),([("a","a"),("b","a")],"outside",["outside","a"],false),([("a","a"),("b","a")],"outside",["outside","b"],false),([("a","a"),("b","a")],"outside",["outside","outside"],true),([("a","b"),("b","a")],"a",[],true),([("a","b"),("b","a")],"a",["a"],true),([("a","b"),("b","a")],"a",["b"],true),([("a","b"),("b","a")],"a",["outside"],false),([("a","b"),("b","a")],"a",["a","a"],true),([("a","b"),("b","a")],"a",["a","b"],true),([("a","b"),("b","a")],"a",["a","outside"],false),([("a","b"),("b","a")],"a",["b","a"],true),([("a","b"),("b","a")],"a",["b","b"],true),([("a","b"),("b","a")],"a",["b","outside"],false),([("a","b"),("b","a")],"a",["outside","a"],false),([("a","b"),("b","a")],"a",["outside","b"],false),([("a","b"),("b","a")],"a",["outside","outside"],false),([("a","b"),("b","a")],"b",[],true),([("a","b"),("b","a")],"b",["a"],true),([("a","b"),("b","a")],"b",["b"],true),([("a","b"),("b","a")],"b",["outside"],false),([("a","b"),("b","a")],"b",["a","a"],true),([("a","b"),("b","a")],"b",["a","b"],true),([("a","b"),("b","a")],"b",["a","outside"],false),([("a","b"),("b","a")],"b",["b","a"],true),([("a","b"),("b","a")],"b",["b","b"],true),([("a","b"),("b","a")],"b",["b","outside"],false),([("a","b"),("b","a")],"b",["outside","a"],false),([("a","b"),("b","a")],"b",["outside","b"],false),([("a","b"),("b","a")],"b",["outside","outside"],false),([("a","b"),("b","a")],"outside",[],true),([("a","b"),("b","a")],"outside",["a"],false),([("a","b"),("b","a")],"outside",["b"],false),([("a","b"),("b","a")],"outside",["outside"],true),([("a","b"),("b","a")],"outside",["a","a"],false),([("a","b"),("b","a")],"outside",["a","b"],false),([("a","b"),("b","a")],"outside",["a","outside"],false),([("a","b"),("b","a")],"outside",["b","a"],false),([("a","b"),("b","a")],"outside",["b","b"],false),([("a","b"),("b","a")],"outside",["b","outside"],false),([("a","b"),("b","a")],"outside",["outside","a"],false),([("a","b"),("b","a")],"outside",["outside","b"],false),([("a","b"),("b","a")],"outside",["outside","outside"],true),([("a","a"),("a","b"),("b","a")],"a",[],true),([("a","a"),("a","b"),("b","a")],"a",["a"],true),([("a","a"),("a","b"),("b","a")],"a",["b"],true),([("a","a"),("a","b"),("b","a")],"a",["outside"],false),([("a","a"),("a","b"),("b","a")],"a",["a","a"],true),([("a","a"),("a","b"),("b","a")],"a",["a","b"],true),([("a","a"),("a","b"),("b","a")],"a",["a","outside"],false),([("a","a"),("a","b"),("b","a")],"a",["b","a"],true),([("a","a"),("a","b"),("b","a")],"a",["b","b"],true),([("a","a"),("a","b"),("b","a")],"a",["b","outside"],false),([("a","a"),("a","b"),("b","a")],"a",["outside","a"],false),([("a","a"),("a","b"),("b","a")],"a",["outside","b"],false),([("a","a"),("a","b"),("b","a")],"a",["outside","outside"],false),([("a","a"),("a","b"),("b","a")],"b",[],true),([("a","a"),("a","b"),("b","a")],"b",["a"],true),([("a","a"),("a","b"),("b","a")],"b",["b"],true),([("a","a"),("a","b"),("b","a")],"b",["outside"],false),([("a","a"),("a","b"),("b","a")],"b",["a","a"],true),([("a","a"),("a","b"),("b","a")],"b",["a","b"],true),([("a","a"),("a","b"),("b","a")],"b",["a","outside"],false),([("a","a"),("a","b"),("b","a")],"b",["b","a"],true),([("a","a"),("a","b"),("b","a")],"b",["b","b"],true),([("a","a"),("a","b"),("b","a")],"b",["b","outside"],false),([("a","a"),("a","b"),("b","a")],"b",["outside","a"],false),([("a","a"),("a","b"),("b","a")],"b",["outside","b"],false),([("a","a"),("a","b"),("b","a")],"b",["outside","outside"],false),([("a","a"),("a","b"),("b","a")],"outside",[],true),([("a","a"),("a","b"),("b","a")],"outside",["a"],false),([("a","a"),("a","b"),("b","a")],"outside",["b"],false),([("a","a"),("a","b"),("b","a")],"outside",["outside"],true),([("a","a"),("a","b"),("b","a")],"outside",["a","a"],false),([("a","a"),("a","b"),("b","a")],"outside",["a","b"],false),([("a","a"),("a","b"),("b","a")],"outside",["a","outside"],false),([("a","a"),("a","b"),("b","a")],"outside",["b","a"],false),([("a","a"),("a","b"),("b","a")],"outside",["b","b"],false),([("a","a"),("a","b"),("b","a")],"outside",["b","outside"],false),([("a","a"),("a","b"),("b","a")],"outside",["outside","a"],false),([("a","a"),("a","b"),("b","a")],"outside",["outside","b"],false),([("a","a"),("a","b"),("b","a")],"outside",["outside","outside"],true),([("b","b")],"a",[],true),([("b","b")],"a",["a"],true),([("b","b")],"a",["b"],false),([("b","b")],"a",["outside"],false),([("b","b")],"a",["a","a"],true),([("b","b")],"a",["a","b"],false),([("b","b")],"a",["a","outside"],false),([("b","b")],"a",["b","a"],false),([("b","b")],"a",["b","b"],false),([("b","b")],"a",["b","outside"],false),([("b","b")],"a",["outside","a"],false),([("b","b")],"a",["outside","b"],false),([("b","b")],"a",["outside","outside"],false),([("b","b")],"b",[],true),([("b","b")],"b",["a"],false),([("b","b")],"b",["b"],true),([("b","b")],"b",["outside"],false),([("b","b")],"b",["a","a"],false),([("b","b")],"b",["a","b"],false),([("b","b")],"b",["a","outside"],false),([("b","b")],"b",["b","a"],false),([("b","b")],"b",["b","b"],true),([("b","b")],"b",["b","outside"],false),([("b","b")],"b",["outside","a"],false),([("b","b")],"b",["outside","b"],false),([("b","b")],"b",["outside","outside"],false),([("b","b")],"outside",[],true),([("b","b")],"outside",["a"],false),([("b","b")],"outside",["b"],false),([("b","b")],"outside",["outside"],true),([("b","b")],"outside",["a","a"],false),([("b","b")],"outside",["a","b"],false),([("b","b")],"outside",["a","outside"],false),([("b","b")],"outside",["b","a"],false),([("b","b")],"outside",["b","b"],false),([("b","b")],"outside",["b","outside"],false),([("b","b")],"outside",["outside","a"],false),([("b","b")],"outside",["outside","b"],false),([("b","b")],"outside",["outside","outside"],true),([("a","a"),("b","b")],"a",[],true),([("a","a"),("b","b")],"a",["a"],true),([("a","a"),("b","b")],"a",["b"],false),([("a","a"),("b","b")],"a",["outside"],false),([("a","a"),("b","b")],"a",["a","a"],true),([("a","a"),("b","b")],"a",["a","b"],false),([("a","a"),("b","b")],"a",["a","outside"],false),([("a","a"),("b","b")],"a",["b","a"],false),([("a","a"),("b","b")],"a",["b","b"],false),([("a","a"),("b","b")],"a",["b","outside"],false),([("a","a"),("b","b")],"a",["outside","a"],false),([("a","a"),("b","b")],"a",["outside","b"],false),([("a","a"),("b","b")],"a",["outside","outside"],false),([("a","a"),("b","b")],"b",[],true),([("a","a"),("b","b")],"b",["a"],false),([("a","a"),("b","b")],"b",["b"],true),([("a","a"),("b","b")],"b",["outside"],false),([("a","a"),("b","b")],"b",["a","a"],false),([("a","a"),("b","b")],"b",["a","b"],false),([("a","a"),("b","b")],"b",["a","outside"],false),([("a","a"),("b","b")],"b",["b","a"],false),([("a","a"),("b","b")],"b",["b","b"],true),([("a","a"),("b","b")],"b",["b","outside"],false),([("a","a"),("b","b")],"b",["outside","a"],false),([("a","a"),("b","b")],"b",["outside","b"],false),([("a","a"),("b","b")],"b",["outside","outside"],false),([("a","a"),("b","b")],"outside",[],true),([("a","a"),("b","b")],"outside",["a"],false),([("a","a"),("b","b")],"outside",["b"],false),([("a","a"),("b","b")],"outside",["outside"],true),([("a","a"),("b","b")],"outside",["a","a"],false),([("a","a"),("b","b")],"outside",["a","b"],false),([("a","a"),("b","b")],"outside",["a","outside"],false),([("a","a"),("b","b")],"outside",["b","a"],false),([("a","a"),("b","b")],"outside",["b","b"],false),([("a","a"),("b","b")],"outside",["b","outside"],false),([("a","a"),("b","b")],"outside",["outside","a"],false),([("a","a"),("b","b")],"outside",["outside","b"],false),([("a","a"),("b","b")],"outside",["outside","outside"],true),([("a","b"),("b","b")],"a",[],true),([("a","b"),("b","b")],"a",["a"],true),([("a","b"),("b","b")],"a",["b"],false),([("a","b"),("b","b")],"a",["outside"],false),([("a","b"),("b","b")],"a",["a","a"],true),([("a","b"),("b","b")],"a",["a","b"],false),([("a","b"),("b","b")],"a",["a","outside"],false),([("a","b"),("b","b")],"a",["b","a"],false),([("a","b"),("b","b")],"a",["b","b"],false),([("a","b"),("b","b")],"a",["b","outside"],false),([("a","b"),("b","b")],"a",["outside","a"],false),([("a","b"),("b","b")],"a",["outside","b"],false),([("a","b"),("b","b")],"a",["outside","outside"],false),([("a","b"),("b","b")],"b",[],true),([("a","b"),("b","b")],"b",["a"],true),([("a","b"),("b","b")],"b",["b"],true),([("a","b"),("b","b")],"b",["outside"],false),([("a","b"),("b","b")],"b",["a","a"],true),([("a","b"),("b","b")],"b",["a","b"],true),([("a","b"),("b","b")],"b",["a","outside"],false),([("a","b"),("b","b")],"b",["b","a"],true),([("a","b"),("b","b")],"b",["b","b"],true),([("a","b"),("b","b")],"b",["b","outside"],false),([("a","b"),("b","b")],"b",["outside","a"],false),([("a","b"),("b","b")],"b",["outside","b"],false),([("a","b"),("b","b")],"b",["outside","outside"],false),([("a","b"),("b","b")],"outside",[],true),([("a","b"),("b","b")],"outside",["a"],false),([("a","b"),("b","b")],"outside",["b"],false),([("a","b"),("b","b")],"outside",["outside"],true),([("a","b"),("b","b")],"outside",["a","a"],false),([("a","b"),("b","b")],"outside",["a","b"],false),([("a","b"),("b","b")],"outside",["a","outside"],false),([("a","b"),("b","b")],"outside",["b","a"],false),([("a","b"),("b","b")],"outside",["b","b"],false),([("a","b"),("b","b")],"outside",["b","outside"],false),([("a","b"),("b","b")],"outside",["outside","a"],false),([("a","b"),("b","b")],"outside",["outside","b"],false),([("a","b"),("b","b")],"outside",["outside","outside"],true),([("a","a"),("a","b"),("b","b")],"a",[],true),([("a","a"),("a","b"),("b","b")],"a",["a"],true),([("a","a"),("a","b"),("b","b")],"a",["b"],false),([("a","a"),("a","b"),("b","b")],"a",["outside"],false),([("a","a"),("a","b"),("b","b")],"a",["a","a"],true),([("a","a"),("a","b"),("b","b")],"a",["a","b"],false),([("a","a"),("a","b"),("b","b")],"a",["a","outside"],false),([("a","a"),("a","b"),("b","b")],"a",["b","a"],false),([("a","a"),("a","b"),("b","b")],"a",["b","b"],false),([("a","a"),("a","b"),("b","b")],"a",["b","outside"],false),([("a","a"),("a","b"),("b","b")],"a",["outside","a"],false),([("a","a"),("a","b"),("b","b")],"a",["outside","b"],false),([("a","a"),("a","b"),("b","b")],"a",["outside","outside"],false),([("a","a"),("a","b"),("b","b")],"b",[],true),([("a","a"),("a","b"),("b","b")],"b",["a"],true),([("a","a"),("a","b"),("b","b")],"b",["b"],true),([("a","a"),("a","b"),("b","b")],"b",["outside"],false),([("a","a"),("a","b"),("b","b")],"b",["a","a"],true),([("a","a"),("a","b"),("b","b")],"b",["a","b"],true),([("a","a"),("a","b"),("b","b")],"b",["a","outside"],false),([("a","a"),("a","b"),("b","b")],"b",["b","a"],true),([("a","a"),("a","b"),("b","b")],"b",["b","b"],true),([("a","a"),("a","b"),("b","b")],"b",["b","outside"],false),([("a","a"),("a","b"),("b","b")],"b",["outside","a"],false),([("a","a"),("a","b"),("b","b")],"b",["outside","b"],false),([("a","a"),("a","b"),("b","b")],"b",["outside","outside"],false),([("a","a"),("a","b"),("b","b")],"outside",[],true),([("a","a"),("a","b"),("b","b")],"outside",["a"],false),([("a","a"),("a","b"),("b","b")],"outside",["b"],false),([("a","a"),("a","b"),("b","b")],"outside",["outside"],true),([("a","a"),("a","b"),("b","b")],"outside",["a","a"],false),([("a","a"),("a","b"),("b","b")],"outside",["a","b"],false),([("a","a"),("a","b"),("b","b")],"outside",["a","outside"],false),([("a","a"),("a","b"),("b","b")],"outside",["b","a"],false),([("a","a"),("a","b"),("b","b")],"outside",["b","b"],false),([("a","a"),("a","b"),("b","b")],"outside",["b","outside"],false),([("a","a"),("a","b"),("b","b")],"outside",["outside","a"],false),([("a","a"),("a","b"),("b","b")],"outside",["outside","b"],false),([("a","a"),("a","b"),("b","b")],"outside",["outside","outside"],true),([("b","a"),("b","b")],"a",[],true),([("b","a"),("b","b")],"a",["a"],true),([("b","a"),("b","b")],"a",["b"],true),([("b","a"),("b","b")],"a",["outside"],false),([("b","a"),("b","b")],"a",["a","a"],true),([("b","a"),("b","b")],"a",["a","b"],true),([("b","a"),("b","b")],"a",["a","outside"],false),([("b","a"),("b","b")],"a",["b","a"],true),([("b","a"),("b","b")],"a",["b","b"],true),([("b","a"),("b","b")],"a",["b","outside"],false),([("b","a"),("b","b")],"a",["outside","a"],false),([("b","a"),("b","b")],"a",["outside","b"],false),([("b","a"),("b","b")],"a",["outside","outside"],false),([("b","a"),("b","b")],"b",[],true),([("b","a"),("b","b")],"b",["a"],false),([("b","a"),("b","b")],"b",["b"],true),([("b","a"),("b","b")],"b",["outside"],false),([("b","a"),("b","b")],"b",["a","a"],false),([("b","a"),("b","b")],"b",["a","b"],false),([("b","a"),("b","b")],"b",["a","outside"],false),([("b","a"),("b","b")],"b",["b","a"],false),([("b","a"),("b","b")],"b",["b","b"],true),([("b","a"),("b","b")],"b",["b","outside"],false),([("b","a"),("b","b")],"b",["outside","a"],false),([("b","a"),("b","b")],"b",["outside","b"],false),([("b","a"),("b","b")],"b",["outside","outside"],false),([("b","a"),("b","b")],"outside",[],true),([("b","a"),("b","b")],"outside",["a"],false),([("b","a"),("b","b")],"outside",["b"],false),([("b","a"),("b","b")],"outside",["outside"],true),([("b","a"),("b","b")],"outside",["a","a"],false),([("b","a"),("b","b")],"outside",["a","b"],false),([("b","a"),("b","b")],"outside",["a","outside"],false),([("b","a"),("b","b")],"outside",["b","a"],false),([("b","a"),("b","b")],"outside",["b","b"],false),([("b","a"),("b","b")],"outside",["b","outside"],false),([("b","a"),("b","b")],"outside",["outside","a"],false),([("b","a"),("b","b")],"outside",["outside","b"],false),([("b","a"),("b","b")],"outside",["outside","outside"],true),([("a","a"),("b","a"),("b","b")],"a",[],true),([("a","a"),("b","a"),("b","b")],"a",["a"],true),([("a","a"),("b","a"),("b","b")],"a",["b"],true),([("a","a"),("b","a"),("b","b")],"a",["outside"],false),([("a","a"),("b","a"),("b","b")],"a",["a","a"],true),([("a","a"),("b","a"),("b","b")],"a",["a","b"],true),([("a","a"),("b","a"),("b","b")],"a",["a","outside"],false),([("a","a"),("b","a"),("b","b")],"a",["b","a"],true),([("a","a"),("b","a"),("b","b")],"a",["b","b"],true),([("a","a"),("b","a"),("b","b")],"a",["b","outside"],false),([("a","a"),("b","a"),("b","b")],"a",["outside","a"],false),([("a","a"),("b","a"),("b","b")],"a",["outside","b"],false),([("a","a"),("b","a"),("b","b")],"a",["outside","outside"],false),([("a","a"),("b","a"),("b","b")],"b",[],true),([("a","a"),("b","a"),("b","b")],"b",["a"],false),([("a","a"),("b","a"),("b","b")],"b",["b"],true),([("a","a"),("b","a"),("b","b")],"b",["outside"],false),([("a","a"),("b","a"),("b","b")],"b",["a","a"],false),([("a","a"),("b","a"),("b","b")],"b",["a","b"],false),([("a","a"),("b","a"),("b","b")],"b",["a","outside"],false),([("a","a"),("b","a"),("b","b")],"b",["b","a"],false),([("a","a"),("b","a"),("b","b")],"b",["b","b"],true),([("a","a"),("b","a"),("b","b")],"b",["b","outside"],false),([("a","a"),("b","a"),("b","b")],"b",["outside","a"],false),([("a","a"),("b","a"),("b","b")],"b",["outside","b"],false),([("a","a"),("b","a"),("b","b")],"b",["outside","outside"],false),([("a","a"),("b","a"),("b","b")],"outside",[],true),([("a","a"),("b","a"),("b","b")],"outside",["a"],false),([("a","a"),("b","a"),("b","b")],"outside",["b"],false),([("a","a"),("b","a"),("b","b")],"outside",["outside"],true),([("a","a"),("b","a"),("b","b")],"outside",["a","a"],false),([("a","a"),("b","a"),("b","b")],"outside",["a","b"],false),([("a","a"),("b","a"),("b","b")],"outside",["a","outside"],false),([("a","a"),("b","a"),("b","b")],"outside",["b","a"],false),([("a","a"),("b","a"),("b","b")],"outside",["b","b"],false),([("a","a"),("b","a"),("b","b")],"outside",["b","outside"],false),([("a","a"),("b","a"),("b","b")],"outside",["outside","a"],false),([("a","a"),("b","a"),("b","b")],"outside",["outside","b"],false),([("a","a"),("b","a"),("b","b")],"outside",["outside","outside"],true),([("a","b"),("b","a"),("b","b")],"a",[],true),([("a","b"),("b","a"),("b","b")],"a",["a"],true),([("a","b"),("b","a"),("b","b")],"a",["b"],true),([("a","b"),("b","a"),("b","b")],"a",["outside"],false),([("a","b"),("b","a"),("b","b")],"a",["a","a"],true),([("a","b"),("b","a"),("b","b")],"a",["a","b"],true),([("a","b"),("b","a"),("b","b")],"a",["a","outside"],false),([("a","b"),("b","a"),("b","b")],"a",["b","a"],true),([("a","b"),("b","a"),("b","b")],"a",["b","b"],true),([("a","b"),("b","a"),("b","b")],"a",["b","outside"],false),([("a","b"),("b","a"),("b","b")],"a",["outside","a"],false),([("a","b"),("b","a"),("b","b")],"a",["outside","b"],false),([("a","b"),("b","a"),("b","b")],"a",["outside","outside"],false),([("a","b"),("b","a"),("b","b")],"b",[],true),([("a","b"),("b","a"),("b","b")],"b",["a"],true),([("a","b"),("b","a"),("b","b")],"b",["b"],true),([("a","b"),("b","a"),("b","b")],"b",["outside"],false),([("a","b"),("b","a"),("b","b")],"b",["a","a"],true),([("a","b"),("b","a"),("b","b")],"b",["a","b"],true),([("a","b"),("b","a"),("b","b")],"b",["a","outside"],false),([("a","b"),("b","a"),("b","b")],"b",["b","a"],true),([("a","b"),("b","a"),("b","b")],"b",["b","b"],true),([("a","b"),("b","a"),("b","b")],"b",["b","outside"],false),([("a","b"),("b","a"),("b","b")],"b",["outside","a"],false),([("a","b"),("b","a"),("b","b")],"b",["outside","b"],false),([("a","b"),("b","a"),("b","b")],"b",["outside","outside"],false),([("a","b"),("b","a"),("b","b")],"outside",[],true),([("a","b"),("b","a"),("b","b")],"outside",["a"],false),([("a","b"),("b","a"),("b","b")],"outside",["b"],false),([("a","b"),("b","a"),("b","b")],"outside",["outside"],true),([("a","b"),("b","a"),("b","b")],"outside",["a","a"],false),([("a","b"),("b","a"),("b","b")],"outside",["a","b"],false),([("a","b"),("b","a"),("b","b")],"outside",["a","outside"],false),([("a","b"),("b","a"),("b","b")],"outside",["b","a"],false),([("a","b"),("b","a"),("b","b")],"outside",["b","b"],false),([("a","b"),("b","a"),("b","b")],"outside",["b","outside"],false),([("a","b"),("b","a"),("b","b")],"outside",["outside","a"],false),([("a","b"),("b","a"),("b","b")],"outside",["outside","b"],false),([("a","b"),("b","a"),("b","b")],"outside",["outside","outside"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"a",[],true),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["a"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["b"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["a","a"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["a","b"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["a","outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["b","a"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["b","b"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["b","outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["outside","a"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["outside","b"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"a",["outside","outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"b",[],true),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["a"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["b"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["a","a"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["a","b"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["a","outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["b","a"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["b","b"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["b","outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["outside","a"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["outside","b"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"b",["outside","outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",[],true),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["a"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["b"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["outside"],true),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["a","a"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["a","b"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["a","outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["b","a"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["b","b"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["b","outside"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["outside","a"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["outside","b"],false),([("a","a"),("a","b"),("b","a"),("b","b")],"outside",["outside","outside"],true)]
#eval do
  for (edges,target,support,expected) in stabilityCases do
    unless stableUnderRegisteredPerturbations edges target support == expected do throw (IO.userError "stability comparison mismatch")
