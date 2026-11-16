import SFT.Physics.StellarCertificate
import SFT.Physics.RunningConvergenceMeasurement
namespace SFT.Physics.StellarWitnesses
open StellarResponses StellarCertificate LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match ((do let c ← hydrostaticBalance; pure (flag c "complete" && flag c "balanced")) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
def witness1 : Bool := match ((do let c ← theoremCertificate; let rows ← RunningConvergenceMeasurement.array (← RunningConvergenceMeasurement.field c "radial_rows"); pure (flag c "all_radial_restoring" && rows.all (fun row=> !flag row "irrational_root_evaluated"))) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
def witness2 : Bool := match ((do let a ← stellarLuminosityExponents; let b ← stellarLifetimeFallExponents; pure (a==(3,4) && b==(2,3))) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
def witness3 : Bool := match ((do pure (flag (← theoremCertificate) "all_flat_rows_require_growth")) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
def witness4 : Bool := match ((do pure ((← baryonicTullyFisherExponent)==4 && (← baryonicTullyFisherRatio (normalize 2 1 (by decide)))==normalize 16 1 (by decide))) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness4Passed : witness4=true := rfl
#print axioms witness4Passed
def witness5 : Bool := match ((do let c ← theoremCertificate; let rows ← RunningConvergenceMeasurement.array (← RunningConvergenceMeasurement.field c "tidal_rows"); pure (flag c "all_tidal_rows_lock" && rows.all (fun row=>flag row "strictly_dissipative_before_lock"))) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness5Passed : witness5=true := rfl
#print axioms witness5Passed
def witnesses : List Witness := [⟨"hydrostatic","Half-One is the complete balanced pair.",witness0⟩,⟨"radial-restoration","All exact registered displacements restore without evaluating a fractional root.",witness1⟩,⟨"stellar-endpoints","Three/four luminosity and two/three lifetime endpoint classes are exact.",witness2⟩,⟨"flat-curve","Every exact registered flat curve forces enclosed support growth.",witness3⟩,⟨"tully-four","Three-space plus the recurrence forces fourth-power baryonic transport.",witness4⟩,⟨"tidal-terminal","Every finite registered mismatch terminates at one-to-one with strict prior decrease.",witness5⟩]
end SFT.Physics.StellarWitnesses
