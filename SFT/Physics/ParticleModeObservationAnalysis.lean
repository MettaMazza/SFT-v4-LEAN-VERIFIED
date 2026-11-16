import SFT.Physics.ThermalMeasuredAnalysis
namespace SFT.Physics.ParticleModeObservationAnalysis
open LeptonIntervals VacuumLedgerProofs SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Target where
 forced : Int
 fitCenter : Int
 fitWidth : Int
 fitDenominator : Int
 directCenter : Int
 directWidth : Int
 directDenominator : Int
 electronMass : Rat
 muonMass : Rat
 tauMass : Rat
 electronWidth : Rat
 muonWidth : Rat
 tauWidth : Rat
 electronLifeYears : Rat
 muonLife : Rat
 muonLifeWidth : Rat
 tauLife : Rat
 tauLifeWidth : Rat
 massOrder : List String
 lifetimeOrder : List String
 fitModelDependent : Bool
 directUnadjusted : Bool
 directDidNotSelect : Bool
 leptonRatios : Bool
 quarkSD : Bool
 quarkBS : Bool
 topCharmBoundary : Bool
 ckm : Bool
 neutrinoMixing : Bool
 neutrinoSum : Bool
 neutrinoOrdering : Bool
 heavyLimit : Rat
 stableLimit : Rat
 allRows : Bool
def exactAnalysis (t : Target) : Value := Id.run do
 let fit := (t.fitCenter-t.fitWidth,t.fitCenter+t.fitWidth)
 let direct := (t.directCenter-t.directWidth,t.directCenter+t.directWidth)
 let displacement := (t.forced*t.directDenominator-t.directCenter,t.directWidth)
 let electronLife := multiply t.electronLifeYears (wholeRatio 31536000)
 let positiveInts := [fit.1,fit.2,direct.1,direct.2,displacement.1,displacement.2].all (fun x=>decide (0<x))
 let positiveRats := [t.electronMass,t.muonMass,t.tauMass,t.electronWidth,t.muonWidth,t.tauWidth,electronLife,t.muonLife,t.muonLifeWidth,t.tauLife,t.tauLifeWidth].all (fun x=>zero.blt x)
 let pair := fun (x : Int × Int) => Value.array [.integer x.1,.integer x.2]
 return .object [
 ("positive_exact_carriers",.boolean (positiveInts && positiveRats)),
 ("fit_interval",pair fit),("direct_interval",pair direct),
 ("direct_standard_uncertainty_displacement",pair displacement),
 ("fit_contains_three",.boolean (decide (fit.1≤t.forced*t.fitDenominator) && decide (t.forced*t.fitDenominator≤fit.2))),
 ("direct_row_exactly_eight_fifths_from_three",.boolean (@decide (displacement.1=8) (Int.decEq displacement.1 8) && @decide (displacement.2=5) (Int.decEq displacement.2 5))),
 ("measurement_boundaries_retained",.boolean (t.fitModelDependent && t.directUnadjusted && t.directDidNotSelect)),
 ("charged_lepton_mass_intervals_strictly_ordered",.boolean ((add t.electronMass t.electronWidth).blt (subtract t.muonMass t.muonWidth) && (subtract t.muonMass t.muonWidth).blt (subtract t.tauMass t.tauWidth))),
 ("charged_lepton_lifetimes_reverse_order",.boolean ((add t.muonLife t.muonLifeWidth).blt electronLife && (add t.tauLife t.tauLifeWidth).blt (add t.muonLife t.muonLifeWidth))),
 ("declared_mass_order_retained",.boolean (t.massOrder==["electron","muon","tau"])),
 ("declared_lifetime_order_retained",.boolean (t.lifetimeOrder==["electron","muon","tau"])),
 ("terminal_lepton_ratios_pass",.boolean t.leptonRatios),
 ("available_quark_ratios_pass",.boolean (t.quarkSD && t.quarkBS)),
 ("top_charm_boundary_retained",.boolean t.topCharmBoundary),
 ("terminal_ckm_vector_pass",.boolean t.ckm),
 ("positive_neutrino_vector_pass",.boolean (t.neutrinoMixing && t.neutrinoSum)),
 ("ordering_boundary_retained",.boolean t.neutrinoOrdering),
 ("heavy_lepton_search_limits_positive",.boolean (zero.blt t.heavyLimit && zero.blt t.stableLimit)),
 ("all_rows_retained",.boolean t.allRows)]
#print axioms exactAnalysis
end SFT.Physics.ParticleModeObservationAnalysis
