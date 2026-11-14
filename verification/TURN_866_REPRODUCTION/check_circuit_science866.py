from pathlib import Path
import subprocess,json,os,hashlib
ns={};exec(Path('work/circuit_spec866.py').read_text(),ns);src=ns['ns'];r=Path('work/constants-recovery').resolve();p=subprocess.Popen(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'NativeCircuitScience866.lean')],stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')));digest=hashlib.sha256();count=0

def compare(expected):
 global count
 line=p.stdout.readline();assert line,p.stderr.read();a=json.loads(line);expected=json.loads(json.dumps(expected));assert a==expected,(count,a,expected);digest.update(line.encode());count+=1
edges=src['forced_edges'](14)
for edge in edges:compare(dict(edge=edge))
for d in range(1,15):compare(dict(depth=d,resources=src['circuit_resources'](d)))
small=src['forced_edges'](3);full=frozenset(small);survivors=[]
for mask in range(1<<len(small)):
 selected=[e for i,e in enumerate(small) if mask&(1<<i)];accepted=frozenset(selected)==full
 compare(dict(mask=mask,selected=selected,accepted=accepted))
 if accepted:survivors.append(mask)
for d in [-2,-1,0,1,2,14]:
 try: expected=dict(ok=src['circuit_resources'](d))
 except ValueError as e:expected=dict(error=str(e))
 compare(expected)
assert p.stdout.read()=='';assert p.wait()==0,p.stderr.read();assert survivors==[16383]
v=dict(status='PASS',source_commit=ns['pin'],ordered_forced_edges=len(edges),resource_depths=14,complete_subsets=16384,survivors=survivors,domain_cases=6,actual_output_sha256=digest.hexdigest(),source_functions=['words_at_depth','forced_edges','circuit_resources','exhaustive_edge_subset_survivors']);Path('work/circuit866_science_report.json').write_text(json.dumps(v,indent=2));print(json.dumps(v))
