import SFT.Chemistry.MolecularElectronicState
import SFT.Physics.MolecularLadders
namespace SFT.Chemistry.MolecularRovibronicState
open SFT.Host SFT.Physics.CapabilityValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure State where
 electronicState : MolecularElectronicState.State
 nuclearOccurrenceIds : List String
 isotopeLabels : List HeldLabel
 vibrationalOrdinal : PositiveCount
 rotationalOrdinal : PositiveCount
 heldSpinState : HeldLabel
 observationRecord : HeldLabel

def valid (state : State) : Except String State := do
 let ids := state.nuclearOccurrenceIds
 if ids.isEmpty then throw "a molecular state requires retained nuclear occurrences"
 if (SFT.Physics.GrandLockDependency.unique ids).length != ids.length then throw "nuclear occurrences must be unique"
 if state.isotopeLabels.length != ids.length then throw "every nuclear occurrence requires one isotope label"
 if !(state.isotopeLabels.all (fun label=>Text.equal label.family "molecular-isotope")) then throw "isotope identity must remain a held molecular label"
 if !Text.equal state.heldSpinState.family "molecular-spin-state" then throw "spin state must remain a held molecular label"
 if !Text.equal state.observationRecord.family "molecular-rovibronic-observation" then throw "rovibronic state requires a retained observation record"
 pure state

def positiveResult : Int → Except String PositiveCount
 | .ofNat n => count n
 | .negSucc _ => .error "an SFT count must be a positive counted value"
def rotationalRecurrence (state : State) : Except String PositiveCount := do
 positiveResult (← SFT.Physics.MolecularLadders.rotationalLevel (.count (.integer (.ofNat state.rotationalOrdinal.value))))
def vibrationalRecurrence (state : State) : Except String PositiveCount := do
 positiveResult (← SFT.Physics.MolecularLadders.oddVibrationalCarrier (.count (.integer (.ofNat state.vibrationalOrdinal.value))))
structure Key where
 molecularCarrierId : String
 isotopes : List String
 vibration : Nat
 rotation : Nat
 spin : String
 observation : String

def exactStateKey (state : State) : Except String Key := do
 let vibration ← vibrationalRecurrence state
 let rotation ← rotationalRecurrence state
 pure ⟨state.electronicState.molecularCarrierId,state.isotopeLabels.map HeldLabel.label,vibration.value,rotation.value,state.heldSpinState.label,state.observationRecord.label⟩
def stringsEqual : List String → List String → Bool
 | [],[]=>true
 | x::xs,y::ys=>Text.equal x y && stringsEqual xs ys
 | [],_::_ | _::_,[]=>false
def keyEqual (a b : Key) : Bool :=
 Text.equal a.molecularCarrierId b.molecularCarrierId && stringsEqual a.isotopes b.isotopes &&
 a.vibration == b.vibration && a.rotation == b.rotation && Text.equal a.spin b.spin && Text.equal a.observation b.observation

def isotopologueDistinguishable (left right : State) : Except String Bool := do
 if !Text.equal left.electronicState.molecularCarrierId right.electronicState.molecularCarrierId then
  throw "isotopologue comparison requires one molecular carrier class"
 let a ← exactStateKey left
 let b ← exactStateKey right
 pure (!keyEqual a b)

def keyValue (k : Key) : Canonical.Value := .array [.text k.molecularCarrierId,.array (k.isotopes.map Canonical.Value.text),.integer (.ofNat k.vibration),.integer (.ofNat k.rotation),.text k.spin,.text k.observation]
#print axioms valid
#print axioms positiveResult
#print axioms rotationalRecurrence
#print axioms vibrationalRecurrence
#print axioms exactStateKey
#print axioms keyEqual
#print axioms isotopologueDistinguishable
end SFT.Chemistry.MolecularRovibronicState
