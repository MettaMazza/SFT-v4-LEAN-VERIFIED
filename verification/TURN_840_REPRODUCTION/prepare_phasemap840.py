from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'phasemap_spec840.py').read_text(),ns);values=ns['values'];q=ns['q'];row=ns['namespace']['MATERIALS_OBLIGATIONS'][69]
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','phasemap').replace('Unit','PhaseMapMaterial').replace('480','840');(w/('phasemap_'+part+'840.py')).write_text(s);subprocess.run(['python3',str(w/('phasemap_'+part+'840.py'))],check=True)
 s=(w/('PhaseMapMaterial'+part.capitalize()+'840.lean')).read_text().replace('import «work».PhaseMapMaterialCarrier840','import SFT.Materials.Lattice\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».PhaseMapMaterialGrammar840','import SFT.Materials.PhaseMapMaterialGrammar').replace('SFT.Physics.PhaseMapMaterial','SFT.Materials.PhaseMapMaterial')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['!('+q(row.carrier)+' : String).isEmpty','!(SFT.Host.Text.equal '+q(row.relation)+' '+q(row.organization)+')','!(SFT.Host.Text.equal '+q(row.observation)+' '+q(row.organization)+')']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "materials"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000');(r/'SFT/Materials'/('PhaseMapMaterial'+part.capitalize()+'.lean')).write_text(s)
