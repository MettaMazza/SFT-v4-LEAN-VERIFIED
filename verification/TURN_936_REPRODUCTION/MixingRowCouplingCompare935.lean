import SFT.Physics.MixingRowCoupling
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.MixingRowCoupling SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let r ← IO.ofExcept interEntryCouplings
 IO.println (render (.object [("quark_row_sum",fraction r.quarkRowSum),("quark_lock",fraction r.quarkLock),("lepton_row_sum",fraction r.leptonRowSum),("lepton_lock",fraction r.leptonLock)]))
