import SFT.Chemistry.RedoxTransfer
import SFT.Physics.ThermoFirstLaw
namespace SFT.Chemistry.ElectrochemicalCell
open SFT.Foundation.Count.TraceDerivation
structure Raw where
 oxidationSite : String
 reductionSite : String
 electronPath : List String
 ionicPath : List String

def admit (r : Raw) : Except String Raw :=
 if !SourceText.nonblank r.oxidationSite || !SourceText.nonblank r.reductionSite ||
 decide (r.oxidationSite=r.reductionSite) || r.electronPath.length < 2 || r.ionicPath.length < 2 ||
 !(decide (r.electronPath.head?=some r.oxidationSite)) ||
 !(decide (r.electronPath.getLast?=some r.reductionSite)) then
 .error "electrochemical cell requires separated sites and complete electron/ionic paths"
 else .ok r
structure Cell where
 raw : Raw
 accepted : admit raw=.ok raw

def original : Raw := ⟨"oxidation-site","reduction-site",
 ["oxidation-site","wire","reduction-site"],["reduction-site","ionic-bridge","oxidation-site"]⟩
theorem originalAdmitted : admit original=.ok original := rfl

theorem acceptedElectronEnd (c : Cell) : c.raw.electronPath.getLast?=some c.raw.reductionSite := by
 by_cases endHeld : c.raw.electronPath.getLast?=some c.raw.reductionSite
 · exact endHeld
 · have h := c.accepted
   unfold admit at h
   rw [decide_eq_false endHeld] at h
   cases g : (!SourceText.nonblank c.raw.oxidationSite || !SourceText.nonblank c.raw.reductionSite || decide (c.raw.oxidationSite=c.raw.reductionSite) || decide (c.raw.electronPath.length < 2) || decide (c.raw.ionicPath.length < 2) || !(decide (c.raw.electronPath.head?=some c.raw.oxidationSite))) <;> rw [g] at h <;> cases h

theorem acceptedElectronStart (c : Cell) : c.raw.electronPath.head?=some c.raw.oxidationSite := by
 by_cases startHeld : c.raw.electronPath.head?=some c.raw.oxidationSite
 · exact startHeld
 · have h := c.accepted
   unfold admit at h
   rw [decide_eq_false startHeld] at h
   cases g : (!SourceText.nonblank c.raw.oxidationSite || !SourceText.nonblank c.raw.reductionSite || decide (c.raw.oxidationSite=c.raw.reductionSite) || decide (c.raw.electronPath.length < 2) || decide (c.raw.ionicPath.length < 2)) <;>
    cases e : decide (c.raw.electronPath.getLast?=some c.raw.reductionSite) <;> rw [g,e] at h <;> cases h

-- Every adjacent step carries the same retained occurrence. Ionic closure is
-- bound in the derivation; the raw Python constructor keeps its original guard.
def steps (carrier : RedoxTransfer.HeldLabel) : List String → List RedoxTransfer.Raw
 | [] => []
 | [_] => []
 | a::b::rest => ⟨carrier,a,b⟩::steps carrier (b::rest)

def vertices : List RedoxTransfer.Raw → List String
 | [] => []
 | r::rest => r.donor::(match rest with | [] => [r.acceptor] | _::_ => vertices rest)

theorem completePath (carrier : RedoxTransfer.HeldLabel) (a b : String) (rest : List String) :
 vertices (steps carrier (a::b::rest))=a::b::rest := by
 induction rest generalizing a b with
 | nil => rfl
 | cons c tail ih => exact congrArg (List.cons a) (ih b c)

theorem everyStepRetainsCarrier (carrier : RedoxTransfer.HeldLabel) (path : List String)
 (step : RedoxTransfer.Raw) (held : step ∈ steps carrier path) : step.electron=carrier := by
 induction path with
 | nil => cases held
 | cons a rest ih =>
   cases rest with
   | nil => cases held
   | cons b tail =>
     cases held with
     | head => rfl
     | tail _ later => exact ih later

