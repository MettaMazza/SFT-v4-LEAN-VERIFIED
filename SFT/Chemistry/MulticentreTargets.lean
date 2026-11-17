import SFT.Chemistry.MulticentrePrediction
import SFT.Chemistry.MulticentreSurface
import SFT.Chemistry.PairExchangeTargets
import SFT.Chemistry.JointCorrelationTargets
namespace SFT.Chemistry.MulticentreTargets
open SFT.Host SFT.Physics.CapabilityValues
abbrev J := Canonical.Value
abbrev Target := PairExchangeTargets.Target
open ConjugatedSupportAnalysis (field array valueAt)
open JointCorrelationTargets (text integer)
def iupacPath : String := "experiments/external_sources/chemistry/snapshots/goldbook-terms/08789.json"
def iupacHash : String := "sha256:570755940f01bfa32741b03b6b2f22b02742101605a2263e57369966ea433abd"
def diboranePath : String := "experiments/external_sources/chemistry/snapshots/multicentre-v1/nist-cccbdb-diborane-experimental-geometry.html"
def diboraneHash : String := "sha256:99e1c36da1bf8aa2b559ba9ef84b43b4965982c3ee1cab13abb933c8fba22527"
def benzenePath : String := "experiments/external_sources/chemistry/snapshots/multicentre-v1/nist-cccbdb-benzene-experimental-geometry.html"
def benzeneHash : String := "sha256:6e158d7639b301cfa6a18bfab4461988c9ffc6190f99fb9a5c0df7baf6f3ec0f"
def targetHash : String := "sha256:d3188205f896f7ad4719a25d2367bbc98d262c7c66424a02c05ae5dec863c445"
def sourceIds : List String := ["IUPAC-GOLD-BOOK-08789-2026","NIST-CCCBDB-SRD101-DIBORANE","NIST-CCCBDB-SRD101-BENZENE"]
def dib_roles : List String := ["rBB","rBH-outer","rBH-bridging","aHBH-outer","aHBH-bridging","aBHB","aHBH-symmetry"]
def ben_roles : List String := ["rCC","rCH","aCCC","aHCC"]
def dib_ids : List String := ["NIST-DIBORANE-rBB","NIST-DIBORANE-rBH-OUTER","NIST-DIBORANE-rBH-BRIDGING","NIST-DIBORANE-aHBH-OUTER","NIST-DIBORANE-aHBH-BRIDGING","NIST-DIBORANE-aBHB","NIST-DIBORANE-aHBH-SYMMETRY"]
def ben_ids : List String := ["NIST-BENZENE-rCC","NIST-BENZENE-rCH","NIST-BENZENE-aCCC","NIST-BENZENE-aHCC"]
def numericRecord (id source species role inscription : String) (n d : Nat) (path hash : String) : Target :=
 ⟨id,[("target_id",.text id),("source_id",.text source),("record_kind",.text "experimental-geometry"),
 ("species",.text species),("record_role",.text role),("inscription",.text inscription),
 ("positive_value_numerator",.integer (.ofNat n)),("positive_value_denominator",.integer (.ofNat d)),
 ("snapshot_path",.text path),("snapshot_hash",.text hash)]⟩
def pointGroup (id source species inscription path hash : String) : Target :=
 ⟨id,[("target_id",.text id),("source_id",.text source),("record_kind",.text "experimental-geometry"),
 ("species",.text species),("record_role",.text "point-group"),("inscription",.text inscription),
 ("positive_value_numerator",.text "absence"),("positive_value_denominator",.text "absence"),
 ("snapshot_path",.text path),("snapshot_hash",.text hash)]⟩
def iupacRecord (id role inscription : String) : Target :=
 ⟨id,[("target_id",.text id),("source_id",.text "IUPAC-GOLD-BOOK-08789-2026"),
 ("record_kind",.text "authoritative-delocalization-topology"),("record_role",.text role),
 ("inscription",.text inscription),("snapshot_path",.text iupacPath),("snapshot_hash",.text iupacHash)]⟩
def coordinateRows (p : MulticentreSurface.Parser) (names : List String) : List (List String) :=
 p.rows.filter (fun row => row.length>=8 && names.any (Text.equal (row.headD "")))
def inscriptionRatio (s : String) : Nat × Nat :=
 let parts := (Text.chars s).splitOn '.'
 match parts with
 | [a,b] => (ElectronSpinSource.decimalNumber (a++b),10^b.length)
 | [] | [_] | _::_::_::_ => (ElectronSpinSource.decimalNumber (Text.chars s),1)
def coordinates (ids roles : List String) (rows : List (List String)) (source species path hash : String) : List Target :=
 (ids.zip (roles.zip rows)).map fun (id,(role,row)) =>
  let inscription := (row.drop 1).headD ""
  let (n,d) := inscriptionRatio inscription
  numericRecord id source species role inscription n d path hash
structure Resolved where
 row : Target
 magnitude : Value
 targetValue : Value

