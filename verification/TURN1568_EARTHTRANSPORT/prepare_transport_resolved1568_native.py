from pathlib import Path
w=Path('work');r=w/'turn1064_recovery'
s=(r/'NonordinaryExternalProgram1395.lean').read_text();s=s[:s.index('set_option maxRecDepth')].replace('SFT.Consciousness.NonordinaryExternalValidation','SFT.EarthEnvironment.EarthEnvironmentalTransportValidation').replace('open SFT.Consciousness SFT.Physics','open SFT.EarthEnvironment SFT.Physics')
s+='''set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/transport_resolved1568_input.json"
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
 let program ← IO.ofExcept (SFT.Physics.CapabilityDocuments.loadProgramFields EarthEnvironmentalTransportExperiment.programFields)
 let inputs ← IO.ofExcept (EarthEnvironmentalTransportValidation.inputValues derivation)
 let observed := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field row "observed_label")
 let result ← IO.ofExcept (EarthEnvironmentalTransportValidation.validateResolved (SFT.Host.Canonical.identity registration) program inputs row audit observed extraction derivation host implementation before after)
 IO.println (SFT.Host.Canonical.render result)
'''
# Resolve actual namespace from the existing scientific module; no replacement operation.
s=s.replace('SFT.Physics.CapabilityDocuments','SFT.Physics.CapabilityDocuments')
(r/'EnvironmentalTransportResolvedProgram1568.lean').write_text(s)
s=(w/'prepare_nonordinaryexternal1395_programme.py').read_text().replace('SFT.Consciousness.NonordinaryExternalValidation','SFT.EarthEnvironment.EarthEnvironmentalTransportValidation').replace('NonordinaryExternalProgram1395','EnvironmentalTransportResolvedProgram1568').replace('nonordinaryexternal1395_programme_native_build1381','transportresolved1568_native_build').replace("out=w/'nonordinary1395_native'","out=w/'transportresolved1568_native'").replace("shared_receipt=w/'redcontrols1444_programme_native_build1381.json'","shared_receipt=w/'receptorresolved1567_native_build.json'")
(w/'prepare_transportresolved1568_programme.py').write_text(s)
