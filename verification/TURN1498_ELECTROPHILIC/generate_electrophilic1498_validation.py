from pathlib import Path
import sys,json
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';s=(r/'NucleophilicValidation.lean').read_text().replace('Nucleophilic','Electrophilic').replace('ORG-007','ORG-008').replace('exact-org-007-structure-mechanism-comparison/1','exact-org-008-comparison/1').replace('then "registered-host"','then "host"')
a=s.index('-- Formula elements');b=s.index('structure Validation',a)
s=s[:a]+'''def messages (analysis : Value) : Except String (List String) := do
 let hash ← stringField analysis "complete_target_vector_hash"
 return ["complete four-source electrophilic substitution vector retained",
 "one 13,165,129-byte, 452-page supplementary PDF opened only after seal",
 "all 25 Table S1 rows retained: 14 displayed zero-yield, 9 displayed full-yield, and intermediate 12 and 93 rows",
 "EAS-like C-electrophile/nucleophilic-phenol coupling, dearomatized support and rearomatization all present",
 "radical, phenoxonium, starting-material, inconsistent-condition, not-promoted and inseparable-mixture controls retained",
 Text.append "complete target vector " hash]
'''+s[b:]
s=s.replace('(snapshotHashes : List (String × String)) (derivationSeal','(snapshotHashes : List (String × String)) (pageTexts : List String) (derivationSeal').replace('ElectrophilicAnalysis.analysis rows primaryDocument','ElectrophilicAnalysis.analysis rows primaryDocument pageTexts').replace('ElectrophilicAnalysis.analysis (rows.take (rows.length-1)) primaryDocument','ElectrophilicAnalysis.analysis (rows.take (rows.length-1)) primaryDocument pageTexts').replace('primary analysis changed','primary changed').replace('adverse-structure-or-mechanism-mismatch','adverse-mismatch').replace('capability-closed prediction package changed','prediction package changed').replace('target release differs from commitment','release changed')
s=s.replace('| .label p => if Text.equal p.family "chemical-observation" then pure p else throw "ORG-008 prediction output is invalid"','| .label p => pure p')
s=s.replace(' && checks.all Prod.snd && omissionRejected && tamperedRejected',' && omissionRejected && tamperedRejected')
s=s.replace('("controls",.object [("omission_rejected",.boolean omissionRejected),("tampered_rejected",.boolean tamperedRejected)])','("omission_rejected",.boolean omissionRejected)')
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_electrophilic1498/sft/chemistry').resolve()))
from sft.chemistry.electrophilic_substitution_batch_v1 import PRIMARY_HASH,TARGET_HASH
import ast
old={}
for n in ast.parse((w/'pinned_nucleophilic1496/sft/chemistry/nucleophilic_substitution_batch_v1.py').read_text()).body:
 if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id in ['PRIMARY_HASH','TARGET_HASH']:old[n.targets[0].id]=ast.literal_eval(n.value)
OLD_PRIMARY=old['PRIMARY_HASH'];OLD_TARGET=old['TARGET_HASH']
s=s.replace(OLD_PRIMARY,PRIMARY_HASH).replace(OLD_TARGET,TARGET_HASH);(r/'ElectrophilicValidation.lean').write_text(s)
b=(w/'build_electrophilic1498_core.py').read_text().replace("['ElectrophilicCarrier','ElectrophilicPath']","['ElectrophilicExperiment','ElectrophilicValidation']").replace('electrophilic1498_core','electrophilic1498_validation').replace('ElectrophilicCoreAudit1498','ElectrophilicValidationAudit1498');(w/'build_electrophilic1498_validation.py').write_text(b)
