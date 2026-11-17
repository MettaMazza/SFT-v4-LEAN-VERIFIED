from pathlib import Path
import sys,os,subprocess,importlib.util,dataclasses,json,hashlib,itertools
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));source=w/'pinned1120/sft/chemistry/kinetic_isotope_fractionation_law_v1.py'
spec=importlib.util.spec_from_file_location('kinetic_source1140',source);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def value(x):return 'empty-One'if x==m.EMPTY_ONE else str(x.value)if isinstance(x,m.PositiveCount)else x.label
def ratio(x):return f'{x.numerator}/{x.denominator}'
def display(x):return ','.join([ratio(x[0]),ratio(x[1]),ratio(x[2]),value(x[3])])
expected=[]
for rank,lp,hp in itertools.product(range(1,4),range(1,10),range(1,10)):
 try:x=m._row(rank,lp,hp);out=display((x.light_rate,x.heavy_rate,x.factor.fraction,x.orientation))+','+','.join(map(value,x.remaining))
 except m.InadmissibleExactValue:out='error'
 expected.append(f'row:{rank},{lp},{hp}:{out}')
a,b=m._rows;c=m._row(3,8,8);wrong=m.HeldLabel('reaction-path','other')
for rs in [(),(a,),(a,b),(a,b,c),(b,),(b,a),(a,c),(a,dataclasses.replace(b,reaction=wrong))]:
 try:out=';'.join(map(display,m.time_series(rs)))
 except m.InadmissibleExactValue:out='error'
 expected.append('series:'+out)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/KineticParity1140.lean'],env=env,capture_output=True,text=True)
(w/'kinetic1140_parity.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1000:]+p.stderr[-500:];actual=p.stdout.splitlines();assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:3]
(w/'kinetic1140_core_report.json').write_text(json.dumps({'status':'PASS','interval_cases':243,'series_cases':8,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'native_sha256':hashlib.sha256((r/'SFT/Chemistry/KineticIsotopeFractionation.lean').read_bytes()).hexdigest()},indent=2));print('PASS243interval/8series cases')
