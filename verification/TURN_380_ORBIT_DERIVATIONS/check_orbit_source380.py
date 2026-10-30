from pathlib import Path
import ast,subprocess,math,json,hashlib,os
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform';src='sft/mathematics/lineage_laws.py'
raw=subprocess.check_output(['git','-C',repo,'show',pin+':'+src]);tree=ast.parse(raw);ns={'gcd':math.gcd};nodes=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in ['_fold_rank','_order_two','_orbit']];exec(compile(ast.fix_missing_locations(ast.Module(body=nodes,type_ignores=[])),'pinned-orbit-functions','exec'),ns)
root=Path('work/constants-recovery').resolve()
env=dict(os.environ,LEAN_PATH=str(root/'.lake/build/lib/lean'))
fresh=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048','--run',str(root/'OrbitSourceCheck380.lean')],env=env,text=True)
Path('work/orbit_source380_native.tsv').write_text(fresh)
expected=[(p,q,ns['_order_two'](q),list(ns['_orbit'](p,q))) for q in range(3,100,2) for p in range(1,q) if math.gcd(p,q)==1];actual=[]
for line in Path('work/orbit_source380_native.tsv').read_text().splitlines():
 p,q,order,trace=line.split('\t');actual.append((int(p),int(q),int(order),ast.literal_eval(trace)))
assert actual==expected
report=dict(status='PASS',fresh_native_lean_execution=True,source_commit=pin,source_path=src,source_sha256=hashlib.sha256(raw).hexdigest(),complete_reduced_rank_cases=len(actual),ordered_trace_positions=sum(len(row[3]) for row in actual),denominators=49,scope='Fresh native complete ordered orbit trace and binary-order value for every original reduced rank through odd denominator99; all fields match unchanged pinned Python functions.')
Path('work/orbit_source380_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
