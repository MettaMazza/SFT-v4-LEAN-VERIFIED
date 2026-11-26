import SFT.Chemistry.IntermolecularBindingExperiment
import SFT.Chemistry.MolecularPolarizabilitySource
namespace SFT.Chemistry.IntermolecularBindingSource
local instance : BEq Int := ⟨fun a b => match a,b with
 | .ofNat n,.ofNat m => n==m
 | .negSucc n,.negSucc m => n==m
 | .ofNat _,.negSucc _ | .negSucc _,.ofNat _ => false⟩
open SFT.Host SFT.Host.Canonical SFT.Physics IntermolecularBindingExperiment
set_option maxRecDepth 50000
set_option maxHeartbeats 100000000
abbrev pair := MolecularPolarizabilitySource.pair
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
 resultClass : String
def ratioValue (value : CapabilityValues.Value) : Except String Rat := match value with
 | .ratio n d => .ok (LeptonIntervals.normalize (.ofNat n.value) d.value d.positive)
 | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => .error "source is not an exact positive ratio"
def rationalEqual (a b : Rat) : Bool :=
 @decide (a.num*Int.ofNat b.den=b.num*Int.ofNat a.den) (Int.decEq _ _)
def signedInscription (s : String) : Except String (Bool × Rat) := do
 let chars := LeptonDecimal.strip (Text.chars s)
 let (negative,body) := match chars with
  | [] => (false,[])
  | c::rest => if c=='-' then (true,rest) else if c=='+' then (false,rest) else (false,chars)
 pure (negative,← ConfigurationObservation.exact (String.ofList body))
def sourceRows (identityBytes targetBytes primaryBytes waterBytes ionBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),
  (waterBytes,waterClusterPath,waterClusterHash),(ionBytes,ionClusterPath,ionClusterHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-011 registered source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let rows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "schema") (.text "sft-v3-intermolecular-binding-withheld-targets/1") ||
  !sameValue (get targets "all_target_values_separate_from_identities") (.boolean true) ||
  !sameValue (get targets "complete_row_count") (.integer 1299) || rows.length != 1299 then
  throw "PROP-011 withheld registry changed"
 let identityKeys := ["target_id","dimer_id","dimer_formula","dimer_name","donor_formula","donor_name",
  "acceptor_formula","acceptor_name","source_id","source_class","source_locator","snapshot_path"]
 let resolved ← (ids.zip rows).mapM fun (id,row) => do
  if !(identityKeys.all fun key => sameValue (get id key) (get row key)) then
   throw "PROP-011 identity and withheld source rows differ"
  let targetId ← field row "target_id" >>= text
  let sourceClass ← field row "source_class" >>= text
  let (value,resultClass) ← if Text.equal sourceClass "authoritative-calculated-benchmark" then do
    let inscription ← field row "value_inscription_kJ_per_mol" >>= text >>= signedInscription
    let stored ← field row "absolute_inscribed_magnitude_kJ_per_mol" >>= pair
    let rational ← ratioValue stored
    if !rationalEqual rational inscription.2 || inscription.2.num==0 then
     throw "PROP-011 calculated inscription reconstruction changed"
    if inscription.1 then pure (CapabilityValues.Value.emptyOne "empty-One","signed-adverse-source-record-structural-EmptyOne")
    else pure (stored,"exact-positive-calculated-binding")
   else if Text.equal sourceClass "reported-experimental-cluster-dissociation-value" then do
    let central ← field row "central_cm_inverse" >>= pair
    let uncertainty ← field row "uncertainty_cm_inverse" >>= pair
    let lower ← field row "lower_cm_inverse" >>= pair
    let upper ← field row "upper_cm_inverse" >>= pair
    let c ← ratioValue central
    let u ← ratioValue uncertainty
    let l ← ratioValue lower
    let h ← ratioValue upper
    if !l.blt c || !c.blt h || !rationalEqual (LeptonIntervals.subtract c u) l ||
     !rationalEqual (LeptonIntervals.add c u) h then
     throw "PROP-011 experimental interval reconstruction changed"
    pure (central,"exact-positive-reported-experimental-cluster-dissociation")
   else throw "PROP-011 source class changed"
  pure (⟨targetId,row,value,resultClass⟩ : Target)
 let positive := resolved.filter fun row => match row.value with
  | .ratio _ _ => true
  | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
 let absent := resolved.filter fun row => match row.value with
  | .emptyOne _ => true
  | .ratio _ _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
 if resolved.length != 1299 || positive.length != 1203 || absent.length != 96 then
  throw "PROP-011 complete positive/adverse partition changed"
 pure resolved
end SFT.Chemistry.IntermolecularBindingSource
