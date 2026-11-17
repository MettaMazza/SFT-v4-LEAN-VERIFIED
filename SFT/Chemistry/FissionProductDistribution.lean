import SFT.Chemistry.IsotopeExchange
namespace SFT.Chemistry.FissionProductDistribution
open SFT.Host SFT.Physics.CapabilityValues
structure Row where
 nuclide : HeldLabel
 chemicalSpecies : HeldLabel
 phase : HeldLabel
 location : HeldLabel
 events : PositiveCount

def construct (n s p l : HeldLabel) (events : PositiveCount) : Except String Row := do
 if !(Text.equal n.family "fission-product" && Text.equal s.family "chemical-species" && Text.equal p.family "chemical-phase" && Text.equal l.family "location") then
  throw "complete fission-product chemical row required"
 return ⟨n,s,p,l,events⟩
def normalized (n d : Nat) : Nat × Nat := let g := Nat.gcd n d; (n/g,d/g)
def total (rows : List Row) : Nat := rows.foldl (fun n r => n+r.events.value) 0
abbrev Reading := HeldLabel × HeldLabel × HeldLabel × HeldLabel × (Nat × Nat)
inductive Distribution where
 | emptyOne
 | rows (values : List Reading)
def chemicalDistribution (rows : List Row) : Distribution :=
 if rows.isEmpty then .emptyOne else
 .rows (rows.map fun r => (r.nuclide,r.chemicalSpecies,r.phase,r.location,normalized r.events.value (total rows)))
def sameNuclides (before after : List Row) : Bool :=
 before.all (fun r => after.any (fun s => IsotopeExchange.sameLabel r.nuclide s.nuclide)) &&
 after.all (fun s => before.any (fun r => IsotopeExchange.sameLabel r.nuclide s.nuclide))
def redistribute (before after : List Row) : Except String Distribution := do
 if !sameNuclides before after || total before != total after then
  throw "fission-product identity or event total changed without explicit physics handoff"
 return chemicalDistribution after

def row (nuclide species phase location : String) (events : Nat) : Except String Row := do
 construct (← heldLabel "fission-product" nuclide) (← heldLabel "chemical-species" species) (← heldLabel "chemical-phase" phase) (← heldLabel "location" location) (← count events)
def before : Except String (List Row) := do return [← row "Cs" "fluoride" "salt" "bulk" 3,← row "Xe" "elemental" "gas" "headspace" 1]
def after : Except String (List Row) := do return [← row "Cs" "fluoride" "salt" "wall" 2,← row "Xe" "elemental" "gas" "headspace" 2]
def handoffWitness : Bool := match before with
 | .error _ => false
 | .ok rs => (rs.all fun r => Text.equal r.nuclide.label "Cs" || Text.equal r.nuclide.label "Xe") &&
  rs.any (fun r => Text.equal r.nuclide.label "Cs") && rs.any (fun r => Text.equal r.nuclide.label "Xe")
def identityWitness : Bool := match before with
 | .error _ => false
 | .ok rs => match rs with
  | [] => false
  | r::_ => Text.equal r.chemicalSpecies.label "fluoride"
def supportWitness : Bool := match before with
 | .error _ => false
 | .ok rs => match rs with
  | [] => false
  | a::tail => match tail with
   | [] => false
   | b::_ => !(IsotopeExchange.sameLabel a.phase b.phase && IsotopeExchange.sameLabel a.location b.location)
def eventsWitness : Bool := match before with
 | .error _ => false
 | .ok rs => rs.all fun r => r.events.value > 0
def partitionWitness : Bool := match before with
 | .error _ => false
 | .ok rs => match chemicalDistribution rs with
  | .emptyOne => false
  | .rows values =>
   let sum := values.foldl (fun (a : Nat × Nat) r =>
    let b := r.2.2.2.2
    normalized (a.1*b.2+b.1*a.2) (a.2*b.2)) (0,1)
   sum == (1,1)
def chemistryWitness : Bool := match (do redistribute (← before) (← after)) with
 | .error _ => false
 | .ok .emptyOne => false
 | .ok (.rows rs) => match rs with
  | [] => false
  | r::_ => Text.equal r.2.2.2.1.label "wall"
def boundaryWitness : Bool := match before,after with
 | .ok a,.ok b => sameNuclides a b
 | .error _,.ok _ | .ok _,.error _ | .error _,.error _ => false
def extensionWitness : Bool := match (do redistribute (← before) (← after)) with
 | .error _ => false
 | .ok .emptyOne => false
 | .ok (.rows rs) => rs.length == 2
theorem handoffWitnessPassed : handoffWitness = true := rfl
theorem identityWitnessPassed : identityWitness = true := rfl
theorem supportWitnessPassed : supportWitness = true := rfl
theorem eventsWitnessPassed : eventsWitness = true := rfl
theorem partitionWitnessPassed : partitionWitness = true := rfl
theorem chemistryWitnessPassed : chemistryWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem extensionWitnessPassed : extensionWitness = true := rfl

theorem acceptedRedistributionExact (before after : List Row) (result : Distribution)
 (accepted : redistribute before after = .ok result) : result = chemicalDistribution after := by
 unfold redistribute at accepted
 cases guard0 : (!sameNuclides before after || total before != total after) with
 | true => rw [guard0] at accepted; cases accepted
 | false => rw [guard0] at accepted; exact (Except.ok.inj accepted).symm
end SFT.Chemistry.FissionProductDistribution
