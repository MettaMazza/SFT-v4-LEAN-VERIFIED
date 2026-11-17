import SFT.Materials.QuasicrystalInflationSource
namespace SFT.Materials.RectificationSourceBinding
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := MaterialSource.Snapshot
abbrev sources := QuasicrystalInflationSource.sources
abbrev Requirement := QuasicrystalInflationSource.Requirement
abbrev validatePreSourceSeal := QuasicrystalInflationSource.validatePreSourceSeal
abbrev stringValue := QuasicrystalInflationSource.stringValue
def requirements : List Requirement := [⟨"NIST-PN-RECTIFICATION-2026-07-27","thisdirectionofpolarityiscalledforwardbias"⟩,⟨"NIST-PN-RECTIFICATION-2026-07-27","obstructscurrentintheoppositedirection"⟩]
def receipts (files : List Snapshot) : Except String (List Value) :=
 requirements.mapM fun requirement => do
  let source ← match sources.find? (fun row => Text.equal row.sourceId requirement.sourceId) with
   | none => .error (Text.intercalate "" ["'",requirement.sourceId,"'"])
   | some source => .ok source
  let bytes ← MaterialSource.readSnapshot files source.path
  if !Text.equal (MaterialSource.bytesHash bytes) source.digest then throw "successor external source mismatch"
  if !Text.contains (MaterialSource.corpus bytes) (SFT.Chemistry.SourceText.casefold requirement.fragment) then
   throw "successor external source mismatch"
  pure (.array [.text requirement.sourceId,.text source.digest,.text requirement.fragment])
#print axioms requirements
#print axioms receipts
end SFT.Materials.RectificationSourceBinding
