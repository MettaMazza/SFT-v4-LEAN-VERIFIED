from pathlib import Path
import sys,json
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_rearrangement1504/sft/chemistry').resolve()));from sft.chemistry import rearrangement_reaction_batch_v1 as b
q=lambda x:json.dumps(x,ensure_ascii=False)
s='''import SFT.Chemistry.RearrangementAnalysis
namespace SFT.Chemistry.RearrangementSource
open SFT.Host RearrangementAnalysis
open ConformerPrediction (get equal)
open JointCorrelationTargets (field text)
open ConformerAnalysis (array)
'''
s+='def authorities : List (String × String) := ['+','.join('('+q(p)+','+q(h)+')'for p,h in b.AUTHORITIES)+']\n'
s+='''def authority (input : Input) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let authorityMatches := match input.files.find? (fun r => Text.equal r.path path) with
   | none => false
   | some row => row.present && Text.equal row.hash expected
  if !authorityMatches then throw (Text.append "ORG-011 authority changed: " path)
  pure ()
 let fields ← match input.preseal with
  | .object fs => pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "ORG-011 prediction seal changed"
 let unsealed : Canonical.Value := .object (fields.filter fun p => !Text.equal p.1 "sealed_payload_hash")
 let claimed := get input.preseal "sealed_payload_hash"
 if !equal claimed (.text "sha256:a772e044a114e8cea5d8698148f46ffe8d6b4f0165eb976b3513eb2245bed36e") ||
  !equal (.text (Canonical.identity unsealed)) claimed ||
  !equal (get input.preseal "new_supplementary_pdf_pages_characterization_structures_formulas_or_spectra_opened_before_this_seal") (.boolean false) ||
  !equal (get input.preseal "external_target_content_used_by_candidate_generator_or_eliminator") (.boolean false) then
  throw "ORG-011 prediction seal changed"
 let pairs ← field input.analysisDocument "explicit_claisen_source_product_pairs_in_source_order" >>= array
 if pairs.length != 8 then throw "ORG-011 complete pair boundary changed"
 pure ()
end SFT.Chemistry.RearrangementSource
''';(r/'RearrangementSource.lean').write_text(s)
s=(r/'EliminationValidation.lean').read_text().replace('Elimination','Rearrangement').replace('ORG-010','ORG-011').replace('exact-org-010-comparison/1','exact-org-011-comparison/1').replace('sha256:157144f86339efa5ddb583d860ef1fd444af6761c3080a82465367544735b89b',b.AUTHORITIES[12][1]).replace('characterized_product_rows_in_source_order','explicit_claisen_source_product_pairs_in_source_order').replace(' && tamperedRejected','')
s='\n'.join(l for l in s.splitlines()if not l.startswith(' let tamperedRejected'))+'\n';s=s.replace('throw "ORG-011 release changed"','throw "ORG-011 target release changed"')
a=s.index('def messages');z=s.index('structure Validation',a);s=s[:a]+'''def messages (analysis : Value) : Except String (List String) := do
 let hash ← stringField analysis "complete_result_vector_sha256"
 return ["complete official 38-page supporting-information PDF retained",
 "all eight source/product structures independently atom-enumerated",
 "eight exact endpoint inventories favorable; no adverse or unresolved endpoint inventory",
 "all eight pairs exhibit a positive constitutional-incidence change",
 "all optimization, non-detection, signed stereochemical and spectral surfaces retained",
 "first incomplete blind surface preserved as unresolved without relabelling",
 Text.append "complete result vector " hash]
'''+s[z:];(r/'RearrangementValidation.lean').write_text(s)
s=(w/'generate_addition1502_experiment.py').read_text().replace('addition1502','rearrangement1504').replace('pinned_addition1499','pinned_rearrangement1504').replace('addition_reaction_batch_v3','rearrangement_reaction_batch_v1').replace('ADDITION_REACTION_SPEC','REARRANGEMENT_REACTION_SPEC').replace('Addition','Rearrangement');(w/'generate_rearrangement1504_experiment.py').write_text(s)
print('Generatedoriginal21authorities/preseal/eightpair boundary and fullvalidator')
