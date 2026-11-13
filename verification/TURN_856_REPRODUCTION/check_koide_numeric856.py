from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/koide_interval_spec856.py').read_text(),ns)
F=ns['Fraction'];source=Path(ns['repo'])/ns['namespace']['SOURCE_PATH'];original=ns['namespace']
values=[(F(n,d),depth) for n,d,depth in [(0,1,160),(-1,1,160),(1,1,0),(1,1,-2),(1,1,1),(2,1,160),(9,4,160),(1,3,8),(100,7,32),(2067682827,10000000,160)]]
def rat(v):return '(LeptonIntervals.normalize ('+str(v.numerator)+') '+str(v.denominator)+' (by decide))'
def result(v):return ['ok',str(v[0]),str(v[1])]
expected=[];expr=[]
for v,d in values:
 try:expected.append(result(original['positive_sqrt_interval'](v,d)))
 except ValueError as e:expected.append(['error','ValueError: '+str(e)])
 expr.append('encode (KoideEnclosure.positiveSqrtInterval '+rat(v)+' ('+str(d)+'))')
expected.append(result(original['koide_source_interval'](source)))
expr.append('encode (KoideComparison.sourceIntervalRows LeptonSource.snapshotRows)')
p=Path('work/KoideNumeric856.lean');p.write_text('''import SFT.Physics.KoideComparison
open SFT.Physics SFT.Host.Canonical
def encode (x : Except String (Rat × Rat)) : Value := match x with
 | .error e => .array [.text "error",.text e]
 | .ok (a,b) => .array [.text "ok",.text (toString a.num ++ (if a.den == 1 then "" else "/" ++ toString a.den)),.text (toString b.num ++ (if b.den == 1 then "" else "/" ++ toString b.den))]
#eval render (.array ['''+','.join(expr)+'''])
#eval KoideComparison.validateRows LeptonSource.snapshotRows
''')
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()))
r=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],text=True,capture_output=True,env=env);Path('work/koide_numeric856_output.log').write_text(r.stdout+r.stderr);r.check_returncode();actual=json.loads(json.loads(r.stdout.splitlines()[0]));assert actual==expected,(actual,expected);assert 'Except.ok true' in r.stdout,r.stdout
report={'status':'PASS','source_commit':ns['pin'],'sqrt_cases':len(values),'full_source_interval_exact_match':True,'both_complete_source_rows':True,'sealed_two_thirds_inside':True,'actual':actual,'expected':expected};Path('work/koide_numeric856_report.json').write_text(json.dumps(report,indent=2));print({k:v for k,v in report.items() if k not in ['actual','expected']})
