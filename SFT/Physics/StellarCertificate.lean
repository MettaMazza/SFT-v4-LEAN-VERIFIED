import SFT.Physics.StellarTides
namespace SFT.Physics.StellarCertificate
open SFT.Host.Canonical StellarResponses LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def flag (row : Value) (key : String) : Bool := match row with
 | .object fields => match fields.find? (fun pair=>SFT.Host.Text.equal pair.1 key) with
  | some (_, .boolean b)=>b
  | some (_, .null) | some (_, .integer _) | some (_, .text _) | some (_, .array _) | some (_, .object _) | none=>false
 | .null | .boolean _ | .integer _ | .text _ | .array _=>false
def natPair (p : Nat × Nat) : Value := .array [.integer (.ofNat p.1),.integer (.ofNat p.2)]
def theoremCertificate : Except String Value := do
 let radialRows ← [normalize 3 2 (by decide),normalize 2 1 (by decide),normalize 5 2 (by decide)].mapM radialRestoration
 let galaxyRows ← [normalize 3 2 (by decide),normalize 2 1 (by decide),normalize 3 1 (by decide)].mapM visibleAsymptoteComparison
 let tidalRows ← [(2,1),(3,1),(3,2),(5,3)].mapM (fun (a,b)=>StellarTides.tidalTerminal (.integer (.ofNat a)) (.integer (.ofNat b)))
 let stellarRows ← [normalize 3 2 (by decide),normalize 2 1 (by decide),normalize 3 1 (by decide)].mapM stellarScaling
 pure (.object [("hydrostatic",← hydrostaticBalance),("radial_exponents",← radialResponseExponents),("radial_rows",.array radialRows),("luminosity_exponents",natPair (← stellarLuminosityExponents)),("lifetime_fall_exponents",natPair (← stellarLifetimeFallExponents)),("stellar_rows",.array stellarRows),("galaxy_rows",.array galaxyRows),("tully_fisher_exponent",.integer (.ofNat (← baryonicTullyFisherExponent))),("tidal_rows",.array tidalRows),("all_radial_restoring",.boolean (radialRows.all (fun row=>flag row "compression_pushes_out" && flag row "expansion_pulls_in"))),("all_flat_rows_require_growth",.boolean (galaxyRows.all (fun row=>flag row "flat_requires_additional_enclosed_support"))),("all_tidal_rows_lock",.boolean (tidalRows.all (fun row=>flag row "terminal_one_to_one" && flag row "finite")))])
#print axioms theoremCertificate
end SFT.Physics.StellarCertificate
