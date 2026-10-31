from pathlib import Path
import subprocess,re,json
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
entries=[('Realization','REFERENCE_REALIZATION','ReferenceRealization'),('ValueRecord','VALUE_RECORD','MeasuredValueRecord'),('Uncertainty','UNCERTAINTY','MeasurementUncertainty'),('Calibration','CALIBRATION','Calibration')]
for stem,key,component in entries:
 low=stem.lower()
 for part in ['spec','grammar','evidence','experiment']:
  s=Path('work/unit_'+part+'480.py').read_text().replace('unit',low).replace('Unit',stem).replace('480','481').replace('UNIT_COMPARISON',key)
  path=Path('work/'+low+'_'+part+'481.py');path.write_text(s)
 for part in ['grammar','evidence','experiment']:subprocess.run(['python3','work/'+low+'_'+part+'481.py'],check=True)
 for tail in ['Grammar','Evidence','Experiment']:
  s=Path('work/'+stem+tail+'481.lean').read_text().replace('import «work».'+stem+'Carrier481','import SFT.Physics.'+component+'\nimport SFT.Physics.ObservationCarrier\nimport SFT.Foundation.CommonRefinement').replace('«work».'+stem+'Grammar481','SFT.Physics.'+stem+'Grammar').replace('«work».'+stem+'Evidence481','SFT.Physics.'+stem+'Evidence')
  if tail=='Experiment':
   s='import SFT.Host.SHA256Window\n'+s
   s=s.replace('SHA256.digest bytes','SHA256Window.digest bytes')
   proof='\ntheorem sourceMatchesOriginal (bytes : ByteArray) :\n    sourceMatches bytes = Text.equal (Text.append "sha256:" (SHA256.digest bytes)) snapshotHash := by\n  unfold sourceMatches\n  rw [SHA256Window.digestPreserved]\n'
   # use exact established original theorem syntax instead of guessing the predicate
   u=(r/'SFT/Physics/UnitExperiment.lean').read_text();start=u.index('theorem sourceMatchesOriginal');end=u.index('\n',u.index('rw [SHA256Window.digestPreserved]',start))+1
   proof='\n'+u[start:end]
   s=s.replace('\nend SFT.Physics.'+stem+'Experiment',proof+'\nend SFT.Physics.'+stem+'Experiment')
  (r/'SFT/Physics'/(stem+tail+'.lean')).write_text(s)
 for tail in ['Validation','ValidationProofs']:
  s=(r/'SFT/Physics'/('Unit'+tail+'.lean')).read_text()
  for t in ['Validation','Experiment','Evidence','Grammar']:s=s.replace('Unit'+t,stem+t)
  (r/'SFT/Physics'/(stem+tail+'.lean')).write_text(s)
 for tail in ['Program','ValidationProgram']:
  s=(r/('Unit'+tail+'480.lean')).read_text()
  for t in ['Validation','Experiment','Evidence','Grammar']:s=s.replace('Unit'+t,stem+t)
  (r/(stem+tail+'481.lean')).write_text(s)
 s=Path('work/unit_program480.py').read_text().replace('UnitProgram480',stem+'Program481').replace('unit_program480',low+'_program481').replace('UNIT-COMPARISON',key.replace('_','-'))
 Path('work/'+low+'_program481.py').write_text(s)
 s=Path('work/unit_validation480_window.py').read_text().replace('UnitValidationProgram480_window',stem+'ValidationProgram481').replace('unit_validation480_window',low+'_validation481').replace('unit_bipm480','measurement_bipm481').replace('UNIT-COMPARISON',key.replace('_','-'))
 Path('work/'+low+'_validation481.py').write_text(s)
 path='claims/SFT-PHYS-MEAS-'+key.replace('_','-')+'-001/independent_validator.py'
 try:ind=subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
 except subprocess.CalledProcessError:
  listing=subprocess.check_output(['git','-C',repo,'ls-tree','-r','--name-only',pin,'claims/SFT-PHYS-MEAS-'+key.replace('_','-')+'-001'],text=True);print(listing);raise
 Path('work/'+low+'_independent481.py').write_text(ind)
 print(stem,'prepared',flush=True)
Path('work/measurement481_entries.json').write_text(json.dumps(entries))
