import SFT.Physics.PMNSPhysical
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.PMNSPhysical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let p ← IO.ofExcept pmnsCPStructure
 IO.println (render (.object [("atmospheric",fraction p.atmospheric),("solar",fraction p.solar),("reactor",fraction p.reactor),("cp_phase",fraction p.cpPhase),("electron_weights",.array [fraction p.electronWeights.1,fraction p.electronWeights.2.1,fraction p.electronWeights.2.2])]))
