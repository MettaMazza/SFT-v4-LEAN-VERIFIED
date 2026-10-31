import SFT.Physics.CosmicComponentTransport
import SFT.Physics.RunningConvergenceCertificate
namespace SFT.Physics.CosmicComponentTransportCertificate
open SFT.Host.Canonical CosmicComponentTransport

def pressureName : PressureOrientation → String
 | .emptyPressureOneForm => "empty-pressure-One-form"
 | .outwardThirdOne => "outward-third-One"
 | .tensionOne => "tension-One"
def powerValue : TransportPower → Value
 | .positive n _ => .integer (.ofNat n)
 | .emptyDilutionOneForm => .text "empty-dilution-One-form"
def lawValue (law : ComponentLaw) : Value := .object [
 ("component",.text law.component),("transport_power",powerValue law.transportPower),
 ("pressure_orientation",.text (pressureName law.pressureOrientation)),
 ("conventional_correspondence",.text law.conventionalCorrespondence)]
def componentTable : Value := .array (componentLaws.map lawValue)
end SFT.Physics.CosmicComponentTransportCertificate
