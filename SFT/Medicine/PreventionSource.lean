import SFT.Medicine.ScreeningSource
namespace SFT.Medicine.PreventionSource
abbrev Snapshot := ScreeningSource.Snapshot
abbrev readSnapshot := ScreeningSource.readSnapshot
abbrev requirements := ScreeningSource.requirements
abbrev sources := ScreeningSource.sources
def expectedLabel : String := "medicine:at-risk-person-or-population__action-before-target-outcome__primary-secondary-tertiary-boundary__risk-frame-time-and-outcomes"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ScreeningSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.PreventionSource
