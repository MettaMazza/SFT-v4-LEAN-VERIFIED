from pathlib import Path
import json
w=Path('work');setup=(w/'generate_rearrangement1504_graphs.py').read_text();exec(setup[:setup.index('q=lambda')]);multi=results[1][1];results.append(('MultiReverse',rearr.forced_complete_rearrangement_transform(multi.reaction_identity,multi.terminal,multi.source)))
outdir=w/'turn1064_recovery/SFT/Chemistry/RearrangementResults';outdir.mkdir(exist_ok=True);manifest=[]
for name,result in results:
 src,term=(('MultiTerminal','MultiSource')if name=='MultiReverse'else(name+'Source',name+'Terminal'))
 s=f'import SFT.Chemistry.RearrangementWitnesses\nimport SFT.Chemistry.RearrangementWitnessGraphs.{src}\nimport SFT.Chemistry.RearrangementWitnessGraphs.{term}\nnamespace SFT.Chemistry.RearrangementResults.{name}\nopen SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier Rearrangement RearrangementWitnesses\nset_option maxRecDepth 20000\nset_option maxHeartbeats 0\n'
 labels={};q=lambda x:json.dumps(x,ensure_ascii=False)
 def held(x):
  global s
  key=(x.family,x.label)
  if key not in labels:
   h='h'+str(len(labels));labels[key]=h;f,l=map(q,key);s+=f'private theorem {h}Family : nonblank {f} = true := rfl\nprivate theorem {h}Label : nonblank {l} = true := rfl\nprivate def {h} : HeldLabel := ⟨{f},{l},{h}Family,{h}Label⟩\n'
  return labels[key]
 def lst(xs):return '['+','.join(xs)+']'
 def pair(a,b):return '('+held(a)+','+held(b)+')'
 broken=[pair(next(b for b in result.source.bonds if b.held_support==h).left,next(b for b in result.source.bonds if b.held_support==h).right)for h in result.moved_supports]
 formed=[pair(next(b for b in result.terminal.bonds if b.held_support==h).left,next(b for b in result.terminal.bonds if b.held_support==h).right)for h in result.moved_supports]
 targets=[]
 for h,alts in result.candidate_target_incidences:
  pairs=[pair(*sorted(e,key=lambda a:result.source.atoms.index(a)))for e in alts];targets.append('('+held(h)+','+lst(pairs)+')')
 fields=[held(result.reaction_identity),'RearrangementWitnessGraphs.'+src+'.sourceSame','RearrangementWitnessGraphs.'+term+'.sourceSame',lst(list(map(held,result.moved_supports))),'⟨'+str(result.moved_support_count.value)+',by decide⟩',lst(broken),lst(formed),lst(targets),lst(list(map(held,result.path_classes))),str(result.constitutionally_degenerate).lower()]
 s+='def expected : Result := ⟨'+','.join(fields)+'⟩\n'
 call={'Single':'singleMove','Multi':'threeMoves','Degenerate':'degenerate'}.get(name,'transform '+fields[0]+' '+fields[1]+' '+fields[2])
 s+=f'theorem result : {call} = .ok expected := by\n change transform {fields[0]} {fields[1]} {fields[2]} = .ok expected\n unfold transform\n rw [RearrangementWitnessGraphs.{src}.sourceSameComponents,RearrangementWitnessGraphs.{term}.sourceSameComponents]\n rfl\n#print axioms result\n'
 s+='theorem transformResult : transform expected.reactionIdentity expected.source expected.terminal = .ok expected := by\n exact result\n#print axioms transformResult\nend SFT.Chemistry.RearrangementResults.'+name+'\n'
 (outdir/(name+'.lean')).write_text(s);manifest.append({'module':'SFT.Chemistry.RearrangementResults.'+name,'name':name})
(w/'rearrangement1504_witness_results.json').write_text(json.dumps(manifest,indent=2)+'\n');print('Generatedfivecomplete original result equality proofs')
