import SFT.Physics.MirrorMassClosure
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.MirrorMassClosure SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let r ← IO.ofExcept mirrorMassClosure
 IO.println (render (.object [("positions",.array (r.positions.map fraction)),("shortfalls",.array (r.shortfalls.map fraction)),("position_sum",fraction r.positionSum),("shortfall_sum",fraction r.shortfallSum),("mirror_closed",.boolean r.mirrorClosed)]))
