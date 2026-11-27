from pathlib import Path
import json
w=Path('work');ns={};exec((w/'generate_addition1502_literalproof.py').read_text().split("s=(w/'AdditionWitnessProof1502.lean')")[0],ns)
state=ns['state'];label=ns['label'];q=lambda x:json.dumps(x,ensure_ascii=False)
x=json.load(open(w/'addition1501_transform_expected.json'))[0]['value']['source'];nodes=[a['label']for a in x['atoms']];edges=[]
for b in x['bonds']:edges += [(b['left']['label'],b['right']['label']),(b['right']['label'],b['left']['label'])]
s='''import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.AdditionWitnessProofs
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
'''
s+='def sourceSame : State := '+state(x)+'\n';s+='def sourceSameGraph : GeneratedGraph := ⟨['+','.join(map(q,nodes))+'],['+','.join('('+q(a)+','+q(b)+')'for a,b in edges)+']⟩\n'
components=[];remaining=set(nodes)
while remaining:
 seed=min(remaining);frontier=[seed];seen=set()
 while frontier:
  a=frontier.pop()
  if a in seen:continue
  seen.add(a);frontier += [b for aa,b in edges if aa==a and b not in seen]
 components.append(sorted(seen));remaining-=seen
names=[]
for i,c in enumerate(components):
 for j,target in enumerate(sorted(nodes)):
  name=f'reach_{i}_{j}';names.append(name);origin=c[0];passed=target in c
  s+=f'private theorem {name} : reachable (graph sourceSame) {q(origin)} {q(target)} = {str(passed).lower()} := by\n change reachable sourceSameGraph {q(origin)} {q(target)} = {str(passed).lower()}\n unfold reachable\n'
  if origin==target:s+=' rw [ite_eq_left rfl]\n rfl\n'
  else:
   s+=' rw [ite_eq_right (by decide)]\n'
   s+=f' let s0 := initialSearch sourceSameGraph.edges {q(origin)}\n change searchLoop sourceSameGraph.edges {q(target)} s0 = {str(passed).lower()}\n'
   queue=[origin];visited=[];n=0
   while queue:
    held=queue[0];rest=queue[1:];restText='['+','.join(map(q,rest))+']'
    if held==target:
     s+=f' exact searchHitsTarget sourceSameGraph.edges {q(target)} s{n} {restText} (by rfl)\n';break
    wasSeen=held in visited
    s+=f' rw [search{"SkipsVisited"if wasSeen else "ExpandsFresh"} sourceSameGraph.edges {q(target)} s{n} {q(held)} {restText} (by rfl) (by decide) (by decide)]\n'
    s+=f' let s{n+1} := {"skipState"if wasSeen else "expandState"} sourceSameGraph.edges s{n} {q(held)} {restText} (by rfl)\n'
    s+=f' change searchLoop sourceSameGraph.edges {q(target)} s{n+1} = {str(passed).lower()}\n'
    if not wasSeen:
     visited.append(held);queue=rest+[b for a,b in edges if a==held and b not in visited]
    else:queue=rest
    n+=1
   else:s+=f' exact searchEmpty sourceSameGraph.edges {q(target)} s{n} (by rfl)\n'
  s+='#print axioms '+name+'\n'
labels={a['label']:a for a in x['atoms']};expected='['+','.join('['+','.join(label(labels[n])for n in c)+']'for c in components)+']'
s+='theorem sourceSameComponents : connectedComponents sourceSame = '+expected+' := by\n'
s+=' have atoms : sourceSame.atoms = ['+','.join(label(labels[n])for n in nodes)+'] := rfl\n'
s+=' unfold connectedComponents\n have sorted : sortLabels sourceSame.atoms = ['+','.join(label(labels[n])for n in sorted(nodes))+'] := rfl\n rw [sorted]\n'
s+=' simp (disch := decide) only [List.foldl,List.any,List.filter,List.map,atoms,'+','.join(names)+',ite_eq_left,ite_eq_right]\n rfl\n#print axioms sourceSameComponents\nend SFT.Chemistry.AdditionWitnessProofs\n'
(w/'AdditionGraphProofExact1502.lean').write_text(s.replace(',rfl,rfl⟩',',by decide,by decide⟩'))
