import SFT.Physics.MatterIdentityGraphs
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.MatterIdentityGraphs
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let c ← IO.ofExcept ckmPhysicalIdentity
 let p ← IO.ofExcept protonElectronIdentity
 IO.println (render (.object [("ckm",.object [("s12_squared",.text c.s12Squared),("s23",.text c.s23),("s13_squared",.text c.s13Squared),("apex_squared",fraction c.apexSquared),("phase",fraction c.phase)]),("proton",.object [("lepton_polynomial",.array [fraction p.leptonPolynomial.1,fraction p.leptonPolynomial.2.1,fraction p.leptonPolynomial.2.2]),("proton_share",fraction p.protonShare),("ratio_graph",.text p.ratioGraph)])]))
