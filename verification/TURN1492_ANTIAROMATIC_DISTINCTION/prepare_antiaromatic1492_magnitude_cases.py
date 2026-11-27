from pathlib import Path
import json,sys
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((w/'pinned_antiaromatic1492/sft/chemistry').resolve()))
from sft.chemistry.antiaromatic_nonaromatic_distinction_validation_v1 import _hundredths
values=['0.01','1.00','-1.25','+1.25','001.25','0.00','-0.00','1.2','1.234','1','1.2.3','','.25','1.',' 1.25','1.25 ','1e2.00','١.٢٥','１２.３４','².00','1.²²','-١.٢٥','--1.00','1_0.00']+[str(n)+'.'+str(m).zfill(2)for n in [0,1,10,100]for m in [0,1,9,10,25,99]]
expected=[]
for x in values:
 try:expected.append({'ok':_hundredths(x)})
 except Exception as e:expected.append({'error':str(e)})
s='''import SFT.Chemistry.AntiaromaticTables
open SFT.Chemistry.AntiaromaticTables SFT.Host
def emit : Except String Nat → Canonical.Value
 | .ok n => .object [("ok",.integer (.ofNat n))] | .error e => .object [("error",.text e)]
def main : IO Unit := IO.println (Canonical.render (.array [EXPRS]))
'''.replace('EXPRS',','.join('emit (hundredths '+json.dumps(x,ensure_ascii=False)+')'for x in values))
(w/'AntiaromaticMagnitudeCasesProgram1492.lean').write_text(s);(w/'antiaromatic1492_magnitude_expected.json').write_text(json.dumps(expected))
s=(w/'check_aromatic1491_magnitude.py').read_text().replace('aromatic1491','antiaromatic1492').replace('AromaticMagnitudeCasesProgram1491','AntiaromaticMagnitudeCasesProgram1492').replace("['AromaticMagnitude']","['AntiaromaticTables']");(w/'check_antiaromatic1492_magnitude.py').write_text(s)
print('Prepared',len(values),'original parser cases')
