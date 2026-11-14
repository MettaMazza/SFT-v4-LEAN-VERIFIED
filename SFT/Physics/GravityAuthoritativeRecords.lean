import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.GravityAuthoritativeRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def componentHashes : List (String × String) := [("cnes-microscope-final.html","sha256:65a86753705aaa80f819e833d1ca4e13f0491e56b58a218c4cddb492c9887f12"),("gwosc-v2-catalogs.json","sha256:fcd8eef741cb536010539f3e42e6bb5d3a5e0fb7a120289fe95b8a1711f59e0c")]
def sourceHash : String := "sha256:b64325355bd993ab32cff6c088023dbe7911ab13278b9439466cd0ae56bedd5e"
def payloadBoundary (payload : Value) : Except String Value := do
 let id := (field payload "record_id").toOption.getD .null
 let boundary := (field payload "formal_seal_boundary").toOption.getD (.object [])
 let count := (field boundary "sealed_claim_count").toOption.getD .null
 if !sameValue id (.text "GRAVITY-SPACETIME-AUTHORITATIVE-2017-2026") || !sameValue count (.integer 13) then
  throw "gravity/spacetime seal boundary changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "gravity/spacetime complete source vector changed")
 if sources.length != 6 then throw "gravity/spacetime complete source vector changed"
 pure payload

def checkComponents (files : List (String × ByteArray)) (payload : Value) : Except String Unit := do
 let sources ← array (← field payload "sources")
 let _ ← sources.foldlM (fun (_ : Unit) source => do
  let snapshot := (field source "snapshot").toOption.getD .null
  let expected := match snapshot with
   | .text name => componentHashes.find? (fun (p : String × String) => Text.equal p.1 name)
   | .object _ | .boolean _ | .integer _ | .null | .array _ => none
  match expected with
  | none => pure ()
  | some (name,hash) =>
   let bytes ← match files.find? (fun (p : String × ByteArray) => Text.equal p.1 name) with
    | none => .error (Text.append "FileNotFoundError: " name)
    | some p => .ok p.2
   if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) hash then
    throw "gravity/spacetime component identity changed"
   pure ()) ()
 pure ()

def controlsBoundary (payload : Value) : Except String Value := do
 let controls ← (do array (← field payload "unfavorable_and_scope_controls")).mapError (fun _ => "gravity/spacetime complete source vector changed")
 if controls.length != 6 then throw "gravity/spacetime complete source vector changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "gravity/spacetime source record identity changed"
 let record ← payloadBoundary payload
 let checked ← controlsBoundary record
 checkComponents files checked
 pure checked

def classificationFromRecord (record : Value) (key : String) : Except String String := do
 let classifications ← field record "complete_classification"
 match (field classifications key).toOption.getD .null with
 | .text label => .ok label
 | .object _ | .boolean _ | .integer _ | .null | .array _ => .error "gravity/spacetime classification missing"

def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) (key : String) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload) key
def clockLabel : String := "inverse-square-source-flux-clock-redshift-and-equivalence-phenomena-confirmed__specific-Fold-fractions-structural"
def clockClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "weak_gravity_clock_equivalence"
def waveLabel : String := "gravity-light-speed-equality-confirmed-at-multimessenger-bound__tensor-polarization-and-quadrupolar-strong-field-support-confirmed"
def waveClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "gravitational_waves"
def horizonLabel : String := "horizon-scale-shadow-and-compact-strong-field-support-confirmed__event-horizon-Hawking-temperature-and-information-reconstruction-not-directly-measured"
def horizonClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "horizons_information"
def nonstandardLabel : String := "formal-admissibility-boundaries-sealed__no-authoritative-wormhole-warp-or-closed-timelike-realization-in-registered-source-vector"
def nonstandardClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "nonstandard_spacetime"
end SFT.Physics.GravityAuthoritativeRecords
