import SFT.Mathematics.GeometryPaths
open SFT.Mathematics.GeometryTopology SFT.Mathematics.DiscreteObjects

#eval do
  let cases : List (Except String (Option (List String)) × Except String (Option (List String))) := [
    (pathDistance ["a","b","c"] [("a","b"),("b","c")] "a" "c", .ok (some ["a","b","c"])),
    (pathDistance ["a"] [] "a" "a", .ok (some emptyOne)),
    (pathDistance [] [] "a" "a", .error "distance endpoints must belong to the generated carrier"),
    (pathDistance ["a"] [("a","b")] "a" "b", .error "distance endpoints must belong to the generated carrier"),
    (pathDistance ["a","b"] [] "a" "b", .ok none),
    (pathDistance ["a","b"] [("b","a")] "a" "b", .ok (some ["a","b"])),
    (pathDistance ["a","b"] [("a","outside"),("outside","b")] "a" "b", .ok (some ["a","outside","b"])),
    (pathDistance ["a","a","b"] [("a","a"),("a","b"),("a","b")] "a" "b", .ok (some ["a","b"])),
    (pathDistance ["a","b","c"] [("a","b"),("b","a"),("a","a")] "a" "c", .ok none),
    (pathDistance ["a","t"] [("a","x"),("a","y"),("x","t"),("y","t")] "a" "t", .ok (some ["a","x","t"])),
    (pathDistance ["a","t"] [("a","y"),("a","x"),("x","t"),("y","t")] "a" "t", .ok (some ["a","y","t"])),
    (pathDistance ["a","t"] [("a","x"),("x","y"),("y","t"),("a","t")] "a" "t", .ok (some ["a","t"])),
    (pathDistance ["a","t"] [("a","x"),("a","x"),("x","t")] "a" "t", .ok (some ["a","x","t"]))]
  for (actual,expected) in cases do
    let agrees := match (actual : Except String (Option (List String))), (expected : Except String (Option (List String))) with
      | .ok a, .ok b => a == b
      | .error a, .error b => a == b
      | _, _ => false
    if !agrees then throw (IO.userError "path source regression failed")
  IO.println s!"PASS: {cases.length} path source cases"
  let choices : Boundary := [("a","b"),("a","c"),("b","a"),("b","c"),("c","a"),("c","b")]
  for mask in List.range 64 do
    let edges := (choices.zip (List.range 6)).filterMap fun (pair : (String × String) × Nat) => if (mask / 2^pair.2) % 2 == 1 then some pair.1 else none
    for origin in ["a","b","c"] do
      for target in ["a","b","c"] do
        let result := match pathDistance ["a","b","c"] edges origin target with
          | .ok none => "NONE"
          | .ok (some path) => String.intercalate "," path
          | .error message => message
        IO.println s!"{mask}\t{origin}\t{target}\t{result}"
