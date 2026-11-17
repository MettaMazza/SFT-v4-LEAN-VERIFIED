from pathlib import Path
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry'
p=r/'RadiolysisNetworkAnalysis.lean';s=p.read_text();start=s.index('def exactRadiolysisAnalysis');a=s.index(' let row ← field analysis "nuchem_012"',start);end=s.index('end SFT.Chemistry.RadiolysisNetworkAnalysis',a)
old=s[start:a];body=s[a:end]
# Preserve the actual source prefix and suffix; only expose their composition for reuse.
resolved='def resolvedAnalysis (analysis : Value) (recorded : String) (total : Nat × Nat)\n (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do\n'+body
s=s[:start]+resolved+old+' resolvedAnalysis analysis recorded total omitLast\n'+s[end:];p.write_text(s)
p=r/'RadiolysisNetworkValidation.lean';s=p.read_text();start=s.index('def validate (analysis');a=s.index(' let registrationHash := identity registration',start);end=s.index('#print axioms inputValues',a);body=s[a:end];om=''' let omission := match RadiolysisNetworkAnalysis.exactRadiolysisAnalysis analysis files surfaces true with
  | .error _ => true
  | .ok _ => false
''';assert om in body;body=body.replace(om,'')
resolved='''def validateResolved (summary : Value) (checks : List (String × Bool)) (omission : Bool)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Value := do
 validateSpec
'''+body
wrapper=s[start:a]+''' let omission := match RadiolysisNetworkAnalysis.exactRadiolysisAnalysis analysis files surfaces true with
  | .error _ => true
  | .ok _ => false
 validateResolved summary checks omission derivationSeal host implementation before after
'''
s=s[:start]+resolved+wrapper+s[end:];p.write_text(s)
runner=(w/'RadiolysisNetworkValidationProgram1160.lean').read_text();start=runner.index(' let files ←');end=runner.index(' let before ←',start);runner=runner[:start]+runner[end:];old=' let result ← IO.ofExcept (SFT.Chemistry.RadiolysisNetworkValidation.validate analysis files surfaces derivationSeal host implementation before after)';assert old in runner
runner=runner.replace(old,''' let recorded ← IO.ofExcept (NuclideCarrierAnalysis.field analysis "complete_result_vector_sha256" >>= NuclideCarrierAnalysis.text)
 let (summary,checks) ← IO.ofExcept (RadiolysisNetworkAnalysis.resolvedAnalysis analysis recorded (370,837013))
 let omission := match RadiolysisNetworkAnalysis.resolvedAnalysis analysis recorded (370,837013) true with
  | .error _ => true
  | .ok _ => false
 let result ← IO.ofExcept (RadiolysisNetworkValidation.validateResolved summary checks omission derivationSeal host implementation before after)''')
(w/'RadiolysisNetworkResolvedProgram1161.lean').write_text(runner)
# Only changed modules need recompilation; experiment remains identical.
s=(w/'build_radiolysis1160_interfaces.py').read_text();s=s.replace("for module in ['RadiolysisNetworkAnalysis','RadiolysisNetworkExperiment','RadiolysisNetworkValidation']:","for module in ['RadiolysisNetworkAnalysis','RadiolysisNetworkValidation']:")
(w/'build_radiolysis1161_resolved.py').write_text(s)
