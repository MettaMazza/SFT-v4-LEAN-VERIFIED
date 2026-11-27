from pathlib import Path
import json,sys,platform
from types import SimpleNamespace
w=Path('work');r=w/'turn1064_recovery';stage=w/'pinned_bulkwater1499';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.materials;sft.materials.__path__.insert(0,str((stage/'sft/materials').resolve()));from sft.materials import successor_evidence as v
from sft.engine.canonical import canonical_value
cid='SFT-MAT-BULK-WATER-RESPONSE-002';spec=next(x for x in v.SPECS if x.claim_id==cid);rows=json.load(open(w/'bulkwater1499_original_source_checks.json'));bad={str((stage/x['path']).resolve()):x['expected']for x in rows if not x['hash_matches']}
# Isolate the original downstream branch; never relabel this as full empirical replay.
original_hash=v.hash_file
try:
 v.hash_file=lambda p:bad.get(str(p.resolve()),original_hash(p))
 result=canonical_value(v.BlindSuccessorMaterialsValidator(stage,spec).validate(SimpleNamespace(seal_hash='native-bulkwater1499')))
finally:v.hash_file=original_hash
assert result['passed'];(w/'bulkwater1499_postsource_expected.json').write_text(json.dumps(result,indent=2)+'\n')
data=json.load(open(w/'bulkwater1499_empirical_input.json'));data.update(source_seal=v.validate_pre_source_seal(stage),receipts=[[q.source_id,v.SOURCE_BY_ID[q.source_id].digest,q.fragment]for q in v.BINDINGS[cid]]);(w/'bulkwater1499_postsource_input.json').write_text(json.dumps(data,indent=2)+'\n')
production=(r/'SFT/Materials/BulkWaterValidation.lean').read_text();body=production[production.index(' let registryHash :='):production.index('\n#print axioms')]
s=(w/'BulkWaterValidation1499.lean').read_text();s=s[:s.index('def main')];s+='''open SFT.Host SFT.Host.Canonical SFT.Materials.BulkWaterExperiment SFT.Materials.BulkWaterValidation
def postSource (sourceSeal : String) (receipts : List SFT.Host.Canonical.Value)
 (derivationSeal host implementation : String) (before after : HostilePackage.Snapshot) : Except String SFT.Host.Canonical.Value := do
 validateSpec
'''+body+'''
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/bulkwater1499_postsource_input.json"
 let parsed ← IO.ofExcept (Lean.Json.parse raw)
 let sourceSeal ← IO.ofExcept (text parsed "source_seal")
 let receiptJson ← IO.ofExcept (items parsed "receipts")
 let receipts ← IO.ofExcept (receiptJson.mapM (convert (raw.utf8ByteSize+1)))
 let output ← IO.ofExcept (do
  let before ← field parsed "before" >>= protectedSnapshot
  let after ← field parsed "after" >>= protectedSnapshot
  postSource sourceSeal receipts (← text parsed "derivation_seal") (← text parsed "host") (← text parsed "implementation") before after)
 IO.println (SFT.Host.Canonical.render output)
''';(w/'BulkWaterPostSource1499.lean').write_text(s)
s=(w/'prepare_bulkwater1499_validation_native.py').read_text().replace('BulkWaterValidation1499','BulkWaterPostSource1499').replace('bulkwater1499_validation','bulkwater1499_postsource');s=s.replace("'bulkwater1499_program_native_build.json']:","'bulkwater1499_program_native_build.json','bulkwater1499_validation_native_build.json']:");(w/'prepare_bulkwater1499_postsource_native.py').write_text(s)
print('Prepared separately labelled downstream comparison; original full replay remains failure')
