import SFT.Physics.MolecularSpectroscopy
open SFT.Physics SFT.Host.Canonical MolecularSpectroscopy
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let hydrogenRotationalToVibrational ← IO.ofExcept hydrogenRotationalToVibrational
 let hydrogenAnharmonicToVibrational ← IO.ofExcept hydrogenAnharmonicToVibrational
 let deuteriumRotationalTransport ← IO.ofExcept deuteriumRotationalTransport
 let deuteriumVibrationalSquaredTransport ← IO.ofExcept deuteriumVibrationalSquaredTransport
 IO.println (render (.object [("hydrogenRotationalToVibrational",frac hydrogenRotationalToVibrational),("hydrogenAnharmonicToVibrational",frac hydrogenAnharmonicToVibrational),("deuteriumRotationalTransport",frac deuteriumRotationalTransport),("deuteriumVibrationalSquaredTransport",frac deuteriumVibrationalSquaredTransport)]))
