from pathlib import Path
import json
w=Path('work');g=(w/'generate_elimination1503_graphs.py').read_text();g=g[:g.index('exec(compile')]+"exec(compile(s[:s.index('q=lambda')],'setup','exec'))";exec(g)
template=(w/'generate_addition1502_results.py').read_text();start=template.index("name='Same'");end=template.index(';ns=',start);template=template[:start]+"name=caseName;x=caseValue"+template[end:]
template=template.replace("comps=[x['source']['atoms'][:3],x['source']['atoms'][3:]]","comps=caseComponents").replace('simpleExample "same"','{caseCall}').replace(' rw [occurrences',' erw [occurrences').replace(' rw [AdditionWitnessGraphs.{name}Source.distance',' erw [AdditionWitnessGraphs.{name}Source.distance')
template=template.replace('AdditionWitnessGraphs','EliminationWitnessGraphs').replace('AdditionWitnessResults','EliminationAdditionResults').replace("s=f'import SFT.","s=f'import SFT.Chemistry.Elimination\\nimport SFT.")
template=template.replace("(w/'AdditionResult1502.lean').write_text(s)","(outdir/(name+'.lean')).write_text(s)")
outdir=w/'turn1064_recovery/SFT/Chemistry/EliminationAdditionResults';outdir.mkdir(exist_ok=True)
for name,result in results:
 x=canonical_value(result);x['new_adjacencies']=[[canonical_value(a)for a in sorted(e,key=lambda a:a.label)]for e in result.new_adjacencies]
 comps=sorted(connected_components(result.source),key=lambda c:min(result.source.atoms.index(a)for a in c));comps=[[canonical_value(a)for a in sorted(c,key=lambda a:a.label)]for c in comps]
 call='Elimination.additionWitness '+json.dumps(name.lower());t=template
 if name=='Successor':t=t.replace("s+=f'theorem result : {caseCall}","caseCall=\"AdditionTransform.transform \"+fields[0]+\" \"+fields[1]+\" \"+fields[2]\ns+=f'theorem result : {caseCall}")
 t=t.replace('#print axioms result\\nend {ns}', '#print axioms result\\ntheorem transformResult : AdditionTransform.transform expected.reactionIdentity expected.source expected.terminal = .ok expected := by\\n exact result\\n#print axioms transformResult\\nend {ns}')
 exec(compile(t,'elimination_result','exec'),{'caseName':name,'caseValue':x,'caseComponents':comps,'caseCall':call,'outdir':outdir})
(w/'elimination1503_witness_results.json').write_text(json.dumps([{'module':'SFT.Chemistry.EliminationAdditionResults.'+n,'name':n}for n,_ in results],indent=2)+'\n')
