from pathlib import Path
import json,ast,copy,tempfile,subprocess,os
from fractions import Fraction
ns={};exec(Path('work/interval_spec644.py').read_text(),ns);space=ns['namespace'];raw=ns['raw'];q=lambda x:json.dumps(x,ensure_ascii=False)
class Blind:
 def __init__(self,*args):pass
 def validate(self,sealed):return 'delegated'
space.update(json=json,Path=Path,BlindExternalMeasurementValidator=Blind)
tree=ast.parse(raw('sft/physics/inverse_square_validation.py'));node=next(n for n in tree.body if isinstance(n,ast.ClassDef) and n.name=='InverseSquareExternalValidator');exec(compile(ast.Module(body=[node],type_ignores=[]),'pinned-validator','exec'),space)
base=json.loads(raw(space['SOURCE_PATH']));cases=[]
for name in ['original','uppercase_doi','changed_source','changed_doi','additional_exponents','no_two','lower_zero','negative_lower','reversed','source_precedence','doi_precedence']:
 d=copy.deepcopy(base);inter=d['reported_observation']['positive_exponent_interval']
 if name=='uppercase_doi':d['doi']=d['doi'].upper()
 if name in ['changed_source','source_precedence']:d['source_id']='changed'
 if name in ['changed_doi','doi_precedence','source_precedence']:d['doi']='changed'
 if name=='additional_exponents':inter['lower']={'numerator':1,'denominator':1};inter['upper']={'numerator':3,'denominator':1}
 if name=='no_two':inter['lower']={'numerator':3,'denominator':1};inter['upper']={'numerator':4,'denominator':1}
 if name in ['lower_zero','source_precedence','doi_precedence']:inter['lower']={'numerator':0,'denominator':1}
 if name=='negative_lower':inter['lower']={'numerator':-1,'denominator':1}
 if name=='reversed':inter['lower'],inter['upper']=inter['upper'],inter['lower']
 with tempfile.TemporaryDirectory() as tmp:
  path=Path(tmp)/space['SOURCE_PATH'];path.parent.mkdir(parents=True);path.write_text(json.dumps(d))
  try:space['InverseSquareExternalValidator'](Path(tmp)).validate(None);expected='ok'
  except Exception as e:expected=type(e).__name__+': '+str(e)
 def rat(x):return '(SFT.Physics.LeptonIntervals.normalize ('+str(x['numerator'])+') '+str(x['denominator'])+' (by decide))'
 record='⟨'+rat(inter['lower'])+','+rat(inter['upper'])+','+q(d['source_id'])+','+q(d['doi'])+'⟩'
 cases.append((name,record,expected))
s='import SFT.Physics.InverseSquareIntervalSource\nimport SFT.Physics.LeptonIntervals\nopen SFT.Physics.InverseSquareIntervalSource\ndef main : IO Unit := do\n'
for name,record,expected in cases:s+=' IO.println (match precheck '+record+' with | .ok _ => "ok" | .error e => e)\n'
p=Path('work/constants-recovery/IntervalSourceCases645.lean');p.write_text(s);env=dict(os.environ,LEAN_PATH=str(p.parent.resolve()/'.lake/build/lib/lean'));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run',p.name],cwd=p.parent,env=env,text=True,capture_output=True);Path('work/interval645_source_cases.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==[c[2] for c in cases],o.stdout;Path('work/interval645_source_cases_report.json').write_text(json.dumps(dict(status='PASS',source_commit=ns['pin'],cases=[c[0] for c in cases],comparison='Actual pinned InverseSquareExternalValidator.validate; unchanged blind-validator delegation stubbed only after precheck'),indent=2));print('PASS',len(cases),'original source-record prechecks')
