from pathlib import Path
import time,json,re,subprocess,os,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');needed=['calculator1015_program_report.json','calculator1015_fresh_report.json','calculator1015_independent_report.json','calculator1015_witness_proofs_report.json']
while not all((w/name).exists() for name in needed):time.sleep(5)
assert all(x['exit']==0 for x in json.loads((w/needed[-1]).read_text()))
for name in needed[:2]:assert json.loads((w/name).read_text())['status']=='PASS'
mods=['CalculatorStatisticsV3','CalculatorFunctionsV3','CalculatorInverseV3','CalculatorMachineV3','CalculatorSession','CalculatorDisplay','CalculatorGUI','CalculatorLayout','CalculatorTerminal','CalculatorInputV3']+sorted(p.stem for p in (r/'SFT/Mathematics').glob('CalculatorV3*.lean'))
# Reuse hashes and comparisons bound to the exact represented operation sources.
for turn,part,mod in [(1014,'statistics','CalculatorStatisticsV3'),(1014,'functions','CalculatorFunctionsV3'),(1014,'inverse','CalculatorInverseV3'),(1015,'machine','CalculatorMachineV3'),(1015,'session','CalculatorSession'),(1015,'display','CalculatorDisplay'),(1015,'gui','CalculatorGUI'),(1015,'witnesses','CalculatorV3Witnesses'),(1015,'evidence','CalculatorV3Evidence'),(1016,'terminal','CalculatorTerminal'),(1016,'layout','CalculatorLayout'),(1016,'input','CalculatorInputV3')]:
 report=json.loads((w/f'calculator{turn}_{part}_report.json').read_text());assert report['status']=='PASS' and report['source_sha256']==hashlib.sha256((r/f'SFT/Mathematics/{mod}.lean').read_bytes()).hexdigest()
for mod,sha in json.loads((w/'calculator1015_grammar_report.json').read_text())['source_sha256'].items():assert sha==hashlib.sha256((r/f'SFT/Mathematics/{mod}.lean').read_bytes()).hexdigest()
decl=[];th=[];defs=[];hashes={}
for mod in mods:
 p=r/f'SFT/Mathematics/{mod}.lean';s=p.read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];hashes[mod]=hashlib.sha256(p.read_bytes()).hexdigest()
 for kind,name in re.findall(r'^\s*(def|theorem|abbrev|structure|inductive) (\w+)',s,re.M):
  full=ns+'.'+name;decl.append(full)
  if kind=='theorem':th.append(full)
  if kind in ['def','theorem','abbrev']:defs.append(full)
p=w/'AuditCalculator1016.lean';p.write_text(''.join('import SFT.Mathematics.'+m+'\n' for m in mods)+''.join('#print axioms '+n+'\n' for n in decl));x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'calculator1016_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms" in x.stdout for n in decl)
(w/'calculator1016_proofs_config.json').write_text(json.dumps(dict(modules=mods,declarations=decl,theorems=th,definitions_and_theorems=defs,source_sha256=hashes),indent=2))
subprocess.run(['python3',str(w/'register_calculator1016.py')],check=True)
