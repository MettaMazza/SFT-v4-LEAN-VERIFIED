from pathlib import Path
import json
w=Path('work');ns={};exec((w/'generate_addition1502_literalproof.py').read_text().split("s=(w/'AdditionWitnessProof1502.lean')")[0],ns);label=ns['label'];q=lambda x:json.dumps(x,ensure_ascii=False)
x=json.load(open(w/'addition1501_transform_expected.json'))[0]['value']['source'];nodes=[a['label']for a in x['atoms']];labels={a['label']:a for a in x['atoms']};edges=[]
for b in x['bonds']:edges += [(b['left']['label'],b['right']['label']),(b['right']['label'],b['left']['label'])]
components=[];remaining=set(nodes)
while remaining:
 seed=min(remaining);todo=[seed];seen=set()
 while todo:
  a=todo.pop()
  if a in seen:continue
  seen.add(a);todo += [b for aa,b in edges if aa==a and b not in seen]
 components.append(sorted(seen));remaining-=seen
lst=lambda ns:'['+','.join(label(labels[n])for n in ns)+']'
clst=lambda cs:'['+','.join(lst(c)for c in cs)+']'
p=w/'AdditionGraphProofExact1502.lean';s=p.read_text();s=s[:s.index('theorem sourceSameComponents')]
for i,c in enumerate(components):
 s+=f'''private theorem filterSeed{i} : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) {q(c[0])} b.label) = {lst([n for n in nodes if n in c])} := by
 have atoms : sourceSame.atoms = {lst(nodes)} := rfl
 rw [atoms]
'''
 for k,node in enumerate(nodes):
  j=sorted(nodes).index(node)
  pred='(fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) '+q(c[0])+' b.label)'
  rest='('+lst(nodes[k+1:])+').filter '+pred
  step='show ('+lst(nodes[k:])+').filter '+pred+' = (match reachable (graph sourceSame) '+q(c[0])+' ('+label(labels[node])+' : SFT.Physics.CapabilityValues.HeldLabel).label with | true => '+label(labels[node])+' :: '+rest+' | false => '+rest+') from rfl'
  s+=' rw ['+step+']\n rw [show ('+label(labels[node])+' : SFT.Physics.CapabilityValues.HeldLabel).label = '+q(node)+' from rfl,reach_'+str(i)+'_'+str(j)+']\n try dsimp only\n'
 s+=' rfl\n#print axioms filterSeed'+str(i)+'\n'
s+='theorem sourceSameComponents : connectedComponents sourceSame = '+clst(components)+' := by\n'
s+=' let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]\n'
s+=' change List.foldl step [] '+lst(sorted(nodes))+' = '+clst(components)+'\n';current=[]
for k,a in enumerate(sorted(nodes)):
 c=next(c for c in components if a in c);new=not any(a in cc for cc in current);after=current+[c]if new else current
 s+=' have step'+str(k)+' : step '+clst(current)+' '+label(labels[a])+' = '+clst(after)+' := by\n'
 if new:
  i=components.index(c);s+='  change '+clst(current)+' ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) '+q(a)+' b.label)] = '+clst(after)+'\n  rw [filterSeed'+str(i)+']\n  rfl\n'
 else:s+='  rfl\n'
 s+=' rw [List.foldl_cons,step'+str(k)+']\n';current=after
s+=' rfl\n#print axioms sourceSameComponents\nend SFT.Chemistry.AdditionWitnessProofs\n';p.write_text(s)
