from pathlib import Path
import subprocess,sys,json,hashlib,ast
from fractions import Fraction
w=Path('work');rt=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v='/Volumes/One Touch/ernos-labs-sft-platform'
def stage(rel):
 b=subprocess.check_output(['git','-C',v,'show',pin+':'+rel]);p=rt/rel;p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==b
 else:p.write_bytes(b)
 return b
for rel in ['sft/physics/nuclear_binding_curve_successor_validation_v1.py','sft/physics/nuclear_binding_curve_successor_execution_v1.py'] :stage(rel)
sys.path.insert(0,str(rt.resolve()))
from sft.physics import nuclear_binding_curve_successor_validation_v1 as src
for rel in [src.SOURCE_PATH,src.RAW_PATH]:stage(rel)
record=src.authoritative_record(rt);rows=src.measured_binding_rows(rt);analysis=src.measurement_analysis(rt);label=src.nuclear_binding_curve_classification(rt)
def enc(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
 if isinstance(x,(list,tuple)):return [enc(v) for v in x]
 return x
(w/'nuclearbindingcurve963_original_measurement.json').write_text(json.dumps(dict(record=record,rows=enc(rows),analysis=analysis,label=label),indent=2));print('PASS original complete2548 measured rows,ranking,anchors,classification',flush=True)
