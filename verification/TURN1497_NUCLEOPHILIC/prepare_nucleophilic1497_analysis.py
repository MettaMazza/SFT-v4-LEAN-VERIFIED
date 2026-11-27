from pathlib import Path
import json,sys
w=Path('work');stage=w/'pinned_nucleophilic1496';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry import nucleophilic_substitution_validation_v1 as v
rows=v._source_rows(stage);primary=json.loads((stage/v.PRIMARY_PATH).read_text());analysis,checks=v.exact_analysis(rows,primary)
cases=['CBr','OH-','CH4O','Br-','CH3CH3','H2O','NaCl','C12H22O11','','+','-','C0','C01','C10','H00','CH0','C-2','C++--','C+-++','C2H5OH','(OH)2','C 2','c2','Cl2','CL2','Xx22','C1C2C3','H٢','C１','C.',' C','C\n','C1+','C99999999999999999999999999','H2SO4','Fe2O3','C1H1','C02H3']
expected=[]
for s in cases:
 try:expected.append({'value':v._formula(s)})
 except ValueError as e:expected.append({'error':str(e)})
sums=[[{'C':1,'O':1},{'C':-1,'H':4}],[{'O':0},{'O':-3,'C':2}],[]]
out={'analysis':analysis,'checks':checks,'formulas':expected,'sums':[v._sum(*s)for s in sums]}
(w/'nucleophilic1497_analysis_expected.json').write_text(json.dumps(out,indent=2)+'\n');(w/'nucleophilic1497_analysis_input.json').write_text(json.dumps({'rows':rows,'primary':primary,'formulas':cases,'sums':sums},indent=2)+'\n')
s=(w/'ConformerPopulationInterfaces1495.lean').read_text();s=s[:s.index('set_option')];s=s.replace('import SFT.Chemistry.ConformerPopulationAnalysis','import SFT.Chemistry.NucleophilicAnalysis')
s+='''set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/nucleophilic1497_analysis_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let rows ← IO.ofExcept (field input "rows" >>= convert (raw.utf8ByteSize+1) >>= ConformerAnalysis.array)
 let primary ← IO.ofExcept (field input "primary" >>= convert (raw.utf8ByteSize+1))
 let (analysis,checks) ← IO.ofExcept (NucleophilicAnalysis.analysis rows primary)
 let formulas ← IO.ofExcept ((← IO.ofExcept (items input "formulas")).mapM fun j => do
  let s ← j.getStr?
  return match NucleophilicFormula.formula s with
   | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
   | .ok rows => .object [("value",NucleophilicFormula.value rows)])
 let sums ← IO.ofExcept ((← IO.ofExcept (items input "sums")).mapM fun group => do
  let rows ← group.getArr?
  let values ← rows.toList.mapM fun row => do
   let fs ← row.getObj?
   fs.toList.mapM fun (k,v) => do return (k,← v.getInt?)
  return NucleophilicFormula.value (NucleophilicFormula.sum values))
 IO.println (SFT.Host.Canonical.render (.object [("analysis",analysis),("checks",.object (checks.map fun (k,v) => (k,.boolean v))),("formulas",.array formulas),("sums",.array sums)]))
'''
(w/'NucleophilicAnalysis1497.lean').write_text(s)
s=(w/'prepare_conformerpopulation1495_interfaces_native.py').read_text().replace('ConformerPopulationAnalysis','NucleophilicAnalysis').replace('ConformerPopulationInterfaces1495','NucleophilicAnalysis1497').replace('conformerpopulation1495_interfaces_native','nucleophilic1497_analysis_native').replace('conformerpopulation1495_interfaces_report','nucleophilic1497_analysis_report')
s=s.replace("'conformer1494_program_optimized_build1492.json']:","'conformer1494_program_optimized_build1492.json','conformerpopulation1495_interfaces_native_build.json']:")
(w/'prepare_nucleophilic1497_analysis_native.py').write_text(s)
print('Prepared fresh original23-field analysis,9checks,38formula cases and3signed-sum cases')
