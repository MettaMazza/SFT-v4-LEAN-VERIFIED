from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'gblock_spec655.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','gblock').replace('Unit','GBlock').replace('480','655');(w/('gblock_'+part+'655.py')).write_text(s);subprocess.run(['python3',str(w/('gblock_'+part+'655.py'))],check=True)
 s=(w/('GBlock'+part.capitalize()+'655.lean')).read_text().replace('import «work».GBlockCarrier655','import SFT.Chemistry.GBlockWitnesses\nimport SFT.Chemistry.GBlockFilling\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».GBlockGrammar655','import SFT.Chemistry.GBlockGrammar').replace('SFT.Physics.GBlock','SFT.Chemistry.GBlock')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['match [SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 1),SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 2),SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 3),SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 4),SFT.Physics.AtomicOrbitCapacity.orbitCapacity (.integer 5)] with | [.ok 2,.ok 6,.ok 10,.ok 14,.ok 18] => true | _ => false','match GBlockOperations.nobleClosures (.integer 7) with | .ok [2,10,18,36,54,86,118] => true | _ => false','match GBlockOperations.firstOccupiedCoordinate (.integer 8) (.integer 1),GBlockOperations.firstOccupiedCoordinate (.integer 5) (.integer 5) with | .ok 119,.ok 121 => true | _,_ => false']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:]
  s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000')
 (r/'SFT/Chemistry'/('GBlock'+part.capitalize()+'.lean')).write_text(s)
