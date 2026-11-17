import SFT.Chemistry.MulticentreSupport
namespace SFT.Chemistry.NuclearElectronic
open SFT.Host SFT.Physics.CapabilityValues
open MulticentreSupport (sameLabel distinct)
structure Support where
 molecularCarrier : HeldLabel
 nuclearOccurrences : List HeldLabel
 isotopeLabels : List HeldLabel
 electronicSupport : HeldLabel
 electronicState : HeldLabel
 record : HeldLabel

def construct (s : Support) : Except String Support := do
 if !Text.equal s.molecularCarrier.family "molecular-carrier" then
  throw "joint support requires one molecular carrier"
 if s.nuclearOccurrences.isEmpty || !distinct s.nuclearOccurrences then
  throw "nuclear occurrences must be positive and distinct"
 if !(s.nuclearOccurrences.all fun x => Text.equal x.family "nuclear-occurrence") then
  throw "nuclear occurrence labels have the wrong family"
 if s.isotopeLabels.length != s.nuclearOccurrences.length || !(s.isotopeLabels.all fun x => Text.equal x.family "molecular-isotope") then
  throw "every nuclear occurrence retains one isotope label"
 if !Text.equal s.electronicSupport.family "molecular-electronic-support" || !Text.equal s.electronicState.family "molecular-electronic-state" then
  throw "electronic support and state must both be retained"
 if !Text.equal s.record.family "nuclear-electronic-record" then
  throw "joint support requires a retained observation record"
 pure s

def nuclearKey (s : Support) : List String := s.isotopeLabels.map HeldLabel.label
def electronicKey (s : Support) : String × String := (s.electronicSupport.label,s.electronicState.label)
def equalElectronic (a b : Support) : Bool :=
 Text.equal a.electronicSupport.label b.electronicSupport.label && Text.equal a.electronicState.label b.electronicState.label

def equalNuclear : List String → List String → Bool
 | [],bs => match bs with | [] => true | _::_ => false
 | a::as,bs => match bs with | [] => false | b::bs => Text.equal a b && equalNuclear as bs

def isotopologues (left right : Support) : Except String Bool :=
 if !sameLabel left.molecularCarrier right.molecularCarrier then
  .error "isotopologue comparison requires one molecular carrier class"
 else .ok (equalElectronic left right && !equalNuclear (nuclearKey left) (nuclearKey right))

def state (isotopes : List String) (record : String) : Except String Support := do
 let labels ← isotopes.mapM (heldLabel "molecular-isotope")
 construct ⟨← heldLabel "molecular-carrier" "hydrogen-diatomic",
  [← heldLabel "nuclear-occurrence" "left",← heldLabel "nuclear-occurrence" "right"],labels,
  ← heldLabel "molecular-electronic-support" "one-sigma-g-two",
  ← heldLabel "molecular-electronic-state" "X-singlet-sigma-g",
  ← heldLabel "nuclear-electronic-record" record⟩
def threeSupportsWitness : Bool := match (do
 let h ← state ["protium","protium"] "H2"
 let hd ← state ["protium","deuterium"] "HD"
 let d ← state ["deuterium","deuterium"] "D2"
 pure (!equalNuclear (nuclearKey h) (nuclearKey hd) && !equalNuclear (nuclearKey hd) (nuclearKey d) && !equalNuclear (nuclearKey h) (nuclearKey d))) with
 | .error _ => false
 | .ok b => b
def equalElectronicWitness : Bool := match (do
 let h ← state ["protium","protium"] "H2"
 let hd ← state ["protium","deuterium"] "HD"
 let d ← state ["deuterium","deuterium"] "D2"
 let a ← isotopologues h hd
 let b ← isotopologues hd d
 pure (a && b)) with
 | .error _ => false
 | .ok b => b
def incompleteWitness : Bool := match state ["protium"] "incomplete" with
 | .error _ => true
 | .ok _ => false

