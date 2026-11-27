from pathlib import Path
import sys,json,platform
w=Path('work');stage=w/'pinned_nucleophilic1496';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry.nucleophilic_substitution_batch_v1 import IDENTITY_PATH,TARGET_PATH,PRIMARY_PATH
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
x={k:json.loads((stage/p).read_text())for k,p in [('identities',IDENTITY_PATH),('targets',TARGET_PATH),('primary',PRIMARY_PATH)]}
x.update(identity_path=IDENTITY_PATH,target_path=TARGET_PATH,primary_path=PRIMARY_PATH,before=canonical_value(snapshot_protected_tree(stage)),after=canonical_value(snapshot_protected_tree(stage)),derivation_seal='native-nucleophilic1497',host=platform.system(),implementation=platform.python_implementation())
(w/'nucleophilic1497_empirical_input.json').write_text(json.dumps(x,indent=2)+'\n')
s=(w/'ConformerPopulationValidation1495.lean').read_text().replace('ConformerPopulationValidation','NucleophilicValidation').replace('ConformerPopulationExperiment','NucleophilicExperiment').replace('pinned_conformerpopulation1495','pinned_nucleophilic1496').replace('conformerpopulation1495_empirical_input','nucleophilic1497_empirical_input')
a=s.index(' let identityActual ←');b=s.index(' let before ←',a)
s=s[:a]+''' let identityActual ← sourceHash (← IO.ofExcept (text input "identity_path"))
 let targetActual ← sourceHash (← IO.ofExcept (text input "target_path"))
 let primaryActual ← sourceHash (← IO.ofExcept (text input "primary_path"))
 let rows ← IO.ofExcept (items (← IO.ofExcept (field input "targets")) "rows")
 let sources ← rows.mapM fun row => do
  let path ← IO.ofExcept (text row "opened_snapshot_path")
  return (path,← sourceHash path)
'''+s[b:]
s=s.replace('NucleophilicValidation.validate identityActual identities targets primary sources','NucleophilicValidation.validate identityActual targetActual primaryActual identities targets primary sources')
(w/'NucleophilicValidation1497.lean').write_text(s)
s=(w/'prepare_nucleophilic1497_analysis_native.py').read_text().replace('NucleophilicAnalysis','NucleophilicValidation').replace('nucleophilic1497_analysis','nucleophilic1497_validation')
s=s.replace("'conformerpopulation1495_interfaces_native_build.json']:","'conformerpopulation1495_interfaces_native_build.json','nucleophilic1497_analysis_native_build.json','nucleophilic1497_program_native_build.json']:")
(w/'prepare_nucleophilic1497_validation_native.py').write_text(s)
print('Prepared fresh source-byte hashes, original snapshots and validator runtime')
