import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.RadioactiveChemicalTransformation
open SFT.Host SFT.Physics.CapabilityValues
structure Edge where
 parent : HeldLabel
 daughter : HeldLabel
 parentSpecies : HeldLabel
 daughterSpecies : HeldLabel
 channel : HeldLabel
 events : PositiveCount

def validFamilies (e : Edge) : Bool :=
 Text.equal e.parent.family "parent-nuclide" && Text.equal e.daughter.family "daughter-nuclide" &&
 Text.equal e.parentSpecies.family "parent-species" && Text.equal e.daughterSpecies.family "daughter-species" &&
 Text.equal e.channel.family "decay-channel"
def construct (parent daughter parentSpecies daughterSpecies channel : HeldLabel) (events : PositiveCount) : Except String Edge :=
 let e := Edge.mk parent daughter parentSpecies daughterSpecies channel events
 if validFamilies e then .ok e else .error "complete parent/daughter chemical edge required"
def labelEqual (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def sameKey (a b : Edge) : Bool := labelEqual a.parent b.parent && labelEqual a.daughter b.daughter && labelEqual a.channel b.channel
def distinctKeys : List Edge → Bool
 | [] => true
 | e::es => !(es.any (sameKey e)) && distinctKeys es
inductive Network where
 | emptyOne
 | edges : List Edge → Network

def network (edges : List Edge) : Except String Network :=
 match edges with
 | [] => .ok .emptyOne
 | e::es => if distinctKeys (e::es) then .ok (.edges (e::es)) else .error "duplicate decay edge"
theorem emptyNetwork : network [] = .ok .emptyOne := rfl
theorem completeNetworkRetained (e : Edge) (es : List Edge) (h : distinctKeys (e::es) = true) :
 network (e::es) = .ok (.edges (e::es)) := by
 change ((if distinctKeys (e::es) then .ok (.edges (e::es)) else .error "duplicate decay edge") : Except String Network) = _
 rw [h]
 rfl

def original (n : Nat := 1) : Except String Edge := do
 construct (← heldLabel "parent-nuclide" "p") (← heldLabel "daughter-nuclide" "d")
  (← heldLabel "parent-species" "ps") (← heldLabel "daughter-species" "ds")
  (← heldLabel "decay-channel" (toString n)) (← count n)
def check (p : Edge → Bool) : Bool := match original with
 | .error _ => false
 | .ok e => p e
def parentWitness : Bool := check (fun e => Text.equal e.parent.label "p")
def daughterWitness : Bool := check (fun e => Text.equal e.daughter.label "d")
def speciesWitness : Bool := check (fun e => !e.parentSpecies.label.isEmpty && !e.daughterSpecies.label.isEmpty)
def channelWitness : Bool := check (fun e => Text.equal e.channel.label "1")
def eventsWitness : Bool := check (fun e => e.events.value==1)
def networkLength : Except String Network → Nat
 | .ok (.edges es) => es.length
 | .ok .emptyOne | .error _ => 0
def networkWitness : Bool := networkLength (original >>= fun e => network [e]) == 1
def absenceWitness : Bool := match network [] with
 | .ok .emptyOne => true
 | .ok (.edges _) | .error _ => false
def successorWitness : Bool := networkLength (do network [← original 1,← original 2]) == 2
theorem parentWitnessPassed : parentWitness = true := rfl
theorem daughterWitnessPassed : daughterWitness = true := rfl
theorem speciesWitnessPassed : speciesWitness = true := rfl
theorem channelWitnessPassed : channelWitness = true := rfl
theorem eventsWitnessPassed : eventsWitness = true := rfl
theorem networkWitnessPassed : networkWitness = true := rfl
theorem absenceWitnessPassed : absenceWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.RadioactiveChemicalTransformation
