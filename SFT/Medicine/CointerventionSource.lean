import SFT.Medicine.InterventionSource
namespace SFT.Medicine.CointerventionSource
abbrev Snapshot := InterventionSource.Snapshot
abbrev readSnapshot := InterventionSource.readSnapshot
abbrev requirements := InterventionSource.requirements
abbrev sources := InterventionSource.sources
def expectedLabel : String := "medicine:joint-care-word__additional-action-to-outcome-relation__all-concurrent-actions-held__arm-setting-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InterventionSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.CointerventionSource
