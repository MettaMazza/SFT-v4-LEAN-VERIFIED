import SFT.Chemistry.AnalyticalAccuracy
namespace SFT.Chemistry.ResolvedRovibronic
open SFT.Host SFT.Physics.CapabilityValues
open AnalyticalAccuracy (PositiveRatio ratio rational)
-- Original rovibronic_joint_law_v1.ExactCoordinate.
inductive Coordinate where
 | emptyOne (identity : String)
 | positive (value : PositiveRatio)
structure State where
 carrier : HeldLabel
 isotopeSupport : List HeldLabel
 electronicState : HeldLabel
 spinMultiplicity : PositiveCount
 vibrationalCoordinate : Coordinate
 rotationalCoordinate : Coordinate
 transitionRecord : HeldLabel
 sourceRecord : HeldLabel

def construct (s : State) : Except String State := do
 if !Text.equal s.carrier.family "molecular-carrier" || s.isotopeSupport.isEmpty ||
  !(s.isotopeSupport.all fun x => Text.equal x.family "molecular-isotope") then
  throw "resolved state requires carrier and isotope support"
 if !Text.equal s.electronicState.family "molecular-electronic-state" then
  throw "electronic state erased"
 if !Text.equal s.transitionRecord.family "molecular-transition-record" ||
  !Text.equal s.sourceRecord.family "resolved-spectrum-record" then
  throw "resolved records must remain held"
 pure s

-- Typed encoding of the two dataclass repr alternatives; retain unreduced counts.
inductive CoordinateKey where
 | emptyOne (identity : String)
 | positive (numerator denominator : Nat)
def coordinateKey : Coordinate → CoordinateKey
 | .emptyOne identity => .emptyOne identity
 | .positive q => .positive q.1.value q.2.value
def jointKey (s : State) : String × List String × String × Nat × CoordinateKey × CoordinateKey × String × String :=
 (s.carrier.label,s.isotopeSupport.map HeldLabel.label,s.electronicState.label,
 s.spinMultiplicity.value,coordinateKey s.vibrationalCoordinate,coordinateKey s.rotationalCoordinate,
 s.transitionRecord.label,s.sourceRecord.label)

def sourceState : Except String State := do
 construct ⟨← heldLabel "molecular-carrier" "H2",
 [← heldLabel "molecular-isotope" "protium",← heldLabel "molecular-isotope" "protium"],
 ← heldLabel "molecular-electronic-state" "X-singlet-sigma-g",← count 1,
 .positive (← ratio 4401213 1000),.positive (← ratio 608530 10000),
 ← heldLabel "molecular-transition-record" "source-absence",← heldLabel "resolved-spectrum-record" "X-row"⟩
def jointKeyWitness : Bool := match sourceState with
 | .error _ => false
 | .ok s =>
   let key := jointKey s
   let fields : List String := [key.1,Text.intercalate "," key.2.1,key.2.2.1,toString key.2.2.2.1,
    match key.2.2.2.2.1 with | .emptyOne x => x | .positive n d => Text.intercalate "/" [toString n,toString d],
    match key.2.2.2.2.2.1 with | .emptyOne x => x | .positive n d => Text.intercalate "/" [toString n,toString d],
    key.2.2.2.2.2.2.1,key.2.2.2.2.2.2.2]
   fields.length == 8

def spinWitness : Bool := match sourceState with
 | .error _ => false
 | .ok s => s.spinMultiplicity.value == 1
theorem jointKeyWitnessPassed : jointKeyWitness = true := rfl
theorem spinWitnessPassed : spinWitness = true := rfl
def erasureWitness : Bool := match (do
 let s ← sourceState
 construct { s with electronicState := ← heldLabel "wrong" "X", vibrationalCoordinate := .emptyOne "empty-One", rotationalCoordinate := .emptyOne "empty-One" }) with
 | .error _ => true
 | .ok _ => false

theorem erasureWitnessPassed : erasureWitness = true := rfl

theorem acceptedRetainsAll (s out : State) (accepted : construct s = .ok out) : out = s := by
 unfold construct at accepted
 cases h0 : (!Text.equal s.carrier.family "molecular-carrier" || s.isotopeSupport.isEmpty || !(s.isotopeSupport.all fun x => Text.equal x.family "molecular-isotope")) with
 | true =>
   rw [h0] at accepted
   exact (congrArg (fun (x : Except String State) => match x with | .error _ => s | .ok v => v) accepted).symm
 | false =>
   rw [h0] at accepted
   cases h1 : (!Text.equal s.electronicState.family "molecular-electronic-state") with
   | true =>
     rw [h1] at accepted
     exact (congrArg (fun (x : Except String State) => match x with | .error _ => s | .ok v => v) accepted).symm
   | false =>
     rw [h1] at accepted
     cases h2 : (!Text.equal s.transitionRecord.family "molecular-transition-record" || !Text.equal s.sourceRecord.family "resolved-spectrum-record") with
     | true =>
       rw [h2] at accepted
       exact (congrArg (fun (x : Except String State) => match x with | .error _ => s | .ok v => v) accepted).symm
     | false =>
       rw [h2] at accepted
       exact (congrArg (fun (x : Except String State) => match x with | .error _ => s | .ok v => v) accepted).symm
end SFT.Chemistry.ResolvedRovibronic
