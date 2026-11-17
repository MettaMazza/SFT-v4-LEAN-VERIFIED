import SFT.Chemistry.MolecularStateTransition
namespace SFT.Chemistry.SelectionRule
open SFT.Physics.CapabilityValues SFT.Host
open SFT.Chemistry.MulticentreSupport (sameLabel)
-- Source: selection_rule_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
def direct : HeldLabel := ⟨"selection-observation-class","direct-one-fold-observation",by rfl,by rfl⟩
def mediated : HeldLabel := ⟨"selection-observation-class","mediated-multi-fold-observation",by rfl,by rfl⟩
def coupled : HeldLabel := ⟨"selection-observation-class","coupled-without-direction",by rfl,by rfl⟩
def closed : HeldLabel := ⟨"selection-observation-class","closed-observation-coordinate",by rfl,by rfl⟩
def unresolved : HeldLabel := ⟨"selection-observation-class","endpoint-signature-not-source-resolved",by rfl,by rfl⟩
def axisNeighbours : List (String × String) :=
 [("Σ","Σ"),("Σ","Π"),("Π","Σ"),("Π","Π"),("Π","Δ"),
  ("Δ","Π"),("Δ","Δ"),("Δ","Φ"),("Φ","Δ"),("Φ","Φ")]
structure StateSignature where
 state : HeldLabel
 multiplicity : PositiveCount
 inversion : HeldLabel
 axis : HeldLabel

def constructSignature (state : HeldLabel) (multiplicity : PositiveCount)
 (inversion axis : HeldLabel) : Except String StateSignature := do
 if !Text.equal state.family "molecular-state" then
  throw "selection signature requires one retained molecular state"
 if !Text.equal inversion.family "inversion-fibre" || !Text.equal axis.family "axis-support" then
  throw "selection signature requires held inversion and axis labels"
 return ⟨state,multiplicity,inversion,axis⟩

def signature (state : String) (multiplicity : Nat) (inversion axis : String) : Except String StateSignature := do
 constructSignature (← heldLabel "molecular-state" state) (← count multiplicity)
  (← heldLabel "inversion-fibre" inversion) (← heldLabel "axis-support" axis)

def directObservationAllowed (initial terminal : StateSignature) : Bool :=
 if !(initial.multiplicity.value == terminal.multiplicity.value) then false
 else if !(axisNeighbours.any fun p => Text.equal p.1 initial.axis.label && Text.equal p.2 terminal.axis.label) then false
 else
  let known := fun s => Text.equal s "g" || Text.equal s "u"
  if known initial.inversion.label && known terminal.inversion.label then
   !Text.equal initial.inversion.label terminal.inversion.label
  else true

-- The Python field accepts arbitrary objects. Only singleton identity and HeldLabel
-- membership are inspected; other payloads are retained without an added guard.
inductive Mediator (Payload : Type) where
 | emptyOne : Mediator Payload
 | held : HeldLabel → Mediator Payload
 | other : Payload → Mediator Payload
structure SelectionRecord (Payload : Type) where
 initial : Option StateSignature
 terminal : Option StateSignature
 observationClass : HeldLabel
 mediatorOrAbsence : Mediator Payload
 retainedRecord : HeldLabel

def isEmptyOne {P : Type} : Mediator P → Bool
 | .emptyOne => true
 | .held _ => false
 | .other _ => false

def constructRecord {P : Type} (initial terminal : Option StateSignature)
 (observationClass : HeldLabel) (mediatorOrAbsence : Mediator P) (record : HeldLabel) : Except String (SelectionRecord P) := do
 if !Text.equal record.family "selection-record" then
  throw "selection result requires its exact observation record"
 if sameLabel observationClass closed then
  if initial.isNone || !terminal.isNone || !isEmptyOne mediatorOrAbsence then
   throw "closed observation must retain its source and structural EmptyOne"
 else if sameLabel observationClass coupled then
  if initial.isNone || terminal.isNone || !isEmptyOne mediatorOrAbsence then
   throw "coupling retains two states without a transition mediator"
 else if sameLabel observationClass unresolved then
  if initial.isNone == terminal.isNone then
   throw "an unresolved endpoint record retains exactly one known signature"
 else if sameLabel observationClass direct then
  match initial,terminal with
  | some a,some b =>
   if !isEmptyOne mediatorOrAbsence then
    throw "direct observation retains two signatures and no mediator"
   if !directObservationAllowed a b then
    throw "closed distinction cannot pass as a direct observation"
  | none,none => throw "direct observation retains two signatures and no mediator"
  | none,some _ => throw "direct observation retains two signatures and no mediator"
  | some _,none => throw "direct observation retains two signatures and no mediator"
 else if sameLabel observationClass mediated then
  if initial.isNone || terminal.isNone then
   throw "mediated observation retains both endpoint signatures"
  match mediatorOrAbsence with
  | .held label =>
   if !Text.equal label.family "mediating-record" then
    throw "a non-direct observation requires an explicit retained mediator"
  | .emptyOne => throw "a non-direct observation requires an explicit retained mediator"
  | .other _ => throw "a non-direct observation requires an explicit retained mediator"
 else throw "selection observation class was not generated"
 return ⟨initial,terminal,observationClass,mediatorOrAbsence,record⟩

