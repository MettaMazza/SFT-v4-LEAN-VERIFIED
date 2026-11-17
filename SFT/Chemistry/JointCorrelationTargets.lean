import SFT.Chemistry.JointCorrelationPrediction
import SFT.Chemistry.JointCorrelationNotes
import SFT.Chemistry.JointCorrelationObservation
import SFT.Chemistry.PairExchangeTargets
import SFT.Chemistry.ConjugatedSupportAnalysis
namespace SFT.Chemistry.JointCorrelationTargets
open SFT.Host SFT.Physics.CapabilityValues
abbrev J := Canonical.Value
abbrev field := ConjugatedSupportAnalysis.field
abbrev Target := PairExchangeTargets.Target

def targetHash : String := "sha256:f7043a52c1c2bd95fc49ab2457f9ab64ad6879e8c835e2fc818dadcd0cbced5c"
def apsPath : String := "experiments/external_sources/chemistry/snapshots/aps-hydrogen-dissociation-1994.json"
def apsHash : String := "sha256:9c41d01395090b18b2eb8b1223e9cb430d9309f79d1a0324b092a5ed8c1b6953"
def nistPath : String := "experiments/external_sources/chemistry/snapshots/electron-spin-v1/C1333740.html"
def nistHash : String := "sha256:410fae804b1fa35ab72d829d95bd3b26c831dde2f0ec0078b614fea2c87d795e"
def text : J → Except String String
 | .text s => .ok s
 | .null | .integer _ | .boolean _ | .array _ | .object _ => .error "source text field required"
def integer : J → Except String Int
 | .integer n => .ok n
 | .null | .text _ | .boolean _ | .array _ | .object _ => .error "source integer field required"
def uncertainty : J → JointCorrelationObservation.UncertaintyInput
 | .text s => if Text.equal s "absence" then .absence else .converted (.error (Text.intercalate "" ["invalid literal for int() with base 10: '",s,"'"]))
 | .integer n => .converted (.ok n)
 | .boolean b => .converted (.ok (if b then 1 else 0))
 | .null => .converted (.error "int() argument must be a string, a bytes-like object or a real number, not 'NoneType'")
 | .array _ => .converted (.error "int() argument must be a string, a bytes-like object or a real number, not 'list'")
 | .object _ => .converted (.error "int() argument must be a string, a bytes-like object or a real number, not 'dict'")
def padded (n : Nat) : String :=
 let s := toString n
 Text.append (Text.join (List.replicate (3-(Text.chars s).length) "0")) s

def apsRow (ordinal : Nat) (source : J) : Except String Target := do
 let id := Text.append "APS-HYDROGEN-DISSOCIATION-" (padded ordinal)
 let copied ← [("species","species"),("state","state"),("record_kind","kind"),
  ("value_inscription","value_inscription"),("value_numerator","value_numerator"),
  ("value_denominator","value_denominator"),("uncertainty_inscription","uncertainty_inscription"),
  ("uncertainty_numerator","uncertainty_numerator"),("uncertainty_denominator","uncertainty_denominator"),
  ("unit","unit")].mapM fun (outKey,inKey) => do return (outKey,← field source inKey)
 return ⟨id,[("target_id",.text id),("source_id",.text "APS-PRA-49-2460-1994")]++copied++
  [("joint_support_role",.text "bound-state-to-separated-product-support"),
   ("snapshot_path",.text apsPath),("snapshot_hash",.text apsHash)]⟩
structure NistRow where
 noteId : String
 species : String
 state : String
 kind : String
 inscription : String
 numerator : Int
 uncertaintyInscription : String
 uncertaintyNumerator : J
 uncertaintyDenominator : J
 role : String

def nistRows : List NistRow := [
 ⟨"Dia111","H2","B-state-dissociation-limit","compiled_observed_dissociation_limit","118377._6",1183776,"absence",.text "absence",.text "absence","bound-excited-state-to-separated-product-support"⟩,
 ⟨"Dia111","H2","B-state","compiled_dissociation_energy","28174.2",281742,"absence",.text "absence",.text "absence","bound-excited-state-to-separated-product-support"⟩,
 ⟨"Dia125","H2","X-ground","measured_upper_limit","36118.3",361183,"0.5",.integer 5,.integer 10,"bound-ground-state-to-separated-product-support"⟩]
def note (notes : List (String × String)) (id : String) : String :=
 match notes.find? (fun row => Text.equal row.1 id) with | none => "" | some row => row.2
