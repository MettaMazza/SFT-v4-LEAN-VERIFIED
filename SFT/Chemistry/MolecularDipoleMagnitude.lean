import SFT.Chemistry.DihedralTorsion
import SFT.Physics.LeptonIntervals
namespace SFT.Chemistry.MolecularDipoleMagnitude
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues DihedralTorsion
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Component where
 axis : HeldLabel
 orientation : HeldLabel
 magnitude : Ratio
def component (axis orientation : HeldLabel) (magnitude : Height) : Except String Component := do
 if !Text.equal axis.family "dipole-axis" then throw "dipole component requires a retained axis"
 if !Text.equal orientation.family "held-dipole-orientation" then throw "dipole direction must remain a held orientation"
 match magnitude with
 | .ratio value => pure ⟨axis,orientation,value⟩
 | .emptyOne | .otherEmptyOne _ | .invalid => throw "dipole component magnitude must be an exact positive ratio"
inductive ComponentInput where
 | component (value : Component)
 | invalid
inductive ComponentsInput where
 | tuple (values : List ComponentInput)
 | other
def distinctAxes : List Component → Bool
 | [] => true
 | first::rest => !(rest.any fun other => equalLabel first.axis other.axis) && distinctAxes rest
def square (value : Ratio) : Rat :=
 let q := LeptonIntervals.normalize (.ofNat value.numerator.value) value.denominator.value value.denominator.positive
 LeptonIntervals.multiply q q
def squaredSum (first : Component) (rest : List Component) : Rat :=
 rest.foldl (fun acc next => LeptonIntervals.add acc (square next.magnitude)) (square first.magnitude)
def positiveRatio (q : Rat) : Except String Ratio := do
 if !(@decide (Int.lt 0 q.num) (Int.decLt _ _)) then throw "dipole square Junction left the exact positive domain"
 pure ⟨← count q.num.natAbs,← count q.den⟩
def exactSquaredMagnitude : ComponentsInput → Except String Height
 | .other => .error "dipole components require a finite generated tuple"
 | .tuple values => do
  if values.isEmpty then return .emptyOne
  let components ← values.mapM fun value => match value with
   | .component value => pure value
   | .invalid => throw "dipole component support contains an invalid form"
  if !distinctAxes components then throw "a dipole axis cannot be counted twice"
  match components with
  | [] => pure .emptyOne
  | first::rest => pure (.ratio (← positiveRatio (squaredSum first rest)))
def symmetryAxes : List (String × List String) :=
 [("inversion-exchange-symmetric-homonuclear-diatomic",[]),
 ("exchange-symmetric-equal-endpoint-isotopologue",["principal-b"]),
 ("isotope-distinguished-principal-axis-carrier",["principal-a","principal-b"])]
structure Carrier where
 species : HeldLabel
 state : HeldLabel
 geometry : HeldLabel
 charge : HeldLabel
 symmetry : HeldLabel
 axes : List HeldLabel
 definition : HeldLabel
def validateCarrier (carrier : Carrier) : Except String Carrier := do
 if !Text.equal carrier.species.family "molecular-species" then throw "dipole carrier must retain a named species"
 if !Text.equal carrier.state.family "molecular-state" then throw "dipole carrier must retain molecular state"
 if !Text.equal carrier.geometry.family "molecular-geometry" then throw "dipole carrier must retain molecular geometry"
 if !Text.equal carrier.charge.family "charge-distinction-carrier" then throw "dipole carrier must retain complete charge distinction"
 let expected ← match symmetryAxes.find? (fun pair => Text.equal pair.1 carrier.symmetry.label) with
  | none => throw "dipole carrier symmetry lies outside the registered boundary"
  | some pair => pure pair.2
 if !Text.equal carrier.symmetry.family "molecular-symmetry" then throw "dipole carrier symmetry lies outside the registered boundary"
 if !(carrier.axes.all fun axis => Text.equal axis.family "dipole-axis") then throw "dipole component axes must remain held labels"
 if carrier.axes.map HeldLabel.label != expected then throw "component support does not follow the retained symmetry class"
 if !Text.equal carrier.definition.family "dipole-magnitude-definition" ||
    !Text.equal carrier.definition.label "exact-Junction-of-positive-component-squares" then throw "dipole magnitude definition changed"
 pure carrier
def structuralMagnitudeClass (carrier : Carrier) : HeldLabel :=
 if carrier.axes.isEmpty then ⟨"dipole-magnitude-class","structural-EmptyOne",rfl,rfl⟩
 else if carrier.axes.length==1 then ⟨"dipole-magnitude-class","one-positive-component",rfl,rfl⟩
 else ⟨"dipole-magnitude-class","multiple-orthogonal-positive-components",rfl,rfl⟩
theorem structuralAbsence : exactSquaredMagnitude (.tuple []) = .ok .emptyOne := rfl
theorem oneComponentSquare (first : Component) : squaredSum first [] = square first.magnitude := rfl
theorem successorSquareJunction (first : Component) (rest : List Component) (next : Component) :
 squaredSum first (rest++[next]) = LeptonIntervals.add (squaredSum first rest) (square next.magnitude) := by
 unfold squaredSum
 have step : ∀ (xs : List Component) (initial : Rat),
   (xs++[next]).foldl (fun acc c => LeptonIntervals.add acc (square c.magnitude)) initial =
   LeptonIntervals.add (xs.foldl (fun acc c => LeptonIntervals.add acc (square c.magnitude)) initial) (square next.magnitude) := by
  intro xs
  induction xs with
  | nil => intro initial; rfl
  | cons head tail ih =>
   intro initial
   exact ih (LeptonIntervals.add initial (square head.magnitude))
 exact step rest (square first.magnitude)