theorem pathConservesCarrier (carrier : RedoxTransfer.HeldLabel) (path : List String)
 (test : RedoxTransfer.HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (RedoxTransfer.flows (steps carrier path)) =
 SFT.Physics.MatterConservedLabels.outputCount test (RedoxTransfer.flows (steps carrier path)) :=
 RedoxTransfer.pairedLossGain _ _

structure Cycle (Part Support State ClockState Clock : Type) where
 cell : Cell
 redox : RedoxTransfer.Transfer
 oxidationBinding : redox.raw.donor=cell.raw.oxidationSite
 reductionBinding : redox.raw.acceptor=cell.raw.reductionSite
 ionicCarrier : RedoxTransfer.HeldLabel
 ionicStart : cell.raw.ionicPath.head?=some cell.raw.reductionSite
 ionicEnd : cell.raw.ionicPath.getLast?=some cell.raw.oxidationSite
 work : SFT.Physics.MechanicalWorkEnergy.EnergyTransfer Part Support State ClockState Clock
 chemicalChanges : List (SFT.Physics.MechanicalEvents.Row (SFT.Physics.MechanicalMomentum.Momentum Part Support State ClockState))
 workBinding : SFT.Physics.MechanicalEvents.changes work.force.interval=chemicalChanges

variable {Part Support State ClockState Clock : Type}
def electronSteps (c : Cycle Part Support State ClockState Clock) := steps c.redox.raw.electron c.cell.raw.electronPath
def ionicSteps (c : Cycle Part Support State ClockState Clock) := steps c.ionicCarrier c.cell.raw.ionicPath

theorem cycleHasPairedRedox (c : Cycle Part Support State ClockState Clock) :
 RedoxTransfer.Closes c.redox.raw (RedoxTransfer.coupled c.redox.raw) := rfl

theorem compensationReturns (c : Cycle Part Support State ClockState Clock) :
 c.cell.raw.ionicPath.head?=some c.cell.raw.reductionSite ∧
 c.cell.raw.ionicPath.getLast?=some c.cell.raw.oxidationSite := ⟨c.ionicStart,c.ionicEnd⟩

def workChange (c : Cycle Part Support State ClockState Clock) :=
 SFT.Physics.MechanicalWorkEnergy.energyChange c.work

theorem sourceBoundedWork (c : Cycle Part Support State ClockState Clock) :
 workChange c=SFT.Physics.MechanicalWorkEnergy.value c.work := rfl

theorem allWorkRowsRetained (c : Cycle Part Support State ClockState Clock) :
 (SFT.Physics.MechanicalWorkEnergy.interactionCells c.work).map Prod.fst =
 SFT.Physics.MechanicalEvents.changes c.work.force.interval :=
 SFT.Physics.MechanicalWorkEnergy.retainsEveryTransferRow c.work

theorem workRetainsChemicalSource (c : Cycle Part Support State ClockState Clock)
 (row : SFT.Physics.MechanicalEvents.Row (SFT.Physics.MechanicalMomentum.Momentum Part Support State ClockState))
 (d : SFT.Physics.MechanicalLocation.Displacement Support)
 (held : (row,d) ∈ SFT.Physics.MechanicalWorkEnergy.interactionCells c.work) :
 row ∈ c.chemicalChanges := by
 rw [← c.workBinding]
 exact ((SFT.Physics.MechanicalWorkEnergy.interactionMembership _ _ _).mp held).1

def history (cycles : List (Cycle Part Support State ClockState Clock)) :=
 cycles.map fun c => (c.cell,c.redox,electronSteps c,ionicSteps c,c.work)

theorem sourceSitesRetained (c : Cycle Part Support State ClockState Clock) :
 c.redox.raw.donor=c.cell.raw.oxidationSite ∧ c.redox.raw.acceptor=c.cell.raw.reductionSite :=
 ⟨c.oxidationBinding,c.reductionBinding⟩

theorem successor (cycles : List (Cycle Part Support State ClockState Clock)) (next : Cycle Part Support State ClockState Clock) :
 history (cycles++[next])=history cycles++[(next.cell,next.redox,electronSteps next,ionicSteps next,next.work)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem originalElectronPath : vertices (steps RedoxTransfer.original.electron original.electronPath)=original.electronPath := rfl
end SFT.Chemistry.ElectrochemicalCell
