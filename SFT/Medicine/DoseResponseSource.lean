import SFT.Medicine.DoseSource
namespace SFT.Medicine.DoseResponseSource
abbrev Snapshot := DoseSource.Snapshot
abbrev readSnapshot := DoseSource.readSnapshot
abbrev requirements := DoseSource.requirements
abbrev sources := DoseSource.sources
def expectedLabel : String := "medicine:ordered-dose-groups-and-outcomes__outcome-incidence-by-dose__complete-dose-support-with-adverse-shapes__population-route-and-time"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← DoseSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.DoseResponseSource
