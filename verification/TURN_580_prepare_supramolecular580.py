from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'supramolecular_spec580.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','supramolecular').replace('Unit','Supramolecular').replace('480','580');(w/('supramolecular_'+part+'580.py')).write_text(s);subprocess.run(['python3',str(w/('supramolecular_'+part+'580.py'))],check=True)
 s=(w/('Supramolecular'+part.capitalize()+'580.lean')).read_text().replace('import «work».SupramolecularCarrier580','import SFT.Foundation.CommonRefinement').replace('import «work».SupramolecularGrammar580','import SFT.Chemistry.SupramolecularGrammar').replace('SFT.Physics.Supramolecular','SFT.Chemistry.Supramolecular')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with components :=')
 (r/'SFT/Chemistry'/('Supramolecular'+part.capitalize()+'.lean')).write_text(s)
(w/'supramolecular580_spec.json').write_text(json.dumps(values,indent=2))
