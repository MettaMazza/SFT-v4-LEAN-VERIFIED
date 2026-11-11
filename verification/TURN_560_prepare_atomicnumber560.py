from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'atomicnumber_spec560.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','atomicnumber').replace('Unit','AtomicNumber').replace('480','560');(w/('atomicnumber_'+part+'560.py')).write_text(s);subprocess.run(['python3',str(w/('atomicnumber_'+part+'560.py'))],check=True)
 s=(w/('AtomicNumber'+part.capitalize()+'560.lean')).read_text().replace('import «work».AtomicNumberCarrier560','import SFT.Chemistry.AtomicNumberOrder\nimport SFT.Foundation.CommonRefinement').replace('import «work».AtomicNumberGrammar560','import SFT.Chemistry.AtomicNumberGrammar').replace('SFT.Physics.AtomicNumber','SFT.Chemistry.AtomicNumber')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 (r/'SFT/Chemistry'/('AtomicNumber'+part.capitalize()+'.lean')).write_text(s)
(w/'atomicnumber560_spec.json').write_text(json.dumps(values,indent=2))
