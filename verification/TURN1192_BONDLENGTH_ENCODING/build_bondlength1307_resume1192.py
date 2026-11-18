import os,subprocess,json,re,hashlib
from pathlib import Path
root=Path('work/turn1064_recovery');env=dict(os.environ);env['LEAN_PATH']=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'])
lean=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')
for module in ['EquilibriumBondLength','EquilibriumBondLengthEvidence','EquilibriumBondLengthExperiment','EquilibriumBondLengthSource','EquilibriumBondLengthValidation']:
 p=root/'SFT/Chemistry'/f'{module}.lean'
 with open('work/'+module+'1307_build.log','w') as log:
  subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 print(module+' compiled',flush=True)
mods=['EquilibriumBondLength','EquilibriumBondLengthGrammar','EquilibriumBondLengthEvidence','EquilibriumBondLengthExperiment','EquilibriumBondLengthSource','EquilibriumBondLengthValidation'];names=[]
for m in mods:
 s=(root/'SFT/Chemistry'/f'{m}.lean').read_text()
 names += ['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^(?:def|theorem)\s+(\w+)',s,re.M)]
p=Path('work/EquilibriumBondLengthAudit1307.lean');p.write_text('\n'.join('import SFT.Chemistry.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n')
with open('work/bondlength1307_entry_audit.log','w') as log:subprocess.run(['python3','work/run_lean_guarded.py',lean,'-j1','-M8192',str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
s=Path('work/bondlength1307_entry_audit.log').read_text();assert s.count('does not depend on any axioms')==len(names),(len(names),s[-3000:]);assert 'depends on axioms'not in s
Path('work/bondlength1307_entry_audit_report.json').write_text(json.dumps({'status':'PASS','declarations':names,'count':len(names),'source_sha256':{m:hashlib.sha256((root/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest() for m in mods}},indent=2)+'\n')
print('PASS '+str(len(names))+' empty-axiom declarations',flush=True)

a=json.loads(Path('work/bondlength1307_entry_audit_report.json').read_text())
a['source_sha256']={'SFT/Chemistry/'+m+'.lean':h for m,h in a['source_sha256'].items()}
Path('work/bondlength1307_full_audit_report.json').write_text(json.dumps(a,indent=2)+'\n')
for check in ['check_bondlength1307_core.py','check_bondlength1307_experiment.py','check_bondlength1307_empirical.py']:
 print('START '+check,flush=True);subprocess.run(['python3','work/'+check],check=True)
