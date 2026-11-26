from pathlib import Path
import sys,json,copy
w=Path('work');stage=w/'pinned_inorgmag1479';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import inorganic_magnetic_state_validation_v1 as v
from sft.engine.canonical import canonical_value
ident=json.loads((stage/v.IDENTITY_PATH).read_text());targets=json.loads((stage/v.TARGET_PATH).read_text());primary=json.loads((stage/v.PRIMARY_PATH).read_text())
rows=v._source_rows(stage)
cases=[];expected=[]
def add(kind,payload,fn):
 cases.append(dict(kind=kind,**payload))
 try: expected.append({'ok':canonical_value(fn())})
 except ValueError as e: expected.append({'error':str(e)})
add('prediction',{'identity':ident},lambda:v.prediction_program_document(stage))
add('source',{'identity':ident,'targets':targets},lambda:v._source_rows(stage))
add('analysis',{'rows':rows,'primary':primary},lambda:v.exact_analysis(rows,primary))
for i in range(177):
 shortened=rows[:i]+rows[i+1:]
 add('analysis',{'rows':shortened,'primary':primary},lambda shortened=shortened:v.exact_analysis(shortened,primary))
(w/'inorgmag1479_interfaces_input.json').write_text(json.dumps(cases)+'\n')
(w/'inorgmag1479_interfaces_expected.json').write_text(json.dumps(expected)+'\n')
print('Prepared180 original comparisons: fullprediction/source/analysis and177 omitted-record controls')
