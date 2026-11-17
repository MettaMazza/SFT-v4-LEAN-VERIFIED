import SFT.Chemistry.CoordinationEntity
import Lean
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.CoordinationEntity
abbrev J := Canonical.Value
def field (j : Lean.Json) (k : String) := j.getObjVal? k
def text (j : Lean.Json) (k : String) := j.getObjValAs? String k
def label (j : Lean.Json) : Except String HeldLabel := do
 let a ← j.getArr?
 heldLabel (← a[0]!.getStr?) (← a[1]!.getStr?)
def parseAttachment (j : Lean.Json) : Except String Attachment := do
 attachment (← count (← j.getObjValAs? Nat "number"))
  (← field j "central" >>= label) (← field j "ligand" >>= label)
  (← field j "group" >>= label) (← field j "trace" >>= label)
def attachmentValue (a : Attachment) : J := .object [
 ("source_occurrence",canonical (.count a.sourceOccurrence)),
 ("central_occurrence",canonical (.label a.centralOccurrence)),
 ("ligand_occurrence",canonical (.label a.ligandOccurrence)),
 ("ligand_group_identity",canonical (.label a.ligandGroupIdentity)),
 ("attachment_trace",canonical (.label a.attachmentTrace))]
def entityValue (e : Entity) : J := .object [
 ("entity_identity",canonical (.label e.entityIdentity)),
 ("central_element_identity",canonical (.label e.centralElementIdentity)),
 ("central_occurrence",canonical (.label e.centralOccurrence)),
 ("ordered_attachments",.array (e.orderedAttachments.map attachmentValue))]
def identityValue (e : IdentityRecord) : J := .object [
 ("entity_identity",canonical (.label e.entityIdentity)),
 ("central_element_identity",canonical (.label e.centralElementIdentity)),
 ("central_occurrence",canonical (.label e.centralOccurrence)),
 ("ordered_ligand_occurrences",.array (e.orderedLigandOccurrences.map (fun x => canonical (.label x)))),
 ("ordered_ligand_group_identities",.array (e.orderedLigandGroupIdentities.map (fun x => canonical (.label x)))),
 ("ordered_attachment_traces",.array (e.orderedAttachmentTraces.map (fun x => canonical (.label x))))]
def runCase (j : Lean.Json) : Except String J := do
 let op ← text j "op"
 if op=="attachment" then return attachmentValue (← field j "attachment" >>= parseAttachment)
 let entity ← field j "entity" >>= label
 let element ← field j "element" >>= label
 let central ← field j "central" >>= label
 let rows ← (← (← field j "rows").getArr?).toList.mapM parseAttachment
 let e ← construct entity element central rows
 if op=="identity" then return identityValue (forcedIdentity e)
 if op=="append" then return .boolean (← appendPreservesIdentity e (← field j "successor" >>= parseAttachment))
 return entityValue e
def output (j : Lean.Json) : J := match runCase j with
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",v)]
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/coordination1135_input.json"
 let rows ← IO.ofExcept (do (← Lean.Json.parse raw).getArr?)
 IO.println (Canonical.render (.array (rows.toList.map output)))
