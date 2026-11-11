from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'isotope_spec560.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','isotope').replace('Unit','Isotope').replace('480','560');(w/('isotope_'+part+'560.py')).write_text(s);subprocess.run(['python3',str(w/('isotope_'+part+'560.py'))],check=True)
 s=(w/('Isotope'+part.capitalize()+'560.lean')).read_text().replace('import «work».IsotopeCarrier560','import SFT.Chemistry.IsotopeFamily\nimport SFT.Foundation.CommonRefinement').replace('import «work».IsotopeGrammar560','import SFT.Chemistry.IsotopeGrammar').replace('SFT.Physics.Isotope','SFT.Chemistry.Isotope')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Isotope'+part.capitalize()+'.lean')).write_text(s)
(w/'isotope560_spec.json').write_text(json.dumps(values,indent=2))
