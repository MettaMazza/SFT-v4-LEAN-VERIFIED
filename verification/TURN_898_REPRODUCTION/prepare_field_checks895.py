from pathlib import Path
import sys,json
w=Path('work');r=w/'constants-recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_validation_v1 import VALIDATION_SPECS
items=[(k,t,n,s.claim_id) for (k,t,n),s in zip([('DYNAMICS','DynamicsValidation',895),('FIELD','RelativisticFieldValidation',896),('OPTICS','OpticsValidation',897),('LOOP','FiniteLoopValidation',898)],VALIDATION_SPECS)]
s=(w/'prepare_vacuum_checks879.py').read_text();a=s.index('items=');b=s.index('\nfor ',a);s=s[:a]+'items='+repr([(k,t,n) for k,t,n,_ in items])+s[b:];s=s.replace("cid='SFT-PHYS-VALIDATION-VACUUM-'+key+'-003'","cid="+repr({k:cid for k,_,_,cid in items})+"[key]").replace('VacuumAuthoritativeRecords','FieldAuthoritativeRecords');exec(compile(s,'field-checks895','exec'),dict(globals()))
s=(w/'audit_vacuum_validation879.py').read_text().replace('VacuumAuthoritative','FieldAuthoritative');(w/'audit_fieldvalidation895.py').write_text(s)
s=(w/'check_vacuum_validation_original879.py').read_text();a=s.index('from sft.physics.vacuum_');b=s.index('\nfrom sft.physics.generated',a);s=s[:a]+"import sys\nsys.path.insert(0,str(Path('work/v3-runtime500').resolve()))\nfrom sft.physics.relativistic_field_validation_v1 import VALIDATION_SPECS,VALIDATOR_BY_ID"+s[b:];s=s.replace("['vacuumfloorvalidation','vacuumpolarizationvalidation','vacuuminertiavalidation','vacuumextractionvalidation'],range(879,883)",repr([t.lower() for _,t,_,_ in items])+',range(895,899)');s=s[:s.index("(w/'vacuum879_original_classifications.json')")];(w/'check_fieldvalidation_original895.py').write_text(s)
# Native record driver checks actual JSON bytes and returns the entire original record and classifications.
s=(r/'VacuumAuthoritativeNative879.lean').read_text().replace('VacuumFloorValidation','DynamicsValidation').replace('VacuumAuthoritativeRecords','FieldAuthoritativeRecords');a=s.index(' let sources ←');s=s[:a]+''' let record ← IO.ofExcept (FieldAuthoritativeRecords.authoritativeRecord bytes files payload)
 let pairs ← ["dynamics_and_spectra","relativistic_and_electromagnetic_fields","optical_operations","finite_loops"].mapM fun key => do
  let value ← IO.ofExcept (FieldAuthoritativeRecords.classificationFromRecord record key)
  pure (key,Value.text value)
 IO.println (render (.object [("record",record),("classifications",.object pairs)]))
''';s=s.replace('import SFT.Physics.DynamicsValidationValidation','import SFT.Physics.FieldAuthoritativeWitnesses').replace('DynamicsValidationExperiment.sourcePath','\"experiments/external_sources/physics/snapshots/relativistic-field-source-record.json\"');(r/'FieldAuthoritativeNative895.lean').write_text(s)
s=(w/'prepare_vacuum_authoritative_native879.py').read_text().replace('VacuumFloorValidation','DynamicsValidation').replace('VacuumAuthoritativeNative879','FieldAuthoritativeNative895').replace("visit('SFT.Physics.DynamicsValidationValidation')","visit('SFT.Physics.FieldAuthoritativeWitnesses')");(w/'prepare_field_authoritative_native895.py').write_text(s)
(w/'fieldvalidation895_items.json').write_text(json.dumps(items))
