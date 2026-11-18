import SFT.Medicine.ScreeningSource
namespace SFT.Medicine.StoppingWithdrawalSource
abbrev Snapshot := ScreeningSource.Snapshot
abbrev readSnapshot := ScreeningSource.readSnapshot
abbrev requirements := ScreeningSource.requirements
abbrev sources := ScreeningSource.sources
def expectedLabel : String := "medicine:ongoing-care-and-patient-state__stop-continue-change-decision__reason-transition-and-aftercare__decision-time-and-follow-up"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ScreeningSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.StoppingWithdrawalSource
