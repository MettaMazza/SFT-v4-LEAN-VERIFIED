from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'material_spec651.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','material').replace('Unit','Material').replace('480','651');(w/('material_'+part+'651.py')).write_text(s);subprocess.run(['python3',str(w/('material_'+part+'651.py'))],check=True)
 s=(w/('Material'+part.capitalize()+'651.lean')).read_text().replace('import «work».MaterialCarrier651','import SFT.Materials.MaterialIdentity\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».MaterialGrammar651','import SFT.Materials.MaterialGrammar').replace('SFT.Physics.Material','SFT.Materials.Material')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['!("complete-constituent-carrier" : String).isEmpty','!(SFT.Host.Text.equal "composition-and-bonding-retained" "material-boundary-held")','!(SFT.Host.Text.equal "declared-scale-identity" "material-boundary-held")']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:]
  s=s.replace('branch := "physics"','branch := "materials"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000')
 (r/'SFT/Materials'/('Material'+part.capitalize()+'.lean')).write_text(s)
