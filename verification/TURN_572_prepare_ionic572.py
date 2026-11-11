from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'ionic_spec572.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','ionic').replace('Unit','Ionic').replace('480','572');(w/('ionic_'+part+'572.py')).write_text(s);subprocess.run(['python3',str(w/('ionic_'+part+'572.py'))],check=True)
 s=(w/('Ionic'+part.capitalize()+'572.lean')).read_text().replace('import «work».IonicCarrier572','import SFT.Foundation.CommonRefinement').replace('import «work».IonicGrammar572','import SFT.Chemistry.IonicGrammar').replace('SFT.Physics.Ionic','SFT.Chemistry.Ionic')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('Ionic'+part.capitalize()+'.lean')).write_text(s)
(w/'ionic572_spec.json').write_text(json.dumps(values,indent=2))
