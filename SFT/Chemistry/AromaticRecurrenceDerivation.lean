import SFT.Chemistry.AromaticRecurrence
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AromaticRecurrenceDerivation
open SFT.Physics.CapabilityValues AromaticRecurrence

theorem retains (carrier : HeldLabel) (cycle : MulticentreSupport.Support) (boundary : List HeldLabel) (layers : List (List Cell)) (out : Recurrence)
 (h : recurrence carrier cycle boundary layers=.ok out) : out=⟨carrier,cycle,boundary,layers⟩ := by
 unfold recurrence at h
 repeat' first | split at h | cases h | rfl

theorem appendRetains (r out : Recurrence) (h : appendLayer r=.ok out) :
 out.carrier=r.carrier ∧ out.cycle=r.cycle ∧ out.boundary=r.boundary ∧ out.layers=r.layers++[completeCells] := by
 have kept := retains r.carrier r.cycle r.boundary (r.layers++[completeCells]) out h
 cases kept
 exact ⟨rfl,rfl,rfl,rfl⟩

theorem layerSumAppend (layers : List (List Cell)) :
 ((layers++[completeCells]).map List.length).sum=(layers.map List.length).sum+4 := by
 induction layers with
 | nil => rfl
 | cons layer layers ih =>
  change layer.length+((layers++[completeCells]).map List.length).sum=(layer.length+(layers.map List.length).sum)+4
  rw [ih,Nat.add_assoc]

theorem successorAddsFour (r out : Recurrence) (h : appendLayer r=.ok out) : supportSize out=supportSize r+4 := by
 have kept := retains r.carrier r.cycle r.boundary (r.layers++[completeCells]) out h
 cases kept
 unfold supportSize
 rw [layerSumAppend,Nat.add_assoc]

theorem replicateLayerSize (n : Nat) : ((List.replicate n completeCells).map List.length).sum=4*n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change 4+((List.replicate n completeCells).map List.length).sum=4*(n+1)
  rw [ih,Nat.mul_succ]
  exact Nat.add_comm 4 (4*n)

theorem generatedSupport (label : String) (centres : List String) (n : PositiveCount) (out : Recurrence)
 (h : aromaticRecurrence label centres n=.ok out) : supportSize out=2+4*n.value := by
 unfold aromaticRecurrence at h
 cases hc : MulticentreSupport.surfaceSupport label centres with
 | error e => rw [hc] at h; cases h
 | ok cycle =>
  rw [hc] at h
  have kept := retains cycle.molecularCarrier cycle [fibreOne,fibreTwo] (List.replicate n.value completeCells) out h
  cases kept
  unfold supportSize
  rw [replicateLayerSize]
  rfl

theorem firstReturn (r : Recurrence) (first : HeldLabel) (rest : List HeldLabel)
 (h : r.cycle.centres=first::rest) : firstReturnTrace r=.ok ((first::rest)++[first]) := by
 unfold firstReturnTrace
 rw [h]
 rfl

theorem traceLength (r : Recurrence) (trace : List HeldLabel) (h : firstReturnTrace r=.ok trace) : trace.length=r.cycle.centres.length+1 := by
 unfold firstReturnTrace at h
 cases hc : r.cycle.centres with
 | nil => rw [hc] at h; cases h
 | cons first rest =>
  rw [hc] at h
  cases h
  exact SFT.Foundation.CommonRefinement.appendLength (first::rest) [first]

theorem rotationsClosed (r : Recurrence) : perturbationClosure r=true := rfl

theorem openingOne (r : Recurrence) : closedPrecedes ⟨r,⟨"molecular-energy-state","closed-recurrence",rfl,rfl⟩,⟨"molecular-energy-state","opened-localized-reference",rfl,rfl⟩,⟨1,by decide⟩⟩=true := rfl
end SFT.Chemistry.AromaticRecurrenceDerivation
