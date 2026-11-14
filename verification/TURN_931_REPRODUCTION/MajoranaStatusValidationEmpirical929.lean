import SFT.Physics.MajoranaStatusValidationValidation
import Lean
open SFT.Physics SFT.Host.Canonical
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
 let bytes ← IO.FS.readBinFile (root ++ "/" ++ MajoranaStatusValidationExperiment.sourcePath)
 let directory := root ++ "/experiments/external_sources/physics/snapshots/"
 let files ← MatterAuthoritativeRecords.componentHashes.mapM fun (name,_) => do
  pure ("experiments/external_sources/physics/snapshots/" ++ name,← IO.FS.readBinFile (directory ++ name))
 let parsed ← IO.ofExcept (Lean.Json.parse (String.fromUTF8! bytes))
 let payload ← IO.ofExcept (convert (bytes.size+1) parsed)
 let result ← IO.ofExcept (MajoranaStatusValidationValidation.validateExternal bytes files payload derivationSeal host implementation before before)
 IO.println (render result.value)
