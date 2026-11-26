import SFT.Physics.HostilePackage
import SFT.Chemistry.CanonicalExecutionChunks
namespace SFT.Chemistry.CanonicalPackageChunks
open SFT.Host.Canonical SFT.Physics SFT.Physics.CapabilityDocuments SFT.Physics.CapabilityAdmission
open SFT.Mathematics.DiscreteObjects SFT.Physics.HostilePackage
def auditProgram (document : List (String × Value)) (before after : Snapshot) : Except String (Program × Certificate) :=
  let executable := ["python","source","script","command","module","callable"].any
    (fun key => document.any (fun row => decide (row.1 = key)))
  let additional := !exactKeys document ["schema","program_id","instructions"]
  match loadProgramFields document with
  | .error reason => .error reason
  | .ok program =>
    let unchanged := decide (before = after)
    let passed := !executable && !additional && unchanged
    let packageHash := CanonicalExecutionChunks.identity (.object document)
    let programHash := CanonicalExecutionChunks.identity (SFT.Physics.CapabilityExecution.canonicalProgram program)
    let payload : Value := .object [("auditor_id",.text auditorId),("package_hash",.text packageHash),
      ("program_hash",.text programHash),("executable_source_present",.boolean executable),
      ("additional_fields_present",.boolean additional),("protected_tree_unchanged",.boolean unchanged),
      ("passed",.boolean passed)]
    if passed then .ok (program,⟨auditorId,packageHash,programHash,executable,additional,unchanged,passed,CanonicalExecutionChunks.identity payload⟩)
    else .error "empirical package failed data-only or protected-tree audit"

theorem auditProgramPreserved (document : List (String × Value)) (before after : Snapshot) :
 auditProgram document before after = HostilePackage.auditProgram document before after := by
 unfold auditProgram HostilePackage.auditProgram
 cases h : loadProgramFields document with
 | error reason => rfl
 | ok program =>
   dsimp only
   rw [CanonicalExecutionChunks.identityPreserved,CanonicalExecutionChunks.identityPreserved]
   split
   · rw [CanonicalExecutionChunks.identityPreserved]
   · rfl
end SFT.Chemistry.CanonicalPackageChunks
#print axioms SFT.Chemistry.CanonicalPackageChunks.auditProgram
#print axioms SFT.Chemistry.CanonicalPackageChunks.auditProgramPreserved
