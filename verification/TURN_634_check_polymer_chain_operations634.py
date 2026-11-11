from pathlib import Path
import sys,ast,itertools,json,subprocess,os
sys.path.insert(0,'work');from polymer_chain_spec633 import raw,namespace,pin,q
ns=dict(namespace);source=raw('sft/chemistry/stereochemistry_organic_polymer_derivation.py');tree=ast.parse(source);exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.ClassDef) and n.name=='RepeatingCarrier'],type_ignores=[]),'pinned-repeating-carrier','exec'),ns)
expected=[];terms=[]
for family,n,b in itertools.product(['repeat-unit','molecular-orientation','other'],[1,2,3],[1,2,4]):
 try:ns['RepeatingCarrier'](ns['HeldLabel'](family,'unit-a'),ns['PositiveCount'](n),ns['PositiveCount'](b));expected.append('true')
 except ns['InadmissibleExactValue']:expected.append('false')
 terms.append('⟨⟨'+q(family)+',"unit-a",by decide,by decide⟩,⟨'+str(n)+',by decide⟩,⟨'+str(b)+',by decide⟩⟩')
p=Path('work/PolymerChainOperations634.lean');p.write_text('import SFT.Chemistry.PolymerChain\nopen SFT.Chemistry.PolymerChain\ndef rows : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := rows.forM fun r => IO.println (match admit r with | .ok _ => true | .error _ => false)\n')
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,text=True,capture_output=True);Path('work/polymer_chain_operations634.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/polymer_chain_operations634_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,cases=len(expected),source='RepeatingCarrier.__post_init__',scope='Three identity families; independent positive occurrence/connection counts, including unequal path counts and singleton extent. No additional path-count guard.'),indent=2));print('PASS',len(expected),'source constructor cases')
