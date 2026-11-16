import SFT.Chemistry.OrbitalSourceTables
import SFT.Chemistry.OrbitalAssignments
import SFT.Chemistry.ElectronSpinTargets
namespace SFT.Chemistry.OrbitalSupportTargets
open SFT.Host SFT.Physics.CapabilityValues OrbitalAssignments
abbrev Snapshot := ElectronSpinTargets.Snapshot
structure Identity where
 targetId : String
 speciesRowId : String
 snapshotPath : String
 snapshotHash : String
 ordinal : Int
structure Target where
 targetId : String
 cells : List String
 stateRecord : String
 terms : List (Int × String)
 configurations : List (Int × String × String × Int)
structure Resolved where
 targetId : String
 speciesRowId : String
 stateRecord : String
 terms : List Term
 configurations : List Configuration
 snapshotHash : String
 targetValue : Value
def identityRegistryHash : String := "sha256:9e3a77634e9871ecd6716cf40face2bfad6a39b3b7720afbb33468a9e27b1fdc"
def targetRegistryHash : String := "sha256:6f3773b443f9376bc4eee04c99cc35f49515684c8e418df46106ca846ac7095d"
def insertTarget (rows : List Target) (row : Target) : List Target :=
 if rows.any (fun old => Text.equal old.targetId row.targetId) then
  rows.map (fun old => if Text.equal old.targetId row.targetId then row else old)
 else rows++[row]
def sameStrings : List String → List String → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | a::as,b::bs => Text.equal a b && sameStrings as bs
def sameTerms : List Term → List (Int × String) → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | a::as,b::bs => match b.1 with
   | .negSucc _ => false
   | .ofNat n => a.multiplicity==n && Text.equal a.symbol b.2 && sameTerms as bs
def sameConfigurations : List Configuration → List (Int × String × String × Int) → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | a::as,b::bs => match b.1 with
   | .negSucc _ => false
   | .ofNat radial => match b.2.2.2 with
     | .negSucc _ => false
     | .ofNat occupancy => a.radial==radial && Text.equal a.family b.2.1 &&
       Text.equal a.symbol b.2.2.1 && a.occupancy==occupancy && sameConfigurations as bs
def rowAt : List (List String) → Nat → Except String (List String)
 | [],_ => .error "tuple index out of range"
 | row::_,0 => .ok row
 | _::rest,n+1 => rowAt rest n
def indexedRow (rows : List (List String)) (index : Int) : Except String (List String) :=
 match index with
 | .ofNat n => rowAt rows n
 | .negSucc n => if n < rows.length then rowAt rows (rows.length-(n+1)) else .error "tuple index out of range"
def stateText (row : List String) : String := match row with | [] => "" | x::_ => x
def selectedRows (events : List ElectronSpinHtml.Event) : List (List String) :=
 (OrbitalSourceTables.parseEvents events).rows.filter fun row =>
  row.length==13 && !(OrbitalAssignments.terms (stateText row)).isEmpty
def termWord (row : Term) : Except String Value := do
 let n ← count row.multiplicity
 let label ← heldLabel "source-support-symbol" row.symbol
 return .word [.count n,.label label]
def configurationWord (row : Configuration) : Except String Value := do
 let n ← count row.radial
 let family ← heldLabel "source-family-label" row.family
 let symbol ← heldLabel "source-support-symbol" row.symbol
 let occupancy ← count row.occupancy
 return .word [.count n,.label family,.label symbol,.count occupancy]
def resolveRow (identity : Identity) (target : Target) (row : List String) : Except String Resolved := do
 let state := stateText row
 if !sameStrings target.cells row || !Text.equal target.stateRecord state then
  throw "ELEC-003 independent NIST row extraction differs from target"
 let terms := OrbitalAssignments.terms state
 let configurations := OrbitalAssignments.configurations state
 if !sameTerms terms target.terms || !sameConfigurations configurations target.configurations then
  throw "ELEC-003 independent assignment extraction differs from target"
 let termValues ← terms.mapM termWord
 let configValue ← if configurations.isEmpty then .ok (.emptyOne "empty-One") else
  (configurations.mapM configurationWord).map Value.word
 let label ← heldLabel "NIST-state-record" state
 return ⟨identity.targetId,identity.speciesRowId,state,terms,configurations,identity.snapshotHash,
  .word [.label label,.word termValues,configValue]⟩
abbrev Cache := List (String × List (List String))
def resolveStep (targets : List Target) (snapshots : List Snapshot)
 (acc : Cache × List Resolved) (identity : Identity) : Except String (Cache × List Resolved) :=
 match snapshots.find? (fun row => Text.equal row.path identity.snapshotPath) with
 | none => .error (Text.append "FileNotFoundError: " identity.snapshotPath)
 | some snapshot => do
  if !Text.equal snapshot.hash identity.snapshotHash then throw "ELEC-003 NIST snapshot changed"
  let (rows,cache) := match acc.1.find? (fun row => Text.equal row.1 identity.snapshotPath) with
   | some cached => (cached.2,acc.1)
   | none => let rows:=selectedRows snapshot.events; (rows,acc.1++[(identity.snapshotPath,rows)])
  let row ← indexedRow rows (identity.ordinal-1)
  let target ← match targets.find? (fun target => Text.equal target.targetId identity.targetId) with
   | none => .error (Text.append "KeyError: " identity.targetId)
   | some target => .ok target
  let resolved ← resolveRow identity target row
  return (cache,acc.2++[resolved])
def resolvedTargets (identityHash targetHash : String) (identities : List Identity)
 (rawTargets : List Target) (snapshots : List Snapshot) : Except String (List Resolved) := do
 if !Text.equal identityHash identityRegistryHash then throw "ELEC-003 target identity registry changed"
 if !Text.equal targetHash targetRegistryHash then throw "ELEC-003 withheld target registry changed"
 let targets := rawTargets.foldl insertTarget []
 let identityIds := SFT.Physics.GrandLockDependency.unique (identities.map Identity.targetId)
 if identities.length != 360 || targets.length != 360 || identityIds.length != targets.length ||
  !(targets.all (fun target => identityIds.any (Text.equal target.targetId))) then
  throw "ELEC-003 source and target support differ"
 let result ← identities.foldlM (resolveStep targets snapshots) ([],[])
 return result.2
end SFT.Chemistry.OrbitalSupportTargets
