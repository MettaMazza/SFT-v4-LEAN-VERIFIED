from pathlib import Path
import sys,json
w=Path('work');stage=w/'pinned1135';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.coordination_entity_validation_v1 import prediction_program_document,IDENTITY_PATH
expected=prediction_program_document(stage)
(w/'coordinationprediction1135_expected.json').write_text(json.dumps(expected)+'\n')
(w/'coordinationprediction1135_input.json').write_bytes((stage/IDENTITY_PATH).read_bytes())
print('Source prediction:',len(expected['instructions']),'instructions')
