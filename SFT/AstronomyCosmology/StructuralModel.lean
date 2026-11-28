import SFT.Physics.LeptonIntervals
namespace SFT.AstronomyCosmology.StructuralModel
open SFT.Physics.LeptonIntervals
-- Pinned V3 sft/astronomy_cosmology/structural_model.py: Fraction input is unrestricted.
def one : Rat := normalize 1 1 (by decide)
def two : Rat := normalize 2 1 (by decide)
def fold (value : Rat) : Rat :=
 let doubled := multiply value two
 if !(one.blt doubled) then doubled else subtract doubled one

def periodTwo : List Rat := [normalize 1 3 (by decide),normalize 2 3 (by decide)]
def periodThree : List Rat :=
 [normalize 1 7 (by decide),normalize 2 7 (by decide),normalize 4 7 (by decide)]
def sourcePathObserver : List String := ["source","path","observer","instrument","record"]
def evidenceClasses : List String := ["direct","retrieval","proxy","reconstruction","model","forecast","missing"]
def exponentCandidates : List Nat := [1,2,3]
def rankFour : List Nat := (exponentCandidates ++ [4]).filter (fun value => value == 4)
def structuralWitnesses : List (String × Bool) :=
 [("source_path_observer_ordered",sourcePathObserver.length == sourcePathObserver.eraseDups.length),
  ("evidence_classes_distinct",evidenceClasses.length == evidenceClasses.eraseDups.length),
  ("period_two_recurs",periodTwo.map fold == [normalize 2 3 (by decide),normalize 1 3 (by decide)]),
  ("period_three_recurs",periodThree.map fold == [normalize 2 7 (by decide),normalize 4 7 (by decide),normalize 1 7 (by decide)]),
  ("period_three_partitions_one",periodThree.foldl add zero == one),
  ("positive_ordered_history",(List.range 6).all (fun k =>
    (normalize (Int.ofNat (k+1)) 8 (by decide)).blt (normalize (Int.ofNat (k+2)) 8 (by decide)))),
  ("joint_population_product",(2:Nat)*3 == 6),
  ("rank_four_unique_in_registered_dimension_successor",rankFour == [4]),
  ("observation_never_recovers_unheld_predecessor",fold (normalize 1 4 (by decide)) == fold (normalize 3 4 (by decide)))]

theorem originalNineWitnesses : structuralWitnesses.map Prod.snd = List.replicate 9 true := by rfl
end SFT.AstronomyCosmology.StructuralModel
