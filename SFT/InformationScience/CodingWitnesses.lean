import SFT.InformationScience.CodingProvenance
namespace SFT.InformationScience.CodingWitnesses
open CodingSupport CodingImages CodingDecoding
open SFT.Mathematics.DiscreteObjects
structure Witness where
  name : String
  statement : String
  passed : Bool

def labels : List String := ["a","b"]
def positions : List String := ["p1","p2","p3"]
def repetition : List NoiseRelation.Word := [["a","a","a"],["b","b","b"]]
def uncoded : List NoiseRelation.Word := [["a"],["b"]]
theorem repetitionResult : repetitionCode labels positions = .ok repetition := rfl

def supportCheck : Bool := match completeSupport labels positions with
 | .error _ => false
 | .ok support => decide (support.length=8) && distinct support

def differenceCheck : Bool := match differenceTrace ["a","a","a"] ["b","b","b"] with
 | .error _ => false
 | .ok trace => match trace with
   | .emptyOne => false
   | .changes rows => decide (rows.length=3)
def detectionCheck : Bool := detectableCode repetition labels
def correctionCheck : Bool := correctableCode repetition labels
def decodingCheck : Bool := decide (decodeReceived repetition labels ["b","a","a"] = .uniqueSource ["a","a","a"])
def unprotectedCheck : Bool := !correctableCode uncoded labels

def witnesses : List Witness := [
  ⟨"support","Two labels over three positions generate eight unique words.",supportCheck⟩,
  ⟨"difference","The repetition codewords differ at all three retained positions.",differenceCheck⟩,
  ⟨"detection","Every single-label change of a width-three repetition codeword lies outside the codebook.",detectionCheck⟩,
  ⟨"correction","The two complete single-label error-image supports are disjoint.",correctionCheck⟩,
  ⟨"decoding","A received b/a/a word belongs uniquely to the all-a source family.",decodingCheck⟩,
  ⟨"unprotected-control","The one-position uncoded family cannot correct a single label change.",unprotectedCheck⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

theorem heldRepetition : ∃ support, completeSupport labels positions = .ok support ∧ codebook support repetition = .ok repetition := by
  exact ⟨QuantitySupport.words labels 3,rfl,rfl⟩

theorem widthThreeSeparates : correctableCode repetition labels = true := rfl

theorem widthTwoDoesNotSeparate : correctableCode [["a","a"],["b","b"]] labels = false := rfl

theorem unprotectedDoesNotSeparate : correctableCode uncoded labels = false := rfl

end SFT.InformationScience.CodingWitnesses
