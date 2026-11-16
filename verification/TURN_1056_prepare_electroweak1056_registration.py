from pathlib import Path
import json,re,hashlib,shutil
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');a=json.load(open(w/'electroweak1056_staged_report.json'));a['theorems']=[];a['definitions_and_theorems']=[]
for m in a['modules']:
 s=(r/f'SFT/Physics/{m}.lean').read_text();a['theorems']+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M)];a['definitions_and_theorems']+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)]
a['checks']=['electroweak1056_'+s for s in ['analysis_report.json','grammar_report.json','staged_report.json','program_report.json','fresh_report.json','empirical_report.json']];a['check_sha256']={f:hashlib.sha256((w/f).read_bytes()).hexdigest() for f in a['checks']}
base='sft/physics/electroweak_measured_value_successor_v1.py';validator='sft/physics/electroweak_measured_value_successor_validation_v1.py'
a['scopes']={
'ElectroweakMeasuredAnalysis':(validator,'interval and exact_electroweak_analysis: arbitrary converted Fraction inputs with original interval guards, all ten analysis fields, original immutable target and both direct/W tampering controls. Reuses terminal sine/cosine and exact partition;47 complete output/error comparisons.'),
'ElectroweakMeasuredRecords':(validator,'source_hashes and authoritative_record: all three original source files, schema, formal receipt, ordered two-source identities and dynamic literal-Boolean methodological boundary.'),
'ElectroweakMeasuredMeasurement':(validator,'exact_electroweak_analysis: immutable original source-record and declared controls decoder, exact canonical ten-field analysis serialization; general Fraction-input domain retained in Analysis.'),
'ElectroweakMeasuredWitnesses':(base,'SPEC.operational_witnesses: exact proper terminal share and One-complement partition, both proved from existing formal operations.'),
'ElectroweakMeasuredGrammar':(base,'SPEC.dimensions: eight original binary axes, full256 candidate product/order, exact first-failure decisions and unique survivor.'),
'ElectroweakMeasuredEvidence':('sft/physics/generated_empirical_law.py','Complete native generated empirical programme, original observationalDerivation provenance and SPEC statement, source registration/census/decisions/closure/controls/hash/unknown behavior.'),
'ElectroweakMeasuredExperiment':('sft/physics/generated_empirical_law.py','Exact two original target rows, original prediction programme, experiment registration, complete single-record vault target and envelope.'),
'ElectroweakMeasuredValidation':(validator,'ElectroweakMeasuredValueSuccessorValidator.validate: source custody, blinded prediction/release, exact ten-field comparison, both original controls, all original isolation/custody/payload hashes and measurements.')}
(w/'electroweak1056_proofs_config.json').write_text(json.dumps(a,indent=2));shutil.copy2(w/'electroweak1056_staged_audit.log',w/'electroweak1056_full_audit.log')
s=json.load(open(r/'CONTINUATION_STATE.json'));s['electroweak1056_staged']={'registered':False,'claim_id':'SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053'};(r/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n')
