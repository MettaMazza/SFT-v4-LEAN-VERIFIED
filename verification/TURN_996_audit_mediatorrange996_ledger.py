from pathlib import Path
import re,subprocess,os,json,hashlib,shutil
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');m='MediatorRangeChannelLedger';p=r/f'SFT/Physics/{m}.lean';s=p.read_text();names=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)];audit=w/'mediatorrange996_ledger_audit.lean';audit.write_text('import SFT.Physics.MediatorRangeChannelLedger\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(audit)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'mediatorrange996_ledger_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
cfg=json.load(open(w/'mediatorrange995_all_proofs_config.json'))
for mod,sha in cfg['source_sha256'].items():assert hashlib.sha256((r/f'SFT/Physics/{mod}.lean').read_bytes()).hexdigest()==sha,mod
cfg['modules'].append(m);cfg['source_sha256'][m]=hashlib.sha256(p.read_bytes()).hexdigest()
for key in ['declarations','theorems','definitions_and_theorems']:cfg[key]+=names
shutil.copy2(p,w/f'constants-recovery/SFT/Physics/{m}.lean');(w/'mediatorrange996_all_proofs_config.json').write_text(json.dumps(cfg,indent=2));(w/'mediatorrange996_all_audit.log').write_text((w/'mediatorrange995_all_audit.log').read_text()+x.stdout);print('PASS',len(names),'new emptytheorems;',len(cfg['declarations']),'totalauditeddeclarations; retainedunchanged144')
