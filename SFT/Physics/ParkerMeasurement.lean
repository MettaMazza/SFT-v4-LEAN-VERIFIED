import SFT.Physics.ParkerProtonEnergy
import SFT.Physics.YangMillsSpectrumMeasurement
namespace SFT.Physics.ParkerMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals VacuumLedgerProofs ParkerProtonEnergy
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def exactMeasurementAnalysis (target : Value) : Except String Value := do
 let event ← field target "parker_event"
 let proton ← field target "proton_rest_energy"
 let mass ← YangMillsSpectrumMeasurement.exactInput (← field proton "value_MeV")
 let uncertainty ← YangMillsSpectrumMeasurement.exactInput (← field proton "standard_uncertainty_MeV")
 let massInterval := (subtract mass uncertainty,add mass uncertainty)
 let terminal ← protonEnergyFraction
 let leading ← historicalLeadingFraction
 let scale := fun edge fraction => multiply (multiply edge (wholeRatio 1000)) fraction
 let terminalInterval := (scale massInterval.1 terminal,scale massInterval.2 terminal)
 let leadingInterval := (scale massInterval.1 leading,scale massInterval.2 leading)
 let lower ← YangMillsSpectrumMeasurement.exactInput (← field event "spectral_analysis_lower_keV")
 let upper ← YangMillsSpectrumMeasurement.exactInput (← field event "spectral_analysis_upper_keV")
 let terminalCentre := scale mass terminal
 let point := wholeRatio 400
 let difference := if point.blt terminalCentre then subtract terminalCentre point else subtract point terminalCentre
 let relative ← LeptonRatios.divide difference point
 let rows ← structuralFormulaCensus
 let adverse := rows.map (fun row => (row,scale mass row.fraction,!(scale mass row.fraction).blt lower && !upper.blt (scale mass row.fraction)))
 let within := fun lo hi => !lo.blt lower && !hi.blt lo && !upper.blt hi
 let pair := fun a b => Value.array [ratValue a,ratValue b]
 pure (.object [
 ("mass_interval_MeV",pair massInterval.1 massInterval.2),
 ("terminal_prediction_interval_keV",pair terminalInterval.1 terminalInterval.2),
 ("terminal_prediction_centre_keV",ratValue terminalCentre),
 ("leading_prediction_interval_keV",pair leadingInterval.1 leadingInterval.2),
 ("reported_spectrum_range_keV",pair lower upper),
 ("terminal_inside_complete_range",.boolean (within terminalInterval.1 terminalInterval.2)),
 ("leading_inside_complete_range",.boolean (within leadingInterval.1 leadingInterval.2)),
 ("absolute_difference_from_approximate_400_keV",ratValue difference),
 ("relative_difference_from_approximate_label",ratValue relative),
 ("approximate_label_has_uncertainty",← field event "approximately_400_has_reported_standard_uncertainty"),
 ("approximate_label_is_exact_cutoff",← field event "approximately_400_is_exact_cutoff_measurement"),
 ("adverse_formula_rows",.array (adverse.map (fun (row,energy,inside) => .object [
 ("sector",.integer (.ofNat row.sector)),("channels",.integer (.ofNat row.channels)),("power",.integer (.ofNat row.power)),
 ("fraction",ratValue row.fraction),("structurally_selected",.boolean row.structurallySelected),("energy_keV",ratValue energy),("inside_reported_range",.boolean inside)]))),
 ("adverse_inside_range",.array ((adverse.filter (fun x => x.2.2)).map (fun x => .array [.integer (.ofNat x.1.sector),.integer (.ofNat x.1.power)]))),
 ("observation_uniquely_selects_structural_formula",.boolean ((adverse.filter (fun x => x.2.2)).length==1))])
end SFT.Physics.ParkerMeasurement
