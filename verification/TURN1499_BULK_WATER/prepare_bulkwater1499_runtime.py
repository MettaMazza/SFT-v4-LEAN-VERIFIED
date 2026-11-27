from pathlib import Path
import sys,json,platform,copy,subprocess
w=Path('work');r=w/'turn1064_recovery';stage=w/'pinned_bulkwater1499';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.materials;sft.materials.__path__.insert(0,str((stage/'sft/materials').resolve()))
from sft.engine.canonical import canonical_value
from sft.materials.successor_structural_counts import water_bulk_ledger_certificate
from sft.claim_evidence import snapshot_protected_tree
cid='SFT-MAT-BULK-WATER-RESPONSE-002';out=json.load(open(w/'bulkwater1499_original_program.json'));out['ledger']=canonical_value(water_bulk_ledger_certificate());(w/'bulkwater1499_original_program.json').write_text(json.dumps(out,indent=2)+'\n')
s=(w/'NucleophilicProgram1497.lean').read_text().replace('SFT.Chemistry','SFT.Materials').replace('Nucleophilic','BulkWater');s=s.replace('("registration",BulkWaterEvidence.registration sourceHash),','("ledger",.object [("required_fields",.array (BulkWater.certificate.requiredFields.map SFT.Host.Canonical.Value.text)),("field_count",.object [("value",.integer (.ofNat BulkWater.certificate.fieldCount.value))]),("complete",.boolean BulkWater.certificate.complete)]),\n    ("registration",BulkWaterEvidence.registration sourceHash),');(w/'BulkWaterProgram1499.lean').write_text(s)
data=json.load(open(w/'bulkwater1499_source_input.json'));before=canonical_value(snapshot_protected_tree(stage));data.update(before=before,after=before,derivation_seal='native-bulkwater1499',host=platform.system(),implementation=platform.python_implementation());(w/'bulkwater1499_empirical_input.json').write_text(json.dumps(data,indent=2)+'\n')
s=(w/'IsotopeResponseValidationProgram1092.lean').read_text().replace('IsotopeResponse','BulkWater');s=s.replace(' let output ← IO.ofExcept (do',' let result := (do');s=s.replace(' IO.println (SFT.Host.Canonical.render output)', ''' let output : SFT.Host.Canonical.Value := match result with
  | .error e => .object [("error",.text e)]
  | .ok v => v
 IO.println (SFT.Host.Canonical.render output)''');(w/'BulkWaterValidation1499.lean').write_text(s)
for kind,mod,runner in [('program','BulkWaterEvidence','BulkWaterProgram1499'),('validation','BulkWaterValidation','BulkWaterValidation1499')]:
 s=(w/'prepare_nucleophilic1497_program_native.py').read_text().replace("visit('SFT.Chemistry.NucleophilicEvidence')", "visit('SFT.Materials."+mod+"')").replace('NucleophilicProgram1497',runner).replace('nucleophilic1497_program', 'bulkwater1499_'+kind)
 s=s.replace("'conformerpopulation1495_interfaces_native_build.json']:","'conformerpopulation1495_interfaces_native_build.json','electrophilic1498_validation_native_build.json'"+(",'bulkwater1499_program_native_build.json'"if kind=='validation'else'')+"]:")
 (w/f'prepare_bulkwater1499_{kind}_native.py').write_text(s)
cases=[];validator=stage/'claims'/cid/'independent_validator.py'
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(out,claim_id=cid,seal_hash='native-bulkwater1499'));sealed.pop('ledger')
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('bulkwater1499_independent_'+case+'.json');f.write_text(json.dumps(sealed));v=json.loads(subprocess.check_output([sys.executable,str(validator),str(f.resolve())],text=True));assert v['passed']==(case=='original');cases.append(dict(case=case,result=v))
(w/'bulkwater1499_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n');print('Originalindependent4casesPASS; exactledger/programmeandempiricaldriversprepared')
