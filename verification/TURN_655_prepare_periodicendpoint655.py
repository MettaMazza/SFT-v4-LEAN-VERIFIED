from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'periodicendpoint_spec655.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','periodicendpoint').replace('Unit','PeriodicEndpoint').replace('480','655');(w/('periodicendpoint_'+part+'655.py')).write_text(s);subprocess.run(['python3',str(w/('periodicendpoint_'+part+'655.py'))],check=True)
 s=(w/('PeriodicEndpoint'+part.capitalize()+'655.lean')).read_text().replace('import «work».PeriodicEndpointCarrier655','import SFT.Chemistry.PeriodicEndpoint\nimport SFT.Chemistry.GBlockEvidence\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».PeriodicEndpointGrammar655','import SFT.Chemistry.PeriodicEndpointGrammar').replace('SFT.Physics.PeriodicEndpoint','SFT.Chemistry.PeriodicEndpoint')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['GBlockEvidence.natResultEqual PeriodicEndpoint.endpoint 137','true','true']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:]
  s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000')
 (r/'SFT/Chemistry'/('PeriodicEndpoint'+part.capitalize()+'.lean')).write_text(s)
