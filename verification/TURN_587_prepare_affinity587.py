from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'affinity_spec587.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','affinity').replace('Unit','Affinity').replace('480','587');(w/('affinity_'+part+'587.py')).write_text(s);subprocess.run(['python3',str(w/('affinity_'+part+'587.py'))],check=True)
 s=(w/('Affinity'+part.capitalize()+'587.lean')).read_text().replace('import «work».AffinityCarrier587','import SFT.Foundation.CommonRefinement').replace('import «work».AffinityGrammar587','import SFT.Chemistry.AffinityGrammar').replace('SFT.Physics.Affinity','SFT.Chemistry.Affinity')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with carriers :=').replace('memMap _ extension _ hextension','memMap _ extra _ hextra')
 import re
 pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
 s=''.join(x if i%2 else x.replace('Acid-response','AcidResponse').replace('Base-response','BaseResponse').replace('acid-response','acidResponse').replace('base-response','baseResponse').replace('Acid-role','AcidRole').replace('Base-role','BaseRole').replace('acid-role','acidRole').replace('base-role','baseRole') for i,x in enumerate(pieces))
 (r/'SFT/Chemistry'/('Affinity'+part.capitalize()+'.lean')).write_text(s)
(w/'affinity587_spec.json').write_text(json.dumps(values,indent=2))
