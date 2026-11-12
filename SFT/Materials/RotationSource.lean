import SFT.Materials.MaterialSource
namespace SFT.Materials.RotationSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def requirements : List MaterialSource.Requirement := [⟨"NIST-SHECHTMAN-QUASICRYSTALS-2026-07-24","only one-, two-, three-, four- and sixfold symmetries"⟩,⟨"NIST-SHECHTMAN-QUASICRYSTALS-2026-07-24","fivefold periodic structures were not supposed to exist"⟩]
def expectedLabel : String := "integer-lattice-action-carrier__finite-order-rotation-relation__translation-compatibility-retained__orders-one-two-three-four-six__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
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


end SFT.Materials.RotationSource
