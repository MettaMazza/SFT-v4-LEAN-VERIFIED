from pathlib import Path
import sys,ast,itertools,json,subprocess,os
sys.path.insert(0,'work');from polymer_chain_spec633 import raw,namespace,pin,q
ns=dict(namespace);source=raw('sft/chemistry/analytical_spectroscopic_derivation.py');tree=ast.parse(source);exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.ClassDef) and n.name=='AnalyticalTrace'],type_ignores=[]),'pinned-analytical-trace','exec'),ns)
expected=[];terms=[]
for family,n,b in itertools.product(['analytical-sample','repeat-unit','other'],[0,1,2],[0,1,2]):
 components=tuple(ns['HeldLabel']('chemical-component','component-a') for _ in range(n));observations=tuple(ns['PositiveCount'](k+1) for k in range(b))
 try:ns['AnalyticalTrace'](ns['HeldLabel'](family,'sample-a'),components,observations);expected.append('true')
 except ns['InadmissibleExactValue']:expected.append('false')
 cs='['+','.join('⟨"chemical-component","component-a",by decide,by decide⟩' for _ in range(n))+']';bs='['+','.join('⟨'+str(k+1)+',by decide⟩' for k in range(b))+']'
 terms.append('⟨⟨'+q(family)+',"sample-a",by decide,by decide⟩,'+cs+','+bs+'⟩')
p=Path('work/AnalyticalSampleOperations638.lean');p.write_text('import SFT.Chemistry.AnalyticalSample\nopen SFT.Chemistry.AnalyticalSample\ndef rows : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := rows.forM fun r => IO.println (match admit r with | .ok _ => true | .error _ => false)\n')
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,text=True,capture_output=True);Path('work/analytical_sample_operations638.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/analytical_sample_operations638_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,cases=len(expected),source='AnalyticalTrace.__post_init__',scope='Three identity families; independent zero/one/two component and observation supports, repeated labels retained, no equality-of-length guard.'),indent=2));print('PASS',len(expected),'source constructor cases')
