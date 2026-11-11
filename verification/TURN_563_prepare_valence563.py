from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'valence_spec563.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','valence').replace('Unit','Valence').replace('480','563');(w/('valence_'+part+'563.py')).write_text(s);subprocess.run(['python3',str(w/('valence_'+part+'563.py'))],check=True)
 s=(w/('Valence'+part.capitalize()+'563.lean')).read_text().replace('import «work».ValenceCarrier563','import SFT.Chemistry.ValenceMaximum\nimport SFT.Foundation.CommonRefinement').replace('import «work».ValenceGrammar563','import SFT.Chemistry.ValenceGrammar').replace('SFT.Physics.Valence','SFT.Chemistry.Valence')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Valence'+part.capitalize()+'.lean')).write_text(s)
(w/'valence563_spec.json').write_text(json.dumps(values,indent=2))
