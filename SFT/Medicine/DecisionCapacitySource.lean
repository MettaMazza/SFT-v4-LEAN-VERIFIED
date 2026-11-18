import SFT.Medicine.InformedConsentSource
namespace SFT.Medicine.DecisionCapacitySource
abbrev Snapshot := InformedConsentSource.Snapshot
abbrev readSnapshot := InformedConsentSource.readSnapshot
abbrev requirements := InformedConsentSource.requirements
abbrev sources := InformedConsentSource.sources
def expectedLabel : String := "medicine:person-decision-context__understand-retain-weigh-communicate__decision-specific-support-and-assistance__time-decision-and-assessment-method"
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← InformedConsentSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.DecisionCapacitySource
