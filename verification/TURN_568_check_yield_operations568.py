from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/yield_spec568.py').read_text(),ns);sc=ns['namespace'];cases=[(n,d) for d in range(1,9) for n in range(1,d+1)]+[(1,1000000007),(1000000006,1000000007)]
expected=[]
for n,d in cases:
 p=sc['ExactPart'].from_pair(n,d);out=sc['exact_yield'](p);assert out is p;expected.append([out.value.numerator,out.value.denominator])
s='import SFT.Chemistry.ProductYield\nopen SFT.Chemistry.ProductYield SFT.Foundation.ExactOperations\ndef main : IO Unit := do\n'
for n,d in cases:s+=' let p := exactYield (normalizePart '+str(n)+' '+str(d)+' (by decide) (by decide))\n IO.println ("[" ++ toString p.numerator ++ "," ++ toString p.denominator ++ "]")\n'
r=Path('work/constants-recovery').resolve();(r/'YieldOperations568.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','YieldOperations568.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/yield_operations568.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected
Path('work/yield_operations568_report.json').write_text(json.dumps(dict(status='PASS',source_commit=ns['pin'],cases=len(cases),results=actual,fresh_native_execution=True,compares='exact_yield identity on admitted original ExactPart domain'),indent=2));print('PASS',len(cases),'original yield operation cases')
