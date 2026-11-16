import SFT.Physics.HiggsCertificate
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.HiggsObservationAnalysis
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactAnalysis (record : Value) : Except String Value := do
 let sources ← array (← field record "sources")
 let rows : Nat → String → Except String Value := fun i key=>do field (← field (← LeptonRatios.atIndex sources i) "rows") key
 let number := fun row key=>do YangMillsSpectrumMeasurement.exactInput (← field row key)
 let scale ← number (← rows 0 "electroweak_vacuum_scale") "reported_value_gev"
 let pdg ← rows 1 "higgs_mass_world_average"
 let atlas ← rows 2 "combined_higgs_mass"
 let cms ← rows 3 "four_lepton_higgs_mass"
 let pair ← rows 4 "trilinear_self_coupling_constraint"
 let formal ← HiggsCertificate.theoremCertificate
 let ratio := formal.terminalMassRatio
 let coupling := formal.terminalSelfCoupling
 let predicted := multiply ratio scale
 let pdgCentral ← number pdg "listed_average_gev"
 let pdgUncertainty ← number pdg "listed_uncertainty_gev"
 let interval ← (← array (← field pdg "reported_interval_from_listed_uncertainty_gev")).mapM YangMillsSpectrumMeasurement.exactInput
 let (pdgLower,pdgUpper) ← match interval with
  | [a,b]=>.ok (a,b)
  | [] | [_] | _::_::_::_=>.error "ValueError: interval requires two endpoints"
 let atlasCentral ← number atlas "reported_value_gev"
 let atlasUncertainty ← number atlas "combined_uncertainty_gev"
 let cmsCentral ← number cms "reported_value_gev"
 let cmsUncertainty ← number cms "reported_uncertainty_gev"
 let pdgOffset := subtract predicted pdgCentral
 let atlasOffset := subtract predicted atlasCentral
 let cmsOffset := subtract predicted cmsCentral
 let kappa ← number pair "sft_normalized_prediction"
 let upper ← number pair "upper_coordinate"
 let lowerMagnitude ← number pair "lower_coordinate_magnitude"
 let lowerDirection ← field pair "lower_coordinate_direction"
 let rat := RunningConvergenceCertificate.rat
 let contains := fun a b=>!predicted.blt a && !b.blt predicted
 .ok (.object [
 ("formal_mass_ratio",rat ratio),("formal_self_coupling",rat coupling),("external_scale_gev",rat scale),("predicted_mass_gev",rat predicted),
 ("pdg_central_gev",rat pdgCentral),("pdg_uncertainty_gev",rat pdgUncertainty),("pdg_interval_gev",.array [rat pdgLower,rat pdgUpper]),("pdg_aggregate_contains_prediction",.boolean (contains pdgLower pdgUpper)),("pdg_offset_gev",rat pdgOffset),("pdg_offset_in_reported_uncertainties",rat (← LeptonRatios.divide pdgOffset pdgUncertainty)),("pdg_error_scale_factor",rat (← number pdg "error_scale_factor")),
 ("atlas_central_gev",rat atlasCentral),("atlas_uncertainty_gev",rat atlasUncertainty),("atlas_offset_gev",rat atlasOffset),("atlas_offset_in_reported_uncertainties",rat (← LeptonRatios.divide atlasOffset atlasUncertainty)),("atlas_one_reported_uncertainty_contains_prediction",.boolean (contains (subtract atlasCentral atlasUncertainty) (add atlasCentral atlasUncertainty))),
 ("cms_central_gev",rat cmsCentral),("cms_uncertainty_gev",rat cmsUncertainty),("cms_offset_gev",rat cmsOffset),("cms_offset_in_reported_uncertainties",rat (← LeptonRatios.divide cmsOffset cmsUncertainty)),("cms_one_reported_uncertainty_contains_prediction",.boolean (contains (subtract cmsCentral cmsUncertainty) (add cmsCentral cmsUncertainty))),
 ("individual_offsets_retained",.boolean (zero.blt atlasOffset && zero.blt cmsOffset)),
 ("kappa_prediction",rat kappa),("kappa_lower_direction",lowerDirection),("kappa_lower_magnitude",rat lowerMagnitude),("kappa_upper",rat upper),("kappa_interval_contains_prediction",.boolean (sameValue lowerDirection (.text "below-reference-direction") && zero.blt lowerMagnitude && kappa.blt upper)),("kappa_confidence_fraction",rat (← number pair "confidence_fraction")),("direct_coupling_is_precision_measurement",.boolean false),("all_sources_retained",.boolean (sources.length==5)),
 ("all_measurement_rows_positive_where_unsigned",.boolean ([scale,pdgCentral,pdgUncertainty,atlasCentral,atlasUncertainty,cmsCentral,cmsUncertainty,lowerMagnitude,upper].all (fun x=>zero.blt x)))])
#print axioms exactAnalysis
end SFT.Physics.HiggsObservationAnalysis
