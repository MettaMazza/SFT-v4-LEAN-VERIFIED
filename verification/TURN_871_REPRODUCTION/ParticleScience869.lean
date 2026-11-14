import SFT.Physics.WZRelation
import SFT.Physics.CPPhase
import SFT.Physics.DiracG
import SFT.Physics.ParityFibre
import SFT.Host.Canonical
open SFT.Physics SFT.Foundation.ExactPartCarrier SFT.Host.Canonical

def partValue (p : Part) : Value := .array [.integer p.numerator,.integer p.denominator]
def partResult (p : Except String Part) : Value := match p with
 | .ok p => partValue p
 | .error e => .object [("error",.text e)]
def main : IO Unit := do
 let g := match DiracG.factor with
  | .ok n => Value.integer n
  | .error e => .object [("error",.text e)]
 let fibre := match ParityFibre.heldFibre with
  | .ok f => .object [("left_held",partValue f.leftHeld),("image",partValue f.image),("right_held",partValue f.rightHeld)]
  | .error e => .object [("error",.text e)]
 IO.println (render (.object [("wz",partResult WZRelation.squaredRatio),("cp",partResult CPPhase.phasePosition),("dirac",g),("parity",fibre)]))
