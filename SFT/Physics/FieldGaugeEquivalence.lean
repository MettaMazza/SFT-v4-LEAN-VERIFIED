import SFT.Physics.FieldElectromagnetic
namespace SFT.Physics.FieldGaugeEquivalence

-- The original equivalence acts only on unobserved description labels.
-- Observation and transfer records are complete, ordered source records.
structure Observable (Source Observation Transfer : Type) where
  source : Source
  observations : List Observation
  transfers : List Transfer

structure Description (Source Observation Transfer Label : Type) where
  observable : Observable Source Observation Transfer
  unobservedLabels : List Label

variable {Source Observation Transfer Label : Type}

def equivalent (a b : Description Source Observation Transfer Label) : Prop :=
  a.observable = b.observable

def relabel (d : Description Source Observation Transfer Label) (labels : List Label) :=
  {d with unobservedLabels := labels}

theorem reflexive (a : Description Source Observation Transfer Label) : equivalent a a := rfl

theorem symmetric (a b : Description Source Observation Transfer Label) (h : equivalent a b) : equivalent b a := h.symm

theorem transitive (a b c : Description Source Observation Transfer Label)
    (ab : equivalent a b) (bc : equivalent b c) : equivalent a c := ab.trans bc

theorem allRelabelingsPreserve (d : Description Source Observation Transfer Label) (labels : List Label) :
    equivalent (relabel d labels) d := rfl

theorem sourcePreserved (a b : Description Source Observation Transfer Label) (h : equivalent a b) :
    a.observable.source = b.observable.source := congrArg Observable.source h

theorem allObservationsPreserved (a b : Description Source Observation Transfer Label) (h : equivalent a b) :
    a.observable.observations = b.observable.observations := congrArg Observable.observations h

theorem allTransfersPreserved (a b : Description Source Observation Transfer Label) (h : equivalent a b) :
    a.observable.transfers = b.observable.transfers := congrArg Observable.transfers h

theorem completeRecordsSuffice (a b : Description Source Observation Transfer Label)
    (source : a.observable.source = b.observable.source)
    (observations : a.observable.observations = b.observable.observations)
    (transfers : a.observable.transfers = b.observable.transfers) : equivalent a b := by
  cases a with
  | mk a la => cases b with
    | mk b lb => cases a with
      | mk sa oa ta => cases b with
        | mk sb ob tb => cases source; cases observations; cases transfers; rfl

theorem changedObservationExcluded (a b : Description Source Observation Transfer Label)
    (h : a.observable.observations ≠ b.observable.observations) : ¬ equivalent a b :=
  fun eq => h (allObservationsPreserved a b eq)

theorem changedTransferExcluded (a b : Description Source Observation Transfer Label)
    (h : a.observable.transfers ≠ b.observable.transfers) : ¬ equivalent a b :=
  fun eq => h (allTransfersPreserved a b eq)

-- Canonical representatives retain the whole observable, avoiding a quotient
-- axiom or a choice of privileged internal labels.
def canonical (d : Description Source Observation Transfer Label) := d.observable

theorem canonicalExactlyEquivalence (a b : Description Source Observation Transfer Label) :
    canonical a = canonical b ↔ equivalent a b := ⟨fun h => h,fun h => h⟩

theorem everyObservableRepresented (o : Observable Source Observation Transfer) :
    canonical (Description.mk o ([] : List Label)) = o := rfl
end SFT.Physics.FieldGaugeEquivalence
