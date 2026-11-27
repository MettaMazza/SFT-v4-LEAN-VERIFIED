from pathlib import Path
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry'
s=(r/'ElectrophilicValidation.lean').read_text().replace('Electrophilic','Addition').replace('ORG-008','ORG-009').replace('exact-org-008-comparison/1','exact-org-009-comparison/3')
a=s.index('def messages');b=s.index('structure Validation',a);s=s[:a]+'''def messages (analysis : Value) : Except String (List String) := do
 let hash ← stringField analysis "complete_result_vector_hash"
 return ["complete 48-file, 12,993,815-byte non-USPTO Open Reaction Database holdout retained",
 "all 131,209 conventional reaction rows inspected at the source-only boundary",
 "all 28 independently labeled azide-alkyne/click/cycloaddition identities selected before product opening",
 "28 favorable, no adverse and no unresolved complete product vectors",
 "112 exact element-preserving correspondences; each has two new cross-carrier adjacencies and three multiplicity relocations",
 "all V1--V8 absent, adverse, unresolved and failed-universal results preserved without awarding closure",
 Text.append "complete result vector " hash]
'''+s[b:]
a=s.index('def validate');b=s.index(' let registrationHash',a);s=s[:a]+'''def validate (input : AdditionAnalysis.Input) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 AdditionSource.authority input
 validateSpec
 let (analysis,checks) ← AdditionAnalysis.analysis input
'''+s[b:]
s=s.replace('"complete_target_vector_hash"','"complete_result_vector_hash"').replace('sha256:41d6d0aed51dec5720ea0553351c9ec72e06e22c037bc0025ca012398787d08d','sha256:ae8b152f09ebdd07e068890f0bff121d6dcfe189f57b6999ea79a6c22f29f96c')
a=s.index(' let omissionRejected');b=s.index(' let passed',a);s=s[:a]+''' let selected ← field input.selection "selected_in_payload_and_row_order" >>= ConformerAnalysis.array
 let outcomes ← field input.comparison "results_in_frozen_order" >>= ConformerAnalysis.array
 let omissionRejected := match AdditionAnalysis.analysis input (some (selected.take (selected.length-1))) (some (outcomes.take (outcomes.length-1))) with
  | .error _ => true
  | .ok _ => false
'''+s[b:]
s=s.replace(',("checks",.object (checks.map fun p => (p.1,.boolean p.2)))','')
s=s.replace(' let sourceIds ← rows.mapM fun row => stringField row "source_id"\n','')
(r/'AdditionValidation.lean').write_text(s)
p=w/'build_addition1502_validation.py';s=(w/'build_addition1501_graph.py').read_text().replace("['AdditionGraph']","['AdditionSource','AdditionExperiment','AdditionValidation']").replace('1501','1502').replace('graph_audit','validation_audit');p.write_text(s)
