from pathlib import Path
import json,itertools,subprocess,os
ns={};exec(Path('work/metallic_spec573.py').read_text(),ns);original=ns['namespace']['connected_collective_support'];cases=[]
labels=['A','B','C'];edges=[(a,b) for a in labels for b in labels if a!=b]
for ids in itertools.permutations(labels):
 for mask in range(64):cases.append((list(ids),[e for i,e in enumerate(edges) if mask & (1<<i)]))
cases += [([],[]),(['A'],[]),(['A'],[('A','A')]),(['A','A'],[('A','A')]),(['A','B'],[('A','B'),('A','B')]),(['','B'],[('','B')]),(['A','B'],[('A','C')]),(['A','B'],[('A','A'),('A','B')]),(['A','B','C','D'],[('A','B'),('C','D')]),(['A','B','C','D'],[('C','D'),('B','C'),('A','B')])]
q=lambda s:json.dumps(s,ensure_ascii=False)
inputs='['+','.join('(['+','.join(q(x) for x in ids)+'],['+','.join('('+q(a)+','+q(b)+')' for a,b in es)+'])' for ids,es in cases)+']'
r=Path('work/constants-recovery').resolve();p=r/'MetallicOperations573.lean';p.write_text('import SFT.Chemistry.MetallicNetwork\nopen SFT.Chemistry SFT.Host.Canonical\nset_option maxRecDepth 10000\ndef inputs : List (List String × List (String × String)) := '+inputs+'\ndef main : IO Unit := IO.println (render (.array (inputs.map (fun row => .boolean (MetallicNetwork.connectedCollectiveSupport row.1 row.2)))))\n')
o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',p.name],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/metallic_operations573.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr
actual=json.loads(o.stdout);expected=[original(tuple(ids),tuple(es)) for ids,es in cases];assert actual==expected,[(cases[i],x,y) for i,(x,y) in enumerate(zip(actual,expected)) if x!=y]
Path('work/metallic_operations573_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'operation':'connected_collective_support','cases':len(cases),'inputs':cases,'expected':expected,'actual':actual,'scope':'all directed edge subsets on three identities in all six identity orders, plus malformed guards, duplicate edge, blank identity, disconnected and reversed-sweep-order cases'},indent=2));print('PASS',len(cases),'original helper cases')
