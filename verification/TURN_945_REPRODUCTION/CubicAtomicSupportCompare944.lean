import SFT.Physics.CubicAtomicSupport
open SFT.Physics SFT.Host.Canonical
#eval do
 let n ← IO.ofExcept CubicAtomicSupport.cubicCoordination
 let w ← IO.ofExcept CubicAtomicSupport.cubicNeighbourWeight
 let b ← IO.ofExcept CubicAtomicSupport.cubicBalance
 IO.println (render (.array [.integer (.ofNat n),.integer w.num,.integer (.ofNat w.den),.integer b.num,.integer (.ofNat b.den)]))
