import SFT.Physics.GravitonPolarization
open SFT.Physics SFT.Host.Canonical
def showResult (x : Except String GravitonPolarization.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => .object [("symmetric_components",.integer (.ofNat r.symmetricComponents)),("gauge_components",.integer (.ofNat r.gaugeComponents)),("physical_polarizations",match r.physicalPolarizations with | none => .array [] | some n => .integer (.ofNat n))]
def main : IO Unit := do
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (3)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (4)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (5)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (6)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (7)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (8)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (2)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (0)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.integer (-1)))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.boolean true))))
 IO.println (render (showResult (GravitonPolarization.gravitonPolarizations (.boolean false))))
