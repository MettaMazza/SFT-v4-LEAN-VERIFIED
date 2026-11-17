import SFT.Chemistry.PairExchangeSource
import SFT.Chemistry.StateSymmetryPrediction
namespace SFT.Chemistry.PairExchangeTargets
open SFT.Host SFT.Physics.CapabilityValues PairExchangeSource
abbrev J := Canonical.Value
structure Identity where
 targetId : String
 snapshotPath : String
 snapshotHash : String
structure Target where
 targetId : String
 fields : List (String × J)
structure State where
 targetId : String
 ordinal : Nat
 stateRecord : String
 term : StateSymmetrySource.Term
 configuration : Option Configuration
 energyInscription : String
 fields : List (String × J)
 targetValue : Value
structure ExchangePair where
 targetId : String
 configuration : Configuration
 singlet : State
 triplet : State
 numerator : Nat
 denominator : Nat
 order : String
 support : String
 fields : List (String × J)
 targetValue : Value

def identityHash : String := "sha256:3b108e98b7060047bd3e7a1e24cfb474579a5d5a235c2a4b76096ef8c1280574"
def targetHash : String := "sha256:204dd9ddc92ae70ab9b89461bd4d86b59bb90ac87add8af34fcbf1dfb906d085"
def identities (actualHash schema : String) (rows : List Identity) : Except String (List Identity) := do
 if !Text.equal actualHash identityHash then throw "ELEC-006 identity registry changed"
 if !Text.equal schema "sft-v3-pair-exchange-identities/1" || rows.length != 60 then
  throw "ELEC-006 identity registry is incomplete"
 if !StateSymmetryPrediction.distinctIds (rows.map Identity.targetId) then
  throw "ELEC-006 identity registry contains duplicate targets"
 return rows
-- Python's target dictionaries retain the last row for each repeated key.
def insertTarget (rows : List Target) (row : Target) : List Target :=
 if rows.any (fun x => Text.equal x.targetId row.targetId) then
  rows.map (fun x => if Text.equal x.targetId row.targetId then row else x)
 else rows++[row]
def targetDictionary (rows : List Target) : List Target := rows.foldl insertTarget []
def targetAt (rows : List Target) (key : String) : Except String Target :=
 match rows.find? (fun x => Text.equal x.targetId key) with
 | some row => .ok row
 | none => .error (Text.intercalate "" ["'",key,"'"])
def fieldsMatch (target : Target) (fields : List (String × J)) : Bool :=
 fields.all (fun (key,v) => match target.fields.find? (fun p => Text.equal p.1 key) with
  | none => false
  | some p => StateSymmetryPrediction.canonicalEqual p.2 v)
def stateValue (s : State) : J := .object (s.fields++[("target_value",canonical s.targetValue)])
def pairValue (p : ExchangePair) : J :=
 .object (p.fields++[("support_identity",.text p.support),("target_value",canonical p.targetValue)])
def stateRow (reference : Identity) (targets : List Target) (ordinal : Nat) (row : List String) : Except String State := do
 let state := row.headD ""
 let term ← match StateSymmetrySource.terms state with
  | [t] => .ok t
  | [] | _::_::_ => .error "ELEC-006 H2 row does not retain exactly one term assignment"
 let config := configurationFromState state
 let id := Text.append "H2-exchange-state-" (paddedOrdinal ordinal)
 let target ← targetAt targets id
 let spin := if term.multiplicity==1 then "alternating-exchange" else "preserving-exchange"
 let spatial := if term.multiplicity==1 then "preserving-exchange" else "alternating-exchange"
 let paired := match config with | none => false | some c => c.occupancy==2
 let sameCell := if paired then "same-cell-pair-recorded" else "no-explicit-same-cell-pair"
 let energy := (row.drop 1).headD ""
 let fields : List (String × J) := [
  ("target_id",.text id),("target_type",.text "state-exchange-assignment"),("state_row_ordinal",.integer (.ofNat ordinal)),
  ("state_record",.text state),("term_assignment_inscription",.text (Text.append term.inscription term.suffix)),
  ("positive_spin_multiplicity",.integer (.ofNat term.multiplicity)),("spin_exchange_class",.text spin),
  ("spatial_exchange_class",.text spatial),("total_exchange_class",.text "alternating-exchange"),
  ("same_cell_record",.text sameCell),("configuration",configurationValue config),("energy_inscription",.text energy),
  ("snapshot_path",.text reference.snapshotPath),("snapshot_hash",.text reference.snapshotHash)]
 if !fieldsMatch target fields then throw "ELEC-006 independent H2 state extraction differs from target"
 let value := Value.word [
  .label (← heldLabel "NIST-state-record" state),.label (← heldLabel "NIST-term-assignment" (Text.append term.inscription term.suffix)),
  .count (← count term.multiplicity),.label (← heldLabel "exchange-class" spin),.label (← heldLabel "exchange-class" spatial),
  .label PairExchange.alternating,.label (← heldLabel "same-cell-observation" sameCell),
  ← configurationWord config,.label (← heldLabel "NIST-energy-inscription" energy)]
 return ⟨id,ordinal,state,term,config,energy,fields,value⟩

