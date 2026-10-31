import SFT.Physics.RunningConvergenceValidation
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
 let root := args.headD ""
 let files ← RunningConvergenceMeasurement.sourceHashes.mapM fun (path,_) => do
   let bytes ← IO.FS.readBinFile (root ++ "/" ++ path)
   pure (path,bytes)
 let bytes := files.head!.2
 let payload ← IO.ofExcept (Lean.Json.parse (String.fromUTF8! bytes))
 let record ← IO.ofExcept (convert (bytes.size+1) payload)
 let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
 let result ← IO.ofExcept (RunningConvergenceValidation.validate files record RunningConvergencePrediction.claimId
   (args[1]!) "Darwin" "CPython" before before)
 IO.println (render result.value)
