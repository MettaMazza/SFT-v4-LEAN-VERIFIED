import SFT.Physics.MixingCorrespondence
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.MixingCorrespondence SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def matrix (m : List (List Rat)) : Value := .array (m.map fun row => .array (row.map fraction))
#eval do
 let result ← IO.ofExcept mixingCorrespondence
 let channels ← IO.ofExcept channelBasis
 let basis ← IO.ofExcept leptonMassBasis
 let values := [LeptonIntervals.normalize (-7) 3 (by decide),LeptonIntervals.zero,LeptonIntervals.normalize 1 6 (by decide),LeptonIntervals.normalize 1 2 (by decide),LeptonIntervals.normalize 5 6 (by decide),LeptonIntervals.normalize 1 1 (by decide),LeptonIntervals.normalize 7 3 (by decide)]
 let folded ← IO.ofExcept (values.mapM triplingFold)
 let alignment ← IO.ofExcept (alignmentMatrix values)
 IO.println (render (.object [("channels",.array (channels.map fraction)),("basis",.array (basis.map fraction)),("tripling",.array (folded.map fraction)),("alignment",matrix alignment),("result",.object [("quark_lock",fraction result.quarkLock),("lepton_lock",fraction result.leptonLock),("quark_matrix",matrix result.quarkMatrix),("lepton_matrix",matrix result.leptonMatrix),("quark_class",.text result.quarkClass),("lepton_class",.text result.leptonClass)])]))
