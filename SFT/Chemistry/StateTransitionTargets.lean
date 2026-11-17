import SFT.Chemistry.StateTransitionPrediction
import SFT.Chemistry.StateTransitionSurface
import SFT.Chemistry.StateTransitionInscription
import SFT.Chemistry.PairExchangeTargets
import SFT.Chemistry.JointCorrelationTargets
namespace SFT.Chemistry.StateTransitionTargets
open SFT.Host SFT.Physics.CapabilityValues
open ConjugatedSupportAnalysis (field)
open JointCorrelationTargets (text)
abbrev J := Canonical.Value
abbrev Target := PairExchangeTargets.Target

def sourcePath := "experiments/external_sources/chemistry/snapshots/electron-spin-v1/C1333740.html"
def sourceHash := "sha256:410fae804b1fa35ab72d829d95bd3b26c831dde2f0ec0078b614fea2c87d795e"
def sourceId := "NIST-CHEMISTRY-WEBBOOK-SRD69-H2-TRANSITIONS"
def targetHash := "sha256:219b5c70f508db7083cbc8c41a7b75118507183f8f5de91e45576835e60b6ac1"
def ordinalText (n : Nat) : String :=
 let digits := Text.chars (ElectronSpinPrediction.numbered "" n)
 String.ofList (List.replicate (3-digits.length) '0' ++ digits)
def cell (row : List String) (n : Nat) : String := (row.drop n).headD ""
def inscriptionOrAbsence (s : String) : String := if s.isEmpty then "absence" else s

def rowRecord (kind : String) (ordinal : Nat) (state transition band classInput : String) : Target :=
 let id := Text.append (if Text.equal kind "primary-state" then "H2-transition-state-" else "H2-transition-continuation-") (ordinalText ordinal)
 ⟨id,[("target_id",.text id),("source_id",.text sourceId),("source_row_kind",.text kind),
 ("source_row_ordinal",.integer (.ofNat ordinal)),("state_record",.text state),
 ("transition_inscription",.text transition),("band_origin_inscription",.text band),
 ("observation_class",.text (StateTransitionInscription.observationClass classInput)),
 ("snapshot_path",.text sourcePath),("snapshot_hash",.text sourceHash)]⟩

structure Rebuilt where
 primary : Nat := 0
 continuation : Nat := 0
 currentState : Option String := none
 rows : List Target := []

def rebuildStep (acc : Rebuilt) (row : List String) : Rebuilt :=
 if row.length==13 && !(StateSymmetrySource.terms (cell row 0)).isEmpty then
  let state := cell row 0
  {acc with
   primary := acc.primary+1
   currentState := some state
   rows := acc.rows++[rowRecord "primary-state" (acc.primary+1) state
      (inscriptionOrAbsence (cell row 11)) (inscriptionOrAbsence (cell row 12)) (cell row 11)]}
 else if row.length==12 && !(ElectronSpinHtml.normalizeSpace (cell row 10)).isEmpty then
  match acc.currentState with
  | none => acc
  | some state => {acc with
      continuation := acc.continuation+1
      rows := acc.rows++[rowRecord "continuation-transition" (acc.continuation+1) state
        (cell row 10) (inscriptionOrAbsence (cell row 11)) (cell row 10)]}
 else acc

structure Resolved where
 row : Target
 band : Value
 targetValue : Value

def resolve (row : Target) : Except String Resolved := do
 let state ← field (.object row.fields) "state_record" >>= text
 let transition ← field (.object row.fields) "transition_inscription" >>= text
 let observation ← field (.object row.fields) "observation_class" >>= text
 let inscription ← field (.object row.fields) "band_origin_inscription" >>= text
 let band ← StateTransitionInscription.exactBand inscription
 let stateLabel ← heldLabel "NIST-state-record" state
 let transitionLabel ← heldLabel "NIST-transition-inscription" transition
 let observationLabel ← heldLabel "transition-observation-class" observation
 let inscriptionLabel ← heldLabel "NIST-band-inscription" inscription
 return ⟨row,band,.word [.label stateLabel,.label transitionLabel,.label observationLabel,band,.label inscriptionLabel]⟩

def reconstructedTargets (identityActual identitySchema : String) (ids : List String)
 (targetActual targetSchema : String) (targets : List Target) (sourceActual : String)
 (events : List StateTransitionSurface.Event) : Except String (List Resolved) := do
 let _ ← StateTransitionPrediction.identities identityActual identitySchema ids
 if !Text.equal targetActual targetHash || !Text.equal sourceActual sourceHash then
  throw "ELEC-009 target or source changed"
 let registered := PairExchangeTargets.targetDictionary targets
 if !Text.equal targetSchema "sft-v3-state-transition-withheld-targets/1" || registered.length != 60 then
  throw "ELEC-009 target registry is incomplete"
 let rebuilt := (StateTransitionSurface.parseEvents events).rows.foldl rebuildStep {}
 let rebuiltIds := rebuilt.rows.map (fun row => row.targetId)
 if rebuilt.primary != 46 || rebuilt.continuation != 14 ||
    !(rebuiltIds.all (fun id => ids.any (Text.equal id))) || !(ids.all (fun id => rebuiltIds.any (Text.equal id))) then
  throw "ELEC-009 independent source census differs"
 rebuilt.rows.mapM fun row => do
  let existing ← match registered.find? (fun target => Text.equal target.targetId row.targetId) with
   | some target => pure target
   | none => throw (Text.append "'" (Text.append row.targetId "'"))
  if !StateSymmetryPrediction.canonicalEqual (.object existing.fields) (.object row.fields) then
   throw "ELEC-009 independent reconstruction differs"
  resolve row
end SFT.Chemistry.StateTransitionTargets
