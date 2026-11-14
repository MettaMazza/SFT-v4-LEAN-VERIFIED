from pathlib import Path
import ast,sys,json
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_shell_periodicity_successor_validation_v1 as src
fn=next(n for n in ast.parse((w/'v3-runtime500/sft/physics/atomic_shell_periodicity_successor_validation_v1.py').read_text()).body if isinstance(n,ast.FunctionDef) and n.name=='atomic_periodicity_classification');vals={n.targets[0].id:ast.literal_eval(n.value) for n in fn.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id in ['configurations','starts_and_ends','resets','local_dips']}
q=json.dumps
s='''import SFT.Physics.AtomicShellPeriodicity
import SFT.Physics.AtomicShellRecords
namespace SFT.Physics.AtomicShellMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals AtomicShellRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ionizationInterval (record : Value) (symbol : String) : Except String (Rat × Rat) := do
 let row ← field (← field (← field (← field record "sources") "ionization") "rows") symbol
 let centre ← decimalField row "value_eV"
 let spreadValue := (field row "uncertainty_eV").toOption.getD ((field row "display_half_width_eV").toOption.getD (.text "missing"))
 let spread ← decimal (← text spreadValue)
 let lower ← RunningConvergence.positiveTake centre spread
 pure (lower,add centre spread)
'''
for key,name in [('configurations','configurations'),('starts_and_ends','envelopes'),('resets','resets'),('local_dips','localDips')]:
 rows=vals[key].items() if isinstance(vals[key],dict) else vals[key];s+=f'def {name} : List (String × String) := ['+','.join('('+q(a)+','+q(b)+')' for a,b in rows)+']\n'
s+='def label : String := '+q(src.MEASURED_LABEL)+'\n'
s+='''def allSeparated (record : Value) (rows : List (String × String)) : Except String Bool := do
 rows.foldlM (fun held pair => do
  let high ← ionizationInterval record pair.1
  let low ← ionizationInterval record pair.2
  pure (held && low.2.blt high.1)) true
def classificationFromRecord (record : Value) : Except String String := do
 let sources ← field record "sources"
 let periodic ← field (← field sources "periodic_table") "row"
 let closures ← AtomicShellPeriodicity.generatedPeriodClosures (.count (.integer 7))
 let widths ← AtomicShellPeriodicity.generatedPeriodWidths (.count (.integer 7))
 if !sameValue (← field periodic "closure_atomic_numbers") (.array (closures.map fun n => .integer (.ofNat n))) then
  throw "generated closures differ from the IUPAC table"
 if !sameValue (← field periodic "period_widths") (.array (widths.map fun n => .integer (.ofNat n))) then
  throw "generated widths differ from the IUPAC table"
 let rows ← field (← field sources "ionization") "rows"
 let configurationsMatch ← configurations.foldlM (fun held pair => do
  let shells ← field (← field rows pair.1) "ground_shells"
  pure (held && sameValue shells (.text pair.2))) true
 if !configurationsMatch then throw "registered NIST closure/successor configuration changed"
 if !(← allSeparated record (envelopes.map fun p => (p.2,p.1))) then
  throw "a registered period endpoint no longer exceeds its start"
 if !(← allSeparated record resets) then
  throw "a registered closure-to-successor ionization reset failed"
 if !(← allSeparated record localDips) then
  throw "a retained local ionization dip changed"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := AtomicShellPeriodicity.generatedPeriodClosures (.count (.integer 7)) == .ok [2,10,18,36,54,86,118] && AtomicShellPeriodicity.generatedPeriodWidths (.count (.integer 7)) == .ok [2,8,8,18,18,32,32]
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.AtomicShellMeasurement
'''
for root in [r,c]:(root/'SFT/Physics/AtomicShellMeasurement.lean').write_text(s)
