from pathlib import Path
import json,sys
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1140/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.nuchem_terminal_batch_v1 import RADIOTRACER_SPEC as spec,AUTHORITIES
q=lambda x:json.dumps(x,ensure_ascii=False)
s='''import SFT.Chemistry.NuclideCarrierAnalysis
namespace SFT.Chemistry.RadiotracerCustodyAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
'''
s+='def claimId : String := '+q(spec.claim_id)+'\ndef targetIds : List String := ['+','.join(q(x.target_id)for x in spec.target_rows)+']\n'
s+='def authorities : List (String × String) := ['+','.join('('+q(p)+','+q(h)+')'for p,h in AUTHORITIES)+']\n'
s+='''def validateAuthorities (files : List Snapshot) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let bytes ← SFT.Materials.MaterialSource.readSnapshot files path
  if !Text.equal (SFT.Materials.MaterialSource.bytesHash bytes) expected then
   throw (Text.append "NUCHEM-009–012 authority changed: " path)
 return ()
def verifySurfaces (analysis : Value) (inputs : List SurfaceInput) : Except String (Nat × Nat) := do
 let sources ← field analysis "complete_source_reconstruction" >>= fields
 let total ← sources.foldlM (fun (total : Nat × Nat) (_,source) => do
  let path ← field source "snapshot_path" >>= text
  let input ← match inputs.find? (fun row => Text.equal row.path path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some row => .ok row
  let reconstructed := NuclideCarrierSurface.surface "pdf" input.pages []
  let expected ← field source "complete_surface_vector"
  if !equal (.array reconstructed) expected then throw "complete NUCHEM-009–012 source reconstruction changed"
  let characters ← reconstructed.foldlM (fun sum row => do
   let n ← field row "character_count" >>= nat
   return sum+n) 0
  return (total.1+reconstructed.length,total.2+characters)) (0,0)
 let pages ← field analysis "complete_pdf_page_count" >>= nat
 let chars ← field analysis "complete_extracted_character_count" >>= nat
 if total.1 != 370 || total.2 != 837013 || total.1 != pages || total.2 != chars then
  throw "complete NUCHEM-009–012 source surface changed"
 return total

def tracerChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let chemistry ← field row "complete_tracer_chemical_vector" >>= array
 let support ← field row "detector_support"
 let detectors ← field support "simple_experiment_detector_count" >>= text
 let times ← field row "flotation_mean_residence_time_minutes" >>= array
 let gold ← field row "gold_leach_vector"
 let tank1 ← field gold "tank_1_injected_activity_mCi" >>= text
 let tank7 ← field gold "tank_7_injected_activity_mCi" >>= text
 let cobalt ← field row "cobalt_recovery_vector"
 let recovery ← field cobalt "recovery_in_copper_matte_percent" >>= text
 let shortCircuit ← field cobalt "short_circuit_percent" >>= text
 let blockedVolume ← field cobalt "blocked_settling_tank_volume_percent" >>= text
 let boundary ← field row "observation_model_boundary" >>= text
 let retained ← field row "all_background_decay_correction_normalization_loss_fit_assumption_adverse_absent_unavailable_and_unresolved_rows_retained" >>= bool
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-009-TRACER-CHEMISTRY",chemistry.length == 8 && chemistry.any (fun x => equal x (.text "58CoO"))),
 ("SFT-CHEM-NUCHEM-009-OBSERVATION-SUPPORT",Text.equal detectors "2" && times.length == 3),
 ("SFT-CHEM-NUCHEM-009-COUNTS",Text.equal tank1 "100" && Text.equal tank7 "130"),
 ("SFT-CHEM-NUCHEM-009-RECOVERY",Text.equal recovery "70-75"),
 ("SFT-CHEM-NUCHEM-009-LOCALIZATION",Text.equal shortCircuit "about 5" && Text.equal blockedVolume "nearly 30"),
 ("SFT-CHEM-NUCHEM-009-INFERENCE-BOUNDARY",(Text.chars "measured curves").isPrefixOf (Text.chars boundary)),
 ("SFT-CHEM-NUCHEM-009-ADVERSE-LIMITS",retained),
 ("SFT-CHEM-NUCHEM-009-COMPLETE-SOURCE",sourceCount == 4)]

def exactTracerAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-009–012 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_009"
 let fullChecks ← tracerChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("tracer_chemistry_rows",.integer 8),("flotation_rows",.integer 3),
  ("cobalt_recovery_percent",.text "70-75"),("short_circuit_percent",.text "about 5"),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_characters",.integer (.ofNat total.2)),
  ("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.RadiotracerCustodyAnalysis
'''
(r/'SFT/Chemistry/RadiotracerCustodyAnalysis.lean').write_text(s)
for kind in ['analysis','validation']:
 s=(w/f'build_fractionation1139_{kind}.py').read_text().replace('EquilibriumIsotopeFractionation','RadiotracerCustody').replace('fractionation1139','radiotracer1140');(w/f'build_radiotracer1140_{kind}.py').write_text(s)
