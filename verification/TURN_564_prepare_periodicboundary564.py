from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'periodicboundary_spec564.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','periodicboundary').replace('Unit','PeriodicBoundary').replace('480','564');(w/('periodicboundary_'+part+'564.py')).write_text(s);subprocess.run(['python3',str(w/('periodicboundary_'+part+'564.py'))],check=True)
 s=(w/('PeriodicBoundary'+part.capitalize()+'564.lean')).read_text().replace('import «work».PeriodicBoundaryCarrier564','import SFT.Chemistry.PeriodicRelease\nimport SFT.Foundation.CommonRefinement').replace('import «work».PeriodicBoundaryGrammar564','import SFT.Chemistry.PeriodicBoundaryGrammar').replace('SFT.Physics.PeriodicBoundary','SFT.Chemistry.PeriodicBoundary')
 if part=='grammar': s=s.replace('exact Count.TraceDerivation.memMap _ extension _ hextension','exact Count.TraceDerivation.memMap _ rule _ hrule')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('PeriodicBoundary'+part.capitalize()+'.lean')).write_text(s)
(w/'periodicboundary564_spec.json').write_text(json.dumps(values,indent=2))
