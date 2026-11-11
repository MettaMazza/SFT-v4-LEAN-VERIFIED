from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'amphoteric_spec585.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','amphoteric').replace('Unit','Amphoteric').replace('480','585');(w/('amphoteric_'+part+'585.py')).write_text(s);subprocess.run(['python3',str(w/('amphoteric_'+part+'585.py'))],check=True)
 s=(w/('Amphoteric'+part.capitalize()+'585.lean')).read_text().replace('import «work».AmphotericCarrier585','import SFT.Foundation.CommonRefinement').replace('import «work».AmphotericGrammar585','import SFT.Chemistry.AmphotericGrammar').replace('SFT.Physics.Amphoteric','SFT.Chemistry.Amphoteric')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('with carrier :=','with species :=')
 import re
 pieces=re.split(r'("(?:[^"\\]|\\.)*")',s)
 s=''.join(x if i%2 else x.replace('Acid-context','AcidContext').replace('Base-context','BaseContext').replace('acid-context','acidContext').replace('base-context','baseContext').replace('Acid-role','AcidRole').replace('Base-role','BaseRole').replace('acid-role','acidRole').replace('base-role','baseRole') for i,x in enumerate(pieces))
 (r/'SFT/Chemistry'/('Amphoteric'+part.capitalize()+'.lean')).write_text(s)
(w/'amphoteric585_spec.json').write_text(json.dumps(values,indent=2))
