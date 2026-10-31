from pathlib import Path
import subprocess,json,re,hashlib
r=Path('work/constants-recovery');repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
entries=[('Magnetic', 'MAGNETIC', 'FieldMagnetic'), ('Induction', 'INDUCTION', 'FieldInduction'), ('Electromagnetic', 'ELECTROMAGNETIC_COMPOSITION', 'FieldElectromagnetic'), ('GaugeEquivalence', 'GAUGE_EQUIVALENCE', 'FieldGaugeEquivalence'), ('Locality', 'LOCALITY_CAUSALITY', 'FieldLocality')];metadata={}
for stem,key,component in entries:
 low=stem.lower()
 for part in ['spec','grammar','evidence','experiment']:
  s=Path('work/unit_'+part+'480.py').read_text().replace('unit',low).replace('Unit',stem).replace('480','488').replace('UNIT_COMPARISON',key)
  if part=='spec':s=s.replace("'sft/physics/measurement_laws.py',{'SOURCE_PATH','SOURCE_HASH','SOURCE_ID','BASE_DEPENDENCIES','targets','spec','"+key+"'}","'sft/physics/field_laws.py',{'SOURCES','BASE','field_law','SOURCE_RESPONSE','GEOMETRIC_DILUTION','GRAVITATIONAL_INTERACTION','ELECTRIC_DISTINCTION','ELECTRIC_POTENTIAL','MAGNETIC','INDUCTION','ELECTROMAGNETIC_COMPOSITION','GAUGE_EQUIVALENCE','LOCALITY_CAUSALITY'}")
  Path('work/'+low+'_'+part+'488.py').write_text(s)
 for part in ['grammar','evidence','experiment']:subprocess.run(['python3','work/'+low+'_'+part+'488.py'],check=True)
 ns={};exec(Path('work/'+low+'_spec488.py').read_text(),ns);values=ns['values'];q=lambda x:json.dumps(x,ensure_ascii=False);metadata[stem]=values
 for tail in ['Grammar','Evidence','Experiment']:
  s=Path('work/'+stem+tail+'488.lean').read_text().replace('import «work».'+stem+'Carrier488','import SFT.Physics.'+component+'\nimport SFT.Physics.ObservationCarrier\nimport SFT.Foundation.CommonRefinement').replace('«work».'+stem+'Grammar488','SFT.Physics.'+stem+'Grammar').replace('«work».'+stem+'Evidence488','SFT.Physics.'+stem+'Evidence')
  if tail=='Evidence':
   a=s.index('def onePairWitness');b=s.index('theorem onePairWitnessPassed',a)
   s=s[:a]+'''def sourceResponseWitness : Bool := decide ((("source","response") : String × String).1 = "source")
def closedTransferWitness : Bool := decide ((["source","destination"] : List String).eraseDups.length = 2)
def witnesses : Value := .array [\n'''+',\n'.join(' .array [.text '+q(w[0])+',.text '+q(w[1])+',.boolean '+n+']' for w,n in zip(values['operational_witnesses'],['sourceResponseWitness','closedTransferWitness']))+']\n'+s[b:]
  s=s.replace('onePairWitness','sourceResponseWitness').replace('successorWitness','closedTransferWitness')
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
  (r/(stem+tail+'488.lean')).write_text(s)
 s=Path('work/unit_program480.py').read_text().replace('UnitProgram480',stem+'Program488').replace('unit_program480',low+'_program488').replace('MEAS-UNIT-COMPARISON','FIELD-'+key.replace('_','-')).replace('All UnitProgram method output fields; full engine admission integration remains separate','All '+stem+'Program method output fields; complete empirical validator checked separately.')
 Path('work/'+low+'_program488.py').write_text(s)
 source=values['source_snapshot_path'];digest=values['source_snapshot_hash'].removeprefix('sha256:')
 s=Path('work/unit_validation480_window.py').read_text().replace('UnitValidationProgram480_window',stem+'ValidationProgram488').replace('unit_validation480_window',low+'_validation488').replace('unit_bipm480.pdf',low+'_source488.bin').replace('MEAS-UNIT-COMPARISON','FIELD-'+key.replace('_','-')).replace('experiments/external_sources/physics/snapshots/bipm-si-brochure-9-en.pdf',source).replace('5442eea2c680caf77a9d96879205a97f57c7c270b98a0bd0126c18fefe47e02c',digest)
 Path('work/'+low+'_validation488.py').write_text(s)
 cid='SFT-PHYS-FIELD-'+key.replace('_','-')+'-001';path='claims/'+cid+'/independent_validator.py';ind=subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True);Path('work/'+low+'_independent488.py').write_text(ind)
 out=Path('work/field488_source');out.mkdir(exist_ok=True);why=subprocess.check_output(['git','-C',repo,'show',pin+':claims/'+cid+'/WHY_DERIVATION_CHECK.md']);(out/(stem+'_WHY.txt')).write_bytes(why)
 print(stem,'prepared',flush=True)
Path('work/field488_entries.json').write_text(json.dumps(entries));Path('work/field488_metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')
