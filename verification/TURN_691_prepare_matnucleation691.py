from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'matnucleation_spec691.py').read_text(),ns);values=ns['values'];q=ns['q'];row=ns['namespace']['MATERIALS_OBLIGATIONS'][24]
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','matnucleation').replace('Unit','Nucleation').replace('480','691');(w/('matnucleation_'+part+'691.py')).write_text(s);subprocess.run(['python3',str(w/('matnucleation_'+part+'691.py'))],check=True)
 s=(w/('Nucleation'+part.capitalize()+'691.lean')).read_text().replace('import «work».NucleationCarrier691','import SFT.Materials.Lattice\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».NucleationGrammar691','import SFT.Materials.NucleationGrammar').replace('SFT.Physics.Nucleation','SFT.Materials.Nucleation')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['!('+q(row.carrier)+' : String).isEmpty','!(SFT.Host.Text.equal '+q(row.relation)+' '+q(row.organization)+')','!(SFT.Host.Text.equal '+q(row.observation)+' '+q(row.organization)+')']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "materials"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000');(r/'SFT/Materials'/('Nucleation'+part.capitalize()+'.lean')).write_text(s)
