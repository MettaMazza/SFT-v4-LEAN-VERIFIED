import SFT.Medicine.ScreeningSource
namespace SFT.Medicine.TreatmentSource
abbrev Snapshot := ScreeningSource.Snapshot
abbrev readSnapshot := ScreeningSource.readSnapshot
abbrev requirements := ScreeningSource.requirements
abbrev sources := ScreeningSource.sources
def expectedLabel : String := "medicine:patient-with-declared-condition__therapeutic-action-to-course__content-delivery-response-and-harm__indication-setting-time-and-follow-up"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← ScreeningSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.TreatmentSource