def resolve (row : Target) : Except String Resolved := do
 let source ← field (.object row.fields) "source_id" >>= text >>= heldLabel "external-source"
 let kind ← field (.object row.fields) "record_kind" >>= text >>= heldLabel "record-kind"
 let role ← field (.object row.fields) "record_role" >>= text >>= heldLabel "record-role"
 let inscription ← field (.object row.fields) "inscription" >>= text >>= heldLabel "source-inscription"
 let numerator := match row.fields.find? (fun p => Text.equal p.1 "positive_value_numerator") with
  | none => Canonical.Value.text "absence"
  | some p => p.2
 let magnitude ← if ConjugatedSupportAnalysis.isText numerator "absence" then pure (Value.emptyOne "empty-One") else do
  let n ← integer numerator
  let d ← field (.object row.fields) "positive_value_denominator" >>= integer
  let pn ← count n.toNat
  let pd ← count d.toNat
  pure (Value.ratio pn pd)
 return ⟨row,magnitude,.word [.label source,.label kind,.label role,.label inscription,magnitude]⟩

def reconstructedTargets (identityActual identitySchema : String) (ids : List String)
 (targetActual targetSchema : String) (targets : List Target) (iupacActual dibActual benActual : String)
 (iupac : J) (dibEvents benEvents : List MulticentreSurface.Event) : Except String (List Resolved) := do
 let _ ← MulticentrePrediction.identities identityActual identitySchema ids
 if !Text.equal targetActual targetHash then throw "ELEC-008 target registry changed"
 let registered := PairExchangeTargets.targetDictionary targets
 if !Text.equal targetSchema "sft-v3-multicentre-withheld-targets/1" || registered.length != 20 then throw "ELEC-008 target registry is incomplete"
 if !Text.equal iupacActual iupacHash || !Text.equal dibActual diboraneHash || !Text.equal benActual benzeneHash then throw "ELEC-008 external source bytes changed"
 let definitions ← field iupac "term" >>= fun term => field term "definitions" >>= array
 let definition ← valueAt definitions 0
 let definitionText ← field definition "text" >>= text
 let note ← field definition "notes" >>= fun notes => field notes "1" >>= text
 let iupacRows := [iupacRecord "IUPAC-DELOCALIZATION-DEFINITION" "definition" definitionText,
  iupacRecord "IUPAC-DELOCALIZATION-RIBBON" "ribbon-topology" note,
  iupacRecord "IUPAC-DELOCALIZATION-SURFACE" "surface-topology" note,
  iupacRecord "IUPAC-DELOCALIZATION-VOLUME" "volume-topology" note]
 let dib := MulticentreSurface.parseEvents dibEvents
 let ben := MulticentreSurface.parseEvents benEvents
 if !Text.contains (MulticentreSurface.text dib) "Point Group D_2h" || !Text.contains (MulticentreSurface.text ben) "Point Group D_6h" then throw "ELEC-008 point-group source record is absent"
 let dibRows := coordinateRows dib ["rBB","rBH","aHBH","aBHB"]
 let benRows := coordinateRows ben ["rCC","rCH","aCCC","aHCC"]
 if dibRows.length != 7 || benRows.length != 4 then throw "ELEC-008 internal-coordinate census is incomplete"
 let dibBonds := dib.rows.filter (fun row => row.length==2 && Text.equal (row.headD "") "H-B")
 if !StateSymmetryPrediction.canonicalEqual (.array (dibBonds.map (fun row => .array (row.map Canonical.Value.text)))) (.array [.array [.text "H-B",.text "8"]]) then throw "ELEC-008 diborane link-count record is incomplete"
 let benBonds := ben.rows.filter (fun row => row.length==2 && (Text.equal (row.headD "") "C:C" || Text.equal (row.headD "") "H-C"))
 if !StateSymmetryPrediction.canonicalEqual (.array (benBonds.map (fun row => .array (row.map Canonical.Value.text)))) (.array [.array [.text "C:C",.text "6"],.array [.text "H-C",.text "6"]]) then throw "ELEC-008 benzene bond-count records are incomplete"
 let dibId := "NIST-CCCBDB-SRD101-DIBORANE"
 let benId := "NIST-CCCBDB-SRD101-BENZENE"
 let rebuilt := iupacRows ++ [pointGroup "NIST-DIBORANE-POINT-GROUP" dibId "diborane" "D2h" diboranePath diboraneHash] ++
  coordinates dib_ids dib_roles dibRows dibId "diborane" diboranePath diboraneHash ++
  [numericRecord "NIST-DIBORANE-HB-LINK-COUNT" dibId "diborane" "H-B-count" "8" 8 1 diboranePath diboraneHash,
   pointGroup "NIST-BENZENE-POINT-GROUP" benId "benzene" "D6h" benzenePath benzeneHash] ++
  coordinates ben_ids ben_roles benRows benId "benzene" benzenePath benzeneHash ++
  [numericRecord "NIST-BENZENE-AROMATIC-LINK-COUNT" benId "benzene" "C:C-count" "6" 6 1 benzenePath benzeneHash,
   numericRecord "NIST-BENZENE-HC-LINK-COUNT" benId "benzene" "H-C-count" "6" 6 1 benzenePath benzeneHash]
 let rebuiltIds := rebuilt.map (fun row => row.targetId)
 if !(rebuiltIds.all (fun id => ids.any (Text.equal id))) || !(ids.all (fun id => rebuiltIds.any (Text.equal id))) then throw "ELEC-008 independently rebuilt identities differ"
 rebuilt.mapM fun row => do
  let existing ← PairExchangeTargets.targetAt registered row.targetId
  if !StateSymmetryPrediction.canonicalEqual (.object existing.fields) (.object row.fields) then throw "ELEC-008 independently reconstructed row differs"
  resolve row
end SFT.Chemistry.MulticentreTargets
