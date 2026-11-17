import SFT.Chemistry.StateSymmetrySource
import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.StateSymmetryPrediction
open SFT.Host SFT.Physics.CapabilityValues
open ElectronSpinPrediction (instruction numbered)
abbrev J := Canonical.Value

def identityHash : String := "sha256:c35f4951ab2576d8b369ac0edd16e562a1b29314b7b1da65bd376fea02042f0f"
def targetHash : String := "sha256:b4241adb2b4648d40f984329699714c829daa46a83204c1928eae302de9df93f"
structure Identity where
 targetId : String
 speciesRowId : String
 snapshotPath : String
 snapshotHash : String
 stateRowOrdinal : Int
 termAssignmentOrdinal : Int

def distinctIds : List String → Bool
 | [] => true
 | s::ss => !(ss.any (Text.equal s)) && distinctIds ss

def identities (actualHash schema : String) (rows : List Identity) : Except String (List Identity) := do
 if !Text.equal actualHash identityHash then throw "ELEC-005 identity registry changed"
 if !Text.equal schema "sft-v3-state-symmetry-identities/1" || rows.length != 362 then
  throw "ELEC-005 identity registry is incomplete"
 if !distinctIds (rows.map Identity.targetId) then throw "ELEC-005 identity registry contains duplicate targets"
 return rows

def axisInstructions (position : Nat) (symbol : String) : Except String (List J × List String) := do
 let rankKey := numbered "rank-key-" position
 let rankValue := numbered "rank-value-" position
 let orientationKey := numbered "orientation-key-" position
 let orientationValue := numbered "orientation-value-" position
 let rank ← StateSymmetrySource.rankInscription symbol
 let invariant := Text.equal symbol "Σ"
 return ([instruction "label" rankKey ["axis-rank-law",symbol],
   if invariant then instruction "empty_one" rankValue ["structural-empty-One"]
   else instruction "label" rankValue ["axis-rank",rank],
   instruction "label" orientationKey ["axis-orientation-law",symbol],
   instruction "count" orientationValue [if invariant then "1" else "2"]],
   [rankKey,rankValue,orientationKey,orientationValue])

def laws : List (String × String) := [
 ("state-equivalence","complete-signature-identity"),
 ("degeneracy","positive-spin-width-times-positive-axis-orientation-count"),
 ("optional-coordinate","held-label-or-structural-empty-One"),
 ("component-class","complete-positive-enumeration")]

def lawInstructions (position : Nat) (law : String × String) : List J × List String :=
 let key := numbered "law-key-" position
 let value := numbered "law-value-" position
 ([instruction "label" key ["symmetry-law",law.1],
   instruction "label" value ["symmetry-law-result",law.2]],[key,value])

def predictionDocument (actualHash schema : String) (rows : List Identity) : Except String J := do
 let _ ← identities actualHash schema rows
 let axisParts ← (["Σ","Π","Δ","Φ"].zipIdx 1).mapM (fun (symbol,i) => axisInstructions i symbol)
 let lawParts := (laws.zipIdx 5).map (fun (law,i) => lawInstructions i law)
 let parts := axisParts++lawParts
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-STATE-SYMMETRY-DEGENERACY-005-symmetry-law-prediction"),
  ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++
   parts.flatMap Prod.fst ++
   [instruction "table" "complete-symmetry-law" (parts.flatMap Prod.snd),
    instruction "emit" "" ["complete-symmetry-law"]]))]

structure Snapshot where
 path : String
 actualHash : String
 events : List StateSymmetrySource.Event
structure WithheldTarget where
 targetId : String
 fields : List (String × J)
structure Resolved where
 identity : Identity
 stateRecord : String
 term : StateSymmetrySource.Term
 reconstructed : J
 targetValue : Value

def sameIds (ids targets : List String) : Bool :=
 ids.all (fun s => targets.any (Text.equal s)) && targets.all (fun s => ids.any (Text.equal s))
def canonicalEqual (a b : J) : Bool := Text.equal (Canonical.render a) (Canonical.render b)
def optionalValue (x : StateSymmetry.OptionalLabel) : Value :=
 match x with
 | .emptyOne s => .emptyOne s
 | .held h => .label h
def axisValue (x : StateSymmetry.AxisRank) : Value :=
 match x with
 | .emptyOne s => .emptyOne s
 | .count n => .count n

structure ParsedSnapshot where
 path : String
 actualHash : String
 rows : List (List String)

