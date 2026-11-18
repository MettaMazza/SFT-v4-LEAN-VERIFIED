from pathlib import Path
import json,ast
w=Path('work');r=w/'turn1064_recovery';entries=json.loads((w/'medicine1277_entries.json').read_text())
# First entry performs fresh full native extraction of its three original fragments.
s=(w/'check_patient1234_empirical.py').read_text().replace('patient1234','efficacy1277').replace('PatientIdentity','Efficacy').replace('1234','1277').replace("'EfficacySeal',",'').replace("'bound_fragments':2","'bound_fragments':3")
(w/'check_efficacy1277_empirical.py').write_text(s)
# Source/seal reuse for first entry is restricted to the already checked shared seal.
s='''from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';a=json.loads((w/'patient1234_empirical_report.json').read_text());assert a['status']=='PASS'
p='SFT/Medicine/PatientIdentitySeal.lean';h=a['source_sha256'][p];assert hashlib.sha256((r/p).read_bytes()).hexdigest()==h
old=json.loads((w/'patient1234_empirical_input.json').read_text());new=json.loads((w/'efficacy1277_empirical_input.json').read_text());assert old['pre_source_payload']==new['pre_source_payload']
(w/'efficacy1277_reused_source_evidence.json').write_text(json.dumps(dict(status='PASS',shared_module_sha256={p:h},same_pre_source_payload=True,scope='Only existing Medicine pre-source seal reused. Efficacy performs its own three-fragment source extraction and full native empirical comparison.'),indent=2)+'\\n')
''';(w/'prepare_efficacy1277_reuse.py').write_text(s)
for tag,mod,cid in entries[1:]:
 p=w/('prepare_'+tag+'_reuse.py');s=p.read_text().replace('patient1234','efficacy1277').replace('PatientIdentity','Efficacy').replace('WHO/ICH','ICH');p.write_text(s)
 p=w/(mod+'ResolvedProgram'+tag[-4:]+'.lean');p.write_text(p.read_text().replace('SFT.Medicine.PatientIdentitySource.lookup','SFT.Medicine.EfficacySource.lookup'))
for tag,mod,cid in entries:
 p=w/('register_'+tag+'.py');s=p.read_text().replace('Original WHO/ICH family requirements exactly equal PatientIdentity; delegate its unchanged native source operation,retaining extraction receipt and rebinding only original observed label.','Original three FDA/ICH requirements; retain rights, safety and well-being; population-level summary; and Adverse effects in original order. '+('Perform fresh full native source validation and extraction.'if tag=='efficacy1277'else'Delegate unchanged EfficacySource extraction,retaining its receipt and original claim-specific observed label.'))
 marker="ind=json.loads((w/'"+tag+"_independent_report.json').read_text());"
 s=s.replace(marker,"reuse=json.loads((w/'"+tag+"_reused_source_evidence.json').read_text())\nfor rel,h in reuse['shared_module_sha256'].items():assert H(r/rel)==h,rel\n"+marker)
 ast.parse(s);p.write_text(s)
for tag,mod,cid in entries:
 for p in w.glob('*'+tag+'*.py'):ast.parse(p.read_text())
print('Six entry checks prepared;119first/113each remaining declarations; distinct source extraction and exact reuse guarded.')
