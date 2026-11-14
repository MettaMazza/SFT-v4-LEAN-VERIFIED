import SFT.Physics.VacuumFloorValidationValidation
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
 let bytes ← IO.FS.readBinFile (root ++ "/" ++ VacuumFloorValidationExperiment.sourcePath)
 let directory := root ++ "/experiments/external_sources/physics/snapshots/"
 let files ← VacuumAuthoritativeRecords.componentHashes.mapM fun (name,_) => do
  pure (name,← IO.FS.readBinFile (directory ++ name))
 let parsed ← IO.ofExcept (Lean.Json.parse (String.fromUTF8! bytes))
 let payload ← IO.ofExcept (convert (bytes.size+1) parsed)
 let sources ← IO.ofExcept (VacuumAuthoritativeRecords.sourceById bytes files payload)
 let floor ← IO.ofExcept (VacuumAuthoritativeRecords.floorFromSources sources)
 let polarization ← IO.ofExcept (VacuumAuthoritativeRecords.polarizationFromSources sources)
 let inertia ← IO.ofExcept (VacuumAuthoritativeRecords.inertiaFromSources sources)
 let extraction ← IO.ofExcept (VacuumAuthoritativeRecords.extractionFromSources sources)
 let fraction := fun (q : Rat) => Value.object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
 IO.println (render (.object [("sources",sources),("floor",.text floor),
  ("polarization",.array [.text polarization.1,.object (polarization.2.map fun (k,v) => (k,fraction v))]),
  ("inertia",.text inertia),("extraction",.text extraction)]))
