from pathlib import Path
w=Path('work');s=(w/'prepare_death1161_reuse.py').read_text();s=s[:s.index("s=(w/'LifeDeathValidationProgram")];s=s.replace('death1161','metabolism1171').replace('LifeDeath','Metabolism').replace('sourceReuse','sourceChecksReused').replace('identical requirements and extraction body; native source function delegates to the previously checked source function, replacing only the original claim-specific label','Only unchanged source-file hash validation and pre-source seal are reused. Original metabolism-resource fragments are checked freshly by MetabolismSource.extractRequirements on byte-identical inputs.');exec(compile(s,'verified-prefix-reuse','exec'),{})
s=(w/'MetabolismValidationProgram1171.lean').read_text().replace('metabolism1171_empirical_input.json','metabolism1171_resolved_input.json');a=s.index('  let payload ←');b=s.index('\n IO.println',a);s=s[:a]+'''  let before ← field input "before" >>= protectedSnapshot
  let after ← field input "after" >>= protectedSnapshot
  let sourceSeal ← text input "verified_source_seal"
  SFT.Biology.MetabolismExperiment.validateSpec
  let registrationHash := SFT.Host.Canonical.identity (SFT.Biology.MetabolismExperiment.registration sourceSeal)
  let program ← CapabilityDocuments.loadProgramFields SFT.Biology.MetabolismExperiment.programFields
  let derivationSeal ← text input "derivation_seal"
  let inputs ← SFT.Biology.MetabolismValidation.inputValues derivationSeal
  let (observedLabel,extractionHash) ← SFT.Biology.MetabolismSource.extractRequirements files
  SFT.Biology.MetabolismValidation.validateResolved registrationHash program inputs
   observedLabel extractionHash derivationSeal
   (← text input "host") (← text input "implementation") before after)'''+s[b:];(w/'MetabolismResolvedProgram1171.lean').write_text(s)
s=(w/'check_death1161_resolved.py').read_text().replace('death1161','metabolism1171').replace('LifeDeath','Metabolism').replace('1161','1171');(w/'check_metabolism1171_resolved.py').write_text(s)
print('Retained identical byte-bound hash and pre-source seal evidence; fresh native metabolism-resource fragment extraction required')
