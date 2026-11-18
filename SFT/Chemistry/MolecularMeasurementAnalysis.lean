import SFT.Chemistry.MolecularMeasurementSource
namespace SFT.Chemistry.MolecularMeasurementAnalysis
open SFT.Host SFT.Host.Canonical
open MolecularMeasurementSource (rowText)
open JointCorrelationTargets (field integer)
open NuclearElectronicTargets (strings)
structure Row where
 targetId : String
 file : String
 ordinal : Int
 cells : List String
 source : Value

def readRow (r : Value) : Except String Row := do
 return ⟨← rowText r "target_id",← rowText r "file",← field r "row_ordinal" >>= integer,
  ← field r "cells" >>= strings,r⟩
def rowComparison (row : Row) (released : List (String × String)) : Value := .object [
 ("target_id",.text row.targetId),("file",.text row.file),("row_ordinal",.integer row.ordinal),
 ("cell_count",.integer (.ofNat row.cells.length)),("passed",.boolean
  (released.any (fun (id,value) => Text.equal id row.targetId && Text.equal value (identity row.source))))]

def counts (rows : List Row) (components : Nat) : Except String (List (String × Nat)) := do
 let files := rows.foldl (fun acc r => if acc.any (Text.equal r.file) then acc else acc++[r.file]) ([] : List String)
 let intervals := rows.filter fun r => Text.equal r.file "entry_and_exit_times_J_1.csv" || Text.equal r.file "entry_and_exit_times_J_2.csv"
 let increasing ← intervals.mapM fun r => do
  let a ← NuclearElectronicSource.atNat r.cells 0 >>= ConfigurationObservation.exact
  let b ← NuclearElectronicSource.atNat r.cells 1 >>= ConfigurationObservation.exact
  return @decide (Int.lt (a.num * Int.ofNat b.den) (b.num * Int.ofNat a.den)) (Int.decLt _ _)
 let tracking := rows.filter fun r => Text.equal r.file "tracking_time_series.csv"
 let durations ← tracking.mapM fun r => NuclearElectronicSource.atNat r.cells 2 >>= ConfigurationObservation.exact
 let countFile := fun name => (rows.filter fun r => Text.equal r.file name).length
 return [("package_components",components),("csv_files",files.length),("rows",rows.length),
  ("cells",(rows.map (fun r => r.cells.length)).foldl (·+·) 0),
  ("real_time_readouts",countFile "real_time_state_tracking_data.csv"),
  ("J2_entry_exit_intervals",countFile "entry_and_exit_times_J_2.csv"),
  ("J1_entry_exit_intervals",countFile "entry_and_exit_times_J_1.csv"),
  ("prepared_sublevel_rows",countFile "sublevel_distribution_J0_to_J1.csv"),
  ("recovery_classes",countFile "histogram_of_recoveries_from_J_0_and_J_2.csv"),
  ("tracking_intervals",tracking.length),
  ("pressure_control_rows",countFile "pressure_dependence_of_J_0_to_J_1_transitions.csv"),
  ("appearance_time_rows",countFile "appearance_time_histogram_J_0_to_J1.csv"),
  ("positive_entry_exit_intervals",(increasing.filter id).length),
  ("positive_tracking_intervals",(durations.filter (fun x => @decide (Int.lt 0 x.num) (Int.decLt 0 x.num))).length),
  ("EmptyOne_tracking_boundary",(durations.filter (fun x => @decide (x.num = 0) (Int.decEq x.num 0))).length)]
end SFT.Chemistry.MolecularMeasurementAnalysis
