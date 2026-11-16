from pathlib import Path
import json,re,hashlib,subprocess,os
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');mod='ThermalEquilibriumEnumeration';p=r/f'SFT/Physics/{mod}.lean';names=['SFT.Physics.'+mod+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',p.read_text(),re.M)];a=w/'equilibrium1039_enumeration_audit.lean';a.write_text('import SFT.Physics.'+mod+'\n'+''.join('#print axioms '+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(a.resolve())],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'equilibrium1039_enumeration_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'equilibrium1039_enumeration_report.json').write_text(json.dumps(dict(status='PASS',declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),source_operations=['fixed_count_throw_forms','canonical_maximum_certificate'],scope='Full original walk soundness/completeness/no duplicates; every fixed-count/fixed-throw vector retained; exact source maximum fold and unique survivor list; complete four-field certificate for every level count L>=2'),indent=2)+'\n')
modules=['ThermalEquilibriumResponse','ThermalEquilibriumResponseCertificate','ThermalEquilibriumNoise','ThermalEquilibriumWeights','ThermalEquilibriumTemperature','ThermalEquilibriumPaired','ThermalEquilibriumMultinomial','ThermalEquilibriumEnumeration','ThermalEquilibriumCertificateProof']+['ThermalEquilibriumMaximum'+str(i)for i in range(2,6)]+['ThermalEquilibriumResponseGrammarBase']+['ThermalEquilibriumResponseCensus'+str(i)for i in range(16)]+['ThermalEquilibriumResponseGrammar','ThermalEquilibriumResponseWitnesses','ThermalEquilibriumResponseEntryEvidence']
verified={};logs=[]
def receipt(file,log,single=None):
 d=json.loads((w/file).read_text());assert d['status']=='PASS';h=d['source_sha256']
 if isinstance(h,str):verified[single]=h
 else:
  for m,v in h.items():verified[Path(m).stem if '/'in m else m]=v
 logs.append((w/log).read_text())
receipt('equilibrium1035_core_report.json','equilibrium1035_audit.log','ThermalEquilibriumResponse')
receipt('equilibrium1035_staged_report.json','equilibrium1035_staged_audit.log')
receipt('equilibrium1036_weights_report.json','equilibrium1036_weights_audit.log','ThermalEquilibriumWeights')
receipt('equilibrium1036_temperature_report.json','equilibrium1036_temperature_audit.log','ThermalEquilibriumTemperature')
receipt('thermalequilibrium1036_grammar_audit.json','thermalequilibrium1036_grammar_audit.log')
receipt('thermalequilibrium1036_entry_audit.json','thermalequilibrium1036_entry_audit.log')
receipt('equilibrium1039_multinomial_report.json','equilibrium1039_multinomial_audit.log')
receipt('equilibrium1039_enumeration_report.json','equilibrium1039_enumeration_audit.log','ThermalEquilibriumEnumeration')
names=[];ths=[];defs=[];hashes={}
for m in modules:
 p=r/f'SFT/Physics/{m}.lean';body=p.read_text();h=hashlib.sha256(p.read_bytes()).hexdigest();assert h==verified[m],m;hashes[m]=h;assert not re.search(r'\bsorry\b|^\s*axiom\b',body,re.M);ns=re.search(r'^namespace (\S+)',body,re.M)[1];names +=[ns+'.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M)];ths +=[ns+'.'+n for n in re.findall(r'^theorem (\w+)',body,re.M)];defs +=[ns+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',body,re.M)]
audit='\n'.join(logs);assert all("'"+n+"' does not depend on any axioms"in audit for n in names)
(w/'thermalequilibrium1039_full_audit.log').write_text(audit)
checks=['equilibrium1035_core_report.json','equilibrium1035_certificate_report.json','equilibrium1035_maximum_report.json','equilibrium1036_weights_report.json','equilibrium1036_temperature_report.json','thermalequilibrium1036_grammar_comparison.json','thermalequilibrium1036_program_report.json','thermalequilibrium1036_fresh_report.json','equilibrium1039_multinomial_report.json','equilibrium1039_enumeration_report.json']
for f in checks:assert json.loads((w/f).read_text())['status']=='PASS',f
cfg=dict(modules=modules,declarations=names,theorems=ths,definitions_and_theorems=defs,source_sha256=hashes,checks=checks,check_sha256={f:hashlib.sha256((w/f).read_bytes()).hexdigest()for f in checks},reuse='Unchanged source-bound audits retained; only changed paired/multinomial and new enumeration declarations audited this turn')
(w/'thermalequilibrium1039_proofs_config.json').write_text(json.dumps(cfg,indent=2)+'\n');print('PASS full entry:',len(modules),'modules',len(names),'declarations',len(ths),'theorems;all zero axioms')
