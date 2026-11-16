import SFT.Physics.SectorAnchorRecords
import SFT.Physics.StrongCPObservationAnalysis
namespace SFT.Physics.StrongCPObservationMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement StrongCPObservationAnalysis
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Input conversion for the hash-bound source record and its original two controls.
-- The six retained exponent fields are natural counts (34,34,34,33,33,33).
def decodeProton (row : Value) : Except String ProtonRow := do
 let number := fun key => do YangMillsSpectrumMeasurement.exactInput (← field row key)
 let power ← SectorAnchorRecords.originalInt (← field row "power_of_ten_years")
 let candidateCountPresent := match row with
  | .object fs => fs.any (fun (k,_)=>Text.equal k "candidate_count")
  | .null | .boolean _ | .integer _ | .text _ | .array _ => false
 .ok ⟨← number "partial_lifetime_lower_limit_mantissa",power.toNat,← field row "interpretation",candidateCountPresent,← number "confidence_fraction"⟩
def decode (record : Value) : Except String Target := do
 let sources ← array (← field record "sources")
 let rows : Nat → Except String Value := fun i=>do field (← LeptonRatios.atIndex sources i) "rows"
 let nedm ← field (← rows 0) "neutron_electric_dipole_moment"
 let number := fun key=>do YangMillsSpectrumMeasurement.exactInput (← field nedm key)
 let specifications : List (Nat × String) := [(1,"p_to_e_plus_pi0"),(1,"p_to_mu_plus_pi0"),(2,"p_to_e_plus_eta"),(2,"p_to_mu_plus_eta"),(3,"p_to_e_plus_pi0_pi0"),(3,"p_to_mu_plus_pi0_pi0")]
 let protons ← specifications.mapM (fun (i,key)=>do decodeProton (← field (← rows i) key))
 let boundary ← field record "methodological_boundary"
 .ok ⟨← field nedm "reported_central_status",← SectorAnchorRecords.originalInt (← field nedm "scientific_power_denominator"),← number "upper_limit_mantissa",← number "reported_statistical_uncertainty_mantissa",← number "reported_systematic_uncertainty_mantissa",← number "confidence_fraction",protons,← field boundary "finite_limits_not_relabelled_as_completed_infinity",← field boundary "null_central_estimate_not_relabelled_as_numerical_proof_zero",sources.length⟩
def exactAnalysis (record : Value) : Except String Value := do
 StrongCPObservationAnalysis.exactAnalysis (← decode record)
end SFT.Physics.StrongCPObservationMeasurement
