import SFT.Physics.BaryonPhotonTransport
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.BaryonPhotonTransport
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let p ← IO.ofExcept baryonPhotonRelation
 IO.println (render (.object [("cp_measure",.text p.cpMeasure),("imbalance_share",fraction p.imbalanceShare),("eta_relation",.text p.etaRelation),("root_policy",.text p.rootPolicy)]))
