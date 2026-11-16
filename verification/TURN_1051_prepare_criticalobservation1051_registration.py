from pathlib import Path
import json,re,hashlib
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');rep=json.loads((w/'criticalobservation1051_staged_report.json').read_text());mods=rep['modules'];decl=rep['declarations'];th=[];defs=[]
for m in mods:
 for kind,n in re.findall(r'^(def|theorem) (\w+)',(r/f'SFT/Physics/{m}.lean').read_text(),re.M):
  defs.append('SFT.Physics.'+m+'.'+n)
  if kind=='theorem':th.append('SFT.Physics.'+m+'.'+n)
checks=[f'criticalobservation1051_{k}_report.json'for k in ['analysis','staged','grammar','program','fresh','empirical']];cfg=dict(modules=mods,declarations=decl,theorems=th,definitions_and_theorems=defs,source_sha256=rep['source_sha256'],checks=checks,check_sha256={f:hashlib.sha256((w/f).read_bytes()).hexdigest()for f in checks});(w/'criticalobservation1051_proofs_config.json').write_text(json.dumps(cfg,indent=2));(w/'criticalobservation1051_full_audit.log').write_bytes((w/'criticalobservation1051_staged_audit.log').read_bytes())
s=(w/'register_spinobservation1049.py').read_text().replace('spinobservation1049','criticalobservation1051').replace('SpinCondensation','CriticalObservation').replace('spin_statistics_condensation','criticality_universality_turbulence').replace('SpinStatisticsCondensationValidator','CriticalityUniversalityTurbulenceValidator').replace('SPIN-STATISTICS-CONDENSATION-046','CRITICALITY-UNIVERSALITY-TURBULENCE-048').replace('SPIN_OBSERVATION_046','CRITICAL_OBSERVATION_048').replace('TURN_1049','TURN_1051').replace('TURN1049','TURN1051').replace('checkpoint1049','checkpoint1051').replace('TURN_1048_SPIN_STATISTICS_045','TURN_1050_CRITICALITY_047').replace('SpinStatisticsCondensationCertificate','CriticalityUniversality').replace('SpinStatisticsCertificateProof','CriticalityScaling').replace('post-seal BEC, Pauli-blocking and spinor validation','post-seal criticality, universality and turbulence validation')
a=s.index('scopes=');b=s.index('\nfor name',a);source='sft/physics/criticality_universality_turbulence_validation_v1.py';scopes={}
for m in mods:
 if m.endswith('Measurement'):scope='All24original exact_criticality_turbulence_analysis fields; exact integer conversions, literalBoolean tests, positive containment arithmetic, original five-row dictionary replacement/order and full target kernel equality; all numerical/row/adverse comparisons.'
 elif m.endswith('Records'):scope='All five original source hashes, exactschema,047formalreceipt and completefour-source guard.'
 elif m.endswith('Witnesses'):scope='Fouroriginal formal witnesses reuse complete047mean,identities,cascade andclasses certificate.'
 elif m.endswith('Grammar'):scope='Complete original eight-axis256candidates in sourceorder, exactfirstfailuredecisions, exhaustive carrier andunique survivor.'
 elif m.endswith('Evidence'):scope='Originalobservationalregistration,census,decisions,closure,controlsandcanonicalhashes.'
 elif m.endswith('Experiment'):scope='Four original source rows,single full-recordtarget, exactmetadata,predictiondocument andenvelope.'
 else:scope='Complete CriticalityUniversalityTurbulenceValidator: exactseal/source/custody/capability/packagechecks;20empiricalpredicates; allfouroriginal adversecontrols andwholecanonicalreceipt; unfavorableLa02retained.'
 scopes[m]=(source if m.endswith(('Measurement','Records','Validation'))else ('sft/physics/generated_empirical_law.py'if m.endswith('Evidence')else 'sft/physics/criticality_universality_turbulence_empirical_v1.py'),scope)
s=s[:a]+'scopes='+repr(scopes)+s[b:];(w/'register_criticalobservation1051.py').write_text(s)
state=json.loads((r/'CONTINUATION_STATE.json').read_text());state['criticalobservation1051_staged']={'claim_id':'SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048','registered':False,'live_jobs':[],'remaining':[],'reports':checks};(r/'CONTINUATION_STATE.json').write_text(json.dumps(state,indent=2)+'\n')
