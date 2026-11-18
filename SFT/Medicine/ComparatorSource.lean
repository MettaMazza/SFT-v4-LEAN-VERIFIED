import SFT.Medicine.InterventionSource
namespace SFT.Medicine.ComparatorSource
abbrev Snapshot := InterventionSource.Snapshot
abbrev readSnapshot := InterventionSource.readSnapshot
abbrev requirements := InterventionSource.requirements
abbrev sources := InterventionSource.sources
def expectedLabel : String := "medicine:alternative-care-action__contrast-with-intervention__concurrent-or-declared-reference__same-eligibility-outcome-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InterventionSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.ComparatorSource
