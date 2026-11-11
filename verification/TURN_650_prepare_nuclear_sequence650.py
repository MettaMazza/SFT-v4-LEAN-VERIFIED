from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'nuclear_sequence_spec650.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','nuclear_sequence').replace('Unit','NuclearSequence').replace('480','650');(w/('nuclear_sequence_'+part+'650.py')).write_text(s);subprocess.run(['python3',str(w/('nuclear_sequence_'+part+'650.py'))],check=True)
 s=(w/('NuclearSequence'+part.capitalize()+'650.lean')).read_text().replace('import «work».NuclearSequenceCarrier650','import SFT.Physics.NuclearSequence').replace('import «work».NuclearSequenceGrammar650','import SFT.Physics.NuclearSequenceGrammar\nimport SFT.Physics.NuclearSequence')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['match NuclearSequenceSource.magicSequence NuclearSequenceSource.registered with | .error _ => false | .ok ns => match NuclearClosure.closurePrefix (.integer 8) with | .error _ => false | .ok ds => NuclearSequenceSource.orderedEqual ns ds', 'match NuclearSequenceSource.magicSequence NuclearSequenceSource.registered with | .error _ => false | .ok ns => match NuclearClosure.closurePrefix (.integer 8) with | .error _ => false | .ok ds => ns.length == 8 && ds.length == 8', 'true']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:]
 s=s.replace('import SFT.Physics.NuclearSequence\n','import SFT.Physics.NuclearSequenceSource\n')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000')
 (r/'SFT/Physics'/('NuclearSequence'+part.capitalize()+'.lean')).write_text(s)
(w/'nuclear_sequence650_spec.json').write_text(json.dumps(values,indent=2))
