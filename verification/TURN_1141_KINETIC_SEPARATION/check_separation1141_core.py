from pathlib import Path
import sys,os,subprocess,importlib.util,json,hashlib,itertools
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));source=w/'pinned1140/sft/chemistry/radiochemical_separation_law_v1.py'
spec=importlib.util.spec_from_file_location('separation_source1141',source);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def loss(x):return 'empty-One'if x==m.EMPTY_ONE else str(x.value)
def make(ft,fc,pt,pc,wt,wc,t='Sc',c='V'):return m.SeparationLedger(m.HeldLabel('target-species',t),m.HeldLabel('contaminant-species',c),*(m.PositiveCount(n)for n in [ft,fc,pt,pc,wt,wc]))
def display(l):
 a=l.recovery;b=l.decontamination_factor
 return f'{a.numerator}/{a.denominator},{b.numerator}/{b.denominator},{loss(l.complete_recovery)}'
expected=[]
for pt,pc,wt,wc,delta in itertools.product(range(1,4),range(1,4),range(1,4),range(1,4),range(2)):
 try:out=display(make(pt+wt+delta,pc+wc,pt,pc,wt,wc))
 except m.InadmissibleExactValue:out='error'
 expected.append(f'ledger:{pt},{pc},{wt},{wc},{delta}:{out}')
for f,p in itertools.product(range(1,6),repeat=2):
 try:out=loss(m.residual_custody(m.PositiveCount(f),m.PositiveCount(p)))
 except m.InadmissibleExactValue:out='error'
 expected.append(f'residual:{f},{p}:{out}')
try:out=display(make(10,12,8,2,2,10,'Sc','Sc'))
except m.InadmissibleExactValue:out='error'
expected.append('same-label:'+out)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/SeparationParity1141.lean'],env=env,capture_output=True,text=True)
(w/'separation1141_parity.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1000:]+p.stderr[-500:];assert p.stdout.splitlines()==expected
(w/'separation1141_core_report.json').write_text(json.dumps({'status':'PASS','ledger_cases':162,'residual_cases':25,'same_label_rejection':True,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'native_sha256':hashlib.sha256((r/'SFT/Chemistry/RadiochemicalSeparation.lean').read_bytes()).hexdigest()},indent=2));print('PASS188 original source outcomes')
