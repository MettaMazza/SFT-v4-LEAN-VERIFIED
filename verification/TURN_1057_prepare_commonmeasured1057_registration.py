from pathlib import Path
import json,re,hashlib,shutil
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');a=json.load(open(w/'commonmeasured1057_staged_report.json'));a['theorems']=[];a['definitions_and_theorems']=[]
for m in a['modules']:
 s=(r/f'SFT/Physics/{m}.lean').read_text();a['theorems']+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M)];a['definitions_and_theorems']+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)]
a['checks']=['commonmeasured1056_analysis_report.json']+['commonmeasured1057_'+s for s in ['grammar_report.json','staged_report.json','program_report.json','fresh_report.json','empirical_report.json']];a['check_sha256']={f:hashlib.sha256((w/f).read_bytes()).hexdigest() for f in a['checks']}
base='sft/physics/common_scale_measured_value_successor_v1.py';validator='sft/physics/common_scale_measured_value_successor_validation_v1.py'
a['scopes']={
'CommonMeasuredAnalysis':(validator,'interval and exact_common_scale_analysis: general converted-Fraction intervals, source dictionary replacement, complete fifteen-field analysis and original measured/support-eight proofs;55complete record/error cases retained unchanged.'),
'CommonMeasuredRecords':(validator,'source_hashes and authoritative_record: all six source bindings, schema, formal and electroweak successor receipts, ordered source IDs and original two-stage dynamic methodological boundary.'),
'CommonMeasuredMeasurement':(validator,'Original immutable source-record and declared-controls decoder; all fifteen analysis fields with exact canonical fraction/dictionary serialization; arbitrary converted-Fraction analysis retained separately.'),
'CommonMeasuredWitnesses':(base,'Both SPEC.operational_witnesses: support-eight exactly25/106 and terminal proper share from original CommonScaleAxis operations, kernel-proved without changing the formal relation.'),
'CommonMeasuredGrammar':(base,'Eight original binary axes, complete256candidate product/order, original first-failure decisions, exhaustive criteria coverage and unique survivor.'),
'CommonMeasuredEvidence':('sft/physics/generated_empirical_law.py','Complete original native empirical programme: observationalDerivation provenance, registration/SPEC statement, census/decisions/closure/controls/hashes and unknown identifiers.'),
'CommonMeasuredExperiment':('sft/physics/generated_empirical_law.py','Exact three original target rows, original prediction programme, registration/envelope and complete single-record vault target.'),
'CommonMeasuredValidation':(validator,'CommonScaleMeasuredValueSuccessorValidator.validate: source custody, blind release, all fifteen analysis fields, exact indexed terminal/APV tampering, thirteen Boolean acceptance predicates, all source isolation/custody/payload hashes and measurement statements.')}
(w/'commonmeasured1057_proofs_config.json').write_text(json.dumps(a,indent=2));shutil.copy2(w/'commonmeasured1057_staged_audit.log',w/'commonmeasured1057_full_audit.log')
s=(w/'register_electroweak1056.py').read_text()
for old,new in [('electroweak1056','commonmeasured1057'),('TURN_1056','TURN_1057'),('TURN1056','TURN1057'),('ELECTROWEAK_MEASURED_053','COMMON_MEASURED_054'),('SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053','SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054'),('ElectroweakMeasured','CommonMeasured'),('complete electroweak measured-value entry','complete common-scale measured-value entry'),('checkpoint1056_electroweak_paths','checkpoint1057_paths')]:s=s.replace(old,new)
(w/'register_commonmeasured1057.py').write_text(s)
s=json.load(open(r/'CONTINUATION_STATE.json'));s['commonmeasured1057_staged']={'registered':False,'claim_id':'SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054'};(r/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n')
