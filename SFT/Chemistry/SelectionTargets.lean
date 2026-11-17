import SFT.Chemistry.SelectionObservation
import SFT.Chemistry.StateTransitionTargets
namespace SFT.Chemistry.SelectionTargets
open SFT.Host
open ConjugatedSupportAnalysis (field array)
open JointCorrelationTargets (text)
open StateTransitionInscription (stripEnds firstToken)
abbrev J := Canonical.Value

def sourceId := "NIST-CHEMISTRY-WEBBOOK-SRD69-H2-SELECTION-SURFACE"
def sourcePath := "experiments/external_sources/chemistry/snapshots/electron-spin-v1/C1333740.html"
def sourceHash := "sha256:410fae804b1fa35ab72d829d95bd3b26c831dde2f0ec0078b614fea2c87d795e"
def authorities : List (String × String) := [
 ("experiments/external_sources/chemistry/selection_rule_target_identities_v1.json","sha256:974583091f4c1cd484b8761fe014c5870db38a175a3fd5c8c2b1147b17e62e87"),
 ("experiments/external_sources/chemistry/selection_rule_withheld_targets_v1.json","sha256:94af2d38e07bbcdd4f70e74557c5f174ebff586f4d287db541bee00ae204b56f"),
 (sourcePath,sourceHash),
 ("experiments/external_sources/chemistry/state_transition_withheld_targets_v1.json","sha256:219b5c70f508db7083cbc8c41a7b75118507183f8f5de91e45576835e60b6ac1"),
 ("experiments/external_sources/chemistry/state_symmetry_withheld_targets_v1.json","sha256:b4241adb2b4648d40f984329699714c829daa46a83204c1928eae302de9df93f")]

def sameStrings (a b : List String) : Bool :=
 a.length==b.length && (a.zip b).all (fun (x,y) => Text.equal x y)
def distinct (xs : List String) : Bool :=
 (xs.foldl (fun seen x => if seen.any (Text.equal x) then seen else seen++[x]) []).length==xs.length

def stateName (row : J) : Except String String := do
 let name ← field row "state_record" >>= text >>= firstToken
 return stripEnds name (fun c => c.toNat==40 || c.toNat==41)

def hydrogenStates (rows : List J) : Except String (List (String × J)) :=
 rows.foldlM (fun states row => do
  let species ← field row "species_row_id" >>= text
  if !Text.equal species "hydrogen-neutral" then return states
  let name ← stateName row
  return (states.filter fun x => !Text.equal x.1 name) ++ [(name,row)]) []

def rebuiltSignature (states : List (String × J)) (name : String) : Except String J := do
 let state := states.find? fun x => Text.equal x.1 name
 let resolved := state.isSome
 let multiplicity ← match state with | none => pure SFT.Host.Canonical.Value.null | some (_,row) => field row "positive_spin_multiplicity"
 let axis ← match state with | none => pure SFT.Host.Canonical.Value.null | some (_,row) => field row "axis_support_symbol"
 let inversion ← match state with | none => pure SFT.Host.Canonical.Value.null | some (_,row) => field row "held_inversion_label"
 return .object [("state",.text name),("resolved",.boolean resolved),
  ("positive_spin_multiplicity",multiplicity),("axis_support_symbol",axis),("held_inversion_label",inversion)]

def rebuild (states : List (String × J)) (source : J) : Except String J := do
 let inscription ← field source "transition_inscription" >>= text
 let names ← SelectionObservation.endpoints inscription
 let signatures ← names.mapM (rebuiltSignature states)
 let id ← field source "target_id" >>= text
 return .object [("target_id",.text (Text.append "selection-" id)),
 ("target_kind",.text "complete-transition-record"),("source_id",.text sourceId),
 ("source_row_kind",← field source "source_row_kind"),("source_row_ordinal",← field source "source_row_ordinal"),
 ("state_record",← field source "state_record"),("transition_inscription",.text inscription),
 ("observation_class",← field source "observation_class"),("endpoint_signatures",.array signatures),
 ("snapshot_path",.text sourcePath),("snapshot_hash",.text sourceHash)]

def requiredNotes : List (String × List String) := [
 ("selection-adverse-note-42",["forbidden","magnetic dipole"]),
 ("selection-adverse-note-73",["no bands","absorption"]),
 ("selection-adverse-note-78",["forbidden","uncoupling","Only Q branches"])]

def targets (actualHashes : List (String × String)) (identities document : J)
 (transitionRows symmetryRows : List J) (raw : String) : Except String (List J) := do
 let _ ← authorities.mapM fun (path,expected) => do
  if !(actualHashes.any fun (p,h) => Text.equal p path && Text.equal h expected) then
   throw (Text.append "ELEC-010 registered source changed: " path)
  pure ()
 let identitySchema ← field identities "schema" >>= text
 let targetSchema ← field document "schema" >>= text
 let identityRows ← field identities "rows" >>= array
 let rows ← field document "rows" >>= array
 let ids ← identityRows.mapM fun row => field row "target_id" >>= text
 let targetIds ← rows.mapM fun row => field row "target_id" >>= text
 if !Text.equal identitySchema "sft-v3-selection-rule-identities/1" ||
    !Text.equal targetSchema "sft-v3-selection-rule-withheld-targets/1" || rows.length != 63 ||
    !sameStrings ids targetIds || !distinct ids || ids.length != 63 then
  throw "ELEC-010 complete target registry differs"
 let states ← hydrogenStates symmetryRows
 if transitionRows.length != 60 || states.length != 46 then
  throw "ELEC-010 dependency source surface is incomplete"
 let _ ← (transitionRows.zip (rows.take 60)).mapM fun (source,combined) => do
  let expected ← rebuild states source
  if !Text.equal (Canonical.render combined) (Canonical.render expected) then
   throw "ELEC-010 independently reconstructed transition target differs"
  pure ()
 let _ ← requiredNotes.mapM fun (id,phrases) => do
  let found := (targetIds.zip rows).find? fun pair => Text.equal pair.1 id
  match found with
  | none => throw "ELEC-010 adverse note was not retained exactly"
  | some (_,row) =>
   let note ← field row "note_text" >>= text
   if !(phrases.all fun phrase => Text.contains note phrase && Text.contains raw phrase) then
    throw "ELEC-010 adverse note was not retained exactly"
   pure ()
 return rows
end SFT.Chemistry.SelectionTargets
