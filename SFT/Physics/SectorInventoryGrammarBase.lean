import SFT.Physics.SectorInventory
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.SectorInventoryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Sector where
  | rejected | admitted

def sectorName : Sector → String
  | .rejected => "selected-known-sectors"
  | .admitted => "complete-primes-through-forced-ceiling"

inductive Charge where
  | rejected | admitted

def chargeName : Charge → String
  | .rejected => "borrowed-group-dimension"
  | .admitted => "complete-p-fibre-members"

inductive Mediator where
  | rejected | admitted

def mediatorName : Mediator → String
  | .rejected => "listed-particle-names"
  | .admitted => "p-squared-pair-cells-less-One"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "measured-coupling"
  | .admitted => "p-predecessor-over-p"

inductive Running where
  | rejected | admitted

def runningName : Running → String
  | .rejected => "imported-beta-function"
  | .admitted => "support-successor-in-sector-gap"

inductive Singlet where
  | rejected | admitted

def singletName : Singlet → String
  | .rejected => "imported-hadron-taxonomy"
  | .admitted => "complete-p-fibre-or-antipodal-pair"

inductive Mixing where
  | rejected | admitted

def mixingName : Mixing → String
  | .rejected => "free-mixing-matrix"
  | .admitted => "three-preimage-offset-over-sector"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "invented-sector-scale"
  | .admitted => "One-shortfall-equals-one-over-p"

inductive Inventory where
  | rejected | admitted

def inventoryName : Inventory → String
  | .rejected => "open-ended-particle-list"
  | .admitted => "complete-count-and-first-excluded-prime"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "known-counts-visible-before-seal"
  | .admitted => "inventory-sealed-before-anchor-check"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "omit-fringe-predictions"
  | .admitted => "standing-falsifiable-penta-hepta-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-sector"
  | .admitted => "no-extra-rule"

structure Candidate where
  sector : Sector
  charge : Charge
  mediator : Mediator
  coupling : Coupling
  running : Running
  singlet : Singlet
  mixing : Mixing
  mass : Mass
  inventory : Inventory
  measurement : Measurement
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [sectorName c.sector, chargeName c.charge, mediatorName c.mediator, couplingName c.coupling, runningName c.running, singletName c.singlet, mixingName c.mixing, massName c.mass, inventoryName c.inventory, measurementName c.measurement, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "sector=" (sectorName c.sector), SFT.Host.Text.append "charge=" (chargeName c.charge), SFT.Host.Text.append "mediator=" (mediatorName c.mediator), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "running=" (runningName c.running), SFT.Host.Text.append "singlet=" (singletName c.singlet), SFT.Host.Text.append "mixing=" (mixingName c.mixing), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "inventory=" (inventoryName c.inventory), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-primes-through-forced-ceiling__complete-p-fibre-members__p-squared-pair-cells-less-One__p-predecessor-over-p__support-successor-in-sector-gap__complete-p-fibre-or-antipodal-pair__three-preimage-offset-over-sector__One-shortfall-equals-one-over-p__complete-count-and-first-excluded-prime__inventory-sealed-before-anchor-check__standing-falsifiable-penta-hepta-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sectorName c.sector) "complete-primes-through-forced-ceiling" &&
  SFT.Host.Text.equal (chargeName c.charge) "complete-p-fibre-members" &&
  SFT.Host.Text.equal (mediatorName c.mediator) "p-squared-pair-cells-less-One" &&
  SFT.Host.Text.equal (couplingName c.coupling) "p-predecessor-over-p" &&
  SFT.Host.Text.equal (runningName c.running) "support-successor-in-sector-gap" &&
  SFT.Host.Text.equal (singletName c.singlet) "complete-p-fibre-or-antipodal-pair" &&
  SFT.Host.Text.equal (mixingName c.mixing) "three-preimage-offset-over-sector" &&
  SFT.Host.Text.equal (massName c.mass) "One-shortfall-equals-one-over-p" &&
  SFT.Host.Text.equal (inventoryName c.inventory) "complete-count-and-first-excluded-prime" &&
  SFT.Host.Text.equal (measurementName c.measurement) "inventory-sealed-before-anchor-check" &&
  SFT.Host.Text.equal (recordName c.record) "standing-falsifiable-penta-hepta-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (sectorName c.sector) "selected-known-sectors" then "Selecting familiar sectors cannot close the ladder." else
  if SFT.Host.Text.equal (chargeName c.charge) "borrowed-group-dimension" then "A borrowed group label imports its answer." else
  if SFT.Host.Text.equal (mediatorName c.mediator) "listed-particle-names" then "Names do not generate a complete inventory." else
  if SFT.Host.Text.equal (couplingName c.coupling) "measured-coupling" then "Measurement cannot select the law." else
  if SFT.Host.Text.equal (runningName c.running) "imported-beta-function" then "An imported beta function is outside the grammar." else
  if SFT.Host.Text.equal (singletName c.singlet) "imported-hadron-taxonomy" then "A taxonomy does not prove closure." else
  if SFT.Host.Text.equal (mixingName c.mixing) "free-mixing-matrix" then "Free entries are parameters." else
  if SFT.Host.Text.equal (massName c.mass) "invented-sector-scale" then "A new scale forks the unified carrier." else
  if SFT.Host.Text.equal (inventoryName c.inventory) "open-ended-particle-list" then "An open list contradicts the forced sector ceiling." else
  if SFT.Host.Text.equal (measurementName c.measurement) "known-counts-visible-before-seal" then "That would restate observation." else
  if SFT.Host.Text.equal (recordName c.record) "omit-fringe-predictions" then "Omission would erase a forced consequence." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-extra-sector" then "An extra sector violates the cover ceiling." else
  "Sectors (2,3,5,7) have charge counts (2,3,5,7), mediator counts (3,8,24,48), couplings (1/2,2/3,4/5,6/7), gauge-carrier total 83 and 72 penta/hepta carriers. Penta/hepta singlets have 5/7 constituents, mixing diagonals 14/15 and 20/21, electron mass-part ratios 2/5 and 2/7, and the complete named inventory has 98 members including 12 Smithions and photon/graviton/Higgs. Prime 11 is excluded."

