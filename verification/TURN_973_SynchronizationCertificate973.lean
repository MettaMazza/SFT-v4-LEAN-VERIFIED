import SFT.Physics.CoupledEnsembleSynchronizationGrammar
import SFT.Host.Canonical
open SFT.Physics CoupledEnsembleSynchronization CoupledEnsembleSynchronizationCertificate SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def list (xs : List Rat) : Value := .array (xs.map frac)
def scale : Scale → Value | .empty => .array [] | .positive q => frac q
def cert (c : Certificate) : Value := .object [
 ("couplings",list c.couplings),("pairs",.array (c.pairs.map (fun (a,b) => .array [frac a,frac b]))),
 ("residual_records",.array (c.residualRecords.map (fun xs => .array (xs.map list)))),
 ("unique_synchronizing_coupling",frac c.uniqueSynchronizingCoupling),
 ("half_One_residuals_empty",.boolean c.halfOneResidualsEmpty),
 ("off_half_residuals_positive",.boolean c.offHalfResidualsPositive),
 ("residual_scale_lower",scale c.residualScaleLower),("residual_scale_half",scale c.residualScaleHalf),
 ("residual_scale_upper",scale c.residualScaleUpper),("synchronized_terminal_preserved",.boolean c.synchronizedTerminalPreserved)]
#eval IO.println (render (match formalCertificate with | .ok c => cert c | .error e => .text e))