structure GroupMember where
 state : State
 configuration : Configuration
 energy : Nat × Nat

def groupMembers (states : List State) : Except String (List GroupMember) :=
 states.foldlM (fun out state => match state.configuration with
  | none => .ok out
  | some c => do return out++[⟨state,c,← exactEnergy state.energyInscription⟩]) []

def pairRow (reference : Identity) (targets : List Target) (ordinal : Nat)
 (config : Configuration) (singlet triplet : GroupMember) : Except String ExchangePair := do
 let (n,d,order) ← separation singlet.energy triplet.energy
 let id := Text.append "H2-exchange-pair-" (paddedOrdinal ordinal)
 let target ← targetAt targets id
 let s := singlet.state
 let t := triplet.state
 let fields : List (String × J) := [
  ("target_id",.text id),("target_type",.text "same-configuration-exchange-pair"),("configuration",configurationValue (some config)),
  ("singlet_state_target_id",.text s.targetId),("singlet_state_record",.text s.stateRecord),
  ("singlet_energy_inscription",.text s.energyInscription),("triplet_state_target_id",.text t.targetId),
  ("triplet_state_record",.text t.stateRecord),("triplet_energy_inscription",.text t.energyInscription),
  ("positive_energy_separation_numerator",.integer (.ofNat n)),("positive_energy_separation_denominator",.integer (.ofNat d)),
  ("held_energy_order",.text order),("snapshot_path",.text reference.snapshotPath),("snapshot_hash",.text reference.snapshotHash)]
 if !fieldsMatch target fields then throw "ELEC-006 independent exchange-pair extraction differs from target"
 let support := supportIdentity config
 let value := Value.word [
  .label (← heldLabel "molecular-orbital-support" support),.label (← heldLabel "singlet-state-record" s.stateRecord),
  .label (← heldLabel "triplet-state-record" t.stateRecord),.label (← heldLabel "singlet-energy-inscription" s.energyInscription),
  .label (← heldLabel "triplet-energy-inscription" t.energyInscription),.ratio (← count n) (← count d),
  .label (← heldLabel "energy-order" order)]
 return ⟨id,config,s,t,n,d,order,support,fields,value⟩

def resolvedTargets (actualIdentityHash identitySchema actualTargetHash targetSchema : String)
 (rawIdentities : List Identity) (rawStates rawPairs : List Target) (actualSnapshotHash : String)
 (events : List StateSymmetrySource.Event) : Except String (List State × List ExchangePair) := do
 let ids ← identities actualIdentityHash identitySchema rawIdentities
 if !Text.equal actualTargetHash targetHash then throw "ELEC-006 withheld target registry changed"
 let registeredStates := targetDictionary rawStates
 let registeredPairs := targetDictionary rawPairs
 if !Text.equal targetSchema "sft-v3-pair-exchange-withheld-targets/1" || registeredStates.length != 46 || registeredPairs.length != 14 ||
   !StateSymmetryPrediction.sameIds ((registeredStates++registeredPairs).map Target.targetId) (ids.map Identity.targetId) then
  throw "ELEC-006 target support is incomplete or differs from identities"
 let reference ← match ids with
  | [] => .error "ELEC-006 identity registry is incomplete"
  | x::_ => .ok x
 if !Text.equal actualSnapshotHash reference.snapshotHash then throw "ELEC-006 NIST H2 snapshot changed"
 if ids.any (fun row => !Text.equal row.snapshotPath reference.snapshotPath || !Text.equal row.snapshotHash reference.snapshotHash) then
  throw "ELEC-006 target identities do not share the registered H2 snapshot"
 let rows := sourceRows events
 if rows.length != 46 then throw "ELEC-006 independent H2 state census is incomplete"
 let states ← (rows.zipIdx 1).mapM fun (row,i) => stateRow reference registeredStates i row
 let members ← groupMembers states
 let configs := sortedConfigurations (members.map GroupMember.configuration)
 let triples := configs.flatMap fun config =>
  let group := members.filter (fun m => configurationEqual m.configuration config)
  let singlets := group.filter (fun m => m.state.term.multiplicity==1)
  let triplets := group.filter (fun m => m.state.term.multiplicity==3)
  singlets.flatMap fun singlet => triplets.map fun triplet => (config,singlet,triplet)
 let pairs ← (triples.zipIdx 1).mapM fun ((config,singlet,triplet),i) => pairRow reference registeredPairs i config singlet triplet
 if pairs.length != 14 then throw "ELEC-006 independent exchange-pair census is incomplete"
 return (states,pairs)

#print axioms identityHash
#print axioms targetHash
#print axioms identities
#print axioms insertTarget
#print axioms targetDictionary
#print axioms targetAt
#print axioms fieldsMatch
#print axioms stateValue
#print axioms pairValue
#print axioms stateRow
#print axioms groupMembers
#print axioms pairRow
#print axioms resolvedTargets
end SFT.Chemistry.PairExchangeTargets
