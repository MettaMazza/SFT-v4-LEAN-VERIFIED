from pathlib import Path
import json,sys,hashlib,copy,subprocess
w=Path('work');stage=w/'pinned_conformerpopulation1495';cid='SFT-CHEM-CONFORMER-POPULATION-ORDERING-006'
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry.conformer_population_ordering_validation_v1 import prediction_program_document,exact_analysis,_source_rows
from sft.chemistry.conformer_population_ordering_batch_v1 import IDENTITY_PATH,TARGET_PATH,PRIMARY_PATH,IDENTITY_HASH,TARGET_HASH,PRIMARY_HASH
identities=json.loads((stage/IDENTITY_PATH).read_text());targets=json.loads((stage/TARGET_PATH).read_text());primary=json.loads((stage/PRIMARY_PATH).read_text())
try:_source_rows(stage);source_result={'ok':True}
except Exception as e:source_result={'error':str(e)}
expected={'prediction':prediction_program_document(stage),'analysis':exact_analysis(tuple(targets['rows']),primary),'source':source_result}
(w/'conformerpopulation1495_interfaces_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
hashfile=lambda p:'sha256:'+hashlib.sha256((stage/p).read_bytes()).hexdigest()
input={'identities':identities,'targets':targets,'primary':primary,'identity_hash':hashfile(IDENTITY_PATH),'target_hash':hashfile(TARGET_PATH),'primary_hash':hashfile(PRIMARY_PATH),'snapshot_hashes':[[row['opened_snapshot_path'],hashfile(row['opened_snapshot_path'])]for row in targets['rows']]}
(w/'conformerpopulation1495_interfaces_input.json').write_text(json.dumps(input,indent=2)+'\n')
out=json.loads((w/'conformerpopulation1495_original_program.json').read_text());cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(out,claim_id=cid,seal_hash='native-conformerpopulation1495'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('conformerpopulation1495_independent_'+case+'.json');f.write_text(json.dumps(sealed));q=subprocess.run([sys.executable,str((stage/'claims'/cid/'independent_validator.py').resolve()),str(f.resolve())],capture_output=True,text=True,check=True);value=json.loads(q.stdout);assert value['passed']==(case=='original');cases.append({'case':case,'result':value})
(w/'conformerpopulation1495_original_independent.json').write_text(json.dumps(cases,indent=2)+'\n')
print('Prepared fresh prediction, exact analysis and actual source-guard outputs; four independent cases PASS')
s=(w/'ConformerValidationProgram1494.lean').read_text();s=s[:s.index('def sourceHash')];s=s.replace('import SFT.Chemistry.ConformerValidation','import SFT.Chemistry.ConformerPopulationAnalysis')
s+='''set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def main : IO Unit := do
 let raw ← IO.FS.readFile "work/conformerpopulation1495_interfaces_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let identities ← IO.ofExcept (field input "identities" >>= convert (raw.utf8ByteSize+1))
 let targets ← IO.ofExcept (field input "targets" >>= convert (raw.utf8ByteSize+1))
 let primary ← IO.ofExcept (field input "primary" >>= convert (raw.utf8ByteSize+1))
 let ih ← IO.ofExcept (text input "identity_hash")
 let th ← IO.ofExcept (text input "target_hash")
 let ph ← IO.ofExcept (text input "primary_hash")
 let hashes ← IO.ofExcept (do
  (← items input "snapshot_hashes").mapM fun row => do
   let a ← row.getArr?
   return (← a[0]!.getStr?,← a[1]!.getStr?))
 let prediction ← IO.ofExcept (ConformerPopulationPrediction.predictionDocument ih identities)
 let rows ← IO.ofExcept (ConformerPopulationPrediction.get targets "rows" |> ConformerAnalysis.array)
 let analysis ← IO.ofExcept (ConformerPopulationAnalysis.analysis rows primary)
 let source : CJ := match ConformerPopulationSource.sourceRows th ph ih identities targets hashes with
  | .error e => .object [("error",.text e)]
  | .ok _ => .object [("ok",.boolean true)]
 IO.println (SFT.Host.Canonical.render (.object [("prediction",prediction),("analysis",analysis),("source",source)]))
'''
(w/'ConformerPopulationInterfaces1495.lean').write_text(s)
# Reuse exact, hash-bound compiled objects from the completed predecessor.
s=(w/'prepare_conformer1494_program_native.py').read_text()
s=s.replace('ConformerGenerationEvidence','ConformerPopulationAnalysis').replace('ConformerGenerationProgram1494','ConformerPopulationInterfaces1495').replace('conformer1494_program_optimized1492','conformerpopulation1495_interfaces_native').replace('conformer1494_program_optimized_build1492','conformerpopulation1495_interfaces_native_build').replace('conformer1494_program_empirical_report','conformerpopulation1495_interfaces_report')
s=s.replace("'antiaromatic1492_optimized_build1492.json']:","'antiaromatic1492_optimized_build1492.json','conformer1494_optimized_build1492.json','conformer1494_program_optimized_build1492.json']:")
(w/'prepare_conformerpopulation1495_interfaces_native.py').write_text(s)
