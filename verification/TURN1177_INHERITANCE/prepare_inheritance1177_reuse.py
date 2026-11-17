from pathlib import Path
w=Path('work');s=(w/'prepare_death1161_reuse.py').read_text();s=s[:s.index("s=(w/'LifeDeathValidationProgram")];s=s.replace('death1161','inheritance1177').replace('LifeDeath','Inheritance').replace('sourceReuse','sourceChecksReused').replace('identical requirements and extraction body; native source function delegates to the previously checked source function, replacing only the original claim-specific label','Only unchanged source-file hash validation and pre-source seal are reused. Original inheritance-replication fragments are checked freshly by InheritanceSource.extractRequirements on byte-identical inputs.');exec(compile(s,'verified-prefix-reuse','exec'),{})
s=(w/'InheritanceValidationProgram1177.lean').read_text().replace('inheritance1177_empirical_input.json','inheritance1177_resolved_input.json');a=s.index('  let payload ←');b=s.index('\n IO.println',a);s=s[:a]+'''  let before ← field input "before" >>= protectedSnapshot
  let after ← field input "after" >>= protectedSnapshot
  let sourceSeal ← text input "verified_source_seal"
  SFT.Biology.InheritanceExperiment.validateSpec
  let registrationHash := SFT.Host.Canonical.identity (SFT.Biology.InheritanceExperiment.registration sourceSeal)
  let program ← CapabilityDocuments.loadProgramFields SFT.Biology.InheritanceExperiment.programFields
  let derivationSeal ← text input "derivation_seal"
  let inputs ← SFT.Biology.InheritanceValidation.inputValues derivationSeal
  let (observedLabel,extractionHash) ← SFT.Biology.InheritanceSource.extractRequirements files
  SFT.Biology.InheritanceValidation.validateResolved registrationHash program inputs
   observedLabel extractionHash derivationSeal
   (← text input "host") (← text input "implementation") before after)'''+s[b:];(w/'InheritanceResolvedProgram1177.lean').write_text(s)
s=(w/'check_death1161_resolved.py').read_text().replace('death1161','inheritance1177').replace('LifeDeath','Inheritance').replace('1161','1177');(w/'check_inheritance1177_resolved.py').write_text(s)
print('Retained identical byte-bound hash and pre-source seal evidence; fresh native inheritance-replication fragment extraction required')
