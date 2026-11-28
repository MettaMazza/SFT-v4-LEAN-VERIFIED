import SFT.Applications.Discovery.Extended
import SFT.Applications.Discovery.Reports
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Extended
open SFT.Applications.Discovery.Source
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Host.Text

def require (name : String) (ok : Bool) : IO Unit :=
 bif ok then line (append "PASS " name) else throw (IO.userError (append "FAIL " name))
def main (args : List String) : IO Unit := do
 let thirds := runExtendedProof [fraction 1 3,fraction 2 3] []
 require "thirds base and original sector 4" (thirds.base.proves && decide (thirds.base.sector = some 4))
 require "thirds extra checks preserve false T6 T11 T12" (!(thirds.t6.getD true) && !(thirds.t11.getD true) && !(thirds.t12.getD true))
 require "thirds T7 T8 T9 T10" (thirds.t7.getD false && thirds.t8 && thirds.t9.getD false && thirds.t10.getD false)
 let half := runExtendedProof [fraction 1 2] []
 require "half sector3 full extended checks" (half.base.proves && decide (half.base.sector = some 3) && half.t6.getD false && half.t7.getD false && half.t8 && half.t9.getD false && half.t10.getD false && half.t11.getD false && half.t12.getD false)
 let corpus ← load (args.headD "reference/applications/discovery-SFT-v2")
 let a := analyze corpus
 each a.unanchored fun g => do
  let p := runExtendedProof g.members a.claimed
  require "extended original PROVES unchanged" (p.base.proves == (p.base.t1Confines && p.base.t2Closed && p.base.t3Resolves && p.base.t4SingleSector))
 line (append "EXTENDED_GROUPS " (n a.unanchored.length))
