from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'matrotation_spec677.py').read_text(),ns);values=ns['values'];q=ns['q'];row=ns['namespace']['MATERIALS_OBLIGATIONS'][11]
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','matrotation').replace('Unit','Rotation').replace('480','677');(w/('matrotation_'+part+'677.py')).write_text(s);subprocess.run(['python3',str(w/('matrotation_'+part+'677.py'))],check=True)
 s=(w/('Rotation'+part.capitalize()+'677.lean')).read_text().replace('import «work».RotationCarrier677','import SFT.Materials.Lattice\nimport SFT.Materials.RotationClosure\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».RotationGrammar677','import SFT.Materials.RotationGrammar').replace('SFT.Physics.Rotation','SFT.Materials.Rotation')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['!('+q(row.carrier)+' : String).isEmpty','!(SFT.Host.Text.equal '+q(row.relation)+' '+q(row.organization)+')','!(SFT.Host.Text.equal '+q(row.observation)+' '+q(row.organization)+')']
  ws.append('(match RotationCertificate.allowedCrystallographicOrders, RotationCertificate.rotationFactorCertificate with | .ok orders, .ok certificate => (orders.map Subtype.val == [1,2,3,4,6]) && (certificate.leastExcluded.val == 5) | _, _ => false)')
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:];s=s.replace('branch := "physics"','branch := "materials"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000');(r/'SFT/Materials'/('Rotation'+part.capitalize()+'.lean')).write_text(s)
