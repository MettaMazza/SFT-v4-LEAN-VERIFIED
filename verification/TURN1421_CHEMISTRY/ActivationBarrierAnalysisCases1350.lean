import SFT.Chemistry.ActivationBarrierAnalysis
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
open SFT.Host SFT.Host.Canonical SFT.Chemistry.ActivationBarrierAnalysis
open SFT.Chemistry.InternalEnergyCompositionExperiment
def boundsJSON (b : Rat×Rat) : CJ := .object [("minimum",.text (fractionText b.1)),("maximum",.text (fractionText b.2))]
def analysisJSON (a : Analysis) : CJ := .object ([
 ("complete_target_count",.integer a.count),("complete_index_species_count",.integer a.speciesCount),
 ("complete_detail_page_count",.integer a.detailCount),("complete_path_state_count",.integer a.stateCount),
 ("complete_explicit_zero_glyph_count_translated_to_EmptyOne",.integer a.zeroCount),
 ("source_reference_EmptyOne_count",.integer a.missingReferenceCount),
 ("source_least_state_coordinate_EmptyOne_count",.integer a.missingLeastCount),
 ("complete_unresolved_path_row_count",.integer a.unresolvedCount),
 ("exact_barrier_range_kJ_mol_minus1",boundsJSON a.barrierBounds),
 ("exact_barrier_range_cm_minus1",boundsJSON a.wavenumberBounds)]++a.checks.map (fun (k,b)=>(k,.boolean b)))
def runCase (v : CJ) : Except String Analysis := do
 let rows ← RunningConvergenceMeasurement.array (get v "rows")
 let targets : List InternalEnergyCompositionSource.Target := rows.map fun row => ⟨"fixture",row,.emptyOne "fixture"⟩
 exactActivationBarrierAnalysis targets (get v "primary")
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/barrier1350_analysis_cases.json"
 let document ← IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
 let cases ← IO.ofExcept (RunningConvergenceMeasurement.array document)
 let results := cases.map fun c => match runCase c with
  | .ok a => SFT.Host.Canonical.Value.object [("ok",analysisJSON a)]
  | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
 IO.println (SFT.Host.Canonical.render (.array results))