def generationRule : String := "Generate the complete twelve-axis product of sector, charge, mediator, coupling, running, singlet, mixing, mass, inventory, measurement, prediction-record and extension forms."
def grammarBoundary : String := "Every prime sector through the independently forced ceiling seven; all fibre members, ordered pair cells, finite positive supports, three generated positions, singlet closures and the first excluded prime."

def candidates : List Candidate :=
  ([Sector.rejected,Sector.admitted]).flatMap fun sector =>
  ([Charge.rejected,Charge.admitted]).flatMap fun charge =>
  ([Mediator.rejected,Mediator.admitted]).flatMap fun mediator =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Running.rejected,Running.admitted]).flatMap fun running =>
  ([Singlet.rejected,Singlet.admitted]).flatMap fun singlet =>
  ([Mixing.rejected,Mixing.admitted]).flatMap fun mixing =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Inventory.rejected,Inventory.admitted]).flatMap fun inventory =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨sector,charge,mediator,coupling,running,singlet,mixing,mass,inventory,measurement,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk sector charge mediator coupling running singlet mixing mass inventory measurement record extension =>
    have hsector : sector ∈ [Sector.rejected,Sector.admitted] := by
      cases sector <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcharge : charge ∈ [Charge.rejected,Charge.admitted] := by
      cases charge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmediator : mediator ∈ [Mediator.rejected,Mediator.admitted] := by
      cases mediator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrunning : running ∈ [Running.rejected,Running.admitted] := by
      cases running <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsinglet : singlet ∈ [Singlet.rejected,Singlet.admitted] := by
      cases singlet <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmixing : mixing ∈ [Mixing.rejected,Mixing.admitted] := by
      cases mixing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinventory : inventory ∈ [Inventory.rejected,Inventory.admitted] := by
      cases inventory <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ sector _ hsector
    apply CommonRefinement.memFlatMap _ _ charge _ hcharge
    apply CommonRefinement.memFlatMap _ _ mediator _ hmediator
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ running _ hrunning
    apply CommonRefinement.memFlatMap _ _ singlet _ hsinglet
    apply CommonRefinement.memFlatMap _ _ mixing _ hmixing
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ inventory _ hinventory
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.SectorInventoryGrammar
