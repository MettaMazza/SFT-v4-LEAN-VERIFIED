import SFT.Physics.QuarkIsolation
import Lean
open SFT.Physics Lean
 def ratJSON (r : Rat) : Json := toJson (r.num,r.den)
 def bracketsJSON (xs : List (Rat × Rat)) : Json :=
  toJson (xs.map fun (a,b) => (ratJSON a,ratJSON b))
 def main : IO Unit := do
  match QuarkIsolation.rootBrackets with
  | .error e => throw (IO.userError e)
  | .ok (down,up) => IO.println (Json.mkObj [("down",bracketsJSON down),("up",bracketsJSON up)]).compress
