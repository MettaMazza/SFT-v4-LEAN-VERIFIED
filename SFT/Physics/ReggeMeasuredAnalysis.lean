import SFT.Physics.ReggeMeasuredSupport
import SFT.Physics.CosmicMeasuredMeasurement
namespace SFT.Physics.ReggeMeasuredAnalysis
open LeptonIntervals ReggeMeasuredSupport SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Row where
 state : String
 spinRank : Int
 jpc : String
 tableStatus : String
 mass : Rat
 massUncertainty : Rat
 width : Rat
 widthLowerUncertainty : Rat
structure Target where
 rows : List Row
 noFit : Bool
 noWidening : Bool
def exactAnalysis (target : Target) : Except String Value := do
 let rows := target.rows
 let ordered := rows.length==5 && (rows.zipWith (fun row rank => @decide (row.spinRank=rank) (Int.decEq row.spinRank rank)) [1,2,3,4,5]).all id
 if !ordered then .error "Regge spin ordering changed" else do
 let supports ← rows.mapM (fun row=> mostRestrictiveResonanceSupport row.mass row.massUncertainty row.width row.widthLowerUncertainty)
 let carriers ← [1,2,3,4,5].mapM (fun rank=>ReggeDimensional.squaredResonanceCarrier (.count (.integer rank)))
 let passes := carriers.zipWith (fun c s=>CosmicComponentTransportMeasurement.within s.squaredInterval c) supports
 let results := ((rows.zip carriers).zip (supports.zip passes)).map (fun ((row,c),(s,passed)) =>
  .object [("state",.text row.state),("spin_J",.integer row.spinRank),("JPC",.text row.jpc),
  ("exact_squared_carrier_GeV2",RunningConvergenceCertificate.rat c),
  ("minimum_measured_width_MeV",RunningConvergenceCertificate.rat s.minimumWidth),
  ("most_restrictive_energy_interval_MeV",CosmicMeasuredMeasurement.pair s.energyInterval),
  ("most_restrictive_squared_interval_GeV2",CosmicMeasuredMeasurement.pair s.squaredInterval),
  ("inside_measured_resonance_support",.boolean passed),("table_status",.text row.tableStatus)])
 let last := match rows.getLast? with | none => "" | some row => row.tableStatus
 .ok (.object [("row_results",.array results),("complete_five_rows",.boolean (rows.length==5)),
 ("natural_parity_vector",.boolean (rows.map Row.jpc == ["1--","2++","3--","4++","5--"])),
 ("exact_carrier_vector",.boolean (carriers == [normalize 3 5 (by decide),normalize 9 5 (by decide),normalize 3 1 (by decide),normalize 21 5 (by decide),normalize 27 5 (by decide)])),
 ("all_five_inside_measured_support",.boolean (passes.all id)),
 ("rho5_omission_retained",.boolean (SFT.Host.Text.contains last "OMITTED FROM SUMMARY TABLE")),
 ("no_fit_declared",.boolean target.noFit),("no_widening_declared",.boolean target.noWidening)])
#print axioms exactAnalysis
end SFT.Physics.ReggeMeasuredAnalysis
