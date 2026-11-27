from pathlib import Path
import json
w=Path('work')
source=(w/'generate_addition1502_witness_graphs.py').read_text();exec(source[:source.index('q=lambda')])
template=(w/'generate_addition1502_results.py').read_text()
start=template.index("name='Same'");end=template.index(";ns=",start)
template=template[:start]+"name=caseName;x=caseValue"+template[end:]
template=template.replace("comps=[x['source']['atoms'][:3],x['source']['atoms'][3:]]","comps=caseComponents")
template=template.replace('simpleExample "same"','{caseCall}')
template=template.replace(' rw [occurrences',' erw [occurrences').replace(' rw [AdditionWitnessGraphs.{name}Source.distance',' erw [AdditionWitnessGraphs.{name}Source.distance')
template=template.replace("(w/'AdditionResult1502.lean').write_text(s)","(outdir/(name+'.lean')).write_text(s)")
outdir=w/'turn1064_recovery/SFT/Chemistry/AdditionWitnessResults';outdir.mkdir(exist_ok=True)
for name,result in results:
 x=canonical_value(result)
 x["new_adjacencies"]=[[canonical_value(a)for a in sorted(e,key=lambda a:a.label)]for e in result.new_adjacencies]
 comps=sorted(connected_components(result.source),key=lambda c:min(result.source.atoms.index(a)for a in c))
 comps=[[canonical_value(a)for a in sorted(c,key=lambda a:a.label)]for c in comps]
 call={'Same':'simpleExample "same"','Adjacent':'simpleExample "adjacent"','Nonadjacent':'simpleExample "nonadjacent"','Multiple':'simpleExample "adjacent" 3','Cyclo':'cycloadditionExample','Successor':'transform hDUMMY AdditionWitnessGraphs.SuccessorSource.sourceSame AdditionWitnessGraphs.SuccessorTerminal.sourceSame'}[name]
 t=template
 if name=='Successor':
  # Identity is the original retained nonadjacent reaction.
  t=t.replace("s+=f'theorem result : {caseCall}","caseCall=\"transform \"+fields[0]+\" \"+fields[1]+\" \"+fields[2]\ns+=f'theorem result : {caseCall}")
 exec(compile(t,'result_generator','exec'),{'caseName':name,'caseValue':x,'caseComponents':comps,'caseCall':call,'outdir':outdir})
manifest=[{'module':'SFT.Chemistry.AdditionWitnessResults.'+name,'name':name}for name,_ in results]
(w/'addition1502_witness_results.json').write_text(json.dumps(manifest,indent=2)+'\n')
