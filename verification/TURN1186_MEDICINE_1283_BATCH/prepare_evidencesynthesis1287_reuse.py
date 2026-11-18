from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
report=json.loads((w/'clinicaltrial1283_empirical_report.json').read_text());assert report['status']=='PASS'
for rel,h in report['source_sha256'].items():assert H(r/rel)==h,rel
assert json.loads((w/'clinicaltrial1283_empirical_output.json').read_text())==json.loads((w/'clinicaltrial1283_original_empirical.json').read_text())
old=json.loads((w/'clinicaltrial1283_empirical_input.json').read_text());new=json.loads((w/'evidencesynthesis1287_empirical_input.json').read_text())
a={x['path']:x for x in old['files']if not x['path'].startswith('claims/')};b={x['path']:x for x in new['files']if not x['path'].startswith('claims/')};assert a.keys()==b.keys()
hashes={}
for rel,x in b.items():
 h=H(Path(x['local']));assert h==H(Path(a[rel]['local'])),rel;hashes[rel]=h
assert old['pre_source_payload']==new['pre_source_payload']
new['verified_source_seal']=old['pre_source_payload']['complete_branch_pre_source_seal_hash']
(w/'evidencesynthesis1287_resolved_input.json').write_text(json.dumps(new,ensure_ascii=False)+'\n')
(w/'evidencesynthesis1287_reused_source_evidence.json').write_text(json.dumps(dict(status='PASS',prior_full_native='clinicaltrial1283_empirical_report.json',shared_module_sha256=report['source_sha256'],same_registered_input_files=hashes,same_pre_source_payload=True,source_label_rebinding='SFT.Medicine.EvidenceSynthesisSource.sourceDerivedTarget',binding='Identical original ICH requirements; original family source delegates to ClinicalTrialSource; only original claim-specific observed label differs'),indent=2)+'\n')
print('Reused actual full native ClinicalTrial source/seal with identical bytes and binding',flush=True)
