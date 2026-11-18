from pathlib import Path
import re,ast
w=Path('work');r=w/'turn1064_recovery'
p=w/'prepare_accuracy1252_reuse.py';s=p.read_text().replace('patient1234','symptom1247').replace('PatientIdentity','SymptomRecord').replace('WHO/ICH','four FDA');p.write_text(s)
p=w/'DiagnosticAccuracyResolvedProgram1252.lean';p.write_text(p.read_text().replace('SFT.Medicine.PatientIdentitySource.lookup','SFT.Medicine.SymptomRecordSource.lookup'))
for fn in ['build_accuracy1252_all.py','check_accuracy1252_empirical.py']:
 p=w/fn;s=p.read_text().replace("mods=['DiagnosticAccuracy'","mods=['StructuralCounts','DiagnosticAccuracy'").replace("mods = ['DiagnosticAccuracy'","mods = ['StructuralCounts','DiagnosticAccuracy'");p.write_text(s);assert "'StructuralCounts'"in s
n=sum(len(re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Medicine'/(m+'.lean')).read_text(),re.M))for m in ['StructuralCounts','DiagnosticAccuracy','DiagnosticAccuracyGrammar','DiagnosticAccuracyEvidence','DiagnosticAccuracySource','DiagnosticAccuracyExperiment','DiagnosticAccuracyValidation'])
p=w/'register_accuracy1252.py';s=p.read_text().replace('==115','=='+str(n)).replace('+115','+'+str(n)).replace('115 audited',str(n)+' audited').replace('115 empty',str(n)+' empty').replace('115 current',str(n)+' current');s=s.replace("scopes={","scopes={'StructuralCounts': ('sft/medicine/structural_counts.py','Original ordered diagnostic and two-arm products,all six certificate fields,four distinct cells and exact_share positive integer guards without ratio reduction.'),",1).replace('three original operational witnesses.','four original operational witnesses,including generated complete diagnostic table.').replace('Original WHO/ICH family requirements exactly equal PatientIdentity; delegate its unchanged native source operation,retaining extraction receipt and rebinding only original observed label.','Original four FDA requirements equal SymptomRecord; delegate its unchanged native extraction,retaining the receipt and original diagnostic observation label.')
s=s.replace("ind=json.loads", "reuse=json.loads((w/'accuracy1252_reused_source_evidence.json').read_text())\nfor rel,h in reuse['shared_module_sha256'].items():assert H(r/rel)==h,rel\nind=json.loads",1)
# Full source operation comparisons are retained separately before entry registration.
s=s.replace("reports=[","reports=['accuracy1252_counts_report.json',",1);ast.parse(s);p.write_text(s)
print('Diagnostic entry audit includes',n,'declarations; original four witnesses and complete structural-count source bound.')
