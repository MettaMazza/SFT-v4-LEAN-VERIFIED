import SFT.Physics.NeutrinoLadder
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.NeutrinoLadder
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def outputCount (x : SFT.Physics.GeneratorOperations.CountInput) : Value := match mersenneCount x with
 | .ok n => .integer (.ofNat n)
 | .error e => .text e
#eval do
 let s ← IO.ofExcept neutrinoSplittingStructure
 let m ← IO.ofExcept neutrinoMassSquares
 let counts := ([.integer 1,.integer 2,.integer 5,.integer 10,.integer 16,.integer 0,.integer (-1),.boolean true,.boolean false] : List SFT.Physics.GeneratorOperations.CountInput).map outputCount
 IO.println (render (.object [("splitting",.object [("solar_rung",.integer (.ofNat s.solarRung)),("atmospheric_rung",.integer (.ofNat s.atmosphericRung)),("rung_ratio",fraction s.rungRatio),("translation_ratio",fraction s.translationRatio)]),("mass",.object [("lightest",fraction m.lightest),("middle",fraction m.middle),("heavy",fraction m.heavy)]),("counts",.array counts)]))
