from pathlib import Path
import sys,os,subprocess,importlib.util,dataclasses,json,hashlib,itertools
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()));source=w/'pinned1140/sft/chemistry/radiotracer_custody_law_v1.py'
spec=importlib.util.spec_from_file_location('radiotracer_source1140',source);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def loss(x):return 'empty-One'if x==m.EMPTY_ONE else str(x.value)
def display(r):return f'{r[0].label},{r[1].numerator}/{r[1].denominator},{loss(r[2])}'
expected=[]
for rank,observed,administered in itertools.product(range(1,4),range(1,6),range(1,6)):
 try:x=m._row(rank,observed,administered,'place');out=display((x.location,x.recovery,x.unobserved))
 except m.InadmissibleExactValue:out='error'
 expected.append(f'row:{rank},{observed},{administered}:{out}')
a,b=m._rows;c=m._row(3,5,5,'terminal');wrong=m.HeldLabel('radiotracer','other');carrier=m.HeldLabel('chemical-carrier','other')
for rows in [(),(a,),(a,b),(a,b,c),(b,),(b,a),(a,c),(a,dataclasses.replace(b,tracer=wrong)),(a,dataclasses.replace(b,chemical_carrier=carrier)),(a,a)]:
 try:out=';'.join(map(display,m.tracer_record(rows)))
 except m.InadmissibleExactValue:out='error'
 expected.append('record:'+out)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/RadiotracerParity1140.lean'],env=env,capture_output=True,text=True)
(w/'radiotracer1140_parity.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1000:]+p.stderr[-500:];actual=p.stdout.splitlines();assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:3]
(w/'radiotracer1140_core_report.json').write_text(json.dumps({'status':'PASS','original_observation_cases':75,'ordered_record_cases':10,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'native_sha256':hashlib.sha256((r/'SFT/Chemistry/RadiotracerCustody.lean').read_bytes()).hexdigest()},indent=2));print('PASS75observation cases/10record cases')
