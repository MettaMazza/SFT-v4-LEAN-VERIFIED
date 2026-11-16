import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.HorizonObservationAnalysis
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactAnalysis (record : Value) : Except String Value := do
 let sources ← array (← field record "sources")
 let white ← field (← field (← LeptonRatios.atIndex sources 0) "rows") "electron_degenerate_white_dwarf"
 let neutron ← field (← field (← LeptonRatios.atIndex sources 1) "rows") "massive_neutron_star"
 let remnant ← field (← LeptonRatios.atIndex sources 2) "rows"
 let horizon ← field record "existing_postseal_boundary"
 let number := fun row key=>do YangMillsSpectrumMeasurement.exactInput (← field row key)
 let whiteLimit ← number white "reported_mass_limit_solar"
 let neutronMass ← number neutron "reported_mass_solar"
 let lowerUncertainty ← number neutron "lower_uncertainty_solar"
 let upperUncertainty ← number neutron "upper_uncertainty_solar"
 let lower := subtract neutronMass lowerUncertainty
 let upper := add neutronMass upperUncertainty
 let hyperRow ← field remnant "conditional_hypermassive_maximum"
 let nonrotatingRow ← field remnant "conditional_nonrotating_maximum"
 let hyper ← number hyperRow "maximum_baryonic_mass_solar"
 let nonrotating ← number nonrotatingRow "maximum_baryonic_mass_solar"
 let hyperBoundary ← text (← field hyperRow "use_boundary")
 let nonrotatingBoundary ← text (← field nonrotatingRow "use_boundary")
 let rat := RunningConvergenceCertificate.rat
 pure (.object [("white_dwarf_limit_solar",rat whiteLimit),("white_dwarf_role",← field white "reported_role"),("neutron_star_mass_solar",rat neutronMass),("neutron_star_interval_solar",.array [rat lower,rat upper]),("neutron_star_interval_wholly_above_white_dwarf_limit",.boolean (whiteLimit.blt lower)),("neutron_star_mass_is_direct_maximum_measurement",.boolean false),("neutron_star_measurement_method",← field neutron "measurement_method"),("neutron_star_credibility",rat (← number neutron "reported_credibility_fraction")),("hypermassive_conditional_upper_solar",rat hyper),("nonrotating_conditional_upper_solar",rat nonrotating),("both_conditional_uppers_above_neutron_interval",.boolean (upper.blt hyper && upper.blt nonrotating)),("conditional_roles_retained",.boolean (Text.contains hyperBoundary "conditional" && Text.contains nonrotatingBoundary "conditional")),("horizon_validation_claim",← field horizon "claim_id"),("horizon_validation_receipt",← field horizon "receipt_hash"),("hawking_directly_measured",.boolean false),("hawking_nonobservation_rewarded_as_match",.boolean false),("all_sources_retained",.boolean (sources.length==3))])
#print axioms exactAnalysis
end SFT.Physics.HorizonObservationAnalysis
