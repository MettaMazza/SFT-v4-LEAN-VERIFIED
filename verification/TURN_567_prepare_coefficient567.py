from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'coefficient_spec567.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','coefficient').replace('Unit','Coefficient').replace('480','567');(w/('coefficient_'+part+'567.py')).write_text(s);subprocess.run(['python3',str(w/('coefficient_'+part+'567.py'))],check=True)
 s=(w/('Coefficient'+part.capitalize()+'567.lean')).read_text().replace('import «work».CoefficientCarrier567','import SFT.Foundation.CommonRefinement').replace('import «work».CoefficientGrammar567','import SFT.Chemistry.CoefficientGrammar').replace('SFT.Physics.Coefficient','SFT.Chemistry.Coefficient')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Coefficient'+part.capitalize()+'.lean')).write_text(s)
(w/'coefficient567_spec.json').write_text(json.dumps(values,indent=2))
