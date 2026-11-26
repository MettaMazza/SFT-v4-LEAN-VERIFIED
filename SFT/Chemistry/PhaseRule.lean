import SFT.Chemistry.InternalEnergyComposition
namespace SFT.Chemistry.PhaseRule
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- phase_rule_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure PhaseRuleAccount where
 components : List HeldLabel
 phases : List HeldLabel
 environmentCoordinates : List HeldLabel

def labels (inputs : List LabelInput) (family message : String) : Except String (List HeldLabel) :=
 inputs.mapM fun input => match input with
 | .held value => if Text.equal value.family family then .ok value else .error message
 | .other => .error message

def makeAccount (components phases environment : List LabelInput) : Except String PhaseRuleAccount := do
 if components.isEmpty then throw "phase-rule account requires positive held component support"
 let components ← labels components "chemical-component" "phase-rule account requires positive held component support"
 if phases.isEmpty then throw "phase-rule account requires positive held phase support"
 let phases ← labels phases "chemical-phase" "phase-rule account requires positive held phase support"
 if !distinctAtoms components || !distinctAtoms phases then throw "phase-rule component or phase identity was duplicated"
 if environment.length != 2 then throw "phase rule requires the two held environmental coordinates"
 let environment ← labels environment "phase-environment-coordinate" "phase rule requires the two held environmental coordinates"
 if !distinctAtoms environment then throw "phase-rule environmental coordinates must remain distinct"
 pure ⟨components,phases,environment⟩

inductive AccountInput where
 | account (value : PhaseRuleAccount)
 | other
inductive IndependentDegreeSupport where
 | emptyOne
 | positive (carriers : List HeldLabel) (count : PositiveCount)
-- The source pops the final available carrier for each phase, retaining order.
def cancelCarriers : List HeldLabel → List HeldLabel → Except String (List HeldLabel)
 | available, [] => .ok available
 | [], _::_ => .error "phase support exceeds the complete coordinate carriers"
 | first::rest, _::phases => cancelCarriers ((first::rest).reverse.tail.reverse) phases

def independentDegreeSupport (input : AccountInput) : Except String IndependentDegreeSupport := do
 let account ← match input with
 | .account a => pure a
 | .other => throw "phase-rule cancellation requires a complete account"
 let remaining ← cancelCarriers (account.components ++ account.environmentCoordinates) account.phases
 match remaining with
 | [] => pure .emptyOne
 | first::rest => pure (.positive (first::rest) ⟨rest.length+1,Nat.zero_lt_succ _⟩)

def componentLabel (n : Nat) := heldLabel "chemical-component" (Text.append "component-" (toString n))
def phaseLabel (n : Nat) := heldLabel "chemical-phase" (Text.append "phase-" (toString n))
def environment : List HeldLabel := [⟨"phase-environment-coordinate","temperature",rfl,rfl⟩,⟨"phase-environment-coordinate","pressure",rfl,rfl⟩]

def hostAccount (components phases : Int) : Except String PhaseRuleAccount := do
 if @decide (components < 1) (Int.decLt components 1) || @decide (phases < 1) (Int.decLt phases 1) then throw "host witness counts must be positive"
 let cs ← (List.range components.toNat).mapM fun i => componentLabel (i+1)
 let ps ← (List.range phases.toNat).mapM fun i => phaseLabel (i+1)
 makeAccount (cs.map MolecularFormationEnergy.LabelInput.held) (ps.map MolecularFormationEnergy.LabelInput.held) (environment.map MolecularFormationEnergy.LabelInput.held)

def jointComponentPhaseSuccessorPreservesDegreeSupport (account : PhaseRuleAccount) : Except String Bool := do
 let prior ← independentDegreeSupport (.account account)
 let c ← componentLabel (account.components.length+1)
 let p ← phaseLabel (account.phases.length+1)
 let successor ← makeAccount ((account.components ++ [c]).map MolecularFormationEnergy.LabelInput.held)
  ((account.phases ++ [p]).map MolecularFormationEnergy.LabelInput.held)
  (account.environmentCoordinates.map MolecularFormationEnergy.LabelInput.held)
 let after ← independentDegreeSupport (.account successor)
 pure (match prior,after with
  | .emptyOne,.emptyOne => true
  | .positive _ n,.positive _ m => n.value==m.value
  | .emptyOne,.positive _ _ | .positive _ _,.emptyOne => false)

def countWitness (components phases expected : Int) : Except String Bool := do
 let account ← hostAccount components phases
 let result ← independentDegreeSupport (.account account)
 pure (match result with | .emptyOne => @decide (expected=0) (Int.decEq expected 0) | .positive _ count => @decide (Int.ofNat count.value=expected) (Int.decEq (Int.ofNat count.value) expected))
def onePhaseWitness := countWitness 1 1 2
def twoPhaseWitness := countWitness 1 2 1
def threePhaseWitness := countWitness 1 3 0
def successorWitness : Except String Bool := do
 let account ← hostAccount 2 2
 jointComponentPhaseSuccessorPreservesDegreeSupport account

theorem oneComponentOnePhase : onePhaseWitness=.ok true := rfl
theorem oneComponentTwoPhases : twoPhaseWitness=.ok true := rfl
theorem completeCancellation : threePhaseWitness=.ok true := rfl
theorem jointSuccessor : successorWitness=.ok true := rfl
end SFT.Chemistry.PhaseRule
