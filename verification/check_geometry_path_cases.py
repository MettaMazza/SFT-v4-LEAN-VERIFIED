"""Compare fresh native path cases with exhaustive simple paths on three labels."""
import itertools,json,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[1]
result=subprocess.run(['lake','env','lean','verification/TURN_122_PathCases.lean'],cwd=root,text=True,capture_output=True,check=True)
(root/'verification/TURN_122_PATH_CASES.tsv').write_text(result.stdout)
lines=result.stdout.splitlines();assert lines[0]=='PASS: 13 path source cases'
choices=[('a','b'),('a','c'),('b','a'),('b','c'),('c','a'),('c','b')]
for row in lines[1:]:
 mask,origin,target,output=row.split('\t');edges=[e for i,e in enumerate(choices) if int(mask)&(1<<i)]
 adjacent=lambda a,b:(a,b) in edges or (b,a) in edges
 if origin==target:
  assert output=='empty-One';continue
 candidates=[]
 for count in range(2):
  for middle in itertools.permutations([x for x in 'abc' if x not in (origin,target)],count):
   path=(origin,*middle,target)
   if all(adjacent(a,b) for a,b in zip(path,path[1:])):candidates.append(path)
 if not candidates:assert output=='NONE'
 else:
  path=tuple(output.split(','));assert path[0]==origin and path[-1]==target
  assert all(adjacent(a,b) for a,b in zip(path,path[1:]))
  assert len(path)==min(map(len,candidates))
assert len(lines)-1==576
report={'status':'PASS','source_cases':13,'exhaustive_three_label_graph_cases':576,'comparison':'Independent enumeration of all simple paths verifies returned path validity, minimal length, identity and unreachable outcomes on every tested graph. This finite regression is not the general shortest-path theorem.'}
(root/'verification/TURN_122_PATH_CASES_REPORT.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report))
