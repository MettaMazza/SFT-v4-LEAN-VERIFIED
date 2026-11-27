from pathlib import Path
import json,sys,copy
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((w/'pinned_aromatic1491/sft/chemistry').resolve()))
from sft.chemistry.aromatic_recurrence_stability_validation_v1 import exact_analysis,TARGET_PATH,PRIMARY_PATH
stage=w/'pinned_aromatic1491';rows=json.loads((stage/TARGET_PATH).read_text())['rows'];primary=json.loads((stage/PRIMARY_PATH).read_text());cases=[]
def add(name,r,p):
 try: result={'ok':exact_analysis(r,p)}
 except Exception as e: result={'error':str(e)}
 cases.append({'name':name,'rows':r,'primary':p,'expected':result})
add('original',rows,primary);add('omitted',rows[:-1],primary);add('empty',[],primary)
for species in ['benzene','cyclohexene','cyclohexane']:
 role='complete-cccbdb-'+species+'-experimental-data-surface'
 for value in ['1.00','-1.00','0.00','1.2','20.50','-999.99']:
  r=copy.deepcopy(rows)
  for row in r:
   if row['source_record_role']==role:
    for table in row['source_outcome']['complete_experimental_data_tables']:
     for record in table:
      if record and record[0]=='Hfg(298.15K)':record[1]=value
  add(species+' '+value,r,primary)
 for what in ['missing-role','missing-property','duplicate-property']:
  r=copy.deepcopy(rows)
  for row in r:
   if row['source_record_role']==role:
    if what=='missing-role':row['source_record_role']='different'
    else:
     for table in row['source_outcome']['complete_experimental_data_tables']:
      matched=[x for x in table if x and x[0]=='Hfg(298.15K)']
      if matched:
       if what=='missing-property':table.remove(matched[0])
       else:table.append(copy.deepcopy(matched[0]))
  add(species+' '+what,r,primary)
p=copy.deepcopy(primary);p['exact_postseal_analysis']['primitive_support_count']=999
add('postseal overwrite exact source semantics',rows,p)
(w/'aromatic1491_analysis_input.json').write_text(json.dumps([{k:v for k,v in c.items() if k!='expected'}for c in cases]))
(w/'aromatic1491_analysis_expected.json').write_text(json.dumps([c['expected']for c in cases]))
s=(w/'InorganicNetworkValidationProgram1490.lean').read_text();a=s.index('def field');s=s[:a].replace('import SFT.Chemistry.InorganicNetworkValidation','import SFT.Chemistry.AromaticRecurrenceAnalysis')
s+='''def main : IO Unit := do
 let raw ← IO.FS.readFile "work/aromatic1491_analysis_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= Lean.Json.getArr?)
 let outputs ← input.toList.mapM fun c => do
  let rows ← IO.ofExcept (c.getObjVal? "rows" >>= convert (raw.utf8ByteSize+1) >>= AromaticRecurrenceAnalysis.array)
  let primary ← IO.ofExcept (c.getObjVal? "primary" >>= convert (raw.utf8ByteSize+1))
  return match AromaticRecurrenceAnalysis.analysis rows primary with
   | .ok v => CJ.object [("ok",v)]
   | .error e => CJ.object [("error",.text e)]
 IO.println (SFT.Host.Canonical.render (.array outputs))
'''
(w/'AromaticAnalysisCasesProgram1491.lean').write_text(s)
s=(w/'check_aromatic1491_magnitude.py').read_text().replace('aromatic1491_magnitude','aromatic1491_analysis').replace('AromaticMagnitudeCasesProgram1491','AromaticAnalysisCasesProgram1491').replace("['AromaticMagnitude']","['AromaticRecurrenceAnalysis','AromaticMagnitude']")
(w/'check_aromatic1491_analysis.py').write_text(s);print('Prepared',len(cases),'fresh original analysis comparisons')
