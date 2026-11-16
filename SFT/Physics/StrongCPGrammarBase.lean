import SFT.Physics.StrongCPCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.StrongCPGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "rewrite-or-bypass-predecessors"
  | .admitted => "compose-immutable-predecessors"

inductive Cp where
  | rejected | admitted

def cpName : Cp → String
  | .rejected => "continuum-angle-or-fitted-small-value"
  | .admitted => "aligned-One-or-self-antipodal-half-One"

inductive Hand where
  | rejected | admitted

def handName : Hand → String
  | .rejected => "selected-single-hand"
  | .admitted => "complete-two-hand-support"

inductive Strong where
  | rejected | admitted

def strongName : Strong → String
  | .rejected => "weak-antipode-reused-for-strong"
  | .admitted => "paired-parity-returns-aligned-One"

inductive Compensator where
  | rejected | admitted

def compensatorName : Compensator → String
  | .rejected => "add-axion-or-free-compensator"
  | .admitted => "empty-One-no-extra-compensator"

inductive Sector where
  | rejected | admitted

def sectorName : Sector → String
  | .rejected => "invent-cross-fibre-mediator"
  | .admitted => "all-generated-actions-are-fibre-preserving"

inductive Baryon where
  | rejected | admitted

def baryonName : Baryon → String
  | .rejected => "untyped-particle-name"
  | .admitted => "three-one-third-parts-close-to-One"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "assume-an-unregistered-decay-step"
  | .admitted => "finite-composition-preserves-the-fibre"

inductive Baryogenesis where
  | rejected | admitted

def baryogenesisName : Baryogenesis → String
  | .rejected => "conflate-distinct-process-grammars"
  | .admitted => "retain-explicit-cosmological-boundary"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-readable-before-seal"
  | .admitted => "targets-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-angle-carrier-or-operation"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  cp : Cp
  hand : Hand
  strong : Strong
  compensator : Compensator
  sector : Sector
  baryon : Baryon
  transition : Transition
  baryogenesis : Baryogenesis
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, cpName c.cp, handName c.hand, strongName c.strong, compensatorName c.compensator, sectorName c.sector, baryonName c.baryon, transitionName c.transition, baryogenesisName c.baryogenesis, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "cp=" (cpName c.cp), SFT.Host.Text.append "hand=" (handName c.hand), SFT.Host.Text.append "strong=" (strongName c.strong), SFT.Host.Text.append "compensator=" (compensatorName c.compensator), SFT.Host.Text.append "sector=" (sectorName c.sector), SFT.Host.Text.append "baryon=" (baryonName c.baryon), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "baryogenesis=" (baryogenesisName c.baryogenesis), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "compose-immutable-predecessors__aligned-One-or-self-antipodal-half-One__complete-two-hand-support__paired-parity-returns-aligned-One__empty-One-no-extra-compensator__all-generated-actions-are-fibre-preserving__three-one-third-parts-close-to-One__finite-composition-preserves-the-fibre__retain-explicit-cosmological-boundary__targets-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-predecessors" &&
  SFT.Host.Text.equal (cpName c.cp) "aligned-One-or-self-antipodal-half-One" &&
  SFT.Host.Text.equal (handName c.hand) "complete-two-hand-support" &&
  SFT.Host.Text.equal (strongName c.strong) "paired-parity-returns-aligned-One" &&
  SFT.Host.Text.equal (compensatorName c.compensator) "empty-One-no-extra-compensator" &&
  SFT.Host.Text.equal (sectorName c.sector) "all-generated-actions-are-fibre-preserving" &&
  SFT.Host.Text.equal (baryonName c.baryon) "three-one-third-parts-close-to-One" &&
  SFT.Host.Text.equal (transitionName c.transition) "finite-composition-preserves-the-fibre" &&
  SFT.Host.Text.equal (baryogenesisName c.baryogenesis) "retain-explicit-cosmological-boundary" &&
  SFT.Host.Text.equal (measurementName c.measurement) "targets-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-predecessors") then "A successor cannot change an admitted receipt." else
  if !(SFT.Host.Text.equal (cpName c.cp) "aligned-One-or-self-antipodal-half-One") then "A continuum angle or small fitted value is inadmissible." else
  if !(SFT.Host.Text.equal (handName c.hand) "complete-two-hand-support") then "Selecting one hand omits half the colour-times-hand product." else
  if !(SFT.Host.Text.equal (strongName c.strong) "paired-parity-returns-aligned-One") then "A one-hand weak carrier contradicts complete strong support." else
  if !(SFT.Host.Text.equal (compensatorName c.compensator) "empty-One-no-extra-compensator") then "An extra carrier has no discrepancy to act on and forks the closed inventory." else
  if !(SFT.Host.Text.equal (sectorName c.sector) "all-generated-actions-are-fibre-preserving") then "A two-sector signature is absent from every complete sector action table." else
  if !(SFT.Host.Text.equal (baryonName c.baryon) "three-one-third-parts-close-to-One") then "A name alone does not establish conservation." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "finite-composition-preserves-the-fibre") then "An unregistered fibre crossing inserts the desired decay." else
  if !(SFT.Host.Text.equal (baryogenesisName c.baryogenesis) "retain-explicit-cosmological-boundary") then "A cosmological tally-changing premise is not a low-energy mediator." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "targets-inaccessible-until-seal") then "That would tune alignment or stability to observation." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "Any such addition is an unforced parameter." else
  "Strong-sector CP is the aligned One; the strong-violation, electric-dipole and added-compensator records are empty-One. The weak one-hand phase remains the self-antipodal half-One. All 83 generated mediators are fibre-preserving; all 202 ordered cross-fibre label pairs and all six colour-to-binary pairs lack a generated carrier. The proton carries baryon One = 3*(1/3), all 27 generated colour-three images retain it, and every finite composition remains in the colour fibre. Proton decay is absent within the complete declared grammar."

