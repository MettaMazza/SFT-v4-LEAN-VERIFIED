import SFT.Physics.StrongFieldHorizon
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showFloor (x : Except String Rat) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok q => fraction q
def main : IO Unit := do
 match StrongFieldHorizon.strongFieldHorizon with
 | .error message => IO.println (render (.object [("error",.text message)]))
 | .ok r => IO.println (render (.object [("mass",fraction r.mass),("radius",fraction r.radius),("entropy_coefficient",fraction r.entropyCoefficient),("area_cells",.integer (.ofNat r.areaCells)),("entropy_cells",fraction r.entropyCells),("normalized_thermal_carrier",fraction r.normalizedThermalCarrier)]))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (1)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (2)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (3)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (4)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (5)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (6)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (7)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (8)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (9)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (10)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (11)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (12)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (13)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (14)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (15)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (16)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (0)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.integer (-1)))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.boolean true))))
 IO.println (render (showFloor (StrongFieldHorizon.finiteDistanceFloor (.boolean false))))
