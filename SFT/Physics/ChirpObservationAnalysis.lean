import SFT.Physics.YangMillsSpectrumMeasurement
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.ChirpObservationAnalysis
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactAnalysis (record : Value) : Except String Value := do
 let developments ← array (← field record "development_context")
 let development ← LeptonRatios.atIndex developments 0
 let sources ← array (← field record "withheld_postseal_sources")
 let chirp ← field (← LeptonRatios.atIndex sources 0) "rows"
 let ring ← field (← LeptonRatios.atIndex sources 1) "rows"
 let chirpSignal ← field chirp "signal"
 let chirpSource ← field chirp "source_and_remnant"
 let ringSignal ← field ring "signal"
 let ringSource ← field ring "source_and_remnant"
 let ringdown ← field ring "ringdown"
 let chirpScope ← field chirp "scope"
 let ringScope ← field ring "scope"
 let number := fun row key=>do YangMillsSpectrumMeasurement.exactInput (← field row key)
 let starts ← number chirpSignal "frequency_start_hz"
 let ends ← number chirpSignal "frequency_end_hz"
 let ringStarts ← number ringSignal "frequency_start_hz"
 let ringEnds ← number ringSignal "frequency_end_hz"
 let eqText := fun row key value=>do pure (Text.equal (← text (← field row key)) value)
 let contains := fun row key value=>do pure (Text.contains (← text (← field row key)) value)
 let twoToOne := fun row=>do
  let initial ← number row "initial_component_count"
  let final ← number row "final_remnant_count"
  pure ((sameValue (RunningConvergenceCertificate.rat initial) (RunningConvergenceCertificate.rat (normalize 2 1 (by decide)))) && (sameValue (RunningConvergenceCertificate.rat final) (RunningConvergenceCertificate.rat (normalize 1 1 (by decide)))))
 let rat := RunningConvergenceCertificate.rat
 pure (.object [
 ("development_source_not_blind",.boolean (← eqText development "blind_validation_role" "none")),
 ("chirp_frequency_interval_hz",.array [rat starts,rat ends]),
 ("chirp_frequency_rises",.boolean (starts.blt ends)),
 ("chirp_amplitude_rises",.boolean (← eqText chirpSignal "amplitude_direction" "rising-to-peak")),
 ("chirp_cycle_count",rat (← number chirpSignal "cycle_count")),
 ("positive_radiated_energy",.boolean ((normalize 0 1 (by decide)).blt (← number chirpSource "radiated_energy_solar_c2"))),
 ("chirp_two_to_one",.boolean (← twoToOne chirpSource)),
 ("chirp_model_role_retained",.boolean (← contains chirpScope "waveform_role" "waveform models")),
 ("ring_frequency_rises",.boolean (ringStarts.blt ringEnds)),
 ("ring_two_to_one",.boolean (← twoToOne ringSource)),
 ("ringdown_quadrupolar",.boolean (← contains ringdown "reported_mode" "l-equals-m-equals-two")),
 ("ringdown_decays",.boolean (← eqText ringdown "damping_direction" "decaying-post-peak-support")),
 ("half_One_not_directly_measured",.boolean (ThermometryMeasurement.literalBoolean (← field ringdown "exact_half_One_damping_directly_measured") false)),
 ("conditional_role_retained",.boolean (← eqText ringScope "interpretation_role" "quasicircular-binary interpretation is conditional")),
 ("alternative_interpretations_retained",.boolean (ThermometryMeasurement.literalBoolean (← field ringScope "alternative_interpretations_retained") true)),
 ("all_sources_retained",.boolean (sources.length==2 && developments.length==1))])
#print axioms exactAnalysis
end SFT.Physics.ChirpObservationAnalysis
