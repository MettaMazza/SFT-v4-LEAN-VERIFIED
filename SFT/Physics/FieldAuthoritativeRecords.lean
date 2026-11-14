import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.FieldAuthoritativeRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def componentHashes : List (String × String) := [("nist-asd-version-history.html","sha256:a327a34eb1b85ef3f003e8c8f0dbcb0c3fc49f039ee4046546a924fc42118454"),("nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("aps-prl-26-721-source-record.json","sha256:03840a7b8b64574c764c40eb91ba6e0ee2c413548ff0d317ca5c8334f72308bc"),("pdg-2025-electroweak-model.pdf","sha256:8642888a3408d8c57fc673b379325b07f02948135491f64a2e42320e8929320a")]
def sourceHash : String := "sha256:97a7631d956cc2eb8142e64603a1f51ece76944195274a28bbe91498edae0308"
def payloadBoundary (payload : Value) : Except String Value := do
 let id := (field payload "record_id").toOption.getD .null
 let boundary := (field payload "formal_seal_boundary").toOption.getD (.object [])
 let count := (field boundary "sealed_claim_count").toOption.getD .null
 if !sameValue id (.text "RELATIVISTIC-FIELD-AUTHORITATIVE-1971-2026") || !sameValue count (.integer 12) then
  throw "relativistic-field source record boundary changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "complete relativistic-field source vector requires seven sources")
 if sources.length != 7 then throw "complete relativistic-field source vector requires seven sources"
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
    throw "relativistic-field component snapshot identity changed"
   pure ()) ()
 pure ()

def controlsBoundary (payload : Value) : Except String Value := do
 let controls ← (do array (← field payload "unfavorable_and_scope_controls")).mapError (fun _ => "complete unfavorable-control vector changed")
 if controls.length != 5 then throw "complete unfavorable-control vector changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "relativistic-field source record identity changed"
 let record ← payloadBoundary payload
 checkComponents files record
 controlsBoundary record

def classificationFromRecord (record : Value) (key : String) : Except String String := do
 let classifications ← field record "complete_classification"
 match (field classifications key).toOption.getD .null with
 | .text label => .ok label
 | .object _ | .boolean _ | .integer _ | .null | .array _ => .error "authoritative classification row is missing"

def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) (key : String) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload) key
def dynamicsLabel : String := "discrete-spectra-and-energy-phase-correspondence-confirmed__specific-Fold-normalization-structural-not-a-measured-particle-value"
def dynamicsClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "dynamics_and_spectra"
def fieldLabel : String := "Dirac-Lorentz-invariant-speed-and-Coulomb-inverse-square-correspondence-confirmed__specific-rational-closure-witnesses-structural"
def fieldClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "relativistic_and_electromagnetic_fields"
def opticsLabel : String := "interference-and-nonlinear-frequency-operations-confirmed__held-polarization-supported-by-registered-observables__half-One-normalization-structural"
def opticsClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "optical_operations"
def loopLabel : String := "finite-renormalized-radiative-calculations-confirmed__floored-loop-law-is-a-formal-finite-support-boundary-not-a-direct-measurement-of-continuum-nonexistence"
def loopClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "finite_loops"
end SFT.Physics.FieldAuthoritativeRecords
