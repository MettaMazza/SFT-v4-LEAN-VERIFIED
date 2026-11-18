import SFT.Medicine.InterventionSource
namespace SFT.Medicine.CounterfactualSource
abbrev Snapshot := InterventionSource.Snapshot
abbrev readSnapshot := InterventionSource.readSnapshot
abbrev requirements := InterventionSource.requirements
abbrev sources := InterventionSource.sources
def expectedLabel : String := "medicine:same-eligibility-patient-state__alternative-action-outcome-relation__mutually-exclusive-potential-courses__identification-assumption-boundary"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InterventionSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.CounterfactualSource
