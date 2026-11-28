import SFT.Applications.Discovery.PythonRandom
import SFT.Applications.Discovery.USDESweep
namespace SFT.Applications.Discovery.USDENull
open SFT.Applications.Discovery
open SFT.Applications.Discovery.USDEMatching
open SFT.Applications.Discovery.USDESweep
open SFT.Applications.Discovery.Display
open SFT.Host.Text

-- This is the source's until-distinct-count loop, with no invented retry cap.
partial def syntheticLoop (count : Nat) (logLo logHi : Float) (g : PythonRandom.Generator) (db : Database) (index : Nat) : IO Database := do
 if db.targets.length ≥ count then return db
 else
  let (sample,g) := PythonRandom.random g
  let exponent := logLo+sample*(logHi-logLo)
  let value := Float.pow 10.0 exponent
  syntheticLoop count logLo logHi g (setTarget db value (append "Null Target " (number (Int.ofNat index)))) (index+1)

def syntheticDatabase (realDatabase : Database) (seed : Int := 20260612) : IO (Except String Database) := do
 match realDatabase.targets with
 | [] => return .error "max() arg is an empty sequence"
 | first::rest =>
  let minimum := rest.foldl (fun x t => if t.value<x then t.value else x) first.value
  let maximum := rest.foldl (fun x t => if t.value>x then t.value else x) first.value
  if minimum≤0.0 || maximum≤0.0 then return .error "math domain error"
  let db ← syntheticLoop realDatabase.targets.length (Float.log10 minimum) (Float.log10 maximum) (PythonRandom.seed seed) {} 1
  return .ok db

structure NullSummary where
 seed : Int
 dbSize : Nat
 nullAlignments : Nat
 comparisonsPerformed : Nat
 analyticNullExpected : Float

def runNullBaseline (realDatabase : Database) (seed : Int := 20260612) (limit : Nat := 120) (toleranceSigmas : Float := 5.0) (analytical : Bool := false) : IO (Except String NullSummary) := do
 let synthetic ← syntheticDatabase realDatabase seed
 -- Original real_db/real_sigma remain the caller's values on success and error.
 -- Only the temporary database is passed into the identical sweep operation.
 return do
  let db ← synthetic
  let result ← discoverySweep db limit toleranceSigmas analytical
  .ok {seed,dbSize := realDatabase.targets.length,nullAlignments := result.alignments.length,comparisonsPerformed := result.comparisonsPerformed,analyticNullExpected := result.nullExpectedAlignments}
end SFT.Applications.Discovery.USDENull
