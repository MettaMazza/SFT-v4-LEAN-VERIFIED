from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_addition1499/sft/chemistry').resolve()));from sft.chemistry import addition_reaction_batch_v3 as b
q=lambda x:json.dumps(x,ensure_ascii=False)
pairs=[(b.FAMILY_BOUNDARY_PATH,b.FAMILY_BOUNDARY_HASH),(b.FAMILY_REGISTRY_PATH,b.FAMILY_REGISTRY_HASH),(b.FAMILY_INVENTORY_PATH,b.FAMILY_INVENTORY_HASH),(b.LAW_PATH,b.LAW_HASH),(b.IDENTITY_PATH,b.IDENTITY_HASH),(b.PRESEAL_PATH,b.PRESEAL_FILE_HASH),(b.METADATA_PATH,b.METADATA_HASH),(b.INVENTORY_PATH,b.INVENTORY_HASH),(b.SELECTION_PATH,b.SELECTION_HASH),(b.SELECTION_SEAL_PATH,b.SELECTION_SEAL_HASH),(b.COMPARISON_PATH,b.COMPARISON_HASH)]
s='''import SFT.Chemistry.AdditionAnalysis
namespace SFT.Chemistry.AdditionSource
open SFT.Host AdditionAnalysis
open ConformerPrediction (get equal)
open JointCorrelationTargets (field text)
open ConformerAnalysis (array)
'''
s+='def authorities : List (String × String) := ['+','.join('('+q(p)+','+q(h)+')'for p,h in pairs)+']\n'
s+='def preserved : List String := ['+','.join(q(p)for p in b.HISTORY_PATHS+b.TOOL_PATHS)+']\n'
s+='''def authority (input : Input) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let authorityMatches := match input.files.find? (fun r => Text.equal r.path path) with
   | none => false
   | some row => row.present && Text.equal row.hash expected
  if !authorityMatches then throw (Text.append "ORG-009 authority changed: " path)
  pure ()
 let _ ← preserved.mapM fun path => do
  if !(input.files.any fun row => Text.equal row.path path && row.present) then
   throw (Text.append "ORG-009 preserved evidence is absent: " path)
  pure ()
 let fields ← match input.preseal with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "ORG-009 prediction seal changed"
 let unsealed : Canonical.Value := .object (fields.filter fun p => !Text.equal p.1 "sealed_payload_hash")
 if !equal (get input.preseal "sealed_payload_hash") (.text PAYLOAD_HASH) ||
  !Text.equal (Canonical.identity unsealed) PAYLOAD_HASH ||
  !equal (get input.preseal "ord_reaction_rows_or_products_opened_before_v9_seal") (.boolean false) ||
  !equal (get input.preseal "external_target_content_used_by_candidate_generator_or_eliminator") (.boolean false) ||
  !equal (get input.preseal "all_v1_through_v8_results_preserved") (.boolean true) then
  throw "ORG-009 prediction seal changed"
 let selected ← field input.selection "selected_in_payload_and_row_order" >>= array
 let outcomes ← field input.comparison "results_in_frozen_order" >>= array
 if selected.length != 28 || outcomes.length != 28 then throw "ORG-009 complete selected boundary changed"
 pure ()
end SFT.Chemistry.AdditionSource
'''.replace('PAYLOAD_HASH',q(b.PRESEAL_PAYLOAD_HASH));(w/'turn1064_recovery/SFT/Chemistry/AdditionSource.lean').write_text(s)
s=(w/'generate_electrophilic1498_experiment.py').read_text().replace('electrophilic1498','addition1502').replace('pinned_addition1502','pinned_addition1499').replace('electrophilic_substitution_batch_v1','addition_reaction_batch_v3').replace('ELECTROPHILIC_SUBSTITUTION_SPEC','ADDITION_REACTION_SPEC').replace('Electrophilic','Addition')
a=s.index(' if !([AdditionWitnesses.completeCarrier');z=s.index(' return ()',a);s=s[:a]+''' let witnessRows ← AdditionWitnesses.witnesses
 if !(witnessRows.all id) then throw "Chemistry operational witness failed"
'''+s[z:];(w/'generate_addition1502_experiment.py').write_text(s)
print('Generated original authority/preservation/preseal checks and experiment generator')
