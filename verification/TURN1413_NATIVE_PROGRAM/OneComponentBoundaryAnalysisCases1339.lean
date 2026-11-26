import SFT.Chemistry.OneComponentBoundaryAnalysis
import Lean
open SFT.Chemistry SFT.Physics
abbrev CJ := SFT.Host.Canonical.Value
def convert : Nat → Lean.Json → Except String CJ
 | 0,_ => .error "JSON nesting exceeds input byte count"
 | n+1,j => match j with
  | .null => .ok .null
  | .bool b => .ok (.boolean b)
  | .num _ => do return .integer (← j.getInt?)
  | .str s => .ok (.text s)
  | .arr xs => do return .array (← xs.toList.mapM (convert n))
  | .obj fs => do return .object (← fs.toList.mapM fun (k,v) => do return (k,← convert n v))
def field (j : Lean.Json) (name : String) := j.getObjVal? name
def text (j : Lean.Json) (name : String) := j.getObjValAs? String name
def items (j : Lean.Json) (name : String) : Except String (List Lean.Json) := do
 return (← (← field j name).getArr?).toList

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def readBytes (path : String) : IO ByteArray := IO.FS.readBinFile (("work/pinned1334/" ++ path) : String)
def readDocument (path : String) : IO CJ := do
 let raw ← IO.FS.readFile (("work/pinned1334/" ++ path) : String)
 IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
open SFT.Host SFT.Host.Canonical SFT.Chemistry.OneComponentBoundaryAnalysis
open SFT.Chemistry.InternalEnergyCompositionExperiment
def analysisJSON (a : Analysis) : CJ := .object ([
 ("complete_target_count",.integer a.count),
 ("dataset_counts",.object (a.datasets.map fun (k,n)=>(k,.integer n))),
 ("component_counts",.object (a.components.map fun (k,n)=>(k,.integer n))),
 ("ordered_successor_edge_count",.integer a.edges),
 ("minimum_temperature_K",.text (fractionText a.temperatureBounds.1)),
 ("maximum_temperature_K",.text (fractionText a.temperatureBounds.2)),
 ("minimum_pressure_kPa",.text (fractionText a.pressureBounds.1)),
 ("maximum_pressure_kPa",.text (fractionText a.pressureBounds.2))]++a.checks.map (fun (k,b)=>(k,.boolean b)))
def runCase (v : CJ) : Except String Analysis := do
 let rows ← RunningConvergenceMeasurement.array (get v "rows")
 let targets : List InternalEnergyCompositionSource.Target := rows.map fun row => ⟨"fixture",row,.emptyOne "fixture"⟩
 exactPhaseBoundaryAnalysis targets (get v "primary")
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/boundary1339_analysis_cases.json"
 let document ← IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
 let cases ← IO.ofExcept (RunningConvergenceMeasurement.array document)
 let results := cases.map fun c => match runCase c with
  | .ok a => SFT.Host.Canonical.Value.object [("ok",analysisJSON a)]
  | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
 IO.println (SFT.Host.Canonical.render (.array results))
