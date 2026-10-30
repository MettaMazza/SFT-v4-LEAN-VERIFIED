import SFT.Computation.Discretization
open SFT.Computation.Discretization SFT.InformationScience.EncodingClasses SFT.InformationScience.EncodingLoss SFT.InformationScience.EncodingMaps
set_option maxRecDepth 1000000
def view : Option OperatorRow → Option ((String × String) × Codeword × Codeword) | none => none | some r => some (r.sourceEdge,r.sourceCell,r.targetCell)
def coverage0 : Encoding := [("a",["x"]),("b",["x"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage0 = true := rfl
example : closedDistinctions ["a","b","c"] coverage0 = .ok [("a","b"),("a","c"),("b","c")] := rfl
example : view (localOperator coverage0 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("a","b")) = some (("a","b"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("a","c")) = some (("a","c"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("a","outside")) = none := rfl
example : view (localOperator coverage0 ("b","a")) = some (("b","a"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("b","c")) = some (("b","c"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("b","outside")) = none := rfl
example : view (localOperator coverage0 ("c","a")) = some (("c","a"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("c","b")) = some (("c","b"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage0 ("c","outside")) = none := rfl
example : view (localOperator coverage0 ("outside","a")) = none := rfl
example : view (localOperator coverage0 ("outside","b")) = none := rfl
example : view (localOperator coverage0 ("outside","c")) = none := rfl
example : view (localOperator coverage0 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["x"]),(["z"],["x"])] = .ok [("a",["x"]),("b",["x"]),("c",["x"])] := rfl
def coverage1 : Encoding := [("a",["x"]),("b",["x"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage1 = true := rfl
example : closedDistinctions ["a","b","c"] coverage1 = .ok [("a","b")] := rfl
example : view (localOperator coverage1 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage1 ("a","b")) = some (("a","b"),["x"],["x"]) := rfl
example : view (localOperator coverage1 ("a","c")) = some (("a","c"),["x"],["y"]) := rfl
example : view (localOperator coverage1 ("a","outside")) = none := rfl
example : view (localOperator coverage1 ("b","a")) = some (("b","a"),["x"],["x"]) := rfl
example : view (localOperator coverage1 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage1 ("b","c")) = some (("b","c"),["x"],["y"]) := rfl
example : view (localOperator coverage1 ("b","outside")) = none := rfl
example : view (localOperator coverage1 ("c","a")) = some (("c","a"),["y"],["x"]) := rfl
example : view (localOperator coverage1 ("c","b")) = some (("c","b"),["y"],["x"]) := rfl
example : view (localOperator coverage1 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage1 ("c","outside")) = none := rfl
example : view (localOperator coverage1 ("outside","a")) = none := rfl
example : view (localOperator coverage1 ("outside","b")) = none := rfl
example : view (localOperator coverage1 ("outside","c")) = none := rfl
example : view (localOperator coverage1 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["x"]),(["z"],["y"])] = .ok [("a",["x"]),("b",["x"]),("c",["y"])] := rfl
def coverage2 : Encoding := [("a",["x"]),("b",["x"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage2 = true := rfl
example : closedDistinctions ["a","b","c"] coverage2 = .ok [("a","b")] := rfl
example : view (localOperator coverage2 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage2 ("a","b")) = some (("a","b"),["x"],["x"]) := rfl
example : view (localOperator coverage2 ("a","c")) = some (("a","c"),["x"],["z"]) := rfl
example : view (localOperator coverage2 ("a","outside")) = none := rfl
example : view (localOperator coverage2 ("b","a")) = some (("b","a"),["x"],["x"]) := rfl
example : view (localOperator coverage2 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage2 ("b","c")) = some (("b","c"),["x"],["z"]) := rfl
example : view (localOperator coverage2 ("b","outside")) = none := rfl
example : view (localOperator coverage2 ("c","a")) = some (("c","a"),["z"],["x"]) := rfl
example : view (localOperator coverage2 ("c","b")) = some (("c","b"),["z"],["x"]) := rfl
example : view (localOperator coverage2 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage2 ("c","outside")) = none := rfl
example : view (localOperator coverage2 ("outside","a")) = none := rfl
example : view (localOperator coverage2 ("outside","b")) = none := rfl
example : view (localOperator coverage2 ("outside","c")) = none := rfl
example : view (localOperator coverage2 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["x"]),(["z"],["z"])] = .ok [("a",["x"]),("b",["x"]),("c",["z"])] := rfl
def coverage3 : Encoding := [("a",["x"]),("b",["y"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage3 = true := rfl
example : closedDistinctions ["a","b","c"] coverage3 = .ok [("a","c")] := rfl
example : view (localOperator coverage3 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage3 ("a","b")) = some (("a","b"),["x"],["y"]) := rfl
example : view (localOperator coverage3 ("a","c")) = some (("a","c"),["x"],["x"]) := rfl
example : view (localOperator coverage3 ("a","outside")) = none := rfl
example : view (localOperator coverage3 ("b","a")) = some (("b","a"),["y"],["x"]) := rfl
example : view (localOperator coverage3 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage3 ("b","c")) = some (("b","c"),["y"],["x"]) := rfl
example : view (localOperator coverage3 ("b","outside")) = none := rfl
example : view (localOperator coverage3 ("c","a")) = some (("c","a"),["x"],["x"]) := rfl
example : view (localOperator coverage3 ("c","b")) = some (("c","b"),["x"],["y"]) := rfl
example : view (localOperator coverage3 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage3 ("c","outside")) = none := rfl
example : view (localOperator coverage3 ("outside","a")) = none := rfl
example : view (localOperator coverage3 ("outside","b")) = none := rfl
example : view (localOperator coverage3 ("outside","c")) = none := rfl
example : view (localOperator coverage3 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["y"]),(["z"],["x"])] = .ok [("a",["x"]),("b",["y"]),("c",["x"])] := rfl
def coverage4 : Encoding := [("a",["x"]),("b",["y"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage4 = true := rfl
example : closedDistinctions ["a","b","c"] coverage4 = .ok [("b","c")] := rfl
example : view (localOperator coverage4 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage4 ("a","b")) = some (("a","b"),["x"],["y"]) := rfl
example : view (localOperator coverage4 ("a","c")) = some (("a","c"),["x"],["y"]) := rfl
example : view (localOperator coverage4 ("a","outside")) = none := rfl
example : view (localOperator coverage4 ("b","a")) = some (("b","a"),["y"],["x"]) := rfl
example : view (localOperator coverage4 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage4 ("b","c")) = some (("b","c"),["y"],["y"]) := rfl
example : view (localOperator coverage4 ("b","outside")) = none := rfl
example : view (localOperator coverage4 ("c","a")) = some (("c","a"),["y"],["x"]) := rfl
example : view (localOperator coverage4 ("c","b")) = some (("c","b"),["y"],["y"]) := rfl
example : view (localOperator coverage4 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage4 ("c","outside")) = none := rfl
example : view (localOperator coverage4 ("outside","a")) = none := rfl
example : view (localOperator coverage4 ("outside","b")) = none := rfl
example : view (localOperator coverage4 ("outside","c")) = none := rfl
example : view (localOperator coverage4 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["y"]),(["z"],["y"])] = .ok [("a",["x"]),("b",["y"]),("c",["y"])] := rfl
def coverage5 : Encoding := [("a",["x"]),("b",["y"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage5 = true := rfl
example : closedDistinctions ["a","b","c"] coverage5 = .ok [] := rfl
example : view (localOperator coverage5 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage5 ("a","b")) = some (("a","b"),["x"],["y"]) := rfl
example : view (localOperator coverage5 ("a","c")) = some (("a","c"),["x"],["z"]) := rfl
example : view (localOperator coverage5 ("a","outside")) = none := rfl
example : view (localOperator coverage5 ("b","a")) = some (("b","a"),["y"],["x"]) := rfl
example : view (localOperator coverage5 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage5 ("b","c")) = some (("b","c"),["y"],["z"]) := rfl
example : view (localOperator coverage5 ("b","outside")) = none := rfl
example : view (localOperator coverage5 ("c","a")) = some (("c","a"),["z"],["x"]) := rfl
example : view (localOperator coverage5 ("c","b")) = some (("c","b"),["z"],["y"]) := rfl
example : view (localOperator coverage5 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage5 ("c","outside")) = none := rfl
example : view (localOperator coverage5 ("outside","a")) = none := rfl
example : view (localOperator coverage5 ("outside","b")) = none := rfl
example : view (localOperator coverage5 ("outside","c")) = none := rfl
example : view (localOperator coverage5 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["y"]),(["z"],["z"])] = .ok [("a",["x"]),("b",["y"]),("c",["z"])] := rfl
def coverage6 : Encoding := [("a",["x"]),("b",["z"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage6 = true := rfl
example : closedDistinctions ["a","b","c"] coverage6 = .ok [("a","c")] := rfl
example : view (localOperator coverage6 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage6 ("a","b")) = some (("a","b"),["x"],["z"]) := rfl
example : view (localOperator coverage6 ("a","c")) = some (("a","c"),["x"],["x"]) := rfl
example : view (localOperator coverage6 ("a","outside")) = none := rfl
example : view (localOperator coverage6 ("b","a")) = some (("b","a"),["z"],["x"]) := rfl
example : view (localOperator coverage6 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage6 ("b","c")) = some (("b","c"),["z"],["x"]) := rfl
example : view (localOperator coverage6 ("b","outside")) = none := rfl
example : view (localOperator coverage6 ("c","a")) = some (("c","a"),["x"],["x"]) := rfl
example : view (localOperator coverage6 ("c","b")) = some (("c","b"),["x"],["z"]) := rfl
example : view (localOperator coverage6 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage6 ("c","outside")) = none := rfl
example : view (localOperator coverage6 ("outside","a")) = none := rfl
example : view (localOperator coverage6 ("outside","b")) = none := rfl
example : view (localOperator coverage6 ("outside","c")) = none := rfl
example : view (localOperator coverage6 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["z"]),(["z"],["x"])] = .ok [("a",["x"]),("b",["z"]),("c",["x"])] := rfl
def coverage7 : Encoding := [("a",["x"]),("b",["z"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage7 = true := rfl
example : closedDistinctions ["a","b","c"] coverage7 = .ok [] := rfl
example : view (localOperator coverage7 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage7 ("a","b")) = some (("a","b"),["x"],["z"]) := rfl
example : view (localOperator coverage7 ("a","c")) = some (("a","c"),["x"],["y"]) := rfl
example : view (localOperator coverage7 ("a","outside")) = none := rfl
example : view (localOperator coverage7 ("b","a")) = some (("b","a"),["z"],["x"]) := rfl
example : view (localOperator coverage7 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage7 ("b","c")) = some (("b","c"),["z"],["y"]) := rfl
example : view (localOperator coverage7 ("b","outside")) = none := rfl
example : view (localOperator coverage7 ("c","a")) = some (("c","a"),["y"],["x"]) := rfl
example : view (localOperator coverage7 ("c","b")) = some (("c","b"),["y"],["z"]) := rfl
example : view (localOperator coverage7 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage7 ("c","outside")) = none := rfl
example : view (localOperator coverage7 ("outside","a")) = none := rfl
example : view (localOperator coverage7 ("outside","b")) = none := rfl
example : view (localOperator coverage7 ("outside","c")) = none := rfl
example : view (localOperator coverage7 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["z"]),(["z"],["y"])] = .ok [("a",["x"]),("b",["z"]),("c",["y"])] := rfl
def coverage8 : Encoding := [("a",["x"]),("b",["z"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage8 = true := rfl
example : closedDistinctions ["a","b","c"] coverage8 = .ok [("b","c")] := rfl
example : view (localOperator coverage8 ("a","a")) = some (("a","a"),["x"],["x"]) := rfl
example : view (localOperator coverage8 ("a","b")) = some (("a","b"),["x"],["z"]) := rfl
example : view (localOperator coverage8 ("a","c")) = some (("a","c"),["x"],["z"]) := rfl
example : view (localOperator coverage8 ("a","outside")) = none := rfl
example : view (localOperator coverage8 ("b","a")) = some (("b","a"),["z"],["x"]) := rfl
example : view (localOperator coverage8 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage8 ("b","c")) = some (("b","c"),["z"],["z"]) := rfl
example : view (localOperator coverage8 ("b","outside")) = none := rfl
example : view (localOperator coverage8 ("c","a")) = some (("c","a"),["z"],["x"]) := rfl
example : view (localOperator coverage8 ("c","b")) = some (("c","b"),["z"],["z"]) := rfl
example : view (localOperator coverage8 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage8 ("c","outside")) = none := rfl
example : view (localOperator coverage8 ("outside","a")) = none := rfl
example : view (localOperator coverage8 ("outside","b")) = none := rfl
example : view (localOperator coverage8 ("outside","c")) = none := rfl
example : view (localOperator coverage8 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["x"]),(["y"],["z"]),(["z"],["z"])] = .ok [("a",["x"]),("b",["z"]),("c",["z"])] := rfl
def coverage9 : Encoding := [("a",["y"]),("b",["x"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage9 = true := rfl
example : closedDistinctions ["a","b","c"] coverage9 = .ok [("b","c")] := rfl
example : view (localOperator coverage9 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage9 ("a","b")) = some (("a","b"),["y"],["x"]) := rfl
example : view (localOperator coverage9 ("a","c")) = some (("a","c"),["y"],["x"]) := rfl
example : view (localOperator coverage9 ("a","outside")) = none := rfl
example : view (localOperator coverage9 ("b","a")) = some (("b","a"),["x"],["y"]) := rfl
example : view (localOperator coverage9 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage9 ("b","c")) = some (("b","c"),["x"],["x"]) := rfl
example : view (localOperator coverage9 ("b","outside")) = none := rfl
example : view (localOperator coverage9 ("c","a")) = some (("c","a"),["x"],["y"]) := rfl
example : view (localOperator coverage9 ("c","b")) = some (("c","b"),["x"],["x"]) := rfl
example : view (localOperator coverage9 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage9 ("c","outside")) = none := rfl
example : view (localOperator coverage9 ("outside","a")) = none := rfl
example : view (localOperator coverage9 ("outside","b")) = none := rfl
example : view (localOperator coverage9 ("outside","c")) = none := rfl
example : view (localOperator coverage9 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["x"]),(["z"],["x"])] = .ok [("a",["y"]),("b",["x"]),("c",["x"])] := rfl
def coverage10 : Encoding := [("a",["y"]),("b",["x"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage10 = true := rfl
example : closedDistinctions ["a","b","c"] coverage10 = .ok [("a","c")] := rfl
example : view (localOperator coverage10 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage10 ("a","b")) = some (("a","b"),["y"],["x"]) := rfl
example : view (localOperator coverage10 ("a","c")) = some (("a","c"),["y"],["y"]) := rfl
example : view (localOperator coverage10 ("a","outside")) = none := rfl
example : view (localOperator coverage10 ("b","a")) = some (("b","a"),["x"],["y"]) := rfl
example : view (localOperator coverage10 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage10 ("b","c")) = some (("b","c"),["x"],["y"]) := rfl
example : view (localOperator coverage10 ("b","outside")) = none := rfl
example : view (localOperator coverage10 ("c","a")) = some (("c","a"),["y"],["y"]) := rfl
example : view (localOperator coverage10 ("c","b")) = some (("c","b"),["y"],["x"]) := rfl
example : view (localOperator coverage10 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage10 ("c","outside")) = none := rfl
example : view (localOperator coverage10 ("outside","a")) = none := rfl
example : view (localOperator coverage10 ("outside","b")) = none := rfl
example : view (localOperator coverage10 ("outside","c")) = none := rfl
example : view (localOperator coverage10 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["x"]),(["z"],["y"])] = .ok [("a",["y"]),("b",["x"]),("c",["y"])] := rfl
def coverage11 : Encoding := [("a",["y"]),("b",["x"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage11 = true := rfl
example : closedDistinctions ["a","b","c"] coverage11 = .ok [] := rfl
example : view (localOperator coverage11 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage11 ("a","b")) = some (("a","b"),["y"],["x"]) := rfl
example : view (localOperator coverage11 ("a","c")) = some (("a","c"),["y"],["z"]) := rfl
example : view (localOperator coverage11 ("a","outside")) = none := rfl
example : view (localOperator coverage11 ("b","a")) = some (("b","a"),["x"],["y"]) := rfl
example : view (localOperator coverage11 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage11 ("b","c")) = some (("b","c"),["x"],["z"]) := rfl
example : view (localOperator coverage11 ("b","outside")) = none := rfl
example : view (localOperator coverage11 ("c","a")) = some (("c","a"),["z"],["y"]) := rfl
example : view (localOperator coverage11 ("c","b")) = some (("c","b"),["z"],["x"]) := rfl
example : view (localOperator coverage11 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage11 ("c","outside")) = none := rfl
example : view (localOperator coverage11 ("outside","a")) = none := rfl
example : view (localOperator coverage11 ("outside","b")) = none := rfl
example : view (localOperator coverage11 ("outside","c")) = none := rfl
example : view (localOperator coverage11 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["x"]),(["z"],["z"])] = .ok [("a",["y"]),("b",["x"]),("c",["z"])] := rfl
def coverage12 : Encoding := [("a",["y"]),("b",["y"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage12 = true := rfl
example : closedDistinctions ["a","b","c"] coverage12 = .ok [("a","b")] := rfl
example : view (localOperator coverage12 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage12 ("a","b")) = some (("a","b"),["y"],["y"]) := rfl
example : view (localOperator coverage12 ("a","c")) = some (("a","c"),["y"],["x"]) := rfl
example : view (localOperator coverage12 ("a","outside")) = none := rfl
example : view (localOperator coverage12 ("b","a")) = some (("b","a"),["y"],["y"]) := rfl
example : view (localOperator coverage12 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage12 ("b","c")) = some (("b","c"),["y"],["x"]) := rfl
example : view (localOperator coverage12 ("b","outside")) = none := rfl
example : view (localOperator coverage12 ("c","a")) = some (("c","a"),["x"],["y"]) := rfl
example : view (localOperator coverage12 ("c","b")) = some (("c","b"),["x"],["y"]) := rfl
example : view (localOperator coverage12 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage12 ("c","outside")) = none := rfl
example : view (localOperator coverage12 ("outside","a")) = none := rfl
example : view (localOperator coverage12 ("outside","b")) = none := rfl
example : view (localOperator coverage12 ("outside","c")) = none := rfl
example : view (localOperator coverage12 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["y"]),(["z"],["x"])] = .ok [("a",["y"]),("b",["y"]),("c",["x"])] := rfl
def coverage13 : Encoding := [("a",["y"]),("b",["y"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage13 = true := rfl
example : closedDistinctions ["a","b","c"] coverage13 = .ok [("a","b"),("a","c"),("b","c")] := rfl
example : view (localOperator coverage13 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("a","b")) = some (("a","b"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("a","c")) = some (("a","c"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("a","outside")) = none := rfl
example : view (localOperator coverage13 ("b","a")) = some (("b","a"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("b","c")) = some (("b","c"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("b","outside")) = none := rfl
example : view (localOperator coverage13 ("c","a")) = some (("c","a"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("c","b")) = some (("c","b"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage13 ("c","outside")) = none := rfl
example : view (localOperator coverage13 ("outside","a")) = none := rfl
example : view (localOperator coverage13 ("outside","b")) = none := rfl
example : view (localOperator coverage13 ("outside","c")) = none := rfl
example : view (localOperator coverage13 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["y"]),(["z"],["y"])] = .ok [("a",["y"]),("b",["y"]),("c",["y"])] := rfl
def coverage14 : Encoding := [("a",["y"]),("b",["y"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage14 = true := rfl
example : closedDistinctions ["a","b","c"] coverage14 = .ok [("a","b")] := rfl
example : view (localOperator coverage14 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage14 ("a","b")) = some (("a","b"),["y"],["y"]) := rfl
example : view (localOperator coverage14 ("a","c")) = some (("a","c"),["y"],["z"]) := rfl
example : view (localOperator coverage14 ("a","outside")) = none := rfl
example : view (localOperator coverage14 ("b","a")) = some (("b","a"),["y"],["y"]) := rfl
example : view (localOperator coverage14 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage14 ("b","c")) = some (("b","c"),["y"],["z"]) := rfl
example : view (localOperator coverage14 ("b","outside")) = none := rfl
example : view (localOperator coverage14 ("c","a")) = some (("c","a"),["z"],["y"]) := rfl
example : view (localOperator coverage14 ("c","b")) = some (("c","b"),["z"],["y"]) := rfl
example : view (localOperator coverage14 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage14 ("c","outside")) = none := rfl
example : view (localOperator coverage14 ("outside","a")) = none := rfl
example : view (localOperator coverage14 ("outside","b")) = none := rfl
example : view (localOperator coverage14 ("outside","c")) = none := rfl
example : view (localOperator coverage14 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["y"]),(["z"],["z"])] = .ok [("a",["y"]),("b",["y"]),("c",["z"])] := rfl
def coverage15 : Encoding := [("a",["y"]),("b",["z"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage15 = true := rfl
example : closedDistinctions ["a","b","c"] coverage15 = .ok [] := rfl
example : view (localOperator coverage15 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage15 ("a","b")) = some (("a","b"),["y"],["z"]) := rfl
example : view (localOperator coverage15 ("a","c")) = some (("a","c"),["y"],["x"]) := rfl
example : view (localOperator coverage15 ("a","outside")) = none := rfl
example : view (localOperator coverage15 ("b","a")) = some (("b","a"),["z"],["y"]) := rfl
example : view (localOperator coverage15 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage15 ("b","c")) = some (("b","c"),["z"],["x"]) := rfl
example : view (localOperator coverage15 ("b","outside")) = none := rfl
example : view (localOperator coverage15 ("c","a")) = some (("c","a"),["x"],["y"]) := rfl
example : view (localOperator coverage15 ("c","b")) = some (("c","b"),["x"],["z"]) := rfl
example : view (localOperator coverage15 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage15 ("c","outside")) = none := rfl
example : view (localOperator coverage15 ("outside","a")) = none := rfl
example : view (localOperator coverage15 ("outside","b")) = none := rfl
example : view (localOperator coverage15 ("outside","c")) = none := rfl
example : view (localOperator coverage15 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["z"]),(["z"],["x"])] = .ok [("a",["y"]),("b",["z"]),("c",["x"])] := rfl
def coverage16 : Encoding := [("a",["y"]),("b",["z"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage16 = true := rfl
example : closedDistinctions ["a","b","c"] coverage16 = .ok [("a","c")] := rfl
example : view (localOperator coverage16 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage16 ("a","b")) = some (("a","b"),["y"],["z"]) := rfl
example : view (localOperator coverage16 ("a","c")) = some (("a","c"),["y"],["y"]) := rfl
example : view (localOperator coverage16 ("a","outside")) = none := rfl
example : view (localOperator coverage16 ("b","a")) = some (("b","a"),["z"],["y"]) := rfl
example : view (localOperator coverage16 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage16 ("b","c")) = some (("b","c"),["z"],["y"]) := rfl
example : view (localOperator coverage16 ("b","outside")) = none := rfl
example : view (localOperator coverage16 ("c","a")) = some (("c","a"),["y"],["y"]) := rfl
example : view (localOperator coverage16 ("c","b")) = some (("c","b"),["y"],["z"]) := rfl
example : view (localOperator coverage16 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage16 ("c","outside")) = none := rfl
example : view (localOperator coverage16 ("outside","a")) = none := rfl
example : view (localOperator coverage16 ("outside","b")) = none := rfl
example : view (localOperator coverage16 ("outside","c")) = none := rfl
example : view (localOperator coverage16 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["z"]),(["z"],["y"])] = .ok [("a",["y"]),("b",["z"]),("c",["y"])] := rfl
def coverage17 : Encoding := [("a",["y"]),("b",["z"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage17 = true := rfl
example : closedDistinctions ["a","b","c"] coverage17 = .ok [("b","c")] := rfl
example : view (localOperator coverage17 ("a","a")) = some (("a","a"),["y"],["y"]) := rfl
example : view (localOperator coverage17 ("a","b")) = some (("a","b"),["y"],["z"]) := rfl
example : view (localOperator coverage17 ("a","c")) = some (("a","c"),["y"],["z"]) := rfl
example : view (localOperator coverage17 ("a","outside")) = none := rfl
example : view (localOperator coverage17 ("b","a")) = some (("b","a"),["z"],["y"]) := rfl
example : view (localOperator coverage17 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage17 ("b","c")) = some (("b","c"),["z"],["z"]) := rfl
example : view (localOperator coverage17 ("b","outside")) = none := rfl
example : view (localOperator coverage17 ("c","a")) = some (("c","a"),["z"],["y"]) := rfl
example : view (localOperator coverage17 ("c","b")) = some (("c","b"),["z"],["z"]) := rfl
example : view (localOperator coverage17 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage17 ("c","outside")) = none := rfl
example : view (localOperator coverage17 ("outside","a")) = none := rfl
example : view (localOperator coverage17 ("outside","b")) = none := rfl
example : view (localOperator coverage17 ("outside","c")) = none := rfl
example : view (localOperator coverage17 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["y"]),(["y"],["z"]),(["z"],["z"])] = .ok [("a",["y"]),("b",["z"]),("c",["z"])] := rfl
def coverage18 : Encoding := [("a",["z"]),("b",["x"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage18 = true := rfl
example : closedDistinctions ["a","b","c"] coverage18 = .ok [("b","c")] := rfl
example : view (localOperator coverage18 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage18 ("a","b")) = some (("a","b"),["z"],["x"]) := rfl
example : view (localOperator coverage18 ("a","c")) = some (("a","c"),["z"],["x"]) := rfl
example : view (localOperator coverage18 ("a","outside")) = none := rfl
example : view (localOperator coverage18 ("b","a")) = some (("b","a"),["x"],["z"]) := rfl
example : view (localOperator coverage18 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage18 ("b","c")) = some (("b","c"),["x"],["x"]) := rfl
example : view (localOperator coverage18 ("b","outside")) = none := rfl
example : view (localOperator coverage18 ("c","a")) = some (("c","a"),["x"],["z"]) := rfl
example : view (localOperator coverage18 ("c","b")) = some (("c","b"),["x"],["x"]) := rfl
example : view (localOperator coverage18 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage18 ("c","outside")) = none := rfl
example : view (localOperator coverage18 ("outside","a")) = none := rfl
example : view (localOperator coverage18 ("outside","b")) = none := rfl
example : view (localOperator coverage18 ("outside","c")) = none := rfl
example : view (localOperator coverage18 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["x"]),(["z"],["x"])] = .ok [("a",["z"]),("b",["x"]),("c",["x"])] := rfl
def coverage19 : Encoding := [("a",["z"]),("b",["x"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage19 = true := rfl
example : closedDistinctions ["a","b","c"] coverage19 = .ok [] := rfl
example : view (localOperator coverage19 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage19 ("a","b")) = some (("a","b"),["z"],["x"]) := rfl
example : view (localOperator coverage19 ("a","c")) = some (("a","c"),["z"],["y"]) := rfl
example : view (localOperator coverage19 ("a","outside")) = none := rfl
example : view (localOperator coverage19 ("b","a")) = some (("b","a"),["x"],["z"]) := rfl
example : view (localOperator coverage19 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage19 ("b","c")) = some (("b","c"),["x"],["y"]) := rfl
example : view (localOperator coverage19 ("b","outside")) = none := rfl
example : view (localOperator coverage19 ("c","a")) = some (("c","a"),["y"],["z"]) := rfl
example : view (localOperator coverage19 ("c","b")) = some (("c","b"),["y"],["x"]) := rfl
example : view (localOperator coverage19 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage19 ("c","outside")) = none := rfl
example : view (localOperator coverage19 ("outside","a")) = none := rfl
example : view (localOperator coverage19 ("outside","b")) = none := rfl
example : view (localOperator coverage19 ("outside","c")) = none := rfl
example : view (localOperator coverage19 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["x"]),(["z"],["y"])] = .ok [("a",["z"]),("b",["x"]),("c",["y"])] := rfl
def coverage20 : Encoding := [("a",["z"]),("b",["x"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage20 = true := rfl
example : closedDistinctions ["a","b","c"] coverage20 = .ok [("a","c")] := rfl
example : view (localOperator coverage20 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage20 ("a","b")) = some (("a","b"),["z"],["x"]) := rfl
example : view (localOperator coverage20 ("a","c")) = some (("a","c"),["z"],["z"]) := rfl
example : view (localOperator coverage20 ("a","outside")) = none := rfl
example : view (localOperator coverage20 ("b","a")) = some (("b","a"),["x"],["z"]) := rfl
example : view (localOperator coverage20 ("b","b")) = some (("b","b"),["x"],["x"]) := rfl
example : view (localOperator coverage20 ("b","c")) = some (("b","c"),["x"],["z"]) := rfl
example : view (localOperator coverage20 ("b","outside")) = none := rfl
example : view (localOperator coverage20 ("c","a")) = some (("c","a"),["z"],["z"]) := rfl
example : view (localOperator coverage20 ("c","b")) = some (("c","b"),["z"],["x"]) := rfl
example : view (localOperator coverage20 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage20 ("c","outside")) = none := rfl
example : view (localOperator coverage20 ("outside","a")) = none := rfl
example : view (localOperator coverage20 ("outside","b")) = none := rfl
example : view (localOperator coverage20 ("outside","c")) = none := rfl
example : view (localOperator coverage20 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["x"]),(["z"],["z"])] = .ok [("a",["z"]),("b",["x"]),("c",["z"])] := rfl
def coverage21 : Encoding := [("a",["z"]),("b",["y"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage21 = true := rfl
example : closedDistinctions ["a","b","c"] coverage21 = .ok [] := rfl
example : view (localOperator coverage21 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage21 ("a","b")) = some (("a","b"),["z"],["y"]) := rfl
example : view (localOperator coverage21 ("a","c")) = some (("a","c"),["z"],["x"]) := rfl
example : view (localOperator coverage21 ("a","outside")) = none := rfl
example : view (localOperator coverage21 ("b","a")) = some (("b","a"),["y"],["z"]) := rfl
example : view (localOperator coverage21 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage21 ("b","c")) = some (("b","c"),["y"],["x"]) := rfl
example : view (localOperator coverage21 ("b","outside")) = none := rfl
example : view (localOperator coverage21 ("c","a")) = some (("c","a"),["x"],["z"]) := rfl
example : view (localOperator coverage21 ("c","b")) = some (("c","b"),["x"],["y"]) := rfl
example : view (localOperator coverage21 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage21 ("c","outside")) = none := rfl
example : view (localOperator coverage21 ("outside","a")) = none := rfl
example : view (localOperator coverage21 ("outside","b")) = none := rfl
example : view (localOperator coverage21 ("outside","c")) = none := rfl
example : view (localOperator coverage21 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["y"]),(["z"],["x"])] = .ok [("a",["z"]),("b",["y"]),("c",["x"])] := rfl
def coverage22 : Encoding := [("a",["z"]),("b",["y"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage22 = true := rfl
example : closedDistinctions ["a","b","c"] coverage22 = .ok [("b","c")] := rfl
example : view (localOperator coverage22 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage22 ("a","b")) = some (("a","b"),["z"],["y"]) := rfl
example : view (localOperator coverage22 ("a","c")) = some (("a","c"),["z"],["y"]) := rfl
example : view (localOperator coverage22 ("a","outside")) = none := rfl
example : view (localOperator coverage22 ("b","a")) = some (("b","a"),["y"],["z"]) := rfl
example : view (localOperator coverage22 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage22 ("b","c")) = some (("b","c"),["y"],["y"]) := rfl
example : view (localOperator coverage22 ("b","outside")) = none := rfl
example : view (localOperator coverage22 ("c","a")) = some (("c","a"),["y"],["z"]) := rfl
example : view (localOperator coverage22 ("c","b")) = some (("c","b"),["y"],["y"]) := rfl
example : view (localOperator coverage22 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage22 ("c","outside")) = none := rfl
example : view (localOperator coverage22 ("outside","a")) = none := rfl
example : view (localOperator coverage22 ("outside","b")) = none := rfl
example : view (localOperator coverage22 ("outside","c")) = none := rfl
example : view (localOperator coverage22 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["y"]),(["z"],["y"])] = .ok [("a",["z"]),("b",["y"]),("c",["y"])] := rfl
def coverage23 : Encoding := [("a",["z"]),("b",["y"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage23 = true := rfl
example : closedDistinctions ["a","b","c"] coverage23 = .ok [("a","c")] := rfl
example : view (localOperator coverage23 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage23 ("a","b")) = some (("a","b"),["z"],["y"]) := rfl
example : view (localOperator coverage23 ("a","c")) = some (("a","c"),["z"],["z"]) := rfl
example : view (localOperator coverage23 ("a","outside")) = none := rfl
example : view (localOperator coverage23 ("b","a")) = some (("b","a"),["y"],["z"]) := rfl
example : view (localOperator coverage23 ("b","b")) = some (("b","b"),["y"],["y"]) := rfl
example : view (localOperator coverage23 ("b","c")) = some (("b","c"),["y"],["z"]) := rfl
example : view (localOperator coverage23 ("b","outside")) = none := rfl
example : view (localOperator coverage23 ("c","a")) = some (("c","a"),["z"],["z"]) := rfl
example : view (localOperator coverage23 ("c","b")) = some (("c","b"),["z"],["y"]) := rfl
example : view (localOperator coverage23 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage23 ("c","outside")) = none := rfl
example : view (localOperator coverage23 ("outside","a")) = none := rfl
example : view (localOperator coverage23 ("outside","b")) = none := rfl
example : view (localOperator coverage23 ("outside","c")) = none := rfl
example : view (localOperator coverage23 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["y"]),(["z"],["z"])] = .ok [("a",["z"]),("b",["y"]),("c",["z"])] := rfl
def coverage24 : Encoding := [("a",["z"]),("b",["z"]),("c",["x"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage24 = true := rfl
example : closedDistinctions ["a","b","c"] coverage24 = .ok [("a","b")] := rfl
example : view (localOperator coverage24 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage24 ("a","b")) = some (("a","b"),["z"],["z"]) := rfl
example : view (localOperator coverage24 ("a","c")) = some (("a","c"),["z"],["x"]) := rfl
example : view (localOperator coverage24 ("a","outside")) = none := rfl
example : view (localOperator coverage24 ("b","a")) = some (("b","a"),["z"],["z"]) := rfl
example : view (localOperator coverage24 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage24 ("b","c")) = some (("b","c"),["z"],["x"]) := rfl
example : view (localOperator coverage24 ("b","outside")) = none := rfl
example : view (localOperator coverage24 ("c","a")) = some (("c","a"),["x"],["z"]) := rfl
example : view (localOperator coverage24 ("c","b")) = some (("c","b"),["x"],["z"]) := rfl
example : view (localOperator coverage24 ("c","c")) = some (("c","c"),["x"],["x"]) := rfl
example : view (localOperator coverage24 ("c","outside")) = none := rfl
example : view (localOperator coverage24 ("outside","a")) = none := rfl
example : view (localOperator coverage24 ("outside","b")) = none := rfl
example : view (localOperator coverage24 ("outside","c")) = none := rfl
example : view (localOperator coverage24 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["z"]),(["z"],["x"])] = .ok [("a",["z"]),("b",["z"]),("c",["x"])] := rfl
def coverage25 : Encoding := [("a",["z"]),("b",["z"]),("c",["y"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage25 = true := rfl
example : closedDistinctions ["a","b","c"] coverage25 = .ok [("a","b")] := rfl
example : view (localOperator coverage25 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage25 ("a","b")) = some (("a","b"),["z"],["z"]) := rfl
example : view (localOperator coverage25 ("a","c")) = some (("a","c"),["z"],["y"]) := rfl
example : view (localOperator coverage25 ("a","outside")) = none := rfl
example : view (localOperator coverage25 ("b","a")) = some (("b","a"),["z"],["z"]) := rfl
example : view (localOperator coverage25 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage25 ("b","c")) = some (("b","c"),["z"],["y"]) := rfl
example : view (localOperator coverage25 ("b","outside")) = none := rfl
example : view (localOperator coverage25 ("c","a")) = some (("c","a"),["y"],["z"]) := rfl
example : view (localOperator coverage25 ("c","b")) = some (("c","b"),["y"],["z"]) := rfl
example : view (localOperator coverage25 ("c","c")) = some (("c","c"),["y"],["y"]) := rfl
example : view (localOperator coverage25 ("c","outside")) = none := rfl
example : view (localOperator coverage25 ("outside","a")) = none := rfl
example : view (localOperator coverage25 ("outside","b")) = none := rfl
example : view (localOperator coverage25 ("outside","c")) = none := rfl
example : view (localOperator coverage25 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["z"]),(["z"],["y"])] = .ok [("a",["z"]),("b",["z"]),("c",["y"])] := rfl
def coverage26 : Encoding := [("a",["z"]),("b",["z"]),("c",["z"])]
example : validateEncoding ["a","b","c"] [["x"],["y"],["z"]] coverage26 = true := rfl
example : closedDistinctions ["a","b","c"] coverage26 = .ok [("a","b"),("a","c"),("b","c")] := rfl
example : view (localOperator coverage26 ("a","a")) = some (("a","a"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("a","b")) = some (("a","b"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("a","c")) = some (("a","c"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("a","outside")) = none := rfl
example : view (localOperator coverage26 ("b","a")) = some (("b","a"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("b","b")) = some (("b","b"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("b","c")) = some (("b","c"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("b","outside")) = none := rfl
example : view (localOperator coverage26 ("c","a")) = some (("c","a"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("c","b")) = some (("c","b"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("c","c")) = some (("c","c"),["z"],["z"]) := rfl
example : view (localOperator coverage26 ("c","outside")) = none := rfl
example : view (localOperator coverage26 ("outside","a")) = none := rfl
example : view (localOperator coverage26 ("outside","b")) = none := rfl
example : view (localOperator coverage26 ("outside","c")) = none := rfl
example : view (localOperator coverage26 ("outside","outside")) = none := rfl
example : composeEncodings [("a",["x"]),("b",["y"]),("c",["z"])] [(["x"],["z"]),(["y"],["z"]),(["z"],["z"])] = .ok [("a",["z"]),("b",["z"]),("c",["z"])] := rfl
