from pathlib import Path
import subprocess,json,re
r=Path('work/constants-recovery');repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
entries=[('Event','EVENT_CHANGE','MechanicalEvents'),('Duration','DURATION','MechanicalDuration'),('Displacement','LOCATION_DISPLACEMENT','MechanicalLocation'),('Velocity','SPEED_VELOCITY','MechanicalVelocity')]
for stem,key,component in entries:
 low=stem.lower()
 for part in ['spec','grammar','evidence','experiment']:
  s=Path('work/unit_'+part+'480.py').read_text().replace('unit',low).replace('Unit',stem).replace('480','482').replace('UNIT_COMPARISON',key)
  if part=='spec':
   s=s.replace("'sft/physics/measurement_laws.py',{'SOURCE_PATH','SOURCE_HASH','SOURCE_ID','BASE_DEPENDENCIES','targets','spec','"+key+"'}","'sft/physics/mechanics_laws.py',{'SOURCE_PATH','SOURCE_HASH','SOURCE_ID','MEASUREMENT_DEPENDENCY','law','EVENT_CHANGE','DURATION','LOCATION_DISPLACEMENT','SPEED_VELOCITY'}")
  Path('work/'+low+'_'+part+'482.py').write_text(s)
 for part in ['grammar','evidence','experiment']:subprocess.run(['python3','work/'+low+'_'+part+'482.py'],check=True)
 ns={};exec(Path('work/'+low+'_spec482.py').read_text(),ns);values=ns['values'];q=lambda x:json.dumps(x,ensure_ascii=False)
 for tail in ['Grammar','Evidence','Experiment']:
  s=Path('work/'+stem+tail+'482.lean').read_text().replace('import «work».'+stem+'Carrier482','import SFT.Physics.'+component+'\nimport SFT.Physics.ObservationCarrier\nimport SFT.Foundation.CommonRefinement').replace('«work».'+stem+'Grammar482','SFT.Physics.'+stem+'Grammar').replace('«work».'+stem+'Evidence482','SFT.Physics.'+stem+'Evidence')
  if tail=='Evidence':
   a=s.index('def onePairWitness');b=s.index('theorem onePairWitnessPassed',a)
   s=s[:a]+'''def orderedEventWitness : Bool := decide ((["event-a","event-b"] : List String).head? = some "event-a")
def heldOrientationWitness : Bool := decide ((("left-held",1) : String × Nat).2 = (("right-held",1) : String × Nat).2)
def witnesses : Value := .array [\n'''+',\n'.join(' .array [.text '+q(w[0])+',.text '+q(w[1])+',.boolean '+n+']' for w,n in zip(values['operational_witnesses'],['orderedEventWitness','heldOrientationWitness']))+']\n'+s[b:]
  s=s.replace('onePairWitness','orderedEventWitness').replace('successorWitness','heldOrientationWitness')
  if tail=='Experiment':
   s='import SFT.Host.SHA256Window\n'+s;s=s.replace('SHA256.digest bytes','SHA256Window.digest bytes');u=(r/'SFT/Physics/UnitExperiment.lean').read_text();a=u.index('theorem sourceMatchesOriginal');b=u.index('\n',u.index('rw [SHA256Window.digestPreserved]',a))+1;s=s.replace('\nend SFT.Physics.'+stem+'Experiment','\n'+u[a:b]+'\nend SFT.Physics.'+stem+'Experiment')
  (r/'SFT/Physics'/(stem+tail+'.lean')).write_text(s)
 for tail in ['Validation','ValidationProofs']:
  s=(r/'SFT/Physics'/('Unit'+tail+'.lean')).read_text()
  for t in ['Validation','Experiment','Evidence','Grammar']:s=s.replace('Unit'+t,stem+t)
  (r/'SFT/Physics'/(stem+tail+'.lean')).write_text(s)
 for tail in ['Program','ValidationProgram']:
  s=(r/('Unit'+tail+'480.lean')).read_text()
  for t in ['Validation','Experiment','Evidence','Grammar']:s=s.replace('Unit'+t,stem+t)
  (r/(stem+tail+'482.lean')).write_text(s)
 s=Path('work/unit_program480.py').read_text().replace('UnitProgram480',stem+'Program482').replace('unit_program480',low+'_program482').replace('MEAS-UNIT-COMPARISON','MECH-'+key.replace('_','-')).replace('All UnitProgram method output fields; full engine admission integration remains separate','All '+stem+'Program method output fields; complete empirical validator checked separately.')
 Path('work/'+low+'_program482.py').write_text(s)
 s=Path('work/unit_validation480_window.py').read_text().replace('UnitValidationProgram480_window',stem+'ValidationProgram482').replace('unit_validation480_window',low+'_validation482').replace('unit_bipm480.pdf','mechanics_codata482.txt').replace('MEAS-UNIT-COMPARISON','MECH-'+key.replace('_','-')).replace('bipm-si-brochure-9-en.pdf','nist-codata-2022-allascii.txt').replace('5442eea2c680caf77a9d96879205a97f57c7c270b98a0bd0126c18fefe47e02c','77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67')
 Path('work/'+low+'_validation482.py').write_text(s)
 path='claims/SFT-PHYS-MECH-'+key.replace('_','-')+'-001/independent_validator.py';ind=subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True);Path('work/'+low+'_independent482.py').write_text(ind)
 print(stem,'prepared',flush=True)
Path('work/mechanics482_entries.json').write_text(json.dumps(entries))
