from pathlib import Path
import sys,json,platform
w=Path('work');r=w/'turn1064_recovery';stage=w/'pinned_conformerpopulation1495'
sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
x=json.loads((w/'conformerpopulation1495_interfaces_input.json').read_text());x.update(before=canonical_value(snapshot_protected_tree(stage)),after=canonical_value(snapshot_protected_tree(stage)),derivation_seal='native-conformerpopulation1495',host=platform.system(),implementation=platform.python_implementation());(w/'conformerpopulation1495_empirical_input.json').write_text(json.dumps(x,indent=2)+'\n')
s=(w/'ConformerValidationProgram1494.lean').read_text().replace('ConformerValidation','ConformerPopulationValidation').replace('ConformerExperiment','ConformerPopulationExperiment').replace('pinned_conformer1493','pinned_conformerpopulation1495').replace('conformer1493_empirical_input','conformerpopulation1495_empirical_input').replace('org_005_target_identities_v1','org_006_complete_target_identities_v1')
s=s.replace(' let result ← IO.ofExcept (ConformerPopulationValidation.validate identityActual identities targets primary sources derivationSeal host implementation before after)\n IO.println (SFT.Host.Canonical.render result.value)', ''' let result := ConformerPopulationValidation.validate identityActual identities targets primary sources derivationSeal host implementation before after
 let value : CJ := match result with
  | .error e => .object [("error",.text e)]
  | .ok r => r.value
 IO.println (SFT.Host.Canonical.render value)''')
(w/'ConformerPopulationValidation1495.lean').write_text(s)
s=(w/'prepare_conformerpopulation1495_interfaces_native.py').read_text().replace('ConformerPopulationAnalysis','ConformerPopulationValidation').replace('ConformerPopulationInterfaces1495','ConformerPopulationValidation1495').replace('conformerpopulation1495_interfaces_native','conformerpopulation1495_validation_native').replace('conformerpopulation1495_interfaces_report','conformerpopulation1495_validation_report')
s=s.replace("'conformer1494_program_optimized_build1492.json']:","'conformer1494_program_optimized_build1492.json','conformerpopulation1495_interfaces_native_build.json','conformerpopulation1495_program_native_build.json']:")
(w/'prepare_conformerpopulation1495_validation_native.py').write_text(s)
print('Prepared original protected-tree snapshot and full-validator runtime')
