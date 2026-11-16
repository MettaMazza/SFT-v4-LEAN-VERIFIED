import SFT.Physics.YangMillsSpectrumMeasurement
import SFT.Physics.SymmetricRecords
namespace SFT.Physics.SmithionObservationAnalysis
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactAnalysis (record : Value) : Except String Value := do
 let sources ← array (← field record "sources")
 let rows : Nat → Except String Value := fun index => do field (← LeptonRatios.atIndex sources index) "rows"
 let planck ← rows 0
 let baryon ← field planck "baryon_density_omega_b_h2"
 let dark ← field planck "cold_dark_density_omega_c_h2"
 let number := fun row key => do YangMillsSpectrumMeasurement.exactInput (← field row key)
 let b ← number baryon "central"
 let bu ← number baryon "standard_uncertainty"
 let d ← number dark "central"
 let du ← number dark "standard_uncertainty"
 let low ← LeptonRatios.divide (subtract d du) (add b bu)
 let high ← LeptonRatios.divide (add d du) (subtract b bu)
 let formal := normalize 27 5 (by decide)
 let transported := multiply formal b
 let sparc ← rows 1
 let meg ← rows 2
 let babar ← rows 3
 let tauMu ← field babar "tau_to_mu_gamma"
 let tauE ← field babar "tau_to_e_gamma"
 let limits ← [meg,tauMu,tauE].mapM (fun row=>number row "branching_fraction_upper_limit")
 let signals ← [meg,tauE,tauMu].mapM (fun row=>field row "observed_signal")
 let boundary ← field record "methodological_boundary"
 let upperType ← field boundary "upper_limits_not_relabelled_as_rate_measurements"
 let massType ← field boundary "unobserved_new_particle_masses_not_relabelled_as_measurements"
 let evidenceTypes := if SymmetricRecords.truthy upperType then massType else upperType
 let rat := RunningConvergenceCertificate.rat
 .ok (.object [
 ("ratio_interval",.array [rat low,rat high]),
 ("transported_density",rat transported),
 ("dark_interval",.array [rat (subtract d du),rat (add d du)]),
 ("ratio_passes",.boolean (!formal.blt low && !high.blt formal)),
 ("absolute_transport_passes",.boolean (!transported.blt (subtract d du) && !(add d du).blt transported)),
 ("sparc_complete",.boolean (sameValue (← field sparc "galaxy_count") (.text "175") && Text.contains (← text (← field sparc "baryon_comparison")) "submaximal")),
 ("all_lfv_limits_positive",.boolean (limits.all (fun q=>zero.blt q))),
 ("all_lfv_searches_null",.boolean (signals.all (fun v=>sameValue v (.text "none")))),
 ("lfv_relative_rate_measured",.boolean false),
 ("smithion_mass_measured",.boolean false),
 ("evidence_types_preserved",evidenceTypes),
 ("all_sources_retained",.boolean (sources.length==4))])
#print axioms exactAnalysis
end SFT.Physics.SmithionObservationAnalysis
