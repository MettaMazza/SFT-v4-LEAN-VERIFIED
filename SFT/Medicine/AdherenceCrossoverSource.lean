import SFT.Medicine.InterventionSource
namespace SFT.Medicine.AdherenceCrossoverSource
abbrev Snapshot := InterventionSource.Snapshot
abbrev readSnapshot := InterventionSource.readSnapshot
abbrev requirements := InterventionSource.requirements
abbrev sources := InterventionSource.sources
def expectedLabel : String := "medicine:assigned-and-received-care-record__assignment-delivery-use-relation__protocol-deviation-trace__participant-time-and-reason"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InterventionSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.AdherenceCrossoverSource
