from pathlib import Path
import itertools,json,ast,subprocess
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');q=json.dumps
text='import SFT.Computation.Consensus\nopen SFT.Computation.Consensus\n'
count=0
for ds,decl,comm,fault in itertools.product(itertools.product(['absent',None,'a','b','extra'],repeat=2),[False,True],['','channel'],['','faults']):
 states=[(f'p{i}',val) for i,val in enumerate(ds) if val!='absent']
 l='['+','.join('('+q(p)+','+('none' if v is None else 'some '+q(v))+')' for p,v in states)+']'
 record='({inputs := [("p0","a"),("p1","b")], decisions := '+l+', sends := [], receives := [], channels := [], messages := [], communicationModel := '+q(comm)+', faultModel := '+q(fault)+', terminationDeclared := '+str(decl).lower()+'} : Record)'
 for val in ['a','b','extra']:
  expected=bool(comm and fault and decl and len(states)==2 and val in ['a','b'] and all(v==val for _,v in states))
  text+='example : accepts '+record+' '+q(val)+' = '+str(expected).lower()+' := rfl\n';count+=1
(r/'verification/TURN_288_ConsensusCases.lean').write_text(text)
p=subprocess.run(['/Users/dolltrading/.elan/bin/lake','env','lean','verification/TURN_288_ConsensusCases.lean'],cwd=r,capture_output=True,text=True);(r/'verification/TURN_288_CONSENSUS_CASES.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-2000:]
events=['a','b','c'];pairs=list(itertools.product(events,repeat=2));text='import SFT.Computation.DistributedOrder\nopen SFT.Computation\n';expected=[]
for mask in range(512):
 edges=[p for i,p in enumerate(pairs) if mask>>i&1];closure=set(edges)
 while True:
  more=closure|{(a,c) for a,b in closure for b2,c in closure if b==b2}
  if more==closure:break
  closure=more
 cycle=any(a==b for a,b in closure)
 expected.append(None if cycle else (sorted(closure),[(e,e) for e in events],[(a,b) for a,b in pairs if a!=b and (a,b) not in closure and (b,a) not in closure],sorted([list(p) for p in itertools.permutations(events) if all(p.index(a)<p.index(b) for a,b in closure)])))
 rows='['+','.join('('+q(a)+','+q(b)+')' for a,b in edges)+']';src='(⟨["a","b","c"],'+rows+',[]⟩ : CausalProvenance.Source)'
 text+='#eval match CausalProvenance.execute '+src+' with | .error _ => "ERROR" | .ok rows => reprStr (rows,DistributedOrder.identities ["a","b","c"],CausalProvenance.incomparablePairs ["a","b","c"] (DistributedOrder.relation ["a","b","c"] rows),ConcurrencySchedules.allSchedules ["a","b","c"] rows)\n'
(r/'verification/TURN_288_OrderCases.lean').write_text(text)
p=subprocess.run(['/Users/dolltrading/.elan/bin/lake','env','lean','verification/TURN_288_OrderCases.lean'],cwd=r,capture_output=True,text=True);(r/'verification/TURN_288_ORDER_CASES.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-2000:]
lines=p.stdout.splitlines();assert len(lines)==512,len(lines)
for i,(line,exp) in enumerate(zip(lines,expected)):
 result=json.loads(line)
 if exp is None:assert result=='ERROR',i
 else:
  actual=ast.literal_eval(result);actual=(*actual[:3],sorted(actual[3]));assert actual==exp,(i,actual,exp)
report=dict(status='PASS',consensus_kernel_checks=count,partial_order_all_three_event_relations=512,checks=['source closure and cycle rejection','reflexive ledger','incomparable pairs','complete linear-extension support','terminal decision acceptance under declared boundary'])
(r/'verification/TURN_288_BATCH_CASE_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
