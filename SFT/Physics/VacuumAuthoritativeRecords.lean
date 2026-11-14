import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.VacuumAuthoritativeRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement

def componentHashes : List (String × String) := [("nist-zero-point-fluctuations-2015.html","sha256:e829ac861cca9f84f43f752465b4ee8801fb07fac76e41f0df4de98ff5f54832"),("nist-casimir-vacuum-forces-2013.html","sha256:906e3d92d1e664daa5070bcf8cdafa4bf20fc8bb003346946870fa9b64ee7b1f"),("pdg-2025-electroweak-model.pdf","sha256:8642888a3408d8c57fc673b379325b07f02948135491f64a2e42320e8929320a"),("cnes-microscope-final.html","sha256:65a86753705aaa80f819e833d1ca4e13f0491e56b58a218c4cddb492c9887f12")]

def sourceHash : String := "sha256:327696985650aebaa20436e9da1d7f20f9bbff4205f9e7146ec8bd887535f3a9"

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "vacuum lineage source record identity changed"
 if !sameValue ((field payload "record_id").toOption.getD .null) (.text "VACUUM-LINEAGE-AUTHORITATIVE-2015-2026") then
  throw "vacuum lineage source record ID changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "vacuum lineage record must retain all four authoritative sources")
 if sources.length != 4 then throw "vacuum lineage record must retain all four authoritative sources"
 let _ ← sources.foldlM (fun (_ : Unit) source => do
  let snapshot ← text (← field source "snapshot")
  let expected ← match componentHashes.find? (fun p => Text.equal p.1 snapshot) with
   | none => .error "vacuum lineage component snapshot identity changed"
   | some p => .ok p.2
  let content ← match files.find? (fun p => Text.equal p.1 snapshot) with
   | none => .error (Text.append "FileNotFoundError: " snapshot)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest content)) expected then
   throw "vacuum lineage component snapshot identity changed"
  pure ()) ()
 pure payload

def assignSource (key : String) (value : Value) : List (String × Value) → List (String × Value)
 | [] => [(key,value)]
 | (k,v)::rest => if Text.equal k key then (k,value)::rest else (k,v)::assignSource key value rest

def sourceById (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let record ← authoritativeRecord bytes files payload
 let sources ← array (← field record "sources")
 let entries ← sources.foldlM (fun entries row => do
  let key ← text (← field row "source_id")
  pure (assignSource key row entries)) []
 pure (.object entries)

def rowByQuantity (source : Value) (quantity : String) : Except String Value := do
 let rows ← array (← field source "rows")
 let matching ← rows.foldlM (fun kept row => do
  let name ← field row "quantity"
  pure (if sameValue name (.text quantity) then kept ++ [row] else kept)) []
 match matching with
 | [row] => .ok row
 | [] | _::_::_ => .error (Text.append "authoritative quantity must occur exactly once: " quantity)

def floorLabel : String := "nonempty-ground-confirmed__casimir-boundary-force-confirmed__half-offset-not-directly-isolated"
def polarizationLabel : String := "inverse-coupling-decreases-with-scale__effective-coupling-running-direction-confirmed"
def inertiaLabel : String := "equivalence-unity-anchor-confirmed-to-mission-precision__vacuum-control-untested"
def extractionLabel : String := "positive-formal-outward-transfer-sealed__standalone-vacuum-work-not-observed__complete-returned-cycle-consistent"

def floorFromSources (sources : Value) : Except String String := do
 let nist ← field sources "NIST-ZERO-POINT-FLUCTUATIONS-2015"
 let casimir ← field sources "NIST-CASIMIR-VACUUM-FORCES-2013"
 let nonempty ← field (← rowByQuantity nist "ground-state residual fluctuation support") "comparison_class"
 let boundary ← field (← rowByQuantity casimir "Casimir interaction") "comparison_class"
 if !sameValue nonempty (.text "nonempty-ground-support-confirmed") ||
    !sameValue boundary (.text "boundary-dependent-vacuum-force-confirmed") then
  pure "vacuum-floor-authoritative-classification-changed"
 else pure floorLabel

def polarizationFromSources (sources : Value) : Except String (String × List (String × Rat)) := do
 let pdg ← field sources "PDG-ELECTROMAGNETIC-RUNNING-2025"
 let low ← rowByQuantity pdg "inverse electromagnetic coupling at the Thomson limit"
 let high ← rowByQuantity pdg "inverse running electromagnetic coupling at the Z scale in the five-flavour MS scheme"
 let direct ← rowByQuantity pdg "direct running observation"
 let lc ← decimalField low "central"
 let lw ← decimalField low "standard_uncertainty"
 let hc ← decimalField high "central"
 let hw ← decimalField high "standard_uncertainty"
 let ll := LeptonIntervals.subtract lc lw
 let lu := LeptonIntervals.add lc lw
 let hl := LeptonIntervals.subtract hc hw
 let hu := LeptonIntervals.add hc hw
 let observed ← field direct "comparison_class"
 pure (if hu.blt ll && sameValue observed (.text "closer-probe-effective-coupling-increase-confirmed")
   then polarizationLabel else "vacuum-polarization-direction-changed",
  [("low_inverse_lower",ll),("low_inverse_upper",lu),("high_inverse_lower",hl),("high_inverse_upper",hu)])

def inertiaFromSources (sources : Value) : Except String String := do
 let microscope ← field sources "CNES-MICROSCOPE-FINAL-2022"
 let row ← rowByQuantity microscope "equivalence of gravitational and inertial response"
 let precision ← field row "reported_precision"
 let classification ← field row "comparison_class"
 if !sameValue precision (.text "1e-15") || !sameValue classification (.text "unity-response-anchor-confirmed") then
  pure "vacuum-inertia-anchor-classification-changed"
 else pure inertiaLabel

def extractionFromSources (sources : Value) : Except String String := do
 let nist ← field sources "NIST-ZERO-POINT-FLUCTUATIONS-2015"
 let work ← field (← rowByQuantity nist "removable ground-state energy") "comparison_class"
 let pump ← field (← rowByQuantity nist "physical amplification boundary") "comparison_class"
 if !sameValue work (.text "free-standing-vacuum-work-not-observed") || !sameValue pump (.text "external-pump-energy-retained") then
  pure "vacuum-extraction-authoritative-classification-changed"
 else pure extractionLabel

def floorClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 floorFromSources (← sourceById bytes files payload)
def polarizationClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String (String × List (String × Rat)) := do
 polarizationFromSources (← sourceById bytes files payload)
def inertiaClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 inertiaFromSources (← sourceById bytes files payload)
def extractionClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 extractionFromSources (← sourceById bytes files payload)
end SFT.Physics.VacuumAuthoritativeRecords
