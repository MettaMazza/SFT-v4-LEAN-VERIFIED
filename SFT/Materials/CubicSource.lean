import SFT.Materials.MaterialSource
namespace SFT.Materials.CubicSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def requirements : List MaterialSource.Requirement := [⟨"NIST-SIX-NEIGHBOUR-MESH-2026-07-24","nearest 6 neighbors"⟩,⟨"NIST-SIX-NEIGHBOUR-MESH-2026-07-24","forward and backward along each of the 3 coordinate axis directions"⟩]
def expectedLabel : String := "three-axis-site-carrier__two-orientations-per-axis__nearest-adjacency-complete__coordination-count-six__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
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


end SFT.Materials.CubicSource
