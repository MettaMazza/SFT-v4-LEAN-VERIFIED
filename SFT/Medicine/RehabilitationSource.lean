import SFT.Medicine.ScreeningSource
namespace SFT.Medicine.RehabilitationSource
abbrev Snapshot := ScreeningSource.Snapshot
abbrev readSnapshot := ScreeningSource.readSnapshot
abbrev requirements := ScreeningSource.requirements
abbrev sources := ScreeningSource.sources
def expectedLabel : String := "medicine:person-function-and-participation-state__iterated-action-to-capacity-change__goals-interventions-context-and-course__baseline-follow-up-and-lived-setting"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ScreeningSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.RehabilitationSource
