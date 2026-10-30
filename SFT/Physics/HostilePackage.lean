import SFT.Physics.CapabilityDocuments
namespace SFT.Physics.HostilePackage
open SFT.Host.Canonical SFT.Physics.CapabilityDocuments SFT.Physics.CapabilityAdmission
open SFT.Mathematics.DiscreteObjects
structure Snapshot where
  rootIdentity : String
  fileHashes : List (String × String)
  snapshotHash : String
  deriving DecidableEq
structure Certificate where
  auditorId : String
  packageHash : String
  programHash : String
  executableSourcePresent : Bool
  additionalFieldsPresent : Bool
  protectedTreeUnchanged : Bool
  passed : Bool
  certificateHash : String

def auditorId : String := "sft-v3-hostile-empirical-package-auditor/1"
def auditProgram (document : List (String × Value)) (before after : Snapshot) : Except String (Program × Certificate) :=
  let executable := ["python","source","script","command","module","callable"].any
    (fun key => document.any (fun row => decide (row.1 = key)))
  let additional := !exactKeys document ["schema","program_id","instructions"]
  match loadProgramFields document with
  | .error reason => .error reason
  | .ok program =>
    let unchanged := decide (before = after)
    let passed := !executable && !additional && unchanged
    let packageHash := identity (.object document)
    let programHash := identity (SFT.Physics.CapabilityExecution.canonicalProgram program)
    let payload : Value := .object [("auditor_id",.text auditorId),("package_hash",.text packageHash),
      ("program_hash",.text programHash),("executable_source_present",.boolean executable),
      ("additional_fields_present",.boolean additional),("protected_tree_unchanged",.boolean unchanged),
      ("passed",.boolean passed)]
    if passed then .ok (program,⟨auditorId,packageHash,programHash,executable,additional,unchanged,passed,identity payload⟩)
    else .error "empirical package failed data-only or protected-tree audit"

theorem parserFailureRetained (document : List (String × Value)) (before after : Snapshot) (reason : String)
    (failed : loadProgramFields document = .error reason) : auditProgram document before after = .error reason := by
  unfold auditProgram
  rw [failed]

theorem acceptedTreeUnchanged (document : List (String × Value)) (before after : Snapshot)
    (program : Program) (certificate : Certificate)
    (accepted : auditProgram document before after = .ok (program,certificate)) : before = after := by
  unfold auditProgram at accepted
  cases parsed : loadProgramFields document with
  | error reason => rw [parsed] at accepted; cases accepted
  | ok result =>
    rw [parsed] at accepted
    dsimp only at accepted
    cases unchanged : decide (before = after) with
    | true => exact of_decide_eq_true unchanged
    | false =>
      rw [unchanged,Bool.and_false] at accepted
      cases accepted
theorem acceptedCertificateBound (document : List (String × Value)) (before after : Snapshot)
    (program : Program) (certificate : Certificate)
    (accepted : auditProgram document before after = .ok (program,certificate)) :
    loadProgramFields document = .ok program ∧ certificate.passed = true ∧
      certificate.packageHash = identity (.object document) ∧
      certificate.programHash = identity (SFT.Physics.CapabilityExecution.canonicalProgram program) := by
  unfold auditProgram at accepted
  cases parsed : loadProgramFields document with
  | error reason => rw [parsed] at accepted; cases accepted
  | ok result =>
    rw [parsed] at accepted
    dsimp only at accepted
    split at accepted
    · rename_i passed
      cases Except.ok.inj accepted
      exact ⟨rfl,passed,rfl,rfl⟩
    · cases accepted
def rejectExecutableSource : Value → Except String Unit
 | .text source => if SFT.Physics.CapabilityValues.nonblank source then
     .error "official empirical predictions accept data-only Fold programs, not executable contributor source"
   else .error "prediction source is missing"
 | .boolean _ => .error "prediction source is missing"
 | .integer _ => .error "prediction source is missing"
 | .null => .error "prediction source is missing"
 | .array _ => .error "prediction source is missing"
 | .object _ => .error "prediction source is missing"

theorem sourceNeverAdmitted (source : Value) : ∃ reason, rejectExecutableSource source = .error reason := by
  cases source with
  | text source =>
    unfold rejectExecutableSource
    dsimp only
    cases SFT.Physics.CapabilityValues.nonblank source with
    | false => exact ⟨_,rfl⟩
    | true => exact ⟨_,rfl⟩
  | boolean b => exact ⟨_,rfl⟩
  | integer n => exact ⟨_,rfl⟩
  | null => exact ⟨_,rfl⟩
  | array xs => exact ⟨_,rfl⟩
  | object xs => exact ⟨_,rfl⟩

theorem changedSnapshotNeverAdmitted (document : List (String × Value)) (before after : Snapshot)
    (changed : before ≠ after) (program : Program) (certificate : Certificate) :
    auditProgram document before after ≠ .ok (program,certificate) :=
  fun accepted => changed (acceptedTreeUnchanged document before after program certificate accepted)

def snapshotPayload (root : String) (rows : List (String × String)) : Value :=
  .object [("root_identity",.text root),("file_hashes",.array
    (rows.map (fun row => .array [.text row.1,.text row.2])))]
def hashFiles (files : List (String × ByteArray)) : List (String × String) :=
  files.map (fun row => (row.1,SFT.Host.Text.append "sha256:" (SFT.Host.SHA256.digest row.2)))
-- The file lists are the original resolved, sorted per-directory enumeration.
def snapshotFromFiles (root : String) (census admitted : Option (List (String × ByteArray))) : Except String Snapshot :=
  match census with
  | none => .error "protected authority directory is missing: census"
  | some first => match admitted with
    | none => .error "protected authority directory is missing: receipts/engine/model_admitted"
    | some second =>
      let rows := hashFiles first ++ hashFiles second
      .ok ⟨root,rows,identity (snapshotPayload root rows)⟩

theorem snapshotRetainsBothTrees (root : String) (census admitted : List (String × ByteArray)) :
    snapshotFromFiles root (some census) (some admitted) =
      .ok ⟨root,hashFiles census ++ hashFiles admitted,
        identity (snapshotPayload root (hashFiles census ++ hashFiles admitted))⟩ := rfl

theorem snapshotRetainsEveryFile (files : List (String × ByteArray)) :
    (hashFiles files).map Prod.fst = files.map Prod.fst := by
  induction files with
  | nil => rfl
  | cons row rest ih =>
    change row.1 :: (hashFiles rest).map Prod.fst = row.1 :: rest.map Prod.fst
    rw [ih]
end SFT.Physics.HostilePackage
