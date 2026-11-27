from pathlib import Path
w=Path('work');r=w/'turn1064_recovery'
s=(r/'NonordinaryExternalProgram1395.lean').read_text();s=s[:s.index('set_option maxRecDepth')].replace('SFT.Consciousness.NonordinaryExternalValidation','SFT.EarthEnvironment.EarthGeologicalProvenanceValidation').replace('open SFT.Consciousness SFT.Physics','open SFT.EarthEnvironment SFT.Physics')
s+='''set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/geoprovenance_resolved1520_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let get (key : String) := IO.ofExcept (field input key >>= convert (raw.utf8ByteSize+1))
 let row ← get "row"
 let audit ← get "audit"
 let registration ← get "registration"
 let extraction ← IO.ofExcept (text input "extraction")
 let derivation ← IO.ofExcept (text input "derivation")
 let host ← IO.ofExcept (text input "host")
 let implementation ← IO.ofExcept (text input "implementation")
 let before ← IO.ofExcept (field input "before" >>= protectedSnapshot)
 let after ← IO.ofExcept (field input "after" >>= protectedSnapshot)
 let program ← IO.ofExcept (SFT.Physics.CapabilityDocuments.loadProgramFields EarthGeologicalProvenanceExperiment.programFields)
 let inputs ← IO.ofExcept (EarthGeologicalProvenanceValidation.inputValues derivation)
 let observed := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field row "observed_label")
 let result ← IO.ofExcept (EarthGeologicalProvenanceValidation.validateResolved (SFT.Host.Canonical.identity registration) program inputs row audit observed extraction derivation host implementation before after)
 IO.println (SFT.Host.Canonical.render result)
'''
# Resolve actual namespace from the existing scientific module; no replacement operation.
s=s.replace('SFT.Physics.CapabilityDocuments','SFT.Physics.CapabilityDocuments')
(r/'GeoprovenanceResolvedProgram1520.lean').write_text(s)
s=(w/'prepare_nonordinaryexternal1395_programme.py').read_text().replace('SFT.Consciousness.NonordinaryExternalValidation','SFT.EarthEnvironment.EarthGeologicalProvenanceValidation').replace('NonordinaryExternalProgram1395','GeoprovenanceResolvedProgram1520').replace('nonordinaryexternal1395_programme_native_build1381','geoprovenanceresolved1520_native_build').replace("out=w/'nonordinary1395_native'","out=w/'geoprovenanceresolved1520_native'").replace("shared_receipt=w/'redcontrols1444_programme_native_build1381.json'","shared_receipt=w/'geocycleresolved1519_native_build.json'")
(w/'prepare_geoprovenanceresolved1520_programme.py').write_text(s)
