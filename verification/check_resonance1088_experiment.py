from pathlib import Path
import json,subprocess,os,re,hashlib
w=Path('work');r=w/'turn1064_recovery'
p=w/'ResonanceExperimentProgram1088.lean'
p.write_text('''import SFT.Chemistry.ResonanceEquivalentExperiment
open SFT.Host SFT.Chemistry.ResonanceEquivalentExperiment
''')
doc=json.loads((w/'resonance1088_prediction_output.json').read_text())
def cv(x):
 if isinstance(x,str):return '.text '+json.dumps(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(cv(v)for v in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+json.dumps(k)+','+cv(v)+')'for k,v in x.items())+']'
 raise TypeError(x)
with p.open('a')as f:f.write('def document : Canonical.Value := '+cv(doc)+'\ndef main : IO Unit := do\n IO.ofExcept validateSpec\n IO.println (Canonical.render (registration document))\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with (w/'resonance1088_experiment_output.json').open('w')as out,(w/'resonance1088_experiment_execution.log').open('w')as err:
 subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
assert json.loads((w/'resonance1088_experiment_output.json').read_text())==json.loads((w/'resonance1088_original_registration.json').read_text())
s=(w/'resonance1088_experiment_build.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",s);assert len(names)==18 and 'depends on axioms:'not in s
(w/'resonance1088_experiment_report.json').write_text(json.dumps(dict(status='PASS',native_spec_admission=True,all_registration_fields_match=True,declarations=names,axioms=[],source_sha256=hashlib.sha256((r/'SFT/Chemistry/ResonanceEquivalentExperiment.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS original registration, native spec admission;18 declarations empty axioms')