def registeredCarriers : List Carrier := [⟨⟨"molecular-species","H2",rfl,rfl⟩,⟨"molecular-state","gas-phase-ground-vibrational-effective-dipole",rfl,rfl⟩,⟨"molecular-geometry","homonuclear-diatomic",rfl,rfl⟩,⟨"charge-distinction-carrier","exchange-identical-two-endpoint-charge-organization",rfl,rfl⟩,⟨"molecular-symmetry","inversion-exchange-symmetric-homonuclear-diatomic",rfl,rfl⟩,[],⟨"dipole-magnitude-definition","exact-Junction-of-positive-component-squares",rfl,rfl⟩⟩,
⟨⟨"molecular-species","D2",rfl,rfl⟩,⟨"molecular-state","gas-phase-ground-vibrational-effective-dipole",rfl,rfl⟩,⟨"molecular-geometry","homonuclear-diatomic",rfl,rfl⟩,⟨"charge-distinction-carrier","exchange-identical-two-endpoint-charge-organization",rfl,rfl⟩,⟨"molecular-symmetry","inversion-exchange-symmetric-homonuclear-diatomic",rfl,rfl⟩,[],⟨"dipole-magnitude-definition","exact-Junction-of-positive-component-squares",rfl,rfl⟩⟩,
⟨⟨"molecular-species","H2O",rfl,rfl⟩,⟨"molecular-state","gas-phase-ground-vibrational-effective-dipole",rfl,rfl⟩,⟨"molecular-geometry","bent-water-triatomic",rfl,rfl⟩,⟨"charge-distinction-carrier","one-oxygen-centred-two-endpoint-electronic-charge-organization",rfl,rfl⟩,⟨"molecular-symmetry","exchange-symmetric-equal-endpoint-isotopologue",rfl,rfl⟩,[⟨"dipole-axis","principal-b",rfl,rfl⟩],⟨"dipole-magnitude-definition","exact-Junction-of-positive-component-squares",rfl,rfl⟩⟩,
⟨⟨"molecular-species","D2O",rfl,rfl⟩,⟨"molecular-state","gas-phase-ground-vibrational-effective-dipole",rfl,rfl⟩,⟨"molecular-geometry","bent-water-triatomic",rfl,rfl⟩,⟨"charge-distinction-carrier","one-oxygen-centred-two-endpoint-electronic-charge-organization",rfl,rfl⟩,⟨"molecular-symmetry","exchange-symmetric-equal-endpoint-isotopologue",rfl,rfl⟩,[⟨"dipole-axis","principal-b",rfl,rfl⟩],⟨"dipole-magnitude-definition","exact-Junction-of-positive-component-squares",rfl,rfl⟩⟩,
⟨⟨"molecular-species","HDO",rfl,rfl⟩,⟨"molecular-state","gas-phase-ground-vibrational-effective-dipole",rfl,rfl⟩,⟨"molecular-geometry","bent-water-triatomic",rfl,rfl⟩,⟨"charge-distinction-carrier","one-oxygen-centred-two-endpoint-electronic-charge-organization",rfl,rfl⟩,⟨"molecular-symmetry","isotope-distinguished-principal-axis-carrier",rfl,rfl⟩,[⟨"dipole-axis","principal-a",rfl,rfl⟩,⟨"dipole-axis","principal-b",rfl,rfl⟩],⟨"dipole-magnitude-definition","exact-Junction-of-positive-component-squares",rfl,rfl⟩⟩]
def registeredCarrierVector : Except String (List Carrier) := registeredCarriers.mapM validateCarrier
def symmetryWitness : Bool := (registeredCarriers.map fun c => c.axes.length)==[0,0,1,1,2]
def oneAxis : Component := ⟨⟨"dipole-axis","principal-b",rfl,rfl⟩,
 ⟨"held-dipole-orientation","toward-distinguished-charge-carrier",rfl,rfl⟩,⟨⟨3,by decide⟩,⟨2,by decide⟩⟩⟩
def firstAxis : Component := ⟨⟨"dipole-axis","principal-a",rfl,rfl⟩,
 ⟨"held-dipole-orientation","first-principal-side",rfl,rfl⟩,⟨⟨3,by decide⟩,⟨5,by decide⟩⟩⟩
def secondAxis : Component := ⟨⟨"dipole-axis","principal-b",rfl,rfl⟩,
 ⟨"held-dipole-orientation","second-principal-side",rfl,rfl⟩,⟨⟨4,by decide⟩,⟨5,by decide⟩⟩⟩
def exactResult (input : ComponentsInput) (n d : Nat) : Bool :=
 match exactSquaredMagnitude input with
 | .error _ => false
 | .ok height => match height with
  | .ratio r => r.numerator.value*d==n*r.denominator.value
  | .emptyOne | .otherEmptyOne _ | .invalid => false
def absenceWitness : Bool := match exactSquaredMagnitude (.tuple []) with
 | .error _ => false
 | .ok height => match height with
  | .emptyOne => true
  | .ratio _ | .otherEmptyOne _ | .invalid => false
def oneAxisWitness := exactResult (.tuple [.component oneAxis]) 9 4
def junctionWitness := exactResult (.tuple [.component firstAxis,.component secondAxis]) 1 1
def duplicateWitness := match exactSquaredMagnitude (.tuple [.component firstAxis,.component firstAxis]) with | .error _ => true | .ok _ => false
theorem registeredCarriersAccepted : registeredCarrierVector.isOk = true := rfl
theorem symmetryPassed : symmetryWitness = true := rfl
theorem absencePassed : absenceWitness = true := rfl
theorem oneAxisPassed : oneAxisWitness = true := rfl
theorem junctionPassed : junctionWitness = true := rfl
theorem duplicatePassed : duplicateWitness = true := rfl
end SFT.Chemistry.MolecularDipoleMagnitude
