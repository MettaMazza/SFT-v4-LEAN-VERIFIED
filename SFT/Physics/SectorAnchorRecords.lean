import SFT.Physics.SectorInventory
import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.SectorAnchorRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement

def sourceHashes : List (String × String) := [
 ("pdg-2025-qcd.pdf","sha256:7cbb5c5ef1d217fd0a13544db36d031e600f4e4df7309af6c859a0b988ed6ada"),
 ("pdg-2025-electroweak-model.pdf","sha256:8642888a3408d8c57fc673b379325b07f02948135491f64a2e42320e8929320a")]

def standingPredictions : Value := .array [
 .text "sector-five mediator count 24",.text "sector-seven mediator count 48",
 .text "penta/hepta charge and matter inventories"]

def originalInt (value : Value) : Except String Int := match value with
 | .integer n => .ok n
 | .boolean false => .ok 0
 | .boolean true => .ok 1
 | .text s => match LeptonDecimal.exponent (Text.chars s) with
   | some n => .ok n
   | none => .error "ValueError: invalid literal for int"
 | .null | .array _ | .object _ => .error "TypeError: int requires a string or number"

def expectedCounts : Except String Value := do
 let weak ← PrimeSectorLadder.mediatorCount (.integer 2)
 let colours ← SectorInventory.chargeKindCount (.integer 3)
 let gluons ← PrimeSectorLadder.mediatorCount (.integer 3)
 pure (.object [("sector_two_mediators",.integer weak),
  ("sector_three_charges",.integer colours),("sector_three_mediators",.integer gluons)])

theorem expectedCountsSource : expectedCounts=.ok (.object [
 ("sector_two_mediators",.integer 3),("sector_three_charges",.integer 3),
 ("sector_three_mediators",.integer 8)]) := rfl

def anchorRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !sameValue ((field payload "record_id").toOption.getD .null) (.text "PDG-FORCE-SECTOR-ANCHORS-2025") then
  throw "PDG force anchor identity changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "both PDG source documents must remain registered")
 if sources.length != 2 then throw "both PDG source documents must remain registered"
 let _ ← sources.foldlM (fun (_ : Unit) source => do
  let snapshot ← text (← field source "snapshot")
  let expected ← match sourceHashes.find? (fun p => Text.equal p.1 snapshot) with
   | some p => .ok p.2
   | none => .error (Text.append "KeyError: " snapshot)
  let bytes ← match files.find? (fun p => Text.equal p.1 snapshot) with
   | some p => .ok p.2
   | none => .error (Text.append "FileNotFoundError: " snapshot)
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw "PDG force source snapshot changed"
  pure ()) ()
 let qcd ← rowAt sources 0
 let electroweak ← rowAt sources 1
 let weak ← originalInt (← field electroweak "observed_mediator_kind_count")
 let colours ← originalInt (← field qcd "observed_charge_kind_count")
 let gluons ← originalInt (← field qcd "observed_mediator_kind_count")
 let observed := Value.object [("sector_two_mediators",.integer weak),
  ("sector_three_charges",.integer colours),("sector_three_mediators",.integer gluons)]
 let expected ← expectedCounts
 let predictions ← field (← field payload "prediction_boundary") "standing_unobserved_rows"
 pure (.object [("observed",observed),("expected",expected),
  ("anchors_pass",.boolean (sameValue observed expected)),
  ("standing_predictions_retained",.boolean (sameValue predictions standingPredictions))])
end SFT.Physics.SectorAnchorRecords