theorem threeSupportsWitnessPassed : threeSupportsWitness = true := rfl
theorem equalElectronicWitnessPassed : equalElectronicWitness = true := rfl
theorem incompleteWitnessPassed : incompleteWitness = true := rfl

-- The batch's finite-product successor extends only the nuclear factor.
def successor (s : Support) (occurrence isotope : HeldLabel) : Support :=
 ⟨s.molecularCarrier,s.nuclearOccurrences++[occurrence],s.isotopeLabels++[isotope],s.electronicSupport,s.electronicState,s.record⟩
theorem successorElectronicFactor (s : Support) (o i : HeldLabel) :
 electronicKey (successor s o i) = electronicKey s := rfl
theorem successorCarrierRecord (s : Support) (o i : HeldLabel) :
 (successor s o i).molecularCarrier = s.molecularCarrier ∧ (successor s o i).record = s.record := ⟨rfl,rfl⟩
theorem successorPreservesOccurrences (s : Support) (o i : HeldLabel) :
 (successor s o i).nuclearOccurrences.take s.nuclearOccurrences.length = s.nuclearOccurrences := by
 change (s.nuclearOccurrences++[o]).take s.nuclearOccurrences.length = _
 induction s.nuclearOccurrences with
 | nil => rfl
 | cons a rest ih => exact congrArg (List.cons a) ih

theorem successorPreservesIsotopes (s : Support) (o i : HeldLabel) :
 (successor s o i).isotopeLabels.take s.isotopeLabels.length = s.isotopeLabels := by
 change (s.isotopeLabels++[i]).take s.isotopeLabels.length = _
 induction s.isotopeLabels with
 | nil => rfl
 | cons a rest ih => exact congrArg (List.cons a) ih

theorem acceptedRetainsAll (s out : Support) (accepted : construct s = .ok out) : out = s := by
 unfold construct at accepted
 cases h0 : (!Text.equal s.molecularCarrier.family "molecular-carrier") with
 | true =>
   rw [h0] at accepted
   exact (congrArg (fun (x : Except String Support) => match x with | .error _ => s | .ok v => v) accepted).symm
 | false =>
   rw [h0] at accepted
   cases h1 : (s.nuclearOccurrences.isEmpty || !distinct s.nuclearOccurrences) with
   | true =>
     rw [h1] at accepted
     exact (congrArg (fun (x : Except String Support) => match x with | .error _ => s | .ok v => v) accepted).symm
   | false =>
     rw [h1] at accepted
     cases h2 : (!(s.nuclearOccurrences.all fun x => Text.equal x.family "nuclear-occurrence")) with
     | true =>
       rw [h2] at accepted
       exact (congrArg (fun (x : Except String Support) => match x with | .error _ => s | .ok v => v) accepted).symm
     | false =>
       rw [h2] at accepted
       cases h3 : (s.isotopeLabels.length != s.nuclearOccurrences.length || !(s.isotopeLabels.all fun x => Text.equal x.family "molecular-isotope")) with
       | true =>
         rw [h3] at accepted
         exact (congrArg (fun (x : Except String Support) => match x with | .error _ => s | .ok v => v) accepted).symm
       | false =>
         rw [h3] at accepted
         cases h4 : (!Text.equal s.electronicSupport.family "molecular-electronic-support" || !Text.equal s.electronicState.family "molecular-electronic-state") with
         | true =>
           rw [h4] at accepted
           exact (congrArg (fun (x : Except String Support) => match x with | .error _ => s | .ok v => v) accepted).symm
         | false =>
           rw [h4] at accepted
           cases h5 : (!Text.equal s.record.family "nuclear-electronic-record") with
           | true =>
             rw [h5] at accepted
             exact (congrArg (fun (x : Except String Support) => match x with | .error _ => s | .ok v => v) accepted).symm
           | false =>
             rw [h5] at accepted
             exact (congrArg (fun (x : Except String Support) => match x with | .error _ => s | .ok v => v) accepted).symm
end SFT.Chemistry.NuclearElectronic
