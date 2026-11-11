from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'traceability_spec559.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','traceability').replace('Unit','Traceability').replace('480','559');(w/('traceability_'+part+'559.py')).write_text(s);subprocess.run(['python3',str(w/('traceability_'+part+'559.py'))],check=True)
 s=(w/('Traceability'+part.capitalize()+'559.lean')).read_text().replace('import «work».TraceabilityCarrier559','import SFT.Chemistry.TraceabilityChain\nimport SFT.Foundation.CommonRefinement').replace('import «work».TraceabilityGrammar559','import SFT.Chemistry.TraceabilityGrammar').replace('SFT.Physics.Traceability','SFT.Chemistry.Traceability')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('{survivor with carrier := .rejected}','{survivor with property := .rejected}')
 (r/'SFT/Chemistry'/('Traceability'+part.capitalize()+'.lean')).write_text(s)
(w/'traceability559_spec.json').write_text(json.dumps(values,indent=2))
