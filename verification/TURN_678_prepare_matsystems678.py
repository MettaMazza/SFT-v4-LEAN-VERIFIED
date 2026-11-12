from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'matsystems_spec678.py').read_text(),ns);values=ns['values'];q=ns['q'];row=ns['namespace']['MATERIALS_OBLIGATIONS'][12]
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','matsystems').replace('Unit','Systems').replace('480','678');(w/('matsystems_'+part+'678.py')).write_text(s);subprocess.run(['python3',str(w/('matsystems_'+part+'678.py'))],check=True)
 s=(w/('Systems'+part.capitalize()+'678.lean')).read_text().replace('import «work».SystemsCarrier678','import SFT.Materials.Lattice\nimport SFT.Materials.CrystalSystems\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».SystemsGrammar678','import SFT.Materials.SystemsGrammar').replace('SFT.Physics.Systems','SFT.Materials.Systems')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['!('+q(row.carrier)+' : String).isEmpty','!(SFT.Host.Text.equal '+q(row.relation)+' '+q(row.organization)+')','!(SFT.Host.Text.equal '+q(row.observation)+' '+q(row.organization)+')']
  ws.append('(match CrystalSystems.crystalSystemCensus with | .ok rows => rows.length == 7 | .error _ => false)')
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "materials"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000');(r/'SFT/Materials'/('Systems'+part.capitalize()+'.lean')).write_text(s)
