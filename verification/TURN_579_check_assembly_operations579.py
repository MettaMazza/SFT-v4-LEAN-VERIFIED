from pathlib import Path
import json,subprocess,os,itertools
ns={};exec(Path('work/intermolecular_spec579.py').read_text(),ns);n=ns['namespace'];q=lambda x:json.dumps(x,ensure_ascii=False);cases=[];nodes=('a','b','c');edges=list(itertools.permutations(nodes,2))
for mask in range(64):cases.append((nodes,[(a,b,'intermolecular') for i,(a,b) in enumerate(edges) if mask>>i&1]))
cases += [([],[]),(['a'],[]),(['a','a'],[('a','a','intermolecular')]),(['a','b'],[]),(['a','b'],[('a','a','intermolecular')]),(['a','b'],[('a','x','intermolecular')]),(['a','b'],[('a','b','bad-family')]),(['a','b'],[('a','b','recognition')]),(['a','b'],[('a','b','network')]),(['a','b'],[('a','b','intermolecular'),('b','a','intermolecular')]),(['','b'],[('','b','intermolecular')])]
s='import SFT.Chemistry.MolecularAssembly\nopen SFT.Chemistry\ndef main : IO Unit := do\n';expected=[]
for ids,rows in cases:
 try:
  a=n['MolecularAssembly'](tuple(ids),tuple((a,b,n['HeldLabel'](f,'channel')) for a,b,f in rows));expected.append('ok:'+str(n['interaction_count'](a).value))
 except ValueError as e:expected.append(str(e))
 expr='⟨'+q(list(ids))+',['+','.join('⟨'+q(a)+','+q(b)+',⟨'+q(f)+',"channel",rfl,rfl⟩⟩' for a,b,f in rows)+']⟩'
 s+=' match MolecularAssembly.admit ('+expr+') with\n | .error e => IO.println e\n | .ok raw => IO.println ("ok:" ++ toString (MolecularAssembly.interactionCount raw))\n'
r=Path('work/constants-recovery').resolve();(r/'AssemblyOperations579.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','AssemblyOperations579.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/assembly_operations579.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=p.stdout.splitlines();assert actual==expected,[(i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b];Path('work/assembly_operations579_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'cases':len(cases),'expected':expected,'actual':actual},indent=2));print('PASS',len(cases),'original assembly cases')
