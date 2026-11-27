from pathlib import Path
import sys,json,copy
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((w/'pinned_antiaromatic1492/sft/chemistry').resolve()))
from sft.chemistry import antiaromatic_nonaromatic_distinction_validation_v1 as v
stage=w/'pinned_antiaromatic1492';rows=json.loads((stage/v.TARGET_PATH).read_text())['rows'];primary=json.loads((stage/v.PRIMARY_PATH).read_text());cases=[];expected=[]
def add(name,r,p):
 cases.append(dict(name=name,rows=r,primary=p))
 try:expected.append({'ok':v.exact_analysis(r,p)})
 except Exception as e:expected.append({'error':str(e)})
add('original',rows,primary)
for i in range(5):
 add('omit '+str(i),rows[:i]+rows[i+1:],primary)
 r=copy.deepcopy(rows);r[i]['source_record_role']='missing';add('role '+str(i),r,primary)
for i in [3,4]:
 for mode in ['empty','duplicate','property-empty']:
  r=copy.deepcopy(rows);o=r[i]['source_outcome']
  ts=o.get('complete_experimental_data_tables')or o.get('complete_gas_thermochemistry_tables')
  if mode=='empty':ts.clear()
  elif mode=='duplicate':ts.extend(copy.deepcopy(ts))
  else:
   for t in ts:
    t[:]=[x for x in t if not x or x[0]!='Hfg(298.15K)']
  add(str(i)+' '+mode,r,primary)
p=copy.deepcopy(primary);p['exact_postseal_analysis']['complete_target_count']=6;add('postseal alteration',rows,p)
add('missing postseal',rows,{})
(w/'antiaromatic1492_analysis_input.json').write_text(json.dumps(cases));(w/'antiaromatic1492_analysis_expected.json').write_text(json.dumps(expected))
s=(w/'AromaticAnalysisCasesProgram1491.lean').read_text().replace('AromaticRecurrenceAnalysis','AntiaromaticDistinctionAnalysis').replace('aromatic1491','antiaromatic1492').replace('AntiaromaticDistinctionAnalysis.array','AromaticRecurrenceAnalysis.array');(w/'AntiaromaticAnalysisCasesProgram1492.lean').write_text(s)
s=(w/'check_aromatic1491_analysis.py').read_text().replace('aromatic1491','antiaromatic1492').replace('AromaticAnalysisCasesProgram1491','AntiaromaticAnalysisCasesProgram1492').replace("['AromaticRecurrenceAnalysis','AromaticMagnitude']","['AntiaromaticDistinctionAnalysis','AntiaromaticTables']");(w/'check_antiaromatic1492_analysis.py').write_text(s)
print('Prepared',len(cases),'full original analysis comparisons')
