import SFT.Medicine.InterventionSource
namespace SFT.Medicine.AllocationSource
abbrev Snapshot := InterventionSource.Snapshot
abbrev readSnapshot := InterventionSource.readSnapshot
abbrev requirements := InterventionSource.requirements
abbrev sources := InterventionSource.sources
def expectedLabel : String := "medicine:eligible-participant-records__assignment-to-declared-arm__allocation-sequence-with-concealment__generation-implementation-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InterventionSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.AllocationSource
