import SFT.Physics.CubicPostsealValidationValidation
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
 let bytes ← IO.FS.readBinFile (root ++ "/" ++ CubicPostsealValidationExperiment.sourcePath)
 let directory := root ++ "/experiments/external_sources/physics/snapshots/"
 let files ← [("nist-simple-cubic-neighbours.pdf","sha256:ab723f91d6658bd8b5d19889884fd87e07046d2b0060e23f7df8d7cb6c35fa5b"),("nist-hydrogen-atomic-data.html","sha256:cc54c774518d62cbb7e95f17b3b7fcd9d1faf0aa90043a607b91dff0a43e2087"),("nist-hydrogen-critical-compilation.pdf","sha256:86ccaeb875fcdb4445e727618509621ceee656e5dc02295140ecdb6e1d2dd443"),("nist-webbook-h2-diatomic-constants.html","sha256:18036a188088f880122249544ceb6b384fabfba93b300b4f9f0fa01aa0ed9b24")].mapM fun (name,_) => do
  pure ("experiments/external_sources/physics/snapshots/" ++ name,← IO.FS.readBinFile (directory ++ name))
 let parsed ← IO.ofExcept (Lean.Json.parse (String.fromUTF8! bytes))
 let payload ← IO.ofExcept (convert (bytes.size+1) parsed)
 let result ← IO.ofExcept (CubicPostsealValidationValidation.validateExternal bytes files payload derivationSeal host implementation before before)
 IO.println (render result.value)
