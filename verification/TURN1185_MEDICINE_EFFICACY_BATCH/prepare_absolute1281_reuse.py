from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
report=json.loads((w/'efficacy1277_empirical_report.json').read_text());assert report['status']=='PASS'
for rel,h in report['source_sha256'].items():assert H(r/rel)==h,rel
assert json.loads((w/'efficacy1277_empirical_output.json').read_text())==json.loads((w/'efficacy1277_original_empirical.json').read_text())
old=json.loads((w/'efficacy1277_empirical_input.json').read_text());new=json.loads((w/'absolute1281_empirical_input.json').read_text())
a={x['path']:x for x in old['files']if not x['path'].startswith('claims/')};b={x['path']:x for x in new['files']if not x['path'].startswith('claims/')};assert a.keys()==b.keys()
hashes={}
for rel,x in b.items():
 h=H(Path(x['local']));assert h==H(Path(a[rel]['local'])),rel;hashes[rel]=h
assert old['pre_source_payload']==new['pre_source_payload']
new['verified_source_seal']=old['pre_source_payload']['complete_branch_pre_source_seal_hash']
(w/'absolute1281_resolved_input.json').write_text(json.dumps(new,ensure_ascii=False)+'\n')
(w/'absolute1281_reused_source_evidence.json').write_text(json.dumps(dict(status='PASS',prior_full_native='efficacy1277_empirical_report.json',shared_module_sha256=report['source_sha256'],same_registered_input_files=hashes,same_pre_source_payload=True,source_label_rebinding='SFT.Medicine.AbsoluteRelativeEffectSource.sourceDerivedTarget',binding='Identical original ICH requirements; original family source delegates to EfficacySource; only original claim-specific observed label differs'),indent=2)+'\n')
print('Reused actual full native Efficacy source/seal with identical bytes and binding',flush=True)

counts=json.loads((w/'accuracy1252_counts_report.json').read_text());assert counts['status']=='PASS'
for rel,h in counts['source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h
assert counts['certificate_fields_each']==6 and counts['ordered_cells_each']==4
