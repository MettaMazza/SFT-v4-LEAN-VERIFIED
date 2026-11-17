from pathlib import Path
import sys,json
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1162/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.anal_performance_batch_v1 import ACCURACY_SPEC as spec,AUTHORITIES
q=lambda x:json.dumps(x,ensure_ascii=False)
s='''import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Chemistry.AnalyticalAccuracySource
namespace SFT.Chemistry.AnalyticalAccuracyAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
''';s+='def claimId : String := '+q(spec.claim_id)+'\ndef targetIds : List String := ['+','.join(q(x.target_id)for x in spec.target_rows)+']\n';s+='def authorities : List (String × String) := ['+','.join('('+q(p)+','+q(h)+')'for p,h in AUTHORITIES)+']\n'
old=(r/'RadiotracerCustodyAnalysis.lean').read_text();prefix=old[old.index('def validateAuthorities'):old.index('def tracerChecks')];prefix=prefix.replace('NUCHEM-009–012','ANAL-001–005');a=prefix.index('def verifySurfaces');prefix=prefix[:a]+'''def verifySurfaces (analysis : Value) (inputs : List SurfaceInput) : Except String (Nat × Nat × Nat) := do
 let sources ← field analysis "complete_source_reconstruction" >>= fields
 let total ← sources.foldlM (fun (total : Nat × Nat × Nat) (_,source) => do
  let path ← field source "snapshot_path" >>= text
  let kind ← field source "media_kind" >>= text
  let input ← match inputs.find? (fun row => Text.equal row.path path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some row => .ok row
  let reconstructed := AnalyticalAccuracySource.surface kind input.pages input.events
  let expected ← field source "complete_surface_vector"
  if !equal (.array reconstructed) expected then throw "complete ANAL-001–005 source reconstruction changed"
  let characters ← reconstructed.foldlM (fun sum row => do
   let n ← field row "character_count" >>= nat
   return sum+n) 0
  return (total.1+(if Text.equal kind "pdf" then reconstructed.length else 0),
   total.2.1+(if Text.equal kind "html" then 1 else 0),total.2.2+characters)) (0,0,0)
 let pages ← field analysis "complete_pdf_page_count" >>= nat
 let htmls ← field analysis "complete_html_document_count" >>= nat
 let chars ← field analysis "complete_extracted_character_count" >>= nat
 if total != (83,1,180366) || total != (pages,htmls,chars) then throw "complete ANAL-001–005 source surface changed"
 return total
''';s+=prefix
s+='''def accuracyChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let certified ← field row "certified_row_count" >>= nat
 let reference ← if certified==6 then field row "reference_noncertified_row_count" >>= nat else pure 0
 let values ← field row "complete_certified_and_reference_value_vector" >>= array
 let paired ← if values.length==7 then do
  let first ← ConjugatedSupportAnalysis.valueAt values 0
  let firstText ← field first "mass_concentration_ng_mL" >>= text
  if !Text.equal firstText "1033 ± 97" then pure false else do
   let last ← ConjugatedSupportAnalysis.valueAt values (values.length-1)
   pure (Text.equal (← field last "mass_concentration_ng_mL" >>= text) "1008 ± 103")
  else pure false
 let methods ← field row "method_vector" >>= array
 let factor ← field row "coverage_factor" >>= text
 let uncertainty ← if Text.equal factor "2.1" then do
  pure (Text.equal (← field row "coverage_probability" >>= text) "approximately 95%") else pure false
 let temperature ← field row "use_temperature_C" >>= text
 let boundary ← if Text.equal temperature "20 to 25" then do
  pure (Text.equal (← field row "serum_density_g_mL" >>= text) "1.025") else pure false
 let issued ← field row "certificate_issue_date" >>= text
 let status ← if Text.equal issued "21 March 2011" then do
  pure (Text.equal (← field row "certificate_expiry" >>= text) "01 October 2015") else pure false
 let last ← ConjugatedSupportAnalysis.valueAt values (values.length-1)
 let lastStatus ← field last "status" >>= text
 let adverse ← if Text.equal lastStatus "reference_noncertified" then
  field row "complete_accuracy_use_and_storage_limits_retained" >>= bool else pure false
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-ANAL-001-REFERENCE",certified==6 && reference==1),
 ("SFT-CHEM-ANAL-001-VALUE-PAIRS",paired),("SFT-CHEM-ANAL-001-METHODS",methods.length==3),
 ("SFT-CHEM-ANAL-001-UNCERTAINTY",uncertainty),("SFT-CHEM-ANAL-001-BOUNDARY",boundary),
 ("SFT-CHEM-ANAL-001-STATUS",status),("SFT-CHEM-ANAL-001-ADVERSE-LIMITS",adverse),
 ("SFT-CHEM-ANAL-001-COMPLETE-SOURCE",sourceCount==6)]
def exactAccuracyAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "ANAL-001–005 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "anal_001"
 let fullChecks ← accuracyChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let values ← field row "complete_certified_and_reference_value_vector" >>= array
 let masses ← values.mapM (fun x => field x "mass_concentration_ng_mL")
 let summary : Value := .object [("certified_value_rows",.integer 6),("reference_noncertified_rows",.integer 1),
 ("mass_concentration_vector",.array masses),("coverage_factor",.text "2.1"),("certificate_status",.text "expired archived measured record"),
 ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
 ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
 ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.AnalyticalAccuracyAnalysis
''';(r/'AnalyticalAccuracyAnalysis.lean').write_text(s)
s=(w/'generate_radiolysis1160_experiment.py').read_text().replace('RadiolysisNetwork','AnalyticalAccuracy').replace('radiolysis1160','accuracy1162').replace('pinned1160','pinned1162').replace('nuchem_terminal_batch_v1','anal_performance_batch_v1').replace('RADIOLYSIS_SPEC','ACCURACY_SPEC')
# The prior generator emits the original witness list by source order.
names=['referenceWitness','measurandWitness','supportWitness','comparisonWitness','truenessWitness','uncertaintyWitness','boundaryWitness','successorWitness']
for a,b in zip(['handoffWitness','identityWitness','networkWitness','eventsWitness','yieldWitness','partitionWitness','closureWitness','extensionWitness'],names):s=s.replace('AnalyticalAccuracy.'+a,'AnalyticalAccuracy.'+b)
(w/'generate_accuracy1162_experiment.py').write_text(s);exec(compile(s,str(w/'generate_accuracy1162_experiment.py'),'exec'),{})
s=(w/'checkpoint1160_files/SFT/Chemistry/RadiolysisNetworkValidation.lean').read_text().replace('RadiolysisNetwork','AnalyticalAccuracy').replace('exactRadiolysisAnalysis','exactAccuracyAnalysis').replace('NUCHEM-009–012','ANAL-001–005').replace('exact-nuchem-terminal-batch/1','exact-anal-performance-batch/1').replace('complete four-source post-seal family retained as 370 PDF pages and 837,013 extracted characters','complete six-source post-seal family retained as 83 PDF pages, one HTML document and 180,366 extracted characters').replace('all measured values units uncertainties assumptions corrections fits estimates losses adverse absent unavailable and unresolved records remain downstream provenance; disclosed pre-seal snippets are never relabelled blind','all values units uncertainties assumptions corrections fits estimates losses adverse absent unavailable unresolved historical and archived-status records remain downstream provenance; disclosed pre-seal snippets are never relabelled blind');(r/'AnalyticalAccuracyValidation.lean').write_text(s)
s=(w/'build_radiolysis1160_interfaces.py').read_text().replace('RadiolysisNetwork','AnalyticalAccuracy').replace('radiolysis1160','accuracy1162').replace('RadiolysisInterfacesAudit1158','AnalyticalAccuracyInterfaces1162');(w/'build_accuracy1162_interfaces.py').write_text(s)
print('Translated original ANAL001 authority, six-source reconstruction,8checks,summary and complete custody validator.')
