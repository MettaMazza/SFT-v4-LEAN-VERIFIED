import SFT.Physics.VacuumInertia
import SFT.Host.Canonical
open SFT.Physics SFT.Foundation SFT.Host.Canonical
def main : IO Unit := do
 let ratio ← IO.ofExcept VacuumInertia.exchange
 let vacuum ← IO.ofExcept VacuumSpectrum.vacuumFloor
 let coupling ← IO.ofExcept ElectroweakMixing.halfOne
 let vf := ExactOperations.foldPart vacuum
 let cf := ExactOperations.foldPart coupling
 let pairs := [(ratio.numerator,ratio.denominator),(vacuum.numerator,vacuum.denominator),
  (coupling.numerator,coupling.denominator),(vf.numerator,vf.denominator),(cf.numerator,cf.denominator)]
 IO.println (render (.array (pairs.map fun p => .array [.integer (.ofNat p.1),.integer (.ofNat p.2)])))
