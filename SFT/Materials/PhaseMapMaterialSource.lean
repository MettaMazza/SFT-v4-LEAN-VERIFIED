import SFT.Materials.MaterialSource
namespace SFT.Materials.PhaseMapMaterialSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def requirements : List MaterialSource.Requirement := [⟨"NIST-TRANSPORT-THERMOELECTRIC-2026-07-24","phase equilibrium data"⟩,⟨"NIST-TRANSPORT-THERMOELECTRIC-2026-07-24","bulk and thin film"⟩,⟨"NIST-TEXTURE-PHASE-FRACTION-2026-07-24","phase fraction"⟩,⟨"NIST-TEXTURE-PHASE-FRACTION-2026-07-24","types and amounts of phases"⟩]
def expectedLabel : String := "composition-condition-support__stable-phase-minimality-relation__coexisting-fractions-and-boundaries__declared-domain-bounded__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let receipts ← requirements.mapM fun requirement => do
   let source ← match sources.find? (fun s => Text.equal s.sourceId requirement.sourceId) with
     | some s => .ok s
     | none => .error (Text.append "KeyError: " requirement.sourceId)
   let bytes ← readSnapshot files source.path
   if !(Text.contains (corpus bytes) (SFT.Chemistry.SourceText.casefold requirement.fragment)) then
     .error "required Materials feature is absent after source release"
   else .ok (Value.array [.text requirement.sourceId,.text source.hash,.text requirement.fragment,
     .text (identity (.array [.text requirement.sourceId,.text (SFT.Chemistry.SourceText.casefold requirement.fragment)]))])
 .ok (expectedLabel,identity (.array receipts))

def extractTarget (files : List Snapshot) : Except String (String × String) := do
 validateSources files
 extractRequirements files

theorem rejectedSourcesStop (files : List Snapshot) (error : String)
 (rejected : validateSources files = .error error) :
 extractTarget files = .error error := by
 unfold extractTarget
 rw [rejected]
 rfl


end SFT.Materials.PhaseMapMaterialSource
