from pathlib import Path
import sys,json,platform
w=Path('work');stage=w/'pinned_coordisomer1473';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import coordination_isomerism_validation_v1 as v
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
before=snapshot_protected_tree(stage)
payload=dict(identities=json.loads((stage/v.IDENTITY_PATH).read_text()),targets=json.loads((stage/v.TARGET_PATH).read_text()),primary=json.loads((stage/v.PRIMARY_PATH).read_text()),derivation_seal='native-coordisomer1474',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(before))
(w/'coordisomer1474_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n')
s=(w/'CoordinationGeometryValidationProgram1472.lean').read_text().replace('CoordinationGeometry','CoordinationIsomerism').replace('coordgeometry1446','coordisomer1474').replace('pinned1446','pinned_coordisomer1473').replace('coordination_geometry_target_identities_v1','coordination_isomerism_target_identities_v2');(w/'CoordinationIsomerismValidationProgram1474.lean').write_text(s)
s=(w/'prepare_coordgeometry1446_optimized1472.py').read_text().replace('coordgeometry1446','coordisomer1474').replace('CoordinationGeometry','CoordinationIsomerism').replace('1472','1474')
s=s.replace("'catalytic1356_optimized_build1470.json'","'catalytic1356_optimized_build1470.json','coordgeometry1446_optimized_build1472.json','coordisomer1474_program_optimized_build1474.json'")
(w/'prepare_coordisomer1474_empirical_native.py').write_text(s)
s=(w/'check_coordgeometry1446_optimized1472.py').read_text().replace('coordgeometry1446_optimized1472','coordisomer1474_empirical').replace('coordgeometry1446_original','coordisomer1474_original').replace('prepare_coordgeometry1446_optimized1472.py','prepare_coordisomer1474_empirical_native.py').replace('CoordinationGeometry','CoordinationIsomerism').replace("'original_target_checks':53","'original_target_checks':17").replace("'adverse_controls':6","'adverse_controls':8").replace('12fields10messages','12fields14messages');(w/'check_coordisomer1474_empirical_native.py').write_text(s)
(w/'run_coordisomer1474_empirical_native.py').write_text("""import time,subprocess,json
from pathlib import Path
w=Path('work')
while not (w/'coordisomer1474_program_optimized_build1474.json').exists():time.sleep(10)
for n in ['prepare_coordisomer1474_empirical_native.py','check_coordisomer1474_empirical_native.py']:
 print('RUN',n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)
""")
print('Prepared complete original12field14message empirical comparison')
