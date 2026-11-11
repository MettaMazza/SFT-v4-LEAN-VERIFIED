from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'metallic_spec573.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','metallic').replace('Unit','Metallic').replace('480','573');(w/('metallic_'+part+'573.py')).write_text(s);subprocess.run(['python3',str(w/('metallic_'+part+'573.py'))],check=True)
 s=(w/('Metallic'+part.capitalize()+'573.lean')).read_text().replace('import «work».MetallicCarrier573','import SFT.Foundation.CommonRefinement').replace('import «work».MetallicGrammar573','import SFT.Chemistry.MetallicGrammar').replace('SFT.Physics.Metallic','SFT.Chemistry.Metallic')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Metallic'+part.capitalize()+'.lean')).write_text(s)
(w/'metallic573_spec.json').write_text(json.dumps(values,indent=2))
