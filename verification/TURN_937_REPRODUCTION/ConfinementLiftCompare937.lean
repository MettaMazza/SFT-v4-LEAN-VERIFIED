import SFT.Physics.ConfinementLift
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.ConfinementLift SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let r ← IO.ofExcept confinementLift
 IO.println (render (.object [("down_sharpened_product",fraction r.downSharpenedProduct),("up_sharpened_product",fraction r.upSharpenedProduct),("lightest_carrier_lift",.integer (.ofNat r.lightestCarrierLift)),("acted_carrier",.text r.actedCarrier),("retained_carriers",.array (r.retainedCarriers.map Value.text))]))
