import SFT.Mathematics.GeometryDimension
open SFT.Mathematics.GeometryTopology

#eval do
  let cases : List (Except String Nat × Except String Nat) := [
    (cellDimension witnessCells witnessBoundary "triangle", .ok 3),
    (cellDimension witnessCells witnessBoundary "pq", .ok 2),
    (cellDimension ["p"] [] "p", .ok 1),
    (cellDimension [] [] "p", .error "dimension requires a registered finite incidence complex"),
    (cellDimension ["p"] [] "q", .error "dimension requires a registered finite incidence complex"),
    (cellDimension ["p","p"] [] "p", .error "dimension requires a registered finite incidence complex"),
    (cellDimension ["p"] [("p","p")] "p", .error "dimension requires a registered finite incidence complex"),
    (cellDimension ["p","q"] [("p","q"),("q","p")] "p", .error "boundary descent cannot contain a return cycle"),
    (cellDimension ["p","q","leaf"] [("p","q"),("q","p")] "leaf", .ok 1),
    (cellDimension ["p","q","r","top"] [("p","q"),("p","r"),("q","top"),("r","top")] "top", .ok 3),
    (cellDimension ["p","q","r","top"] [("r","top"),("q","top"),("p","r"),("p","q")] "top", .ok 3)]
  for (actual, expected) in cases do
    let agrees := match (actual : Except String Nat), (expected : Except String Nat) with
      | .ok a, .ok b => a == b
      | .error a, .error b => a == b
      | _, _ => false
    if !agrees then throw (IO.userError "boundary-depth source case failed")
  IO.println s!"PASS: {cases.length} boundary-depth source cases"
