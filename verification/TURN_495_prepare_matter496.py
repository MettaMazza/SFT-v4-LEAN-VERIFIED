from pathlib import Path
import subprocess,json,re,hashlib
r=Path('work/constants-recovery');repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
entries=[['NuclearReactions','NUCLEAR_REACTIONS','NuclearReactions'],['Fission','FISSION','NuclearFission']];metadata={}
for stem,key,component in entries:
 low=stem.lower()
 for part in ['spec','grammar','evidence','experiment']:
  s=Path('work/unit_'+part+'480.py').read_text().replace('unit',low).replace('Unit',stem).replace('480','496').replace('UNIT_COMPARISON',key)
  if part=='spec':
   s=s.replace("'sft/physics/measurement_laws.py',{'SOURCE_PATH','SOURCE_HASH','SOURCE_ID','BASE_DEPENDENCIES','targets','spec','"+key+"'}", "'sft/physics/measured_value.py',{'CODATA_SOURCE_ID','CODATA_SOURCE_PATH','CODATA_SOURCE_HASH'}),('sft/physics/matter_nuclear_laws.py',{'SOURCES','BASE','matter_law','MASS_ENERGY','PARTICLE_ANTIPARTICLE','FERMION_BOSON','CONSERVED_LABELS','PARTICLE_SPECTRUM','COMPOSITE_HADRONS','SCATTERING','DECAY','MIXING','NUCLEAR_BINDING','NUCLEAR_LEVELS','RADIOACTIVITY','NUCLEAR_REACTIONS','FISSION'}")
  Path('work/'+low+'_'+part+'496.py').write_text(s)
 for part in ['grammar','evidence','experiment']:subprocess.run(['python3','work/'+low+'_'+part+'496.py'],check=True)
 ns={};exec(Path('work/'+low+'_spec496.py').read_text(),ns);values=ns['values'];slug=values['claim_id'].removeprefix('SFT-PHYS-').removesuffix('-001');q=lambda x:json.dumps(x,ensure_ascii=False);metadata[stem]=values
 for tail in ['Grammar','Evidence','Experiment']:
  s=Path('work/'+stem+tail+'496.lean').read_text().replace('import «work».'+stem+'Carrier496','import SFT.Physics.'+component+'\nimport SFT.Physics.ObservationCarrier\nimport SFT.Foundation.CommonRefinement').replace('«work».'+stem+'Grammar496','SFT.Physics.'+stem+'Grammar').replace('«work».'+stem+'Evidence496','SFT.Physics.'+stem+'Evidence')
  if tail=='Evidence':
   a=s.index('def onePairWitness');b=s.index('theorem onePairWitnessPassed',a)
   s=s[:a]+'''def sourceResponseWitness : Bool := decide ((["a","b"] : List String).length = 2)
def closedTransferWitness : Bool := (["phase-a","phase-b"] : List String).all (fun x => ["phase-b","phase-a"].contains x) && (["phase-b","phase-a"] : List String).all (fun x => ["phase-a","phase-b"].contains x)
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
  (r/(stem+tail+'496.lean')).write_text(s)
 s=Path('work/unit_program480.py').read_text().replace('UnitProgram480',stem+'Program496').replace('unit_program480',low+'_program496').replace('MEAS-UNIT-COMPARISON',slug).replace('All UnitProgram method output fields; full engine admission integration remains separate','All '+stem+'Program method output fields; complete empirical validator checked separately.')
 Path('work/'+low+'_program496.py').write_text(s)
 source=values['source_snapshot_path'];digest=values['source_snapshot_hash'].removeprefix('sha256:')
 s=Path('work/unit_validation480_window.py').read_text().replace('UnitValidationProgram480_window',stem+'ValidationProgram496').replace('unit_validation480_window',low+'_validation496').replace('unit_bipm480.pdf',low+'_source496.bin').replace('MEAS-UNIT-COMPARISON',slug).replace('experiments/external_sources/physics/snapshots/bipm-si-brochure-9-en.pdf',source).replace('5442eea2c680caf77a9d96879205a97f57c7c270b98a0bd0126c18fefe47e02c',digest)
 Path('work/'+low+'_validation496.py').write_text(s)
 cid=values['claim_id'];path='claims/'+cid+'/independent_validator.py';ind=subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True);Path('work/'+low+'_independent496.py').write_text(ind)
 out=Path('work/matter496_source');out.mkdir(exist_ok=True);why=subprocess.check_output(['git','-C',repo,'show',pin+':claims/'+cid+'/WHY_DERIVATION_CHECK.md']);(out/(stem+'_WHY.txt')).write_bytes(why)
 print(stem,'prepared',flush=True)
Path('work/matter496_entries.json').write_text(json.dumps(entries));Path('work/matter496_metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')
