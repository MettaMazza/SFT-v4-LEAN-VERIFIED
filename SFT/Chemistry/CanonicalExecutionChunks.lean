import SFT.Physics.CapabilityExecution
import SFT.Host.SHA256Chunks
namespace SFT.Chemistry.CanonicalExecutionChunks
open SFT.Host SFT.Physics
open CapabilityPrediction CapabilityValues CapabilityAdmission CapabilityOperations CapabilityExecution
def identity (v : Canonical.Value) : String :=
 Text.append "sha256:" (SHA256Chunks.digest (Canonical.render v).toUTF8)
theorem identityPreserved (v : Canonical.Value) : identity v = Canonical.identity v := by
 unfold identity Canonical.identity
 rw [SHA256Chunks.digestPreserved]
def valueIdentity (v : CapabilityValues.Value) : String := identity (CapabilityValues.canonical v)
def execute (p : Program) (inputs : List (String × CapabilityValues.Value)) : Except String Execution := do
 if inputs.isEmpty then .error "official prediction requires a registered positive input manifest"
 else if !(inputs.all (fun x => nonblank x.1)) then .error "registered input identity is missing"
 else
  let s ← run inputs initial 0 p.instructions
  pure ⟨p.programId,identity (canonicalProgram p),identity (canonicalInputs inputs),s.emitted,
   valueIdentity s.emitted,s.trace,identity (canonicalTrace s.trace),true⟩
theorem executePreserved (p : Program) (inputs : List (String × CapabilityValues.Value)) :
 execute p inputs = CapabilityExecution.execute p inputs := by
 unfold execute CapabilityExecution.execute valueIdentity CapabilityValues.identity
 split
 · rfl
 · split
   · rfl
   · cases h : run inputs initial 0 p.instructions with
     | error e => rfl
     | ok state =>
       change Except.ok _ = Except.ok _
       rw [identityPreserved,identityPreserved,identityPreserved,identityPreserved]
end SFT.Chemistry.CanonicalExecutionChunks
#print axioms SFT.Chemistry.CanonicalExecutionChunks.identity
#print axioms SFT.Chemistry.CanonicalExecutionChunks.identityPreserved
#print axioms SFT.Chemistry.CanonicalExecutionChunks.valueIdentity
#print axioms SFT.Chemistry.CanonicalExecutionChunks.execute
#print axioms SFT.Chemistry.CanonicalExecutionChunks.executePreserved
