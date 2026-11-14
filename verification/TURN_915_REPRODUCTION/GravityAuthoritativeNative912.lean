import SFT.Physics.GravityAuthoritativeWitnesses
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
 let bytes ← IO.FS.readBinFile (root ++ "/" ++ "experiments/external_sources/physics/snapshots/gravity-spacetime-source-record.json")
 let directory := root ++ "/experiments/external_sources/physics/snapshots/"
 let files ← GravityAuthoritativeRecords.componentHashes.mapM fun (name,_) => do
  pure (name,← IO.FS.readBinFile (directory ++ name))
 let parsed ← IO.ofExcept (Lean.Json.parse (String.fromUTF8! bytes))
 let payload ← IO.ofExcept (convert (bytes.size+1) parsed)
 let record ← IO.ofExcept (GravityAuthoritativeRecords.authoritativeRecord bytes files payload)
 let pairs ← ["weak_gravity_clock_equivalence","gravitational_waves","horizons_information","nonstandard_spacetime"].mapM fun key => do
  let value ← IO.ofExcept (GravityAuthoritativeRecords.classificationFromRecord record key)
  pure (key,Value.text value)
 IO.println (render (.object [("record",record),("classifications",.object pairs)]))
