from pathlib import Path
import json
w=Path('work');r=w/'turn1064_recovery';rows=json.load(open(w/'addition1501_transform_expected.json'))
name='Same';x=rows[0]['value'];ns='SFT.Chemistry.AdditionWitnessResults.'+name
s=f'import SFT.Chemistry.AdditionWitnessGraphs.{name}Source\nimport SFT.Chemistry.AdditionWitnessGraphs.{name}Terminal\nnamespace {ns}\nopen SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph AdditionTransform AdditionWitnesses\nset_option maxRecDepth 20000\nset_option maxHeartbeats 0\n'
labels={}
def held(x):
 global s
 key=(x['family'],x['label'])
 if key not in labels:
  h='h'+str(len(labels));labels[key]=h;f,l=map(json.dumps,key)
  s+=f'private theorem {h}Family : nonblank {f} = true := rfl\nprivate theorem {h}Label : nonblank {l} = true := rfl\nprivate def {h} : HeldLabel := ⟨{f},{l},{h}Family,{h}Label⟩\n'
 return labels[key]
def lst(xs):return '['+','.join(xs)+']'
def count(n):return '⟨'+str(n)+',by decide⟩'
edges=[]
for a,b in x['new_adjacencies']:
 bb=next(bb for bb in x['terminal']['bonds'] if {bb['left']['label'],bb['right']['label']}=={a['label'],b['label']});edges.append('('+held(bb['left'])+','+held(bb['right'])+')')
classes=[]
for c in x['component_site_classes']:
 sep='.emptyOne'if'identity'in c['separation']else '.count '+count(c['separation']['value'])
 classes.append('⟨'+count(c['source_component_ordinal']['value'])+','+held(c['label'])+','+sep+'⟩')
fields=[held(x['reaction_identity']),f'AdditionWitnessGraphs.{name}Source.sourceSame',f'AdditionWitnessGraphs.{name}Terminal.sourceSame',count(x['source_component_count']['value']),lst(edges),count(2),lst(list(map(held,x['reduced_multiplicity_supports']))),count(x['reduced_layer_count']['value']),lst(classes),lst(list(map(held,x['relocated_supports'])))]
comps=[x['source']['atoms'][:3],x['source']['atoms'][3:]]
comptext=lst([lst(list(map(held,c)))for c in comps])
newexpr=f"sortBy edgeBefore ((endpointKeys {fields[2]}).filter fun e => !(endpointKeys {fields[1]}).any (NucleophilicCarrier.sameEdge e))"
occ=[]
for i,c in enumerate(comps):
 members={a['label']for a in c};atoms=[]
 for a,b in x['new_adjacencies']:
  bb=next(bb for bb in x['terminal']['bonds'] if {bb['left']['label'],bb['right']['label']}=={a['label'],b['label']})
  atoms.extend(held(bb[k])for k in ['left','right']if bb[k]['label']in members)
 occ.append(f" have occurrences{i} : (({newexpr}).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf {comptext} a == {i}) = {lst(atoms)} := rfl\n rw [occurrences{i}]\n dsimp only\n")
s+='def expected : Result := ⟨'+','.join(fields)+'⟩\n'
s+=f'theorem result : simpleExample "same" = .ok expected := by\n change transform {fields[0]} {fields[1]} {fields[2]} = .ok expected\n unfold transform\n rw [AdditionWitnessGraphs.{name}Source.sourceOrderedComponents, AdditionWitnessGraphs.{name}Terminal.sourceSameComponents]\n conv => lhs; whnf\n dsimp only [List.mapM, List.mapM.loop, List.range, List.range.loop, List.length]\n'
s+=''.join(occ)
s+=f' rw [AdditionWitnessGraphs.{name}Source.distance0, AdditionWitnessGraphs.{name}Source.distance1]\n rfl\n#print axioms result\nend {ns}\n'
(w/'AdditionResult1502.lean').write_text(s)