def classifyObservation (initial terminal : Option StateSignature) (record : String)
 (observed : Bool := true) (isCoupled : Bool := false) (mediator : Option String := none) : Except String (SelectionRecord Unit) := do
 let heldRecord ← heldLabel "selection-record" record
 if !observed then return ← constructRecord initial none closed .emptyOne heldRecord
 if isCoupled then return ← constructRecord initial terminal coupled .emptyOne heldRecord
 match initial,terminal with
 | some a,some b =>
  if directObservationAllowed a b then
   constructRecord initial terminal direct .emptyOne heldRecord
  else match mediator with
   | none => throw "observed non-direct relation must not erase its mediator requirement"
   | some text => constructRecord initial terminal mediated (.held (← heldLabel "mediating-record" text)) heldRecord
 | none,none => constructRecord initial terminal unresolved .emptyOne heldRecord
 | none,some _ => constructRecord initial terminal unresolved .emptyOne heldRecord
 | some _,none => constructRecord initial terminal unresolved .emptyOne heldRecord

-- The exact returned record retains every source field whenever its original guards pass.
theorem acceptedSignatureExact (s : HeldLabel) (m : PositiveCount) (i a : HeldLabel)
 (out : StateSignature) (h : constructSignature s m i a = .ok out) :
 out = StateSignature.mk s m i a := by
 unfold constructSignature at h
 cases hs : (!Text.equal s.family "molecular-state") with
 | true => rw [hs] at h; cases h
 | false =>
  rw [hs] at h
  cases hi : (!Text.equal i.family "inversion-fibre" || !Text.equal a.family "axis-support") with
  | true => rw [hi] at h; cases h
  | false => rw [hi] at h; exact (Except.ok.inj h).symm
theorem directRetainsMultiplicity (initial terminal : StateSignature)
 (accepted : directObservationAllowed initial terminal = true) :
 initial.multiplicity.value = terminal.multiplicity.value := by
 unfold directObservationAllowed at accepted
 cases same : (initial.multiplicity.value == terminal.multiplicity.value) with
 | false => rw [same] at accepted; cases accepted
 | true => exact Nat.eq_of_beq_eq_true same

theorem directAxisNeighbour (initial terminal : StateSignature)
 (accepted : directObservationAllowed initial terminal = true) :
 (axisNeighbours.any fun p => Text.equal p.1 initial.axis.label && Text.equal p.2 terminal.axis.label) = true := by
 unfold directObservationAllowed at accepted
 cases same : (initial.multiplicity.value == terminal.multiplicity.value) with
 | false => rw [same] at accepted; cases accepted
 | true =>
  rw [same] at accepted
  cases neighbour : (axisNeighbours.any fun p => Text.equal p.1 initial.axis.label && Text.equal p.2 terminal.axis.label) with
  | false => rw [neighbour] at accepted; cases accepted
  | true => rfl

theorem directChangesKnownInversion (initial terminal : StateSignature)
 (known : ((Text.equal initial.inversion.label "g" || Text.equal initial.inversion.label "u") &&
 (Text.equal terminal.inversion.label "g" || Text.equal terminal.inversion.label "u")) = true)
 (accepted : directObservationAllowed initial terminal = true) :
 Text.equal initial.inversion.label terminal.inversion.label = false := by
 unfold directObservationAllowed at accepted
 cases mult : (initial.multiplicity.value == terminal.multiplicity.value) with
 | false => rw [mult] at accepted; cases accepted
 | true =>
  rw [mult] at accepted
  cases axis : (axisNeighbours.any fun p => Text.equal p.1 initial.axis.label && Text.equal p.2 terminal.axis.label) with
  | false => rw [axis] at accepted; cases accepted
  | true =>
   rw [axis] at accepted
   change (if ((Text.equal initial.inversion.label "g" || Text.equal initial.inversion.label "u") &&
    (Text.equal terminal.inversion.label "g" || Text.equal terminal.inversion.label "u")) then
    !Text.equal initial.inversion.label terminal.inversion.label else true) = true at accepted
   rw [known] at accepted
   cases same : Text.equal initial.inversion.label terminal.inversion.label with
   | false => rfl
   | true => rw [same] at accepted; cases accepted

def directWitness : Bool := match (do
 let sg ← signature "G" 1 "g" "Σ"
 let pu ← signature "C" 1 "u" "Π"
 classifyObservation (some sg) (some pu) "G-to-C") with
 | .error _ => false
 | .ok r => sameLabel r.observationClass direct

def mediatedWitness : Bool := match (do
 let dg ← signature "J" 1 "g" "Δ"
 let bu ← signature "B" 1 "u" "Σ"
 classifyObservation (some dg) (some bu) "J-to-B" true false (some "uncoupling")) with
 | .error _ => false
 | .ok r => sameLabel r.observationClass mediated

def closedWitness : Bool := match (do
 let sg ← signature "G" 1 "g" "Σ"
 classifyObservation (some sg) none "emission-closed" false) with
 | .error _ => false
 | .ok r => isEmptyOne r.mediatorOrAbsence

def adverseWitness : Bool := match (do
 let dg ← signature "J" 1 "g" "Δ"
 let bu ← signature "B" 1 "u" "Σ"
 classifyObservation (some dg) (some bu) "invalid-direct") with
 | .error _ => true
 | .ok _ => false

theorem directWitnessPassed : directWitness = true := by rfl
theorem mediatedWitnessPassed : mediatedWitness = true := by rfl
theorem closedWitnessPassed : closedWitness = true := by rfl
theorem adverseWitnessPassed : adverseWitness = true := by rfl

end SFT.Chemistry.SelectionRule
