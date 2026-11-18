from pathlib import Path
import json,sys,ast
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1307/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.equilibrium_bond_length_law_v1 import equilibrium_length_multiplier
from sft.chemistry.equilibrium_bond_length_validation_v1 import _fraction
names=['H2','D2','HD','','h2','H2 '];pairs=[(1,2),(2,4),(-2,-4),(-1,2),(0,1),(1,0),(True,True),(1,False)];expected=[]
for f,a in [(equilibrium_length_multiplier,n)for n in names]+[(_fraction,dict(numerator=n,denominator=d))for n,d in pairs]:
 try:v=f(a);expected.append(['ok',v.numerator,v.denominator])
 except Exception as e:expected.append(['error',str(e)])
(w/'bondlength1307_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n');q=lambda s:json.dumps(s,ensure_ascii=False)
def value(n):return '.boolean '+str(n).lower() if isinstance(n,bool)else '.integer ('+str(n)+')'
s='''import SFT.Chemistry.EquilibriumBondLengthSource
open SFT.Host.Canonical SFT.Chemistry
def encode : Except String Rat → Value
 | .ok q => .array [.text "ok",.integer q.num,.integer (Int.ofNat q.den)]
 | .error e => .array [.text "error",.text e]
def main : IO Unit := do
 IO.println (render (.array [\n'''
s+=',\n'.join(['encode (EquilibriumBondLength.equilibriumLengthMultiplier '+q(n)+')'for n in names]+['encode (EquilibriumBondLengthSource.fraction (.object [("numerator",'+value(n)+'),("denominator",'+value(d)+')]))'for n,d in pairs])+']))\n';(w/'EquilibriumBondLengthCoreProgram1307.lean').write_text(s)
s=(w/'check_bondlength1307_experiment.py').read_text();s=s[:s.index('from sft.chemistry.equilibrium_bond_length_validation_v1 import prediction_program_document')]+'''expected=json.loads((w/'bondlength1307_core_expected.json').read_text())
p=subprocess.run(lean+['--run','work/EquilibriumBondLengthCoreProgram1307.lean'],env=env,capture_output=True,text=True)
(w/'bondlength1307_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1000:]+p.stderr[-500:]
actual=json.loads(p.stdout);assert actual==expected
(w/'bondlength1307_core_report.json').write_text(json.dumps(dict(status='PASS',original_cases=len(expected),all_fields_match=True,source_sha256={str(p.relative_to(root)):hashlib.sha256(p.read_bytes()).hexdigest()for p in [root/'SFT/Chemistry/EquilibriumBondLength.lean',root/'SFT/Chemistry/EquilibriumBondLengthSource.lean']}),indent=2)+'\\n')
print('PASS14original isotope/fraction domain and normalization cases',flush=True)
''';ast.parse(s);(w/'check_bondlength1307_core.py').write_text(s)
p=w/'build_bondlength1307.py';s=p.read_text()+'''\na=json.loads(Path('work/bondlength1307_entry_audit_report.json').read_text())
a['source_sha256']={'SFT/Chemistry/'+m+'.lean':h for m,h in a['source_sha256'].items()}
Path('work/bondlength1307_full_audit_report.json').write_text(json.dumps(a,indent=2)+'\\n')
subprocess.run(['python3','work/check_bondlength1307_core.py'],check=True)
''';ast.parse(s);p.write_text(s)
print('Prepared14fresh original guard cases and native comparison; six-module audit reused as full report without another run.')
