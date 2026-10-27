import SFT.Mathematics.GeometryTopology
open SFT.Mathematics.GeometryTopology SFT.Mathematics.DiscreteObjects
example : incidenceWellFormed [] [] = false := rfl
example : incidenceWellFormed ["a"] [] = true := rfl
example : incidenceWellFormed ["a","a"] [] = false := rfl
example : incidenceWellFormed ["a","b"] [("a","b"),("a","b")] = false := rfl
example : incidenceWellFormed ["a"] [("a","a")] = false := rfl
example : incidenceWellFormed ["a"] [("b","a")] = false := rfl
example : adjacent [("outside","x"),("outside","y")] "x" "y" = true := rfl
example : adjacent [("a","x"),("b","y")] "x" "y" = false := rfl
example : finiteTopology ["a"] [emptyOne,["outside","a"]] = true := rfl
example : finiteTopology ["a"] [emptyOne,["a"],["outside","a"]] = false := rfl
example : finiteTopology ["empty-One"] [["empty-One"]] = true := rfl
example : continuous [] [emptyOne] [["x"]] [] = true := rfl
example : continuous ["a"] [emptyOne,["a"]] [["x"]] [("a","x"),("extra","x")] = false := rfl
example : inverseOpen ["a"] [("a","x"),("a","y")] ["x"] = emptyOne := rfl
example : inverseOpen ["a"] [("a","y"),("a","x")] ["x"] = ["a"] := rfl
example : continuous ["a","b"] [["b","a"]] [["x"]] [("a","x"),("b","x")] = false := rfl
