import SFT.Chemistry.StateTransitionTargets
import SFT.Chemistry.MolecularStateTransition
import SFT.Chemistry.MulticentreComparison
namespace SFT.Chemistry.StateTransitionComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open MolecularStateTransition
abbrev J := Canonical.Value
abbrev Predictions := JointCorrelationComparison.Predictions
abbrev lookup := JointCorrelationComparison.lookup

def predictionMap (entries : List (Value × Value)) : Except String Predictions := do
 let rows := entries.foldl (fun rows (key,value) => match key with
  | .label h => if Text.equal h.family "state-transition-law" then JointCorrelationComparison.store rows h.label value else rows
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => rows) []
 if rows.length != 9 then throw "ELEC-009 prediction law is incomplete"
 return rows

def validatePrediction (predicted : Predictions) : Except String Unit := do
 let f ← lookup predicted "forward"
 let r ← lookup predicted "reverse"
 let b ← lookup predicted "bidirectional"
 let c ← lookup predicted "coupled"
 let a ← lookup predicted "absence"
 if !equal f (.label forward) || !equal r (.label reverse) || !equal b (.label bidirectional) ||
    !equal c (.label coupled) || !equal a (.label absent) then throw "ELEC-009 orientation law changed"
 return ()

def compare (row : StateTransitionTargets.Resolved) : Except String J := do
 let fs := Canonical.Value.object row.row.fields
 let state ← field fs "state_record" >>= text
 let transition ← field fs "transition_inscription" >>= text
 let observation ← field fs "observation_class" >>= text
 let inscription ← field fs "band_origin_inscription" >>= text
 let structural ← if Text.equal observation "absent-transition-coordinate" then do
   let record ← absentTransition "H2" state transition
   pure (match record.terminal with | .emptyOne => true | .state _ | .otherEmptyOne _ => false)
  else do
   let (left,right,orientation) ← StateTransitionInscription.endpoints state transition
   let record ← observedTransition "H2" left right orientation transition
   pure (isObserved record && (MulticentreSupport.sameLabel orientation forward ||
    MulticentreSupport.sameLabel orientation reverse || MulticentreSupport.sameLabel orientation bidirectional ||
    MulticentreSupport.sameLabel orientation coupled))
 let bandPass := if Text.equal inscription "absence" then
   match row.band with | .emptyOne _ => true | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false
  else match row.band with | .ratio _ _ => true | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
 return .object [("target_id",← field fs "target_id"),("row_kind",← field fs "source_row_kind"),
  ("state_record",.text state),("transition_inscription",.text transition),("observation_class",.text observation),
  ("band_origin_inscription",.text inscription),("exact_band",.text (← MulticentreComparison.magnitudeText row.band)),
  ("passed",.boolean (structural && bandPass))]
end SFT.Chemistry.StateTransitionComparison
