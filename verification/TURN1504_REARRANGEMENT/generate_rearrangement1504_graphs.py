from pathlib import Path
import json,sys,re,copy
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry/RearrangementWitnessGraphs';r.mkdir(exist_ok=True)
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_addition1499/sft/chemistry').resolve()));from sft.chemistry import addition_reaction_law_v3 as v
from sft.chemistry.addition_reaction_law_v1 import AdditionBond,AdditionState,atom,support,connected_components
from sft.engine.exact import HeldLabel
from sft.engine.canonical import canonical_value
sft.chemistry.__path__.insert(0,str((w/'pinned_rearrangement1504/sft/chemistry').resolve()))
from sft.chemistry import rearrangement_reaction_law_v1 as rearr
results=[('Single',rearr._single_move()),('Multi',rearr._three_moves()),('Degenerate',rearr._degenerate())]
base=results[0][1];ext=AdditionBond(base.source.atoms[0],atom('rearr-successor-atom'),support('rearr-successor-support'))
a=AdditionState(HeldLabel('addition-state',base.source.identity.label+'-successor'),base.source.atoms+(ext.right,),base.source.bonds+(ext,),base.source.free_supports)
b=AdditionState(HeldLabel('addition-state',base.terminal.identity.label+'-successor'),base.terminal.atoms+(ext.right,),base.terminal.bonds+(ext,),base.terminal.free_supports)
results.append(('Successor',rearr.forced_complete_rearrangement_transform(base.reaction_identity,a,b)))
q=lambda x:json.dumps(x,ensure_ascii=False)
fixture='json.load(open(w/\'addition1502_graph_fixture.json\'))'
old="json.load(open(w/'addition1501_transform_expected.json'))[0]['value']['source']"
manifest=[]
for prefix,result in results:
 for which in ['Source','Terminal']:
  st=result.source if which=='Source'else result.terminal;x=canonical_value(st);name=prefix+which
  (w/'addition1502_graph_fixture.json').write_text(json.dumps(x))
  for filename in ['generate_addition1502_graphproofs2.py','factor_addition1502_component_proof.py','seal_addition1502_fixture_proofs.py']:
   text=(w/filename).read_text().replace(old,fixture);exec(compile(text,filename,'exec'),{})
  text=(w/'AdditionGraphProofExact1502.lean').read_text();end='end SFT.Chemistry.AdditionWitnessProofs';text=text[:text.rindex(end)]
  families=dict(re.findall(r'private theorem (held\d+)Family : .*?nonblank ("(?:[^"\\]|\\.)*") = true',text))
  labels=dict(re.findall(r'private theorem (held\d+)Label : .*?nonblank ("(?:[^"\\]|\\.)*") = true',text))
  aliases={json.loads(labels[k]):k for k in labels if json.loads(families[k])=='addition-atom-occurrence'}
  components=sorted(connected_components(st),key=lambda c:min(st.atoms.index(a)for a in c))
  ordered='['+','.join('['+','.join(aliases[a.label]for a in sorted(c,key=lambda a:a.label))+']'for c in components)+']'
  text+='theorem sourceOrderedComponents : AdditionTransform.sourceComponents sourceSame = '+ordered+' := by\n unfold AdditionTransform.sourceComponents\n rw [sourceSameComponents]\n rfl\n#print axioms sourceOrderedComponents\n'
  pairs=[]
  # Distance proofs use the actual FIFO transitions and already proved worklist equation.
  edges=[]
  for bond in st.bonds:edges += [(bond.left.label,bond.right.label),(bond.right.label,bond.left.label)]
  for i,(left,right)in enumerate(pairs):
   origin=left.label;target=right.label;separation=v._shortest_distance(st,left,right)
   expected='.emptyOne'if origin==target else '.count ⟨'+str(separation.value)+',by decide⟩'
   text+=f'theorem distance{i} : shortestDistance sourceSame {aliases[origin]} {aliases[target]} = .ok ({expected}) := by\n'
   if origin==target:text+=' rfl\n'
   else:
    d=separation.value
    text+=f' have search : distanceLoop sourceSameGraph.edges {q(target)} (initialSearch sourceSameGraph.edges {q(origin)}) [0] = some {d} := by\n'
    text+=f'  let s0 := initialSearch sourceSameGraph.edges {q(origin)}\n  change distanceLoop sourceSameGraph.edges {q(target)} s0 [0] = some {d}\n'
    queue=[origin];ds=[0];visited=[];n=0
    while queue:
     held=queue[0];rest=queue[1:];dist=ds[0];restText='['+','.join(map(q,rest))+']'
     text+='  rw [distanceLoopEquation]\n'
     if held not in visited and held==target:text+='  rfl\n';break
     seen=held in visited
     text+=f'  let s{n+1} := {"skipState"if seen else "expandState"} sourceSameGraph.edges s{n} {q(held)} {restText} (by rfl)\n'
     if seen:queue=rest;ds=ds[1:]
     else:
      visited.append(held);added=[b for a,b in edges if a==held and b not in visited];queue=rest+added;ds=ds[1:]+[dist+1]*len(added)
     n+=1;text+=f'  change distanceLoop sourceSameGraph.edges {q(target)} s{n} ['+','.join(map(str,ds))+f'] = some {d}\n'
    else:raise AssertionError('distance failed')
    text+=' unfold shortestDistance\n rw [ite_eq_right (by decide)]\n'
    text+=f' change (match distanceLoop sourceSameGraph.edges {q(target)} (initialSearch sourceSameGraph.edges {q(origin)}) [0] with | none => Except.error "addition sites must belong to one retained source carrier" | some n => do return Separation.count (← SFT.Physics.CapabilityValues.count n)) = .ok ({expected})\n'
    text+=' rw [search]\n rfl\n'
   text+='#print axioms distance'+str(i)+'\n'
  text+=end+'\n';text=text.replace('SFT.Chemistry.AdditionWitnessProofs','SFT.Chemistry.RearrangementWitnessGraphs.'+name)
  (r/(name+'.lean')).write_text(text);manifest.append({'module':'SFT.Chemistry.RearrangementWitnessGraphs.'+name,'name':name,'distance_proofs':len(pairs),'fixture':x})
(w/'rearrangement1504_witness_graphs.json').write_text(json.dumps(manifest,indent=2)+'\n');print('Generated',len(manifest),'graphs and',sum(x['distance_proofs']for x in manifest),'distance proofs')
