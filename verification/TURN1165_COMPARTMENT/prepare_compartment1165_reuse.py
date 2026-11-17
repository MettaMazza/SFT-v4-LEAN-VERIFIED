from pathlib import Path
w=Path('work');s=(w/'prepare_death1161_reuse.py').read_text();s=s[:s.index("s=(w/'LifeDeathValidationProgram")];s=s.replace('death1161','compartment1165').replace('LifeDeath','Compartment').replace('sourceReuse','sourceChecksReused').replace('identical requirements and extraction body; native source function delegates to the previously checked source function, replacing only the original claim-specific label','Only unchanged source-file hash validation and pre-source seal are reused. Original compartment fragments are checked freshly by CompartmentSource.extractRequirements on byte-identical inputs.');exec(compile(s,'verified-prefix-reuse','exec'),{})
s=(w/'CompartmentValidationProgram1165.lean').read_text().replace('compartment1165_empirical_input.json','compartment1165_resolved_input.json');a=s.index('  let payload ←');b=s.index('\n IO.println',a);s=s[:a]+'''  let before ← field input "before" >>= protectedSnapshot
  let after ← field input "after" >>= protectedSnapshot
  let sourceSeal ← text input "verified_source_seal"
  SFT.Biology.CompartmentExperiment.validateSpec
  let registrationHash := SFT.Host.Canonical.identity (SFT.Biology.CompartmentExperiment.registration sourceSeal)
  let program ← CapabilityDocuments.loadProgramFields SFT.Biology.CompartmentExperiment.programFields
  let derivationSeal ← text input "derivation_seal"
  let inputs ← SFT.Biology.CompartmentValidation.inputValues derivationSeal
  let (observedLabel,extractionHash) ← SFT.Biology.CompartmentSource.extractRequirements files
  SFT.Biology.CompartmentValidation.validateResolved registrationHash program inputs
   observedLabel extractionHash derivationSeal
   (← text input "host") (← text input "implementation") before after)'''+s[b:];(w/'CompartmentResolvedProgram1165.lean').write_text(s)
s=(w/'check_death1161_resolved.py').read_text().replace('death1161','compartment1165').replace('LifeDeath','Compartment').replace('1161','1165');(w/'check_compartment1165_resolved.py').write_text(s)
print('Retained identical byte-bound hash and pre-source seal evidence; fresh native compartment fragment extraction required')
