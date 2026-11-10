from pathlib import Path
import subprocess,json,re
r=Path('work/constants-recovery');w=Path('work');repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
entries=[('PlasmaMHD','PLASMA_MHD','CollectiveMagnetofluid')];metadata={}
for stem,key,component in entries:
 low=stem.lower()
 spec=(w/'unit_spec480.py').read_text().replace('UNIT_COMPARISON',key)
 spec=spec.replace("('sft/physics/measurement_laws.py',{'SOURCE_PATH','SOURCE_HASH','SOURCE_ID','BASE_DEPENDENCIES','targets','spec','"+key+"'})", "('sft/physics/measured_value.py',{'CODATA_SOURCE_ID','CODATA_SOURCE_PATH','CODATA_SOURCE_HASH'}),('sft/physics/collective_matter_laws.py',{'SOURCES','BASE','collective_law','COARSE_GRAIN','DENSITY','PRESSURE_STRESS','FLOW_CONSERVATION','INVISCID','VISCOSITY','TURBULENCE','PLASMA_COLLECTIVE','PLASMA_OSCILLATION','PLASMA_MHD'})")
 (w/(low+'_spec544.py')).write_text(spec)
 for part in ['grammar','evidence','experiment']:
  s=(w/('unit_'+part+'480.py')).read_text().replace('unit',low).replace('Unit',stem).replace('480','544');(w/(low+'_'+part+'544.py')).write_text(s);subprocess.run(['python3',str(w/(low+'_'+part+'544.py'))],check=True)
 ns={};exec(spec,ns);values=ns['values'];metadata[stem]=values;q=lambda x:json.dumps(x,ensure_ascii=False)
 for tail in ['Grammar','Evidence','Experiment']:
  s=(w/(stem+tail+'544.lean')).read_text().replace('import «work».'+stem+'Carrier544','import SFT.Physics.'+component+'\nimport SFT.Physics.ObservationCarrier\nimport SFT.Foundation.CommonRefinement').replace('«work».'+stem+'Grammar544','SFT.Physics.'+stem+'Grammar').replace('«work».'+stem+'Evidence544','SFT.Physics.'+stem+'Evidence')
  if tail=='Evidence':
   a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in values['operational_witnesses'])+']\n'+s[b:]
  if tail=='Experiment':
   s=s.replace(stem+'Evidence.onePairWitness',str(values['operational_witnesses'][0][2]).lower()).replace(stem+'Evidence.successorWitness',str(values['operational_witnesses'][1][2]).lower())
   s='import SFT.Host.SHA256Window\n'+s;s=s.replace('SHA256.digest bytes','SHA256Window.digest bytes');u=(r/'SFT/Physics/UnitExperiment.lean').read_text();a=u.index('theorem sourceMatchesOriginal');b=u.index('\n',u.index('rw [SHA256Window.digestPreserved]',a))+1;s=s.replace('\nend SFT.Physics.'+stem+'Experiment','\n'+u[a:b]+'\nend SFT.Physics.'+stem+'Experiment')
  (r/'SFT/Physics'/(stem+tail+'.lean')).write_text(s)
 for tail in ['Validation','ValidationProofs']:
  s=(r/'SFT/Physics'/('Unit'+tail+'.lean')).read_text()
  for t in ['Validation','Experiment','Evidence','Grammar']:s=s.replace('Unit'+t,stem+t)
  (r/'SFT/Physics'/(stem+tail+'.lean')).write_text(s)
 for tail in ['Program','ValidationProgram']:
  s=(r/('Unit'+tail+'480.lean')).read_text()
  for t in ['Validation','Experiment','Evidence','Grammar']:s=s.replace('Unit'+t,stem+t)
  (r/(stem+tail+'544.lean')).write_text(s)
 cid=values['claim_id']
 s=(w/'unit_program480.py').read_text().replace('UnitProgram480',stem+'Program544').replace('unit_program480',low+'_program544').replace('SFT-PHYS-MEAS-UNIT-COMPARISON-001',cid);(w/(low+'_program544.py')).write_text(s)
 s=(w/'unit_validation480_window.py').read_text().replace('UnitValidationProgram480_window',stem+'ValidationProgram544').replace('unit_validation480_window',low+'_validation544').replace('unit_bipm480.pdf',low+'_source544.bin').replace('SFT-PHYS-MEAS-UNIT-COMPARISON-001',cid).replace('experiments/external_sources/physics/snapshots/bipm-si-brochure-9-en.pdf',values['source_snapshot_path']).replace('5442eea2c680caf77a9d96879205a97f57c7c270b98a0bd0126c18fefe47e02c',values['source_snapshot_hash'].removeprefix('sha256:'));(w/(low+'_validation544.py')).write_text(s)
 (w/(low+'_independent544.py')).write_bytes(subprocess.check_output(['git','-C',repo,'show',pin+':claims/'+cid+'/independent_validator.py']))
 print(stem,'exact source adapters prepared')
(w/'collective544_entries.json').write_text(json.dumps(entries));(w/'collective544_metadata.json').write_text(json.dumps(metadata,indent=2))
