from pathlib import Path
import sys,json
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_elimination1503/sft/chemistry').resolve()));from sft.chemistry import elimination_reaction_batch_v1 as b
q=lambda x:json.dumps(x,ensure_ascii=False)
pairs=[(b.FAMILY_BOUNDARY_PATH,b.FAMILY_BOUNDARY_HASH),(b.FAMILY_REGISTRY_PATH,b.FAMILY_REGISTRY_HASH),(b.FAMILY_INVENTORY_PATH,b.FAMILY_INVENTORY_HASH),(b.LAW_PATH,b.LAW_HASH),(b.IDENTITY_PATH,b.IDENTITY_HASH),(b.PRESEAL_PATH,b.PRESEAL_FILE_HASH),(b.INVENTORY_PATH,b.INVENTORY_HASH),(b.ANALYSIS_PATH,b.ANALYSIS_HASH),(b.IUPAC_PATH,b.IUPAC_HASH),(b.CAPTURE_TOOL_PATH,b.CAPTURE_TOOL_HASH),(b.ANALYSIS_TOOL_PATH,b.ANALYSIS_TOOL_HASH)]
s='''import SFT.Chemistry.EliminationAnalysis
namespace SFT.Chemistry.EliminationSource
open SFT.Host EliminationAnalysis
open ConformerPrediction (get equal)
open JointCorrelationTargets (field text)
open ConformerAnalysis (array)
'''
s+='def authorities : List (String × String) := ['+','.join('('+q(p)+','+q(h)+')'for p,h in pairs)+']\n'
s+='''def authority (input : Input) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let authorityMatches := match input.files.find? (fun r => Text.equal r.path path) with
   | none => false
   | some row => row.present && Text.equal row.hash expected
  if !authorityMatches then throw (Text.append "ORG-010 authority changed: " path)
  pure ()
 let fields ← match input.preseal with
  | .object fs => pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "ORG-010 prediction seal changed"
 let unsealed : Canonical.Value := .object (fields.filter fun p => !Text.equal p.1 "sealed_payload_hash")
 if !equal (get input.preseal "sealed_payload_hash") (.text PAYLOAD_HASH) ||
  !Text.equal (Canonical.identity unsealed) PAYLOAD_HASH ||
  !equal (get input.preseal "supplementary_archive_product_structures_yields_spectra_or_complete_page_contents_opened_before_this_seal") (.boolean false) ||
  !equal (get input.preseal "external_target_content_used_by_candidate_generator_or_eliminator") (.boolean false) then
  throw "ORG-010 prediction seal changed"
 let products ← field input.analysisDocument "characterized_product_rows_in_source_order" >>= array
 let unsuccessful ← field input.analysisDocument "unsuccessful_substrate_rows" >>= array
 let optimisation ← field input.analysisDocument "optimisation_tables" >>= array
 if products.length != 32 || unsuccessful.length != 5 || optimisation.length != 7 then
  throw "ORG-010 complete external row boundary changed"
 pure ()
end SFT.Chemistry.EliminationSource
'''.replace('PAYLOAD_HASH',q(b.PRESEAL_PAYLOAD_HASH));(r/'EliminationSource.lean').write_text(s)
s=(r/'AdditionValidation.lean').read_text().replace('Addition','Elimination').replace('ORG-009','ORG-010').replace('exact-org-009-comparison/3','exact-org-010-comparison/1').replace('complete_result_vector_hash','complete_result_vector_sha256').replace('sha256:ae8b152f09ebdd07e068890f0bff121d6dcfe189f57b6999ea79a6c22f29f96c',b.ANALYSIS_HASH)
a=s.index('def messages');z=s.index('structure Validation',a)
s=s[:a]+'''def messages (analysis : Value) : Except String (List String) := do
 let hash ← stringField analysis "complete_result_vector_sha256"
 return ["complete 22-member Europe PMC archive and all 117 supplementary PDF pages retained",
 "all 32 characterized product blocks retained; every reported product displays unsaturation",
 "all 32 incomplete coproduct carriers remain explicitly unresolved for complete atom/support balance",
 "all five unsuccessful or low-elimination rows preserved without success filtering",
 "all seven optimization tables and 34 rows including the printed source gap retained",
 "the six-row 3a-prime/3a time course preserves decreasing intermediate and increasing product",
 Text.append "complete result vector " hash]
'''+s[z:]
a=s.index(' let selected ←');z=s.index(' let passed',a)
s=s[:a]+''' let products ← field input.analysisDocument "characterized_product_rows_in_source_order" >>= ConformerAnalysis.array
 let omissionRejected := match EliminationAnalysis.analysis input (some (products.take (products.length-1))) with
  | .error _ => true
  | .ok _ => false
'''+s[z:]
(r/'EliminationValidation.lean').write_text(s)
print('Generated original11authority checks, originalpreseal/rowboundary and fullvalidator')
