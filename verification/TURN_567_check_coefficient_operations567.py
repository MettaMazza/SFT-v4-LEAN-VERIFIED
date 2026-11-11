from pathlib import Path
import json,os,subprocess
ns={};exec(Path('work/coefficient_spec567.py').read_text(),ns);sc=ns['namespace'];q=lambda x:json.dumps(x,ensure_ascii=False)
R=lambda side,identity,n,els:('reaction-side',side,identity,n,els)
a=R('reactant','AB',1,[('A',1),('B',1)]);b=R('reactant','A',1,[('A',1)]);c=R('product','A2B',1,[('A',2),('B',1)])
cases=[[],[a],[a,b,c],[a,b],[a,c],[R('reactant','X',2,[('A',1)]),R('product','Y',1,[('A',2)])],[R('reactant','X',1,[('A',1)]),R('product','Y',1,[('B',1)])],[R('product','Y',1,[('B',1),('A',2)]),b,a],[R('reactant','x',1,[('A',1),('A',1)])],[R('reactant',' ',1,[('A',1)])],[R('reactant','x',1,[])],[('other','reactant','X',1,[('A',1)])],[R('middle','X',1,[('A',1)])],[R('reactant','X',1000000007,[('A',2)]),R('product','Y',2,[('A',1000000007)])]]
cases += [[R("reactant","X",1,[(" ",1)])],[R("reactant","X",1,[("\u2003",1)])]]
cases += [[R('reactant','X',k,[('A',1)]),R('product','Y',k,[('A',1)])] for k in [1,2,6,1000000007]]
expected=[];exprs=[]
for rows in cases:
 try:
  species=tuple(sc['ReactionSpecies'](sc['HeldLabel'](fam,side),identity,sc['PositiveCount'](n),tuple((label,sc['PositiveCount'](count)) for label,count in els)) for fam,side,identity,n,els in rows)
  expected.append({'primitive':sc['primitive_coefficients'](species),'balanced':sc['reaction_is_balanced'](species),'reactant':sc['_side_totals'](species,'reactant'),'product':sc['_side_totals'](species,'product'),'unknown':sc['_side_totals'](species,'other')})
 except sc['InadmissibleExactValue'] as e:expected.append({'error':str(e)})
 rowexpr=[]
 for fam,side,identity,n,els in rows:
  ee='['+','.join('makeElement '+q(label)+' '+str(count)+' (by decide)' for label,count in els)+']'
  rowexpr.append('((('+ee+' : List (Except String Element)).mapM id).bind (fun elements => makeSpecies '+q(fam)+' '+q(side)+' '+q(identity)+' '+str(n)+' (by decide) elements))')
 exprs.append('['+','.join(rowexpr)+']')
s='import SFT.Chemistry.StoichiometricPrimitive\nopen SFT.Chemistry.StoichiometricPrimitive SFT.Chemistry.ReactionTotals SFT.Host.Canonical\ndef dict (rows : List (String × Nat)) : Value := .object (rows.map fun x => (x.1,.integer (Int.ofNat x.2)))\ndef run (rows : List (Except String Species)) : Value :=\n match rows.mapM id with\n | .error e => .object [("error",.text e)]\n | .ok word => .object [("primitive",.boolean (primitiveCoefficients word)),("balanced",.boolean (reactionIsBalanced word)),("reactant",dict (sideTotals word "reactant")),("product",dict (sideTotals word "product")),("unknown",dict (sideTotals word "other"))]\ndef main : IO Unit := do\n'
s+='\n'.join(' IO.println (render (run '+e+'))' for e in exprs)+'\n';r=Path('work/constants-recovery').resolve();(r/'CoefficientOperations567.lean').write_text(s);env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','CoefficientOperations567.lean'],cwd=r,env=env,text=True,capture_output=True);Path('work/coefficient_operations567.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected,(actual,expected);Path('work/coefficient_operations567_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'cases':len(cases),'results':actual,'fresh_native_execution':True,'compares':'ReactionSpecies guards, full per-side dictionaries and balance, including original abstract witness and omission'},indent=2));print('PASS',len(cases),'exact original operation cases')
