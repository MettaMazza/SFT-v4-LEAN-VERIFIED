import SFT.Chemistry.StateEnergySourceTables
import SFT.Chemistry.StateEnergyInscription
import SFT.Chemistry.OrbitalSupportTargets
import SFT.Chemistry.ConjugatedSupportAnalysis
namespace SFT.Chemistry.StateEnergyTargets
open SFT.Host SFT.Physics.CapabilityValues
abbrev J := Canonical.Value
abbrev Identity := OrbitalSupportTargets.Identity
abbrev Snapshot := ElectronSpinTargets.Snapshot
structure Target where
 targetId : String
 stateRecord : String
 inscription : String
 numerator : Int
 denominator : Int
 quality : String
 original : J
structure Resolved where
 original : J
 numerator : Nat
 denominator : Nat
 targetValue : Value

def identityRegistryHash := "sha256:513a7156a9e2c17cd4a48f51dc0dcf1382902f8f45bbcbfe97a17994bb0c23eb"
def targetRegistryHash := "sha256:ce4175dff16e3b54451075e40f80a09e2dab9641a3a14a095bb0676542c16ab9"
def insertTarget (rows : List Target) (row : Target) : List Target :=
 if rows.any (fun old=>Text.equal old.targetId row.targetId) then
  rows.map (fun old=>if Text.equal old.targetId row.targetId then row else old)
 else rows++[row]
def selectedRows (events : List ElectronSpinHtml.Event) : List (List String) :=
 (StateEnergySourceTables.parseEvents events).rows.filter fun row=>
  row.length==13 && !(OrbitalAssignments.terms (OrbitalSupportTargets.stateText row)).isEmpty

def cellAt : List String → Nat → Except String String
 | [],_ => .error "tuple index out of range"
 | a::_,0 => .ok a
 | _::rest,n+1 => cellAt rest n

def sameNatural (n : Nat) : Int → Bool
 | .ofNat m => n==m
 | .negSucc _ => false

def resolveRow (target : Target) (row : List String) : Except String Resolved := do
 let inscription ← cellAt row 1
 let exact ← StateEnergyInscription.exactValue inscription
 let state ← cellAt row 0
 if !Text.equal state target.stateRecord || !Text.equal inscription target.inscription ||
    !sameNatural exact.1 target.numerator || !sameNatural exact.2 target.denominator then
  throw "ELEC-004 independent source extraction differs"
 let magnitude ← if exact.1==0 then pure (.emptyOne "empty-One") else do
  let n ← count exact.1
  let d ← count exact.2
  pure (.ratio n d)
 let stateLabel ← heldLabel "NIST-state-record" state
 let unit ← heldLabel "measured-energy-unit" "inverse-centimetre"
 let quality ← heldLabel "measurement-quality" target.quality
 pure ⟨target.original,exact.1,exact.2,.word [.label stateLabel,.label unit,magnitude,.label quality]⟩

abbrev Cache := List (String × List (List String))
def resolveStep (targets : List Target) (snapshots : List Snapshot)
 (acc : Cache × List Resolved) (identity : Identity) : Except String (Cache × List Resolved) := do
 let snapshot ← match snapshots.find? (fun row=>Text.equal row.path identity.snapshotPath) with
  | none => .error (Text.append "FileNotFoundError: " identity.snapshotPath)
  | some row => .ok row
 if !Text.equal snapshot.hash identity.snapshotHash then throw "ELEC-004 NIST snapshot changed"
 let (rows,cache) := match acc.1.find? (fun row=>Text.equal row.1 identity.snapshotPath) with
  | some found => (found.2,acc.1)
  | none => let rows:=selectedRows snapshot.events; (rows,acc.1++[(identity.snapshotPath,rows)])
 let row ← OrbitalSupportTargets.indexedRow rows (identity.ordinal-1)
 let target ← match targets.find? (fun t=>Text.equal t.targetId identity.targetId) with
  | none => .error (Text.intercalate "" ["'",identity.targetId,"'"])
  | some t => .ok t
 let result ← resolveRow target row
 pure (cache,acc.2++[result])

def resolvedTargets (identityHash targetHash : String) (identitySchema targetSchema : J)
 (identities : List Identity) (rawTargets : List Target) (snapshots : List Snapshot) : Except String (List Resolved) := do
 if !Text.equal targetHash targetRegistryHash then throw "ELEC-004 target registry changed"
 if !Text.equal identityHash identityRegistryHash then throw "ELEC-004 identity registry changed"
 if !ConjugatedSupportAnalysis.isText identitySchema "sft-v3-state-energy-order-identities/1" || identities.length != 306 then
  throw "ELEC-004 identity support is incomplete"
 let targets := rawTargets.foldl insertTarget []
 if !ConjugatedSupportAnalysis.isText targetSchema "sft-v3-state-energy-order-withheld-targets/1" || targets.length != 306 then
  throw "ELEC-004 target support is incomplete"
 let result ← identities.foldlM (resolveStep targets snapshots) ([],[])
 pure result.2

def setField (fields : List (String × J)) (key : String) (value : J) : List (String × J) :=
 if fields.any (fun x=>Text.equal x.1 key) then
  fields.map (fun x=>if Text.equal x.1 key then (key,value) else x)
 else fields++[(key,value)]
def resolvedValue (row : Resolved) : J :=
 let fields := match row.original with
  | .object fs => fs
  | .null | .text _ | .integer _ | .boolean _ | .array _ => []
 let exact : J := .object [("numerator",.integer (.ofNat row.numerator)),("denominator",.integer (.ofNat row.denominator))]
 .object (setField (setField fields "exact" exact) "target_value" (canonical row.targetValue))

#print axioms identityRegistryHash
#print axioms targetRegistryHash
#print axioms insertTarget
#print axioms selectedRows
#print axioms cellAt
#print axioms sameNatural
#print axioms resolveRow
#print axioms resolveStep
#print axioms resolvedTargets
#print axioms setField
#print axioms resolvedValue
end SFT.Chemistry.StateEnergyTargets
