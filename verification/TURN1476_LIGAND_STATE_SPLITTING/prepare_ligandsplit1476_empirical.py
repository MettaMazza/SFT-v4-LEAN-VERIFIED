from pathlib import Path
import sys,json,platform
w=Path('work');stage=w/'pinned_ligandsplit1474';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import ligand_state_splitting_validation_v1 as v
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
before=snapshot_protected_tree(stage)
payload=dict(identities=json.loads((stage/v.IDENTITY_PATH).read_text()),targets=json.loads((stage/v.TARGET_PATH).read_text()),primary=json.loads((stage/v.PRIMARY_PATH).read_text()),derivation_seal='native-ligandsplit1475',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(before))
(w/'ligandsplit1476_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n')
s=(w/'CoordinationIsomerismValidationProgram1474.lean').read_text().replace('CoordinationIsomerism','LigandStateSplitting').replace('coordisomer1474','ligandsplit1476').replace('pinned_coordisomer1473','pinned_ligandsplit1474').replace('coordination_isomerism_target_identities_v2','ligand_state_splitting_target_identities_v1');(w/'LigandStateSplittingValidationProgram1476.lean').write_text(s)
s=(w/'prepare_coordisomer1474_empirical_native.py').read_text().replace('coordisomer1474','ligandsplit1476').replace('CoordinationIsomerism','LigandStateSplitting').replace('Program1474','Program1476').replace('optimized1474','optimized1476').replace('build1474','build1476')
s=s.replace("'ligandsplit1476_program_optimized_build1476.json'", "'coordisomer1474_program_optimized_build1474.json','coordisomer1474_optimized_build1474.json','ligandsplit1475_program_optimized_build1475.json'")
(w/'prepare_ligandsplit1476_empirical_native.py').write_text(s)
s=(w/'check_coordisomer1474_empirical_native.py').read_text().replace('coordisomer1474','ligandsplit1476').replace('CoordinationIsomerism','LigandStateSplitting').replace('ligandsplit1476_original_empirical','ligandsplit1475_original_empirical').replace("'original_target_checks':17","'original_target_checks':32").replace("'adverse_controls':8","'adverse_controls':7").replace('12fields14messages','12fields13messages');(w/'check_ligandsplit1476_empirical_native.py').write_text(s)
(w/'run_ligandsplit1476_empirical_native.py').write_text("import subprocess\nfor n in ['prepare_ligandsplit1476_empirical_native.py','check_ligandsplit1476_empirical_native.py']:\n print('RUN',n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)\n")
print('Prepared full original12field13message native comparison')
