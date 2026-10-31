import SFT.Physics.MechanicalAngularMomentum
namespace SFT.Physics.MechanicalCompositeCentre
open SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

-- Every constituent retains its inertial content, complete momentum and location relation.
structure Constituent (Part Support State ClockState : Type) where
  separation : MechanicalLocation.Displacement Support
  momentum : MechanicalMomentum.Momentum Part Support State ClockState

def weighted {Part Support State ClockState : Type}
    (p : Constituent Part Support State ClockState) :=
  multiply (.positive .forward p.momentum.content)
    (MechanicalWorkEnergy.displacementScalar p.separation)

def weightedSum {Part Support State ClockState : Type} :
    List (Constituent Part Support State ClockState) → Scalar
  | [] => .emptyOne
  | p :: ps => add (weighted p) (weightedSum ps)

def completeMass {Part Support State ClockState : Type}
    (p : Constituent Part Support State ClockState) :
    List (Constituent Part Support State ClockState) → PositiveFraction
  | [] => p.momentum.content
  | q :: qs => sumMagnitude p.momentum.content (completeMass q qs)

structure Composite (Part Support State ClockState : Type) where
  first : Constituent Part Support State ClockState
  rest : List (Constituent Part Support State ClockState)

def constituents {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) := c.first :: c.rest

def centre {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) :=
  dividePositive (weightedSum (constituents c)) (completeMass c.first c.rest)

def momenta {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) := (constituents c).map Constituent.momentum

def weightedCells {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) := (constituents c).map (fun p => (p,weighted p))

theorem exactWeightedPart {Part Support State ClockState : Type}
    (p : Constituent Part Support State ClockState) :
    weighted p = .positive (MechanicalAcceleration.scalarOrientation p.separation.held)
      (SFT.Mathematics.ExactRatioRelations.compose p.momentum.content p.separation.separation) := by
  have forwardProduct (o : Orientation) : productOrientation .forward o = o := by cases o <;> rfl
  change Scalar.positive (productOrientation .forward (MechanicalAcceleration.scalarOrientation p.separation.held)) (SFT.Mathematics.ExactRatioRelations.compose p.momentum.content p.separation.separation) = _
  rw [forwardProduct]

theorem eachWeightExact {Part Support State ClockState : Type}
    (p : Constituent Part Support State ClockState) :
    (p.momentum.content.numerator * p.separation.separation.numerator) *
      (SFT.Mathematics.ExactRatioRelations.compose p.momentum.content p.separation.separation).denominator =
      (SFT.Mathematics.ExactRatioRelations.compose p.momentum.content p.separation.separation).numerator *
        (p.momentum.content.denominator * p.separation.separation.denominator) :=
  SFT.Mathematics.ExactRatioRelations.composeValue _ _

theorem massSuccessorExact {Part Support State ClockState : Type}
    (p q : Constituent Part Support State ClockState) (rest : List (Constituent Part Support State ClockState)) :
    (leftCross p.momentum.content (completeMass q rest) + rightCross p.momentum.content (completeMass q rest)) *
      (completeMass p (q :: rest)).denominator =
    (completeMass p (q :: rest)).numerator * denominator p.momentum.content (completeMass q rest) :=
  sumExact _ _

theorem completeInertialSupportPositive {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) : 0 < (completeMass c.first c.rest).numerator :=
  (completeMass c.first c.rest).positive

theorem retainsEveryConstituent {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) :
    (weightedCells c).map Prod.fst = constituents c := by
  have aux (ps : List (Constituent Part Support State ClockState)) :
      (ps.map (fun p => (p,weighted p))).map Prod.fst = ps := by
    induction ps with
    | nil => rfl
    | cons p ps ih => exact congrArg (List.cons p) ih
  exact aux _

theorem momentumCount {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) : (momenta c).length = (constituents c).length :=
  by
  have lengthMap (ps : List (Constituent Part Support State ClockState)) :
      (ps.map Constituent.momentum).length = ps.length := by
    induction ps with
    | nil => rfl
    | cons p ps ih => exact congrArg Nat.succ ih
  exact lengthMap _

theorem centreExact {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) (o : Orientation) (x : PositiveFraction)
    (h : weightedSum (constituents c) = .positive o x) :
    centre c = .positive o (quotientMagnitude x (completeMass c.first c.rest)) ∧
      (x.numerator * (completeMass c.first c.rest).denominator) *
        (quotientMagnitude x (completeMass c.first c.rest)).denominator =
      (quotientMagnitude x (completeMass c.first c.rest)).numerator *
        (x.denominator * (completeMass c.first c.rest).numerator) := by
  constructor
  · unfold centre
    rw [h]
    rfl
  · exact quotientExact _ _

theorem emptyWeightedSupport {Part Support State ClockState : Type}
    (c : Composite Part Support State ClockState) (h : weightedSum (constituents c) = .emptyOne) :
    centre c = .emptyOne := by unfold centre; rw [h]; rfl

-- Grouping never removes, duplicates or reorders a constituent.
inductive Group (Carrier : Type) where
  | one : Carrier → Group Carrier
  | junction : Group Carrier → Group Carrier → Group Carrier

def leaves {Carrier : Type} : Group Carrier → List Carrier
  | .one p => [p]
  | .junction a b => leaves a ++ leaves b

def leading {Carrier : Type} : Group Carrier → Carrier
  | .one p => p
  | .junction a _ => leading a

def remainder {Carrier : Type} : Group Carrier → List Carrier
  | .one _ => []
  | .junction a b => remainder a ++ leaves b

theorem allLeaves {Carrier : Type} (g : Group Carrier) : leading g :: remainder g = leaves g := by
  induction g with
  | one => rfl
  | junction a b ih _ =>
    change (leading a :: remainder a) ++ leaves b = leaves a ++ leaves b
    rw [ih]

def assemble {Part Support State ClockState : Type}
    (g : Group (Constituent Part Support State ClockState)) : Composite Part Support State ClockState :=
  ⟨leading g,remainder g⟩

theorem exactAssembly {Part Support State ClockState : Type}
    (g : Group (Constituent Part Support State ClockState)) : constituents (assemble g) = leaves g := allLeaves g

theorem sameCompleteSupport {Part Support State ClockState : Type}
    (a b : Composite Part Support State ClockState) (h : constituents a = constituents b) : a = b := by
  cases a with
  | mk p ps =>
    cases b with
    | mk q qs =>
      have equal := List.cons.inj h
      cases equal.1
      cases equal.2
      rfl

theorem regroupingRetainsCompleteCarrier {Part Support State ClockState : Type}
    (a b c : Group (Constituent Part Support State ClockState)) :
    assemble (.junction (.junction a b) c) = assemble (.junction a (.junction b c)) := by
  apply sameCompleteSupport
  rw [exactAssembly,exactAssembly]
  exact MechanicalAngularMotion.appendAssociative _ _ _

theorem regroupingCentre {Part Support State ClockState : Type}
    (a b c : Group (Constituent Part Support State ClockState)) :
    centre (assemble (.junction (.junction a b) c)) = centre (assemble (.junction a (.junction b c))) :=
  congrArg centre (regroupingRetainsCompleteCarrier a b c)

theorem regroupingMomentum {Part Support State ClockState : Type}
    (a b c : Group (Constituent Part Support State ClockState)) :
    momenta (assemble (.junction (.junction a b) c)) = momenta (assemble (.junction a (.junction b c))) :=
  congrArg momenta (regroupingRetainsCompleteCarrier a b c)

end SFT.Physics.MechanicalCompositeCentre
