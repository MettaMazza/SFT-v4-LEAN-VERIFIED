import SFT.Chemistry.AntiaromaticDistinction
namespace SFT.Chemistry.AntiaromaticDistinctionDerivation
open SFT.Physics.CapabilityValues AntiaromaticDistinction
open AromaticRecurrence (Cell)
theorem retains (carrier : HeldLabel) (cycle : MulticentreSupport.Support)
 (geometry supportState recurrenceClass : HeldLabel) (recurrenceSupport : RecurrenceSupport)
 (layers : List (List Cell)) (out : Alternative)
 (h : alternative carrier cycle geometry supportState recurrenceClass recurrenceSupport layers=.ok out) :
 out=⟨carrier,cycle,geometry,supportState,recurrenceClass,recurrenceSupport,layers⟩ := by
 unfold alternative at h
 repeat' first | split at h | cases h | rfl

theorem orderRetains (a n f : Alternative) (first second : PositiveCount) (out : StabilityOrder)
 (h : stabilityOrder a n f first second=.ok out) : out=⟨a,n,f,first,second⟩ := by
 unfold stabilityOrder at h
 repeat' first | split at h | cases h | rfl

theorem orderClasses (s : StabilityOrder) : exactOrder s=[aromatic,nonaromatic,antiaromatic] := rfl

theorem nonclassifiedAppend (a : Alternative)
 (ha : MulticentreSupport.sameLabel a.recurrenceClass aromatic=false)
 (hf : MulticentreSupport.sameLabel a.recurrenceClass antiaromatic=false) : appendLayer a=.ok a := by
 unfold appendLayer
 rw [ha,hf]
 rfl
end SFT.Chemistry.AntiaromaticDistinctionDerivation
