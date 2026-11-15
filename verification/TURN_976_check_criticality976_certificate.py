from pathlib import Path
import sys,json,os,subprocess,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import coupled_map_criticality_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
p=w/'constants-recovery/CriticalityCertificate976.lean';p.write_text('import SFT.Physics.CoupledMapCriticalityEvidence\nopen SFT.Physics CoupledMapCriticalityCertificate CoupledMapCriticalityEvidence SFT.Host.Canonical\n#eval IO.println (render (match criticalityCertificate with | .ok c => certificateValue c | .error e => .text e))\n');out=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);assert json.loads(out)==canonical_value(src.criticality_certificate())
mods=['CoupledMapCriticality','CoupledMapCriticalityCertificate','CoupledMapCriticalityGeneral','CoupledMapCriticalityGrammar','CoupledMapCriticalityEvidence','CriticalityPrediction','CriticalityRecords','CriticalityExperiment','CriticalityMeasurement','CriticalityValidation'];ds=[];hashes={}
for m in mods:
 p=r/f'SFT/Physics/{m}.lean';hashes[m]=hashlib.sha256(p.read_bytes()).hexdigest();ds+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',p.read_text(),re.M)]
p=w/'constants-recovery/CriticalityAudit976.lean';p.write_text('import SFT.Physics.CoupledMapCriticalityGeneral\nimport SFT.Physics.CriticalityValidation\n'+'\n'.join('#print axioms '+d for d in ds));out=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'criticality976_staged_audit.log').write_text(out);bad=[d for d in ds if "'"+d+"' does not depend on any axioms" not in out];assert not bad,bad
(w/'criticality976_certificate_report.json').write_text(json.dumps(dict(status='PASS',entire_original_certificate=True,fields=5,source_sha256=hashes,declarations=ds,axioms=[]),indent=2));print('PASS five-field certificate;',len(ds),'empty declarations')