def nistRow (notes : List (String × String)) (ordinal : Nat) (s : NistRow) : Target :=
 let id := Text.append "NIST-H2-DISSOCIATION-" (padded ordinal)
 ⟨id,[("target_id",.text id),("source_id",.text "NIST-CHEMISTRY-WEBBOOK-SRD69-H2-DISSOCIATION"),
 ("species",.text s.species),("state",.text s.state),("record_kind",.text s.kind),
 ("value_inscription",.text s.inscription),("value_numerator",.integer s.numerator),("value_denominator",.integer 10),
 ("uncertainty_inscription",.text s.uncertaintyInscription),("uncertainty_numerator",s.uncertaintyNumerator),
 ("uncertainty_denominator",s.uncertaintyDenominator),("unit",.text "inverse-centimetre"),
 ("joint_support_role",.text s.role),("source_note_id",.text s.noteId),("source_note_text",.text (note notes s.noteId)),
 ("snapshot_path",.text nistPath),("snapshot_hash",.text nistHash)]⟩
structure Resolved where
 row : Target
 observation : JointCorrelationObservation.Observation
 targetValue : Value

def resolve (row : Target) : Except String Resolved := do
 let value := Canonical.Value.object row.fields
 let source ← field value "source_id" >>= text
 let species ← field value "species" >>= text
 let state ← field value "state" >>= text
 let role ← field value "joint_support_role" >>= text
 let vn ← field value "value_numerator" >>= integer
 let vd ← field value "value_denominator" >>= integer
 let un ← field value "uncertainty_numerator"
 let ud ← field value "uncertainty_denominator"
 let obs ← JointCorrelationObservation.dissociationObservation source species state role vn vd (uncertainty un) (uncertainty ud)
 let kind ← field value "record_kind" >>= text >>= heldLabel "record-kind"
 let inscription ← field value "value_inscription" >>= text >>= heldLabel "source-value-inscription"
 let uncertaintyInscription ← field value "uncertainty_inscription" >>= text >>= heldLabel "source-uncertainty-inscription"
 return ⟨row,obs,.word [.label obs.sourceIdentity,.label obs.speciesIdentity,.label obs.stateIdentity,
  .label obs.jointSupportRole,obs.positiveEnergySeparation,obs.positiveUncertaintyOrAbsence,
  .label kind,.label inscription,.label uncertaintyInscription]⟩

def reconstructedTargets (identityActual identitySchema : String) (ids : List String)
 (targetActual targetSchema : String) (targets : List Target) (apsActual nistActual apsSchema : String)
 (apsRecords : List J) (events : List JointCorrelationNotes.Event) : Except String (List Resolved) := do
 let _ ← JointCorrelationPrediction.identities identityActual identitySchema ids
 if !Text.equal targetActual targetHash then throw "ELEC-007 withheld target registry changed"
 let registered := PairExchangeTargets.targetDictionary targets
 if !Text.equal targetSchema "sft-v3-joint-correlation-withheld-targets/1" || registered.length != 9 then
  throw "ELEC-007 withheld target registry is incomplete"
 if !Text.equal apsActual apsHash || !Text.equal nistActual nistHash then throw "ELEC-007 external source bytes changed"
 if !Text.equal apsSchema "sft-v3-primary-source-numeric-extract/1" || apsRecords.length != 6 then
  throw "ELEC-007 transparent APS extract is incomplete"
 let notes := (JointCorrelationNotes.parseEvents events).notes
 if !Text.contains (note notes "Dia111") "118377._6" || !Text.contains (note notes "Dia111") "28174.2" ||
  !Text.contains (note notes "Dia125") "36118.3 ± 0.5" then throw "ELEC-007 NIST source inscriptions are incomplete"
 let aps ← (apsRecords.zipIdx 1).mapM (fun (row,i) => apsRow i row)
 let rebuilt := aps++(nistRows.zipIdx 1).map (fun (row,i) => nistRow notes i row)
 let rebuiltIds := rebuilt.map (fun row => row.targetId)
 if !(rebuiltIds.all (fun id => ids.any (Text.equal id))) || !(ids.all (fun id => rebuiltIds.any (Text.equal id))) then
  throw "ELEC-007 independently rebuilt identities differ"
 rebuilt.mapM fun row => do
  let registered ← PairExchangeTargets.targetAt registered row.targetId
  if !StateSymmetryPrediction.canonicalEqual (.object registered.fields) (.object row.fields) then
   throw "ELEC-007 independently reconstructed target differs from registry"
  resolve row
end SFT.Chemistry.JointCorrelationTargets
