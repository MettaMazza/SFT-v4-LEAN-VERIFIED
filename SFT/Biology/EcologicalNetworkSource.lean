import SFT.Biology.LifeOrganizationSource
namespace SFT.Biology.EcologicalNetworkSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := LifeOrganizationSource.Snapshot
abbrev Source := LifeOrganizationSource.Source
abbrev Requirement := LifeOrganizationSource.Requirement
abbrev sources := LifeOrganizationSource.sources
abbrev distinctIds := LifeOrganizationSource.distinctIds
abbrev readSnapshot := LifeOrganizationSource.readSnapshot
abbrev corpus := LifeOrganizationSource.corpus
abbrev validateSources := LifeOrganizationSource.validateSources
def requirements : List Requirement := [⟨"SFT-BIO-SRC-EUROPEPMC-SCALE-FREE-RARE-6399239-XML-V1","scale-free networks are not ubiquitous"⟩,⟨"SFT-BIO-SRC-EUROPEPMC-SCALE-FREE-RARE-6399239-XML-V1","log-normal distributions fit"⟩]
def expectedLabel : String := "biology:complete-population-interaction-graph__degree-path-and-clustering-census__nodes-edges-effort-and-missing-links-held__sampling-scale-declared"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let receipts ← requirements.mapM fun requirement => do
  let source ← match sources.find? (fun s => Text.equal s.sourceId requirement.sourceId) with
   | none => .error (Text.intercalate "" ["'",requirement.sourceId,"'"])
   | some s => .ok s
  let bytes ← readSnapshot files source.path
  let folded := SFT.Chemistry.SourceText.casefold requirement.fragment
  if !(Text.contains (corpus bytes) folded) then
   throw (Text.intercalate "" ["required Biology feature absent: ",requirement.sourceId," :: ",requirement.fragment])
  return Value.array [.text requirement.sourceId,.text source.digest,.text requirement.fragment,
   .text (identity (.array [.text requirement.sourceId,.text folded]))]
 return (expectedLabel,identity (.array receipts))
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 validateSources files
 extractRequirements files
theorem sourceChecksReused (files : List Snapshot)
 (checked : validateSources files = .ok ()) :
 sourceDerivedTarget files = extractRequirements files := by
 unfold sourceDerivedTarget
 rw [checked]
 rfl
end SFT.Biology.EcologicalNetworkSource
