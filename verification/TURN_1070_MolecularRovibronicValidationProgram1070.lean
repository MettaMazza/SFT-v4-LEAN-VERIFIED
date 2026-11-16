import SFT.Chemistry.MolecularRovibronicValidation
import Lean
open SFT.Physics SFT.Chemistry SFT.Host.Canonical
def convert : Nat → Lean.Json → Except String Value
 | 0,_ => .error "JSON nesting exceeds input byte count"
 | n+1,j => match j with
   | .null => .ok .null
   | .bool b => .ok (.boolean b)
   | .num _ => do pure (.integer (← j.getInt?))
   | .str s => .ok (.text s)
   | .arr xs => do pure (.array (← xs.toList.mapM (convert n)))
   | .obj fs => do pure (.object (← fs.toList.mapM (fun (k,v) => do pure (k,← convert n v))))

def main (args : List String) : IO Unit := do
 let root := args[0]!
 let derivationSeal := args[1]!
 let host := args[2]!
 let implementation := args[3]!
 let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
 let path := "experiments/external_sources/physics/snapshots/molecular-spectroscopy-successor-source-record.json"
 let snapshot ← IO.FS.readBinFile (root ++ "/" ++ path)
 let body ← IO.FS.readFile (root ++ "/" ++ path)
 let payload ← IO.ofExcept (do convert (body.utf8ByteSize+1) (← Lean.Json.parse body))
 let names ← IO.ofExcept (do
  let sources ← RunningConvergenceMeasurement.field payload "sources"
  ["hydrogen","deuterium"].mapM fun name => do
   RunningConvergenceMeasurement.text (← RunningConvergenceMeasurement.field (← RunningConvergenceMeasurement.field sources name) "snapshot_path"))
 let files ← names.mapM fun name=>do pure (name,← IO.FS.readBinFile (System.FilePath.mk (root ++ "/" ++ name)))
 let result ← IO.ofExcept (MolecularRovibronicValidation.validate snapshot files payload derivationSeal host implementation before before)
 IO.println (render result.value)
