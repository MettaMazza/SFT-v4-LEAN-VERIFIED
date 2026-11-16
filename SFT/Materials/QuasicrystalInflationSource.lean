import SFT.Materials.MaterialSource
import SFT.Chemistry.ConjugatedSupportAnalysis
namespace SFT.Materials.QuasicrystalInflationSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := MaterialSource.Snapshot
structure Source where
 sourceId : String
 uri : String
 path : String
 digest : String
structure Requirement where
 sourceId : String
 fragment : String
def sources : List Source := [⟨"NIST-QUASICRYSTAL-APERIODIC-2026-07-27","https://www.nist.gov/news-events/news/2025/04/rare-crystal-shape-found-increase-strength-3d-printed-metal","experiments/external_sources/materials/snapshots/nist-quasicrystal-measurement.html","sha256:a1b7cc0a5882502bb31b9706225b926c9ffb1e8d93ea5c0043249376c4d6ff18"⟩,⟨"NIST-PHONON-THERMAL-LIMITS-2026-07-27","https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication960-11.pdf","experiments/external_sources/materials/snapshots/nist-phonon-thermal-limits-2026-07-27.txt","sha256:208d3ff48584c6548ccb00d3b1559ba63d66b1fabe027af9bb499504d5cad64b"⟩,⟨"NIST-PN-RECTIFICATION-2026-07-27","https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir4414.pdf","experiments/external_sources/materials/snapshots/nist-pn-rectification-2026-07-27.txt","sha256:ca301b8fc47ba509909982ca2b077c238b92f3ff4978ed7377d086071c519ba4"⟩,⟨"NIST-SUPERCONDUCTING-ISOTOPE-2026-07-27","https://nvlpubs.nist.gov/nistpubs/jres/094/jresv94n3p147_A1b.pdf","experiments/external_sources/materials/snapshots/nist-superconducting-isotope-2026-07-27.txt","sha256:48fa89f9f63d467e9259e766f81fd8f854924ad479ec0006d14075cfe48d3ae3"⟩,⟨"NIST-FERRIMAGNETIC-SUBLATTICES-2026-07-27","https://www.nist.gov/publications/thickness-dependent-magnetism-variation-ferrimagnetic-rare-earthtransition-metal-fe1","experiments/external_sources/materials/snapshots/nist-ferrimagnetism-2026-07-27.html","sha256:685872920e5663b2ec71636b953d0e7ddec3d1cb679fb4f17bb94b6d6d811795"⟩,⟨"NIST-HALL-QUANTIZATION-2026-07-27","https://www.nist.gov/programs-projects/integer-and-fractional-quantum-hall-effect","experiments/external_sources/materials/snapshots/nist-hall-quantization-2026-07-27.html","sha256:4536e34ab401e72216f8b9010bafc9f1cacdbbfc47ca8fc998b781fa9125994c"⟩,⟨"NIST-WATER-THERMOPHYSICAL-2026-07-27","https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Mask=FFF&Units=CAL","experiments/external_sources/materials/snapshots/nist-water-complete-2026-07-27.html","sha256:ba9fc5225bc8d0d89cbe15703bff2d9dc06ef64244598c420c7666931f1befbf"⟩,⟨"NIST-LIQUID-WATER-DENSITY-2026-07-27","https://www.nist.gov/document/jpcrd38200921ppdf","experiments/external_sources/materials/snapshots/nist-liquid-water-properties-2026-07-27.txt","sha256:b3af256bcffd7ff87fbf2aa00f545910a531d5a1b285fa9bb9f926f7afad9e24"⟩,⟨"NIST-ICE-DENSITY-2026-07-27","https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=926353","experiments/external_sources/materials/snapshots/nist-ice-properties-2026-07-27.txt","sha256:7073b61255cf73163595c9ca25646dcf2c323dd2aca942d797f9f0e4dd6c178e"⟩]
def requirements : List Requirement := [⟨"NIST-QUASICRYSTAL-APERIODIC-2026-07-27","pattern that fills the space, but never repeats"⟩,⟨"NIST-QUASICRYSTAL-APERIODIC-2026-07-27","fivefold rotational symmetry"⟩]
def stringValue : Value → Except String String
 | .text s => .ok s
 | .integer _ | .boolean _ | .null | .array _ | .object _ => .error "source digest requires a string"
def fieldsValue : Value → Except String (List (String × Value))
 | .object fields => .ok fields
 | .text _ | .integer _ | .boolean _ | .null | .array _ => .error "source mapping required"
def countEight : Value → Bool
 | .integer (.ofNat n) => n==8
 | .integer (.negSucc _) | .text _ | .boolean _ | .null | .array _ | .object _ => false

def validatePreSourceSeal (payload : Value) (files : List Snapshot) : Except String String := do
 let claimed ← SFT.Chemistry.ConjugatedSupportAnalysis.field payload "sealed_payload_hash" >>= stringValue
 let fields ← fieldsValue payload
 let content := Value.object (fields.filter (fun item => !Text.equal item.1 "sealed_payload_hash"))
 if !Text.equal (identity content) claimed then throw "successor pre-source seal invalid"
 let selected ← SFT.Chemistry.ConjugatedSupportAnalysis.field payload "external_source_identities_selected"
 if !MaterialSource.isFalse selected then throw "successor pre-source seal invalid"
 let required ← SFT.Chemistry.ConjugatedSupportAnalysis.field payload "required_claim_count"
 if !countEight required then throw "successor pre-source seal invalid"
 let manifest ← SFT.Chemistry.ConjugatedSupportAnalysis.field payload "source_files" >>= fieldsValue
 let _ ← manifest.mapM (fun (path,digest) => do
  let expected ← stringValue digest
  let bytes ← MaterialSource.readSnapshot files path
  if !Text.equal (MaterialSource.bytesHash bytes) expected then throw "sealed successor source changed"
  pure ())
 pure claimed

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
#print axioms sources
#print axioms requirements
#print axioms stringValue
#print axioms fieldsValue
#print axioms countEight
#print axioms validatePreSourceSeal
#print axioms receipts
end SFT.Materials.QuasicrystalInflationSource
