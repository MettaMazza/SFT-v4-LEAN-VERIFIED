from pathlib import Path
import sys,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1322/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.vibrational_frequency_law_v1 import exact_recurrence_frequency,repeated_equal_interval_frequency,VibrationalFrequencyCarrier
from sft.engine.exact import HeldLabel as L,PositiveCount as C
rows=[];expr=[]
def record(code,f):
 try:out={'ok':f()}
 except Exception as e:out={'error':str(e)}
 rows.append(out);expr.append(code)
def pair(r):return [r.numerator.value,r.denominator.value]
def ci(n):return '.other'if n is None else '.count ⟨'+str(n)+',by decide⟩'
def count(n):return None if n is None else C(n)
for n,d in [(12,3),(1,1),(137,31),(2,7),(6,9),(None,3),(12,None),(None,None)]:record('result ratioValue (exactRecurrenceFrequency ('+ci(n)+') ('+ci(d)+'))',lambda n=n,d=d:pair(exact_recurrence_frequency(count(n),count(d))))
for n,d,k in [(12,3,5),(12,3,1),(2,7,11),(137,31,23),(6,9,4),(None,3,2),(12,None,2),(12,3,None),(None,None,None)]:record('result ratioValue (repeatedEqualIntervalFrequency ('+ci(n)+') ('+ci(d)+') ('+ci(k)+'))',lambda n=n,d=d,k=k:pair(repeated_equal_interval_frequency(count(n),count(d),count(k))))
families=['molecular-species','vibrational-symmetry','observation-interval-unit','vibrational-transition-class']
for wrong in [-1]+list(range(7)):
 fs=[('wrong' if j==wrong else f)for j,f in zip([0,2,5,6],families)];ns=[None if j==wrong else n for j,n in zip([1,3,4],[1,12,3])]
 labels=['⟨'+json.dumps(f)+',"held",rfl,rfl⟩'for f in fs];lean='⟨'+','.join([labels[0],ci(ns[0]),labels[1],ci(ns[1]),ci(ns[2]),labels[2],labels[3]])+'⟩'
 record('result (fun _ => .boolean true) (validateCarrier '+lean+')',lambda fs=fs,ns=ns:bool(VibrationalFrequencyCarrier(L(fs[0],'held'),count(ns[0]),L(fs[1],'held'),count(ns[1]),count(ns[2]),L(fs[2],'held'),L(fs[3],'held'))))
for unit in ['centimeter','held-interval-A','held-interval-B']:
 carrier=VibrationalFrequencyCarrier(L(families[0],'held'),C(1),L(families[1],'held'),C(12),C(3),L(families[2],unit),L(families[3],'held'))
 record('result ratioValue (exactFrequency ⟨⟨"molecular-species","held",rfl,rfl⟩,'+ci(1)+',⟨"vibrational-symmetry","held",rfl,rfl⟩,'+ci(12)+','+ci(3)+',⟨"observation-interval-unit",'+json.dumps(unit)+',rfl,rfl⟩,⟨"vibrational-transition-class","held",rfl,rfl⟩⟩)',lambda carrier=carrier:pair(carrier.exact_frequency))
(w/'vibrational1322_core_expected.json').write_text(json.dumps(rows,indent=2)+'\n')
(w/'VibrationalFrequencyCases1322.lean').write_text('''import SFT.Chemistry.VibrationalFrequency
open SFT.Host SFT.Host.Canonical SFT.Chemistry.VibrationalFrequency
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ratioValue (r : SFT.Chemistry.DihedralTorsion.Ratio) : Value := .array [.integer r.numerator.value,.integer r.denominator.value]
def result {α : Type} (encode : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",encode v)]
def main : IO Unit := IO.println (render (.array [
'''+',\n'.join(expr)+']))\n');print('Prepared',len(rows),'original cases')
