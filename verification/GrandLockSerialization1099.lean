import SFT.Physics.GrandLockEntryEvidence
open SFT.Host SFT.Physics
def main : IO Unit := do
 let encoded := Canonical.render GrandLockEntryEvidence.completenessRecord
 IO.println (toString encoded.utf8ByteSize)
 IO.println (SFT.Foundation.AdmissionControls.executionIdentity GrandLockEntryEvidence.completenessRecord)
