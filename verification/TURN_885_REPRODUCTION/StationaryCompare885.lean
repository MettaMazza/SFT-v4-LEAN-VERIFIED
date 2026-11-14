import SFT.Physics.StationarySpectrum
open SFT.Physics SFT.Host.Canonical
def output (x : Except String (List SFT.Foundation.ExactOperations.PositiveFraction)) : Value := match x with | .error e => .object [("error",.text e)] | .ok xs => .object [("ok",.array (xs.map fun p => .array [.integer (.ofNat p.numerator),.integer (.ofNat p.denominator)]))]
def main : IO Unit := do
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.integer (1)))))
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.integer (2)))))
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.integer (3)))))
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.integer (4)))))
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.integer (5)))))
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.integer (6)))))
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.integer (0)))))
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.integer (-1)))))
 IO.println (render (output (StationarySpectrum.stationarySpectrum (.boolean true))))
