from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'property_spec660.py').read_text(),ns);values=ns['values'];q=ns['q'];row=ns['namespace']['MATERIALS_OBLIGATIONS'][5]
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','property').replace('Unit','Property').replace('480','660');(w/('property_'+part+'660.py')).write_text(s);subprocess.run(['python3',str(w/('property_'+part+'660.py'))],check=True)
 s=(w/('Property'+part.capitalize()+'660.lean')).read_text().replace('import «work».PropertyCarrier660','import SFT.Materials.PropertyRelation\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».PropertyGrammar660','import SFT.Materials.PropertyGrammar').replace('SFT.Physics.Property','SFT.Materials.Property')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['!('+q(row.carrier)+' : String).isEmpty','!(SFT.Host.Text.equal '+q(row.relation)+' '+q(row.organization)+')','!(SFT.Host.Text.equal '+q(row.observation)+' '+q(row.organization)+')']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "materials"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000');(r/'SFT/Materials'/('Property'+part.capitalize()+'.lean')).write_text(s)