def resolve (identity : Identity) (target : WithheldTarget) (snapshot : ParsedSnapshot) : Except String Resolved := do
 if !Text.equal snapshot.actualHash identity.snapshotHash then throw "ELEC-005 NIST snapshot changed"
 let sourceRows := snapshot.rows
 let stateIndex ← match identity.stateRowOrdinal with
  | .ofNat n => if n==0 then .error "ELEC-005 registered NIST state row is absent" else .ok (n-1)
  | .negSucc _ => .error "ELEC-005 registered NIST state row is absent"
 let sourceRow ← match sourceRows.drop stateIndex with
  | [] => .error "ELEC-005 registered NIST state row is absent"
  | cells::_ => .ok cells
 let state := sourceRow.headD ""
 let assignments := StateSymmetrySource.terms state
 let termIndex ← match identity.termAssignmentOrdinal with
  | .ofNat n => if n==0 then .error "ELEC-005 registered NIST term assignment is absent" else .ok (n-1)
  | .negSucc _ => .error "ELEC-005 registered NIST term assignment is absent"
 let term ← match assignments.drop termIndex with
  | [] => .error "ELEC-005 registered NIST term assignment is absent"
  | x::_ => .ok x
 let reconstructed ← StateSymmetrySource.reconstructed state term
 let fields := match reconstructed with
  | .object fs => fs
  | .null | .text _ | .integer _ | .boolean _ | .array _ => []
 if !(fields.all (fun (key,value) =>
    match target.fields.find? (fun p => Text.equal p.1 key) with
    | none => false
    | some p => canonicalEqual p.2 value)) then
  throw "ELEC-005 independent NIST symmetry extraction differs from target"
 let signature ← StateSymmetry.fromSource identity.speciesRowId (← count term.multiplicity) term.symbol
  (StateSymmetrySource.inversionLabel term.suffix) (StateSymmetrySource.reflectionLabel term.suffix)
  (StateSymmetrySource.axisComponent term.suffix) (StateSymmetrySource.componentKind term.suffix)
 let value := Value.word [
  .label (← heldLabel "NIST-state-record" state),
  .label (← heldLabel "NIST-term-assignment" (Text.append term.inscription term.suffix)),
  .count signature.multiplicity,.label (← heldLabel "source-support-symbol" term.symbol),
  axisValue signature.axisRank,.count signature.orientationCount,.count (StateSymmetry.degeneracy signature),
  optionalValue signature.inversion,optionalValue signature.reflection,
  optionalValue signature.axisComponent,optionalValue signature.componentKind]
 return ⟨identity,state,term,reconstructed,value⟩

def resolvedTargets (actualIdentityHash identitySchema actualTargetHash targetSchema : String)
 (rows : List Identity) (targets : List WithheldTarget) (snapshots : List Snapshot) : Except String (List Resolved) := do
 let ids ← identities actualIdentityHash identitySchema rows
 if !Text.equal actualTargetHash targetHash then throw "ELEC-005 withheld target registry changed"
 if !Text.equal targetSchema "sft-v3-state-symmetry-withheld-targets/1" || targets.length != 362 ||
    !distinctIds (targets.map WithheldTarget.targetId) ||
    !sameIds (ids.map Identity.targetId) (targets.map WithheldTarget.targetId) then
  throw "ELEC-005 target support is incomplete or differs from identities"
 let parsed := snapshots.map (fun s => ParsedSnapshot.mk s.path s.actualHash (StateSymmetrySource.sourceRows s.events))
 ids.mapM fun row => do
  let target ← match targets.find? (fun t => Text.equal t.targetId row.targetId) with
   | none => .error "ELEC-005 target support is incomplete or differs from identities"
   | some t => .ok t
  let snapshot ← match parsed.find? (fun s => Text.equal s.path row.snapshotPath) with
   | none => .error "registered source snapshot unavailable"
   | some s => .ok s
  resolve row target snapshot

#print axioms identityHash
#print axioms targetHash
#print axioms distinctIds
#print axioms identities
#print axioms axisInstructions
#print axioms laws
#print axioms lawInstructions
#print axioms predictionDocument
#print axioms sameIds
#print axioms canonicalEqual
#print axioms optionalValue
#print axioms axisValue
#print axioms resolve
#print axioms resolvedTargets
end SFT.Chemistry.StateSymmetryPrediction
