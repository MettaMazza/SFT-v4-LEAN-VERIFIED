from pathlib import Path
import sys,json,ast
from types import SimpleNamespace
w=Path('work');stage=w/'pinned_conformerpopulation1495'
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry import conformer_population_ordering_validation_v1 as v
from sft.claim_evidence import CapabilityClosedFoldInterpreter,fold_program_from_mapping
from sft.engine.exact import HeldLabel
from sft.engine.canonical import canonical_value
x=json.loads((w/'conformerpopulation1495_interfaces_input.json').read_text());document=v.prediction_program_document(stage);execution=CapabilityClosedFoldInterpreter().execute(fold_program_from_mapping(document),{'registered-premise':HeldLabel('sealed-derivation','native-conformerpopulation1495')})
rows=tuple(x['targets']['rows']);release=SimpleNamespace(targets={row['target_id']:HeldLabel('external-complete-source-record-hash',row['target_payload_hash'])for row in rows})
# Execute the exact original post-seal comparison/analysis/control statements as a component test.
# This does not bypass or claim success for the separately checked full source-snapshot guard.
tree=ast.parse((stage/'sft/chemistry/conformer_population_ordering_validation_v1.py').read_text());cls=next(n for n in tree.body if isinstance(n,ast.ClassDef));method=next(n for n in cls.body if isinstance(n,ast.FunctionDef)and n.name=='validate');body=method.body
def assigns(n,key):return isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id==key for t in n.targets)
a=next(i for i,n in enumerate(body)if assigns(n,'comparisons'));b=next(i for i,n in enumerate(body)if assigns(n,'passed'))
env=dict(v.__dict__);env.update(self=SimpleNamespace(root=stage),predictions=v._prediction_map(execution.output),rows=rows,release=release,document=document)
exec(compile(ast.Module(body=body[a:b+1],type_ignores=[]),'original_postseal_component','exec'),env)
out={k:canonical_value(env[k])for k in ['comparisons','analysis','controls','passed']};out['registration']=canonical_value(v.experiment_registration_record(stage))
(w/'conformerpopulation1495_postseal_expected.json').write_text(json.dumps(out,indent=2)+'\n')
s=(w/'ConformerPopulationInterfaces1495.lean').read_text().replace('import SFT.Chemistry.ConformerPopulationAnalysis','import SFT.Chemistry.ConformerPopulationValidation')
a=s.index(' let source : CJ');s=s[:a]+''' let programFields := match prediction with | .object fs => fs | _ => []
 let program ← IO.ofExcept (CapabilityDocuments.loadProgramFields programFields)
 let inputs ← IO.ofExcept (ConformerPopulationValidation.inputValues "native-conformerpopulation1495")
 let execution ← IO.ofExcept (CapabilityExecution.execute program inputs)
 let predictions ← IO.ofExcept (ConformerPopulationSource.predictionMap execution.output)
 let released ← IO.ofExcept (rows.mapM fun row => do
  let id ← JointCorrelationTargets.field row "target_id" >>= JointCorrelationTargets.text
  let payload ← JointCorrelationTargets.field row "target_payload_hash" >>= JointCorrelationTargets.text
  let label ← CapabilityValues.heldLabel "external-complete-source-record-hash" payload
  return (id,CapabilityValues.canonical (.label label)))
 let comparisons ← IO.ofExcept (rows.mapM (ConformerPopulationComparison.compare predictions released))
 let controls ← IO.ofExcept (ConformerPopulationComparison.controls rows analysis prediction released)
 let passed := comparisons.all ConformerPopulationValidation.rowPassed && ConformerPopulationComparison.analysisPassed analysis && controls.all Prod.snd
 IO.println (SFT.Host.Canonical.render (.object [
  ("comparisons",.array comparisons),("analysis",analysis),
  ("controls",.object (controls.map fun (k,v) => (k,.boolean v))),
  ("passed",.boolean passed),("registration",ConformerPopulationExperiment.registration prediction)]))
'''
(w/'ConformerPopulationPostseal1495.lean').write_text(s)
s=(w/'prepare_conformerpopulation1495_validation_native.py').read_text().replace('ConformerPopulationValidation1495','ConformerPopulationPostseal1495').replace('conformerpopulation1495_validation_native','conformerpopulation1495_postseal_native').replace('conformerpopulation1495_validation_report','conformerpopulation1495_postseal_report')
s=s.replace("'conformerpopulation1495_program_native_build.json']:","'conformerpopulation1495_program_native_build.json','conformerpopulation1495_validation_native_build.json']:")
(w/'prepare_conformerpopulation1495_postseal_native.py').write_text(s)
print('Prepared exact original isolated post-seal component comparison:',len(out['comparisons']),'targets',len(out['controls']),'controls')