def generationRule : String := "Generate the complete product of immutable predecessor, CP carrier, handed support, strong-sector product, compensator, sector-action typing, baryon tally, finite transition, baryogenesis boundary, measurement custody and extension forms."
def grammarBoundary : String := "All nonempty subsets of the exact two-hand fibre; complete colour-three times hand support; every mediator cell in prime sectors two, three, five and seven; every ordered cross-fibre label pair; every colour-three word; and every finite composition of the generated typed actions."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Cp.rejected,Cp.admitted]).flatMap fun cp =>
  ([Hand.rejected,Hand.admitted]).flatMap fun hand =>
  ([Strong.rejected,Strong.admitted]).flatMap fun strong =>
  ([Compensator.rejected,Compensator.admitted]).flatMap fun compensator =>
  ([Sector.rejected,Sector.admitted]).flatMap fun sector =>
  ([Baryon.rejected,Baryon.admitted]).flatMap fun baryon =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Baryogenesis.rejected,Baryogenesis.admitted]).flatMap fun baryogenesis =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,cp,hand,strong,compensator,sector,baryon,transition,baryogenesis,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor cp hand strong compensator sector baryon transition baryogenesis measurement extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcp : cp ∈ [Cp.rejected,Cp.admitted] := by
      cases cp <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hhand : hand ∈ [Hand.rejected,Hand.admitted] := by
      cases hand <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstrong : strong ∈ [Strong.rejected,Strong.admitted] := by
      cases strong <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcompensator : compensator ∈ [Compensator.rejected,Compensator.admitted] := by
      cases compensator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsector : sector ∈ [Sector.rejected,Sector.admitted] := by
      cases sector <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbaryon : baryon ∈ [Baryon.rejected,Baryon.admitted] := by
      cases baryon <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbaryogenesis : baryogenesis ∈ [Baryogenesis.rejected,Baryogenesis.admitted] := by
      cases baryogenesis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ cp _ hcp
    apply CommonRefinement.memFlatMap _ _ hand _ hhand
    apply CommonRefinement.memFlatMap _ _ strong _ hstrong
    apply CommonRefinement.memFlatMap _ _ compensator _ hcompensator
    apply CommonRefinement.memFlatMap _ _ sector _ hsector
    apply CommonRefinement.memFlatMap _ _ baryon _ hbaryon
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ baryogenesis _ hbaryogenesis
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.StrongCPGrammar
