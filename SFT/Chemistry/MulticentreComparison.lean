import SFT.Chemistry.MulticentreTargets
import SFT.Chemistry.MulticentreSupport
import SFT.Chemistry.JointCorrelationComparison
namespace SFT.Chemistry.MulticentreComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text integer)
abbrev J := Canonical.Value
abbrev Predictions := JointCorrelationComparison.Predictions
abbrev lookup := JointCorrelationComparison.lookup
def predictionMap (entries : List (Value × Value)) : Except String Predictions := do
 let rows := entries.foldl (fun rows (key,value) => match key with
  | .label h => if Text.equal h.family "multicentre-law" then JointCorrelationComparison.store rows h.label value else rows
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => rows) []
 if rows.length != 8 then throw "ELEC-008 prediction table is incomplete"
 return rows
def expected : Except String Predictions := do
 return [("minimum-centre-count",.count (← count 3)),
 ("support-identity",.label (← heldLabel "multicentre-result" "one-complete-extended-support")),
 ("connection",.label (← heldLabel "multicentre-result" "connected-generated-graph")),
 ("ribbon",.label MulticentreSupport.ribbon),("surface",.label MulticentreSupport.surface),("volume",.label MulticentreSupport.volume),
 ("reduction",.label (← heldLabel "multicentre-result" "irreducible-to-one-localized-pair")),
 ("extension",.label (← heldLabel "multicentre-result" "connected-successor-with-no-extra-rule"))]
def validatePrediction (predicted : Predictions) : Except String Unit := do
 let wanted ← expected
 if predicted.length != 8 || !(wanted.all fun (key,v) => predicted.any (fun (k,w) => Text.equal k key && equal v w)) then throw "ELEC-008 sealed law changed"
 return ()
def magnitudeText : Value → Except String String
 | .emptyOne _ => .ok "structural-absence"
 | .ratio n d => .ok (Text.intercalate "/" [toString n.value,toString d.value])
 | .count _ | .label _ | .word _ | .pair _ _ | .table _ => .error "ratio magnitude required"
def required (role : String) : Except String String :=
 match [("definition","localized bonds"),("ribbon-topology","ribbon"),("surface-topology","surface"),("volume-topology","volume")].find? (fun p => Text.equal p.1 role) with
 | none => .error (Text.intercalate "" ["'",role,"'"])
 | some p => .ok p.2
def compare (predicted : Predictions) (row : MulticentreTargets.Resolved) : Except String J := do
 let fs := Canonical.Value.object row.row.fields
 let source ← field fs "source_id" >>= text
 let role ← field fs "record_role" >>= text
 let inscription ← field fs "inscription" >>= text
 let bridge ← MulticentreSupport.bridge
 let ring ← MulticentreSupport.ring
 let structural ← if Text.equal source "IUPAC-GOLD-BOOK-08789-2026" then do
   pure (Text.contains inscription (← required role))
  else if Text.equal source "NIST-CCCBDB-SRD101-DIBORANE" then do
   pure (MulticentreSupport.irreducible bridge && equal (.label bridge.topology) (← lookup predicted "ribbon"))
  else do
   pure (MulticentreSupport.irreducible ring && equal (.label ring.topology) (← lookup predicted "surface") && ring.edges.length==6)
 let n := match row.row.fields.find? (fun p => Text.equal p.1 "positive_value_numerator") with
  | none => Canonical.Value.text "absence"
  | some p => p.2
 let exactPassed ← if ConjugatedSupportAnalysis.isText n "absence" then pure (equal row.magnitude (.emptyOne "empty-One")) else do
  let numerator ← integer n
  let denominator ← field fs "positive_value_denominator" >>= integer
  pure (equal row.magnitude (.ratio (← count numerator.toNat) (← count denominator.toNat)))
 let copied ← ["target_id","source_id","record_kind","record_role","inscription"].mapM fun key => do return (key,← field fs key)
 return .object (copied++[("exact_magnitude",.text (← magnitudeText row.magnitude)),("structural_pass",.boolean structural),
 ("exact_pass",.boolean exactPassed),("passed",.boolean (structural && exactPassed))])
end SFT.Chemistry.MulticentreComparison
