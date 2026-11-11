import SFT.Chemistry.Diastereomer
open SFT.Chemistry SFT.Chemistry.Chirality SFT.Chemistry.Diastereomer
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def left : OrientedMolecule := ⟨⟨["a","z"],["E","F"],[("a","z")],[]⟩,[("a",baseOrientation),("z",baseOrientation)]⟩
def right : OrientedMolecule := ⟨⟨["p","b"],["F","E"],[("b","p")],[]⟩,[("p",baseOrientation),("b",baseOrientation)]⟩
def m : ConstitutionMap := sourceConstitutionMap left right ["b","p"]
 (by decide) (by decide) (by decide) (by decide) (by decide)
 (List.Perm.swap "p" "b" [])
 (by intro edge h; cases h with
     | head => exact ⟨.head _,.tail _ (.head _)⟩
     | tail _ h => cases h)
 (by decide)
def cases : List (String × String × String × List String) := [("0","0","E",["a"]),("0","0","G",["a"]),("0","0","E",["z"]),("0","0","G",["z"]),("0","0","E",["a","z"]),("0","0","G",["a","z"]),("0","m","E",["a"]),("0","m","G",["a"]),("0","m","E",["z"]),("0","m","G",["z"]),("0","m","E",["a","z"]),("0","m","G",["a","z"]),("0","zz","E",["a"]),("0","zz","G",["a"]),("0","zz","E",["z"]),("0","zz","G",["z"]),("0","zz","E",["a","z"]),("0","zz","G",["a","z"]),("m","0","E",["a"]),("m","0","G",["a"]),("m","0","E",["z"]),("m","0","G",["z"]),("m","0","E",["a","z"]),("m","0","G",["a","z"]),("m","m","E",["a"]),("m","m","G",["a"]),("m","m","E",["z"]),("m","m","G",["z"]),("m","m","E",["a","z"]),("m","m","G",["a","z"]),("m","zz","E",["a"]),("m","zz","G",["a"]),("m","zz","E",["z"]),("m","zz","G",["z"]),("m","zz","E",["a","z"]),("m","zz","G",["a","z"]),("zz","0","E",["a"]),("zz","0","G",["a"]),("zz","0","E",["z"]),("zz","0","G",["z"]),("zz","0","E",["a","z"]),("zz","0","G",["a","z"]),("zz","m","E",["a"]),("zz","m","G",["a"]),("zz","m","E",["z"]),("zz","m","G",["z"]),("zz","m","E",["a","z"]),("zz","m","G",["a","z"]),("zz","zz","E",["a"]),("zz","zz","G",["a"]),("zz","zz","E",["z"]),("zz","zz","G",["z"]),("zz","zz","E",["a","z"]),("zz","zz","G",["a","z"])]
def main : IO Unit := cases.forM fun (fresh,target,element,links) =>
 IO.println (MolecularIsomer.structurallyEquivalent
  (extendedLeftCarrier m fresh element baseOrientation links).carrier
  (extendedRightCarrier m target element baseOrientation links).carrier)
