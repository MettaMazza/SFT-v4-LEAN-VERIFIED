from pathlib import Path
import itertools,json,subprocess,os,dataclasses
ns={};exec(Path('work/molecule_spec576.py').read_text(),ns);n=ns['namespace'];cases=[]
def add(ids,labels,edges,charge=()):cases.append((tuple(ids),tuple(labels),tuple(edges),tuple(charge)))
for mask in range(64):
 edges=[e for i,e in enumerate(itertools.permutations(['A','B','C'],2)) if mask&(1<<i)]
 add(['A','B','C'],['E','E','H'],edges)
for ids,labels,edges,charge in [([],[],[],()),(['A'],['E'],[],()),(['A','A'],['E','E'],[('A','A')],()),(['A','B'],['E'],[('A','B')],()),(['','B'],['E','H'],[('','B')],()),(['A','B'],[' ','H'],[('A','B')],()),(['A','B'],['E','H'],[('A','A')],()),(['A','B'],['E','H'],[('A','X')],()),(['A','B'],['E','H'],[('A','B'),('A','B')],()),(['A','B'],['E','H'],[('A','B'),('B','A')],()),(['A','B'],['E','E'],[('A','B')],[('charge','open')]),(['α','😀'],['é','E'],[('😀','α')],())]:add(ids,labels,edges,charge)
expected=[]
for ids,labels,edges,charge in cases:
 try:
  carrier=n['MolecularCarrier'](ids,labels,edges,tuple(n['HeldLabel'](a,b) for a,b in charge));sig=n['composition_signature'](carrier);expected.append({'ok':True,'signature':[[key,count.value] for key,count in sig]})
 except ValueError as e:expected.append({'error':str(e)})
helpers=[([],[]),(['A'],[]),(['A'],[('A','X')]),(['A'],[('X','Y')]),(['A','A'],[]),(['A','B'],[('A','B')]),(['A','B'],[('A','X'),('X','B')]),(['A','B'],[('A','A'),('A','B')])]
hexpected=[n['_connected'](tuple(ids),tuple(edges)) for ids,edges in helpers]
q=lambda x:json.dumps(x,ensure_ascii=False)
def strings(xs):return '['+','.join(q(x) for x in xs)+']'
def pairs(xs):return '['+','.join('('+q(a)+','+q(b)+')' for a,b in xs)+']'
s='import SFT.Chemistry.MolecularCarrier\nopen SFT.Chemistry.MolecularCarrier SFT.Host.Canonical\nset_option maxRecDepth 10000\ndef result (raw : Raw) : Value := match admit raw with\n | .error e => .object [("error",.text e)]\n | .ok carrier => .object [("ok",.boolean true),("signature",.array ((compositionSignature carrier).map (fun row => .array [.text row.1,.integer (Int.ofNat row.2)])))]\ndef main : IO Unit := do\n'
for ids,labels,edges,charge in cases:s+=' IO.println (render (result ⟨'+','.join([strings(ids),strings(labels),pairs(edges),pairs(charge)])+'⟩))\n'
for ids,edges in helpers:s+=' IO.println (render (.boolean (connected '+strings(ids)+' '+pairs(edges)+')))\n'
r=Path('work/constants-recovery').resolve();(r/'MoleculeOperations576.lean').write_text(s);o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run','MoleculeOperations576.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/molecule_operations576.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;actual=[json.loads(x) for x in o.stdout.splitlines()];assert actual==expected+hexpected,[(i,a,b) for i,(a,b) in enumerate(zip(actual,expected+hexpected)) if a!=b];Path('work/molecule_operations576_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'constructor_cases':len(cases),'connected_helper_cases':len(helpers),'results':actual,'inputs':cases,'helper_inputs':helpers},indent=2));print('PASS',len(actual),'original constructor/composition/helper cases')
