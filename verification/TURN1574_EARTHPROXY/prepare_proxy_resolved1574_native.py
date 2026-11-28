from pathlib import Path
w=Path('work');r=w/'turn1064_recovery'
s=(r/'NonordinaryExternalProgram1395.lean').read_text();s=s[:s.index('set_option maxRecDepth')].replace('SFT.Consciousness.NonordinaryExternalValidation','SFT.EarthEnvironment.EarthProxyReconstructionValidation').replace('open SFT.Consciousness SFT.Physics','open SFT.EarthEnvironment SFT.Physics')
s+='''set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/proxy_resolved1574_input.json"
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
 let program ← IO.ofExcept (SFT.Physics.CapabilityDocuments.loadProgramFields EarthProxyReconstructionExperiment.programFields)
 let inputs ← IO.ofExcept (EarthProxyReconstructionValidation.inputValues derivation)
 let observed := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field row "observed_label")
 let result ← IO.ofExcept (EarthProxyReconstructionValidation.validateResolved (SFT.Host.Canonical.identity registration) program inputs row audit observed extraction derivation host implementation before after)
 IO.println (SFT.Host.Canonical.render result)
'''
# Resolve actual namespace from the existing scientific module; no replacement operation.
s=s.replace('SFT.Physics.CapabilityDocuments','SFT.Physics.CapabilityDocuments')
(r/'ProxyReconstructionResolvedProgram1574.lean').write_text(s)
s=(w/'prepare_nonordinaryexternal1395_programme.py').read_text().replace('SFT.Consciousness.NonordinaryExternalValidation','SFT.EarthEnvironment.EarthProxyReconstructionValidation').replace('NonordinaryExternalProgram1395','ProxyReconstructionResolvedProgram1574').replace('nonordinaryexternal1395_programme_native_build1381','proxyresolved1574_native_build').replace("out=w/'nonordinary1395_native'","out=w/'proxyresolved1574_native'").replace("shared_receipt=w/'redcontrols1444_programme_native_build1381.json'","shared_receipt=w/'remoteresolved1573_native_build.json'")
(w/'prepare_proxyresolved1574_programme.py').write_text(s)
