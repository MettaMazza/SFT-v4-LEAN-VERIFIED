import SFT.Computation.InverseProblem
open SFT.Computation.InverseProblem SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 1000000
def model0 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[],by rfl,by rfl,by rfl⟩
example : (predecessors model0 ["x"],reconstruct model0 ["x"]) = ([],none) := rfl
example : (remainingPredecessors model0 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model0 ["y"],reconstruct model0 ["y"]) = ([],none) := rfl
example : (remainingPredecessors model0 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model0 ["outside"],reconstruct model0 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model0 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model0 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model0 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model1 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model1 ["x"],reconstruct model1 ["x"]) = ([[]],some []) := rfl
example : (remainingPredecessors model1 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model1 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model1 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model1 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model1 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model1 ["y"],reconstruct model1 ["y"]) = ([],none) := rfl
example : (remainingPredecessors model1 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model1 ["outside"],reconstruct model1 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model1 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model1 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model1 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model2 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model2 ["x"],reconstruct model2 ["x"]) = ([],none) := rfl
example : (remainingPredecessors model2 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model2 ["y"],reconstruct model2 ["y"]) = ([[]],some []) := rfl
example : (remainingPredecessors model2 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model2 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model2 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model2 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model2 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model2 ["outside"],reconstruct model2 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model2 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model2 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model2 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model3 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model3 ["x"],reconstruct model3 ["x"]) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model3 ["y"],reconstruct model3 ["y"]) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model3 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model3 ["outside"],reconstruct model3 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model3 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model3 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model3 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model4 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model4 ["x"],reconstruct model4 ["x"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model4 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model4 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model4 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model4 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model4 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model4 ["y"],reconstruct model4 ["y"]) = ([],none) := rfl
example : (remainingPredecessors model4 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model4 ["outside"],reconstruct model4 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model4 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model4 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model4 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model5 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model5 ["x"],reconstruct model5 ["x"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model5 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model5 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model5 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model5 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model5 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model5 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model5 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model5 ["y"],reconstruct model5 ["y"]) = ([],none) := rfl
example : (remainingPredecessors model5 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model5 ["outside"],reconstruct model5 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model5 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model5 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model5 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model6 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model6 ["x"],reconstruct model6 ["x"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model6 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model6 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model6 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model6 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model6 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model6 ["y"],reconstruct model6 ["y"]) = ([[]],some []) := rfl
example : (remainingPredecessors model6 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model6 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model6 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model6 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model6 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model6 ["outside"],reconstruct model6 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model6 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model6 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model6 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model7 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model7 ["x"],reconstruct model7 ["x"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model7 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model7 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model7 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model7 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model7 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model7 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model7 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model7 ["y"],reconstruct model7 ["y"]) = ([[]],some []) := rfl
example : (remainingPredecessors model7 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model7 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model7 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model7 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model7 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model7 ["outside"],reconstruct model7 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model7 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model7 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model7 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model8 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model8 ["x"],reconstruct model8 ["x"]) = ([],none) := rfl
example : (remainingPredecessors model8 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model8 ["y"],reconstruct model8 ["y"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model8 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model8 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model8 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model8 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model8 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model8 ["outside"],reconstruct model8 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model8 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model8 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model8 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model9 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model9 ["x"],reconstruct model9 ["x"]) = ([[]],some []) := rfl
example : (remainingPredecessors model9 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model9 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model9 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model9 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model9 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model9 ["y"],reconstruct model9 ["y"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model9 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model9 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model9 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model9 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model9 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model9 ["outside"],reconstruct model9 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model9 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model9 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model9 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model10 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model10 ["x"],reconstruct model10 ["x"]) = ([],none) := rfl
example : (remainingPredecessors model10 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model10 ["y"],reconstruct model10 ["y"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model10 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model10 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model10 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model10 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model10 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model10 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model10 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model10 ["outside"],reconstruct model10 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model10 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model10 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model10 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model11 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model11 ["x"],reconstruct model11 ["x"]) = ([[]],some []) := rfl
example : (remainingPredecessors model11 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model11 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model11 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model11 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model11 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model11 ["y"],reconstruct model11 ["y"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model11 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model11 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model11 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model11 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model11 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model11 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model11 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model11 ["outside"],reconstruct model11 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model11 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model11 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model11 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model12 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["x"]),(["a"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model12 ["x"],reconstruct model12 ["x"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model12 ["y"],reconstruct model12 ["y"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model12 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model12 ["outside"],reconstruct model12 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model12 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model12 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model12 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model13 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["x"]),(["a"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model13 ["x"],reconstruct model13 ["x"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model13 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model13 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model13 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model13 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model13 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model13 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model13 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model13 ["y"],reconstruct model13 ["y"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model13 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model13 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model13 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model13 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model13 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model13 ["outside"],reconstruct model13 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model13 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model13 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model13 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model14 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["x"]),(["a"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model14 ["x"],reconstruct model14 ["x"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model14 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model14 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model14 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model14 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model14 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model14 ["y"],reconstruct model14 ["y"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model14 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model14 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model14 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model14 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model14 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model14 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model14 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model14 ["outside"],reconstruct model14 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model14 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model14 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model14 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model15 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["x"]),(["a"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model15 ["x"],reconstruct model15 ["x"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model15 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model15 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model15 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model15 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model15 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model15 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model15 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model15 ["y"],reconstruct model15 ["y"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model15 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model15 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model15 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model15 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model15 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model15 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model15 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model15 ["outside"],reconstruct model15 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model15 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model15 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model15 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model16 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model16 ["x"],reconstruct model16 ["x"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model16 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model16 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model16 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model16 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model16 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model16 ["y"],reconstruct model16 ["y"]) = ([],none) := rfl
example : (remainingPredecessors model16 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model16 ["outside"],reconstruct model16 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model16 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model16 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model16 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model17 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model17 ["x"],reconstruct model17 ["x"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model17 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model17 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model17 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model17 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model17 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model17 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model17 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model17 ["y"],reconstruct model17 ["y"]) = ([],none) := rfl
example : (remainingPredecessors model17 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model17 ["outside"],reconstruct model17 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model17 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model17 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model17 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model18 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model18 ["x"],reconstruct model18 ["x"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model18 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model18 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model18 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model18 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model18 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model18 ["y"],reconstruct model18 ["y"]) = ([[]],some []) := rfl
example : (remainingPredecessors model18 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model18 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model18 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model18 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model18 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model18 ["outside"],reconstruct model18 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model18 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model18 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model18 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model19 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model19 ["x"],reconstruct model19 ["x"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model19 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model19 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model19 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model19 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model19 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model19 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model19 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model19 ["y"],reconstruct model19 ["y"]) = ([[]],some []) := rfl
example : (remainingPredecessors model19 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model19 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model19 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model19 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model19 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model19 ["outside"],reconstruct model19 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model19 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model19 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model19 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model20 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["x"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model20 ["x"],reconstruct model20 ["x"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model20 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model20 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model20 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model20 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model20 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model20 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model20 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model20 ["y"],reconstruct model20 ["y"]) = ([],none) := rfl
example : (remainingPredecessors model20 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model20 ["outside"],reconstruct model20 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model20 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model20 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model20 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model21 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["x"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model21 ["x"],reconstruct model21 ["x"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model21 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model21 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model21 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model21 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model21 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model21 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model21 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model21 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model21 ["y"],reconstruct model21 ["y"]) = ([],none) := rfl
example : (remainingPredecessors model21 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model21 ["outside"],reconstruct model21 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model21 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model21 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model21 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model22 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["x"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model22 ["x"],reconstruct model22 ["x"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model22 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model22 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model22 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model22 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model22 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model22 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model22 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model22 ["y"],reconstruct model22 ["y"]) = ([[]],some []) := rfl
example : (remainingPredecessors model22 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model22 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model22 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model22 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model22 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model22 ["outside"],reconstruct model22 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model22 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model22 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model22 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model23 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["x"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model23 ["x"],reconstruct model23 ["x"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model23 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model23 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model23 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model23 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model23 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model23 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model23 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model23 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model23 ["y"],reconstruct model23 ["y"]) = ([[]],some []) := rfl
example : (remainingPredecessors model23 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model23 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model23 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model23 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model23 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model23 ["outside"],reconstruct model23 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model23 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model23 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model23 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model24 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model24 ["x"],reconstruct model24 ["x"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model24 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model24 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model24 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model24 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model24 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model24 ["y"],reconstruct model24 ["y"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model24 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model24 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model24 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model24 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model24 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model24 ["outside"],reconstruct model24 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model24 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model24 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model24 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model25 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model25 ["x"],reconstruct model25 ["x"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model25 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model25 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model25 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model25 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model25 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model25 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model25 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model25 ["y"],reconstruct model25 ["y"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model25 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model25 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model25 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model25 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model25 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model25 ["outside"],reconstruct model25 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model25 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model25 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model25 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model26 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model26 ["x"],reconstruct model26 ["x"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model26 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model26 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model26 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model26 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model26 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model26 ["y"],reconstruct model26 ["y"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model26 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model26 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model26 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model26 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model26 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model26 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model26 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model26 ["outside"],reconstruct model26 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model26 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model26 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model26 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model27 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model27 ["x"],reconstruct model27 ["x"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model27 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model27 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model27 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model27 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model27 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model27 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model27 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model27 ["y"],reconstruct model27 ["y"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model27 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model27 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model27 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model27 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model27 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model27 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model27 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model27 ["outside"],reconstruct model27 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model27 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model27 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model27 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model28 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["x"]),(["a"],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model28 ["x"],reconstruct model28 ["x"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model28 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model28 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model28 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model28 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model28 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model28 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model28 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model28 ["y"],reconstruct model28 ["y"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model28 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model28 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model28 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model28 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model28 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model28 ["outside"],reconstruct model28 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model28 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model28 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model28 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model29 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model29 ["x"],reconstruct model29 ["x"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model29 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model29 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model29 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model29 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model29 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model29 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model29 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model29 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model29 ["y"],reconstruct model29 ["y"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model29 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model29 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model29 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model29 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model29 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model29 ["outside"],reconstruct model29 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model29 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model29 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model29 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model30 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model30 ["x"],reconstruct model30 ["x"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model30 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model30 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model30 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model30 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model30 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model30 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model30 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model30 ["y"],reconstruct model30 ["y"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model30 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model30 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model30 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model30 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model30 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model30 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model30 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model30 ["outside"],reconstruct model30 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model30 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model30 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model30 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model31 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["x"])],by rfl,by rfl,by rfl⟩
example : (predecessors model31 ["x"],reconstruct model31 ["x"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model31 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model31 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model31 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model31 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model31 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model31 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model31 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model31 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model31 ["y"],reconstruct model31 ["y"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model31 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model31 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model31 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model31 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model31 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model31 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model31 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model31 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model31 ["outside"],reconstruct model31 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model31 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model31 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model31 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model31 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model31 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model31 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model31 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model31 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model31 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model32 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model32 ["x"],reconstruct model32 ["x"]) = ([],none) := rfl
example : (remainingPredecessors model32 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model32 ["y"],reconstruct model32 ["y"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model32 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model32 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model32 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model32 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model32 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model32 ["outside"],reconstruct model32 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model32 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model32 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model32 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model33 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model33 ["x"],reconstruct model33 ["x"]) = ([[]],some []) := rfl
example : (remainingPredecessors model33 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model33 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model33 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model33 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model33 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model33 ["y"],reconstruct model33 ["y"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model33 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model33 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model33 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model33 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model33 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model33 ["outside"],reconstruct model33 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model33 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model33 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model33 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model34 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model34 ["x"],reconstruct model34 ["x"]) = ([],none) := rfl
example : (remainingPredecessors model34 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model34 ["y"],reconstruct model34 ["y"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model34 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model34 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model34 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model34 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model34 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model34 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model34 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model34 ["outside"],reconstruct model34 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model34 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model34 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model34 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model35 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model35 ["x"],reconstruct model35 ["x"]) = ([[]],some []) := rfl
example : (remainingPredecessors model35 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model35 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model35 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model35 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model35 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model35 ["y"],reconstruct model35 ["y"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model35 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model35 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model35 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model35 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model35 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model35 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model35 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model35 ["outside"],reconstruct model35 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model35 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model35 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model35 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model36 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model36 ["x"],reconstruct model36 ["x"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model36 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model36 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model36 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model36 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model36 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model36 ["y"],reconstruct model36 ["y"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model36 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model36 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model36 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model36 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model36 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model36 ["outside"],reconstruct model36 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model36 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model36 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model36 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model37 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model37 ["x"],reconstruct model37 ["x"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model37 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model37 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model37 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model37 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model37 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model37 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model37 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model37 ["y"],reconstruct model37 ["y"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model37 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model37 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model37 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model37 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model37 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model37 ["outside"],reconstruct model37 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model37 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model37 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model37 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model38 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model38 ["x"],reconstruct model38 ["x"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model38 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model38 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model38 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model38 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model38 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model38 ["y"],reconstruct model38 ["y"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model38 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model38 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model38 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model38 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model38 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model38 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model38 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model38 ["outside"],reconstruct model38 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model38 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model38 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model38 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model39 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model39 ["x"],reconstruct model39 ["x"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model39 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model39 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model39 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model39 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model39 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model39 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model39 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model39 ["y"],reconstruct model39 ["y"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model39 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model39 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model39 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model39 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model39 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model39 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model39 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model39 ["outside"],reconstruct model39 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model39 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model39 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model39 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model40 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model40 ["x"],reconstruct model40 ["x"]) = ([],none) := rfl
example : (remainingPredecessors model40 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model40 ["y"],reconstruct model40 ["y"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model40 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model40 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model40 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model40 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model40 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model40 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model40 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model40 ["outside"],reconstruct model40 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model40 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model40 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model40 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model41 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model41 ["x"],reconstruct model41 ["x"]) = ([[]],some []) := rfl
example : (remainingPredecessors model41 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model41 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model41 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model41 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model41 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model41 ["y"],reconstruct model41 ["y"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model41 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model41 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model41 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model41 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model41 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model41 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model41 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model41 ["outside"],reconstruct model41 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model41 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model41 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model41 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model42 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model42 ["x"],reconstruct model42 ["x"]) = ([],none) := rfl
example : (remainingPredecessors model42 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model42 ["y"],reconstruct model42 ["y"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model42 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model42 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model42 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model42 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model42 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model42 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model42 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model42 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model42 ["outside"],reconstruct model42 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model42 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model42 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model42 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model43 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model43 ["x"],reconstruct model43 ["x"]) = ([[]],some []) := rfl
example : (remainingPredecessors model43 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model43 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model43 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model43 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model43 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model43 ["y"],reconstruct model43 ["y"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model43 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model43 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model43 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model43 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model43 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model43 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model43 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model43 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model43 ["outside"],reconstruct model43 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model43 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model43 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model43 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model44 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["x"]),(["a"],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model44 ["x"],reconstruct model44 ["x"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model44 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model44 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model44 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model44 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model44 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model44 ["y"],reconstruct model44 ["y"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model44 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model44 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model44 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model44 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model44 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model44 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model44 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model44 ["outside"],reconstruct model44 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model44 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model44 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model44 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model45 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model45 ["x"],reconstruct model45 ["x"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model45 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model45 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model45 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model45 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model45 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model45 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model45 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model45 ["y"],reconstruct model45 ["y"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model45 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model45 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model45 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model45 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model45 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model45 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model45 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model45 ["outside"],reconstruct model45 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model45 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model45 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model45 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model46 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model46 ["x"],reconstruct model46 ["x"]) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model46 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model46 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model46 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model46 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model46 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model46 ["y"],reconstruct model46 ["y"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model46 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model46 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model46 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model46 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model46 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model46 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model46 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model46 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model46 ["outside"],reconstruct model46 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model46 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model46 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model46 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model47 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model47 ["x"],reconstruct model47 ["x"]) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model47 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model47 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model47 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model47 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model47 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model47 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model47 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model47 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model47 ["y"],reconstruct model47 ["y"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model47 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model47 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model47 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model47 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model47 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model47 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model47 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model47 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model47 ["outside"],reconstruct model47 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model47 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model47 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model47 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model47 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model47 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model47 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model47 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model47 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model47 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model48 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model48 ["x"],reconstruct model48 ["x"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model48 ["y"],reconstruct model48 ["y"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model48 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model48 ["outside"],reconstruct model48 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model48 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model48 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model48 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model49 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model49 ["x"],reconstruct model49 ["x"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model49 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model49 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model49 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model49 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model49 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model49 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model49 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model49 ["y"],reconstruct model49 ["y"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model49 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model49 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model49 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model49 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model49 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model49 ["outside"],reconstruct model49 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model49 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model49 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model49 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model50 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model50 ["x"],reconstruct model50 ["x"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model50 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model50 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model50 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model50 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model50 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model50 ["y"],reconstruct model50 ["y"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model50 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model50 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model50 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model50 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model50 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model50 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model50 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model50 ["outside"],reconstruct model50 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model50 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model50 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model50 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model51 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model51 ["x"],reconstruct model51 ["x"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model51 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model51 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model51 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model51 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model51 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model51 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model51 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model51 ["y"],reconstruct model51 ["y"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model51 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model51 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model51 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model51 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model51 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model51 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model51 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model51 ["outside"],reconstruct model51 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model51 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model51 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model51 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model52 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["x"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model52 ["x"],reconstruct model52 ["x"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model52 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model52 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model52 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model52 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model52 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model52 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model52 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model52 ["y"],reconstruct model52 ["y"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model52 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model52 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model52 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model52 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model52 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model52 ["outside"],reconstruct model52 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model52 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model52 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model52 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model53 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["x"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model53 ["x"],reconstruct model53 ["x"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model53 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model53 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model53 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model53 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model53 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model53 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model53 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model53 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model53 ["y"],reconstruct model53 ["y"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model53 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model53 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model53 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model53 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model53 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model53 ["outside"],reconstruct model53 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model53 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model53 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model53 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model54 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["x"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model54 ["x"],reconstruct model54 ["x"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model54 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model54 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model54 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model54 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model54 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model54 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model54 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model54 ["y"],reconstruct model54 ["y"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model54 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model54 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model54 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model54 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model54 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model54 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model54 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model54 ["outside"],reconstruct model54 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model54 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model54 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model54 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model55 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["x"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model55 ["x"],reconstruct model55 ["x"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model55 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model55 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model55 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model55 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model55 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model55 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model55 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model55 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model55 ["y"],reconstruct model55 ["y"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model55 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model55 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model55 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model55 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model55 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model55 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model55 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model55 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model55 ["outside"],reconstruct model55 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model55 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model55 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model55 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model55 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model55 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model55 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model55 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model55 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model55 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model56 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model56 ["x"],reconstruct model56 ["x"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model56 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model56 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model56 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model56 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model56 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model56 ["y"],reconstruct model56 ["y"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model56 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model56 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model56 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model56 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model56 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model56 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model56 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model56 ["outside"],reconstruct model56 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model56 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model56 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model56 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model57 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model57 ["x"],reconstruct model57 ["x"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model57 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model57 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model57 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model57 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model57 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model57 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model57 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model57 ["y"],reconstruct model57 ["y"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model57 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model57 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model57 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model57 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model57 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model57 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model57 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model57 ["outside"],reconstruct model57 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model57 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model57 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model57 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model58 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model58 ["x"],reconstruct model58 ["x"]) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model58 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model58 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model58 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model58 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model58 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model58 ["y"],reconstruct model58 ["y"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model58 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model58 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model58 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model58 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model58 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model58 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model58 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model58 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model58 ["outside"],reconstruct model58 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model58 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model58 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model58 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model59 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model59 ["x"],reconstruct model59 ["x"]) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model59 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model59 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model59 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model59 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model59 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model59 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model59 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model59 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model59 ["y"],reconstruct model59 ["y"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model59 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model59 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model59 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model59 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model59 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model59 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model59 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model59 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model59 ["outside"],reconstruct model59 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model59 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model59 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model59 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model59 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model59 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model59 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model59 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model59 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model59 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model60 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[(["a"],["x"]),(["a"],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model60 ["x"],reconstruct model60 ["x"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model60 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model60 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model60 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model60 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model60 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model60 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model60 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model60 ["y"],reconstruct model60 ["y"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model60 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model60 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model60 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model60 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model60 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model60 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model60 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model60 ["outside"],reconstruct model60 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model60 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model60 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model60 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model61 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model61 ["x"],reconstruct model61 ["x"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model61 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model61 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model61 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model61 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model61 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model61 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model61 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model61 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model61 ["y"],reconstruct model61 ["y"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model61 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model61 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model61 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model61 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model61 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model61 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model61 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model61 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model61 ["outside"],reconstruct model61 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model61 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model61 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model61 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model61 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model61 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model61 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model61 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model61 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model61 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model62 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["y"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model62 ["x"],reconstruct model62 ["x"]) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model62 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model62 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model62 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model62 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model62 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model62 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model62 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model62 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model62 ["y"],reconstruct model62 ["y"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model62 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model62 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model62 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model62 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model62 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model62 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model62 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model62 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model62 ["outside"],reconstruct model62 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model62 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model62 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model62 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model62 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model62 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model62 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model62 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model62 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model62 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
def model63 : Model := ⟨[[],["a"],["a","b"]],[["x"],["y"]],[([],["x"]),([],["y"]),(["a"],["x"]),(["a"],["y"]),(["a","b"],["x"]),(["a","b"],["y"])],by rfl,by rfl,by rfl⟩
example : (predecessors model63 ["x"],reconstruct model63 ["x"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model63 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["x"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model63 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["x"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model63 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["x"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model63 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["x"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model63 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["x"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model63 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["x"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model63 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["x"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model63 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["x"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model63 ["y"],reconstruct model63 ["y"]) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model63 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["y"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([[],["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model63 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["y"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([["a"],["a","b"]],none) := rfl
example : (remainingPredecessors model63 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["y"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([[],["a","b"]],none) := rfl
example : (remainingPredecessors model63 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["y"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([["a","b"]],some ["a","b"]) := rfl
example : (remainingPredecessors model63 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["y"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[],["a"]],none) := rfl
example : (remainingPredecessors model63 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["y"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([["a"]],some ["a"]) := rfl
example : (remainingPredecessors model63 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["y"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([[]],some []) := rfl
example : (remainingPredecessors model63 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["y"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (predecessors model63 ["outside"],reconstruct model63 ["outside"]) = ([],none) := rfl
example : (remainingPredecessors model63 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["outside"] (⟨[],[],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model63 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["outside"] (⟨[[]],[[]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model63 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["outside"] (⟨[["a"]],[["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model63 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["outside"] (⟨[[],["a"]],[[],["a"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model63 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["outside"] (⟨[["a","b"]],[["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model63 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["outside"] (⟨[[],["a","b"]],[[],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model63 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["outside"] (⟨[["a"],["a","b"]],[["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : (remainingPredecessors model63 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions),reconstructRemaining model63 ["outside"] (⟨[[],["a"],["a","b"]],[[],["a"],["a","b"]],fun _ h => h⟩ : Exclusions)) = ([],none) := rfl
example : composeRelations [] [] = [] := rfl
example : composeRelations [] [(["a"],["a"])] = [] := rfl
example : composeRelations [] [(["a"],["b"])] = [] := rfl
example : composeRelations [] [(["a"],["a"]),(["a"],["b"])] = [] := rfl
example : composeRelations [] [(["b"],["a"])] = [] := rfl
example : composeRelations [] [(["a"],["a"]),(["b"],["a"])] = [] := rfl
example : composeRelations [] [(["a"],["b"]),(["b"],["a"])] = [] := rfl
example : composeRelations [] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [] := rfl
example : composeRelations [] [(["b"],["b"])] = [] := rfl
example : composeRelations [] [(["a"],["a"]),(["b"],["b"])] = [] := rfl
example : composeRelations [] [(["a"],["b"]),(["b"],["b"])] = [] := rfl
example : composeRelations [] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [] := rfl
example : composeRelations [] [(["b"],["a"]),(["b"],["b"])] = [] := rfl
example : composeRelations [] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [] := rfl
example : composeRelations [] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [] := rfl
example : composeRelations [] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [] := rfl
example : composeRelations [(["a"],["a"])] [] = [] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["a"]),(["a"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"])] [(["b"],["a"])] = [] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"])] [(["b"],["b"])] = [] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"])] [(["b"],["a"]),(["b"],["b"])] = [] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"])] [] = [] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["a"])] = [] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["b"])] = [] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [] := rfl
example : composeRelations [(["a"],["b"])] [(["b"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["b"])] [(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [] = [] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["b"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["b"]),(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["b"],["a"])] [] = [] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["a"]),(["a"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"])] [(["b"],["a"])] = [] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["a"]),(["b"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["b"]),(["b"],["a"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"])] [(["b"],["b"])] = [] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["a"]),(["b"],["b"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["b"]),(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"])] [(["b"],["a"]),(["b"],["b"])] = [] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [] = [] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["b"],["a"])] = [] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["b"],["b"])] = [] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["b"],["a"]),(["b"],["b"])] = [] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [] = [] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["b"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [] = [] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["b"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["b"]),(["a"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["b"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["b"])] [] = [] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["a"])] = [] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["b"])] = [] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [] := rfl
example : composeRelations [(["b"],["b"])] [(["b"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["b"])] [(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [] = [] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["b"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [] = [] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["a"])] = [] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["b"])] = [] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [] = [] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["a"])] = [(["a"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["b"])] = [(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [(["a"],["a"]),(["a"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["b"]),(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [] = [] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["b"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["b"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["b"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["b"],["a"]),(["b"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["b"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [] = [] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["b"]),(["b"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["b"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [] = [] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"])] = [(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"])] = [(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"]),(["b"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["b"],["a"]),(["b"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [] = [] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["a"])] = [(["a"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["a"]),(["b"],["a"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"])] = [(["a"],["b"]),(["a"],["a"]),(["b"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["a"]),(["b"],["a"]),(["b"],["b"]),(["b"],["a"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["b"])] = [(["a"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["b"])] = [(["a"],["b"]),(["a"],["b"]),(["b"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["b"]),(["a"],["a"]),(["a"],["b"]),(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
example : composeRelations [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] = [(["a"],["a"]),(["a"],["b"]),(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
