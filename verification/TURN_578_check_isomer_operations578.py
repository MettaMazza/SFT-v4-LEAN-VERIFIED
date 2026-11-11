from pathlib import Path
import json,subprocess,os,itertools
ns={};exec(Path('work/isomer_spec578.py').read_text(),ns);n=ns['namespace'];q=lambda x:json.dumps(x,ensure_ascii=False);cases=[];carriers=[]
nodes=('a','b','c');edges=list(itertools.combinations(nodes,2))
for labels in [('E','E','E'),('E','H','H')]:
 for mask in range(8):
  try:carriers.append(n['MolecularCarrier'](nodes,labels,tuple(e for i,e in enumerate(edges) if mask>>i&1)))
  except ValueError:pass
cases=list(itertools.product(carriers,repeat=2))
chain=n['_CHAIN'];branch=n['_BRANCHED'];cases.extend([(chain,branch),(chain,chain),(branch,branch),(n['_DIATOMIC'],chain)])
for order in itertools.permutations(('q','r','s','t')):
 mapping=dict(zip(chain.occurrence_ids,order));other=n['MolecularCarrier'](order,chain.element_labels,tuple((mapping[a],mapping[b]) for a,b in chain.bonds));cases.extend([(chain,other),(branch,other)])
def carrier(c):return '⟨'+q(list(c.occurrence_ids))+','+q(list(c.element_labels))+',['+','.join('('+q(a)+','+q(b)+')' for a,b in c.bonds)+'],[]⟩'
s='import SFT.Chemistry.MolecularIsomer\nopen SFT.Chemistry\ndef main : IO Unit := do\n';expected=[]
for a,b in cases:
 expected.append([n['structurally_equivalent'](a,b),n['molecular_isomers'](a,b)])
 s+=' IO.println ("[" ++ (if MolecularIsomer.structurallyEquivalent ('+carrier(a)+') ('+carrier(b)+') then "true" else "false") ++ "," ++ (if MolecularIsomer.molecularIsomers ('+carrier(a)+') ('+carrier(b)+') then "true" else "false") ++ "]")\n'
r=Path('work/constants-recovery').resolve();(r/'IsomerOperations578.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','IsomerOperations578.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/isomer_operations578.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected,[(i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b];Path('work/isomer_operations578_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'cases':len(cases),'expected':expected,'actual':actual},indent=2));print('PASS',len(cases),'source isomer pairs')
