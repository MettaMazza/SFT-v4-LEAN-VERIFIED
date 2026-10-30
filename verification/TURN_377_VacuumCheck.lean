import SFT.Physics.VacuumSpectrum
import Lean
open SFT.Physics.VacuumSpectrum Lean
def main : IO Unit := do
 for k in [1,2,3,4,5,6,7,8] do
  IO.println (Json.mkObj [("depth",toJson k),("levels",toJson (pairs (levels k)))]).compress
