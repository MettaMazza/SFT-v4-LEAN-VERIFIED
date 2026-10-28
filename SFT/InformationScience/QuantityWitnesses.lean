import SFT.InformationScience.QuantityPositions
namespace SFT.InformationScience.QuantityWitnesses
open QuantitySupport QuantityProfile QuantityPositions SFT.Mathematics.DiscreteObjects
structure Witness where
  name : String
  statement : String
  passed : Bool

def labels : List String := ["held-a","held-b"]
def positions : List String := ["p1","p2","p3"]
def support : List Word := match completeWordSupport labels positions with
  | .error _ => []
  | .ok words => words
def fine : Observation := support.map (fun word => (word,SFT.Host.Text.append "seen:" (SFT.Host.Text.intercalate ":" word)))
def coarse : Observation := support.map (fun word => (word,SFT.Host.Text.append "seen:" (word.headD "")))
def supportCheck : Bool := decide (support.length = 8) && distinct support

def fineCheck : Bool := match informationProfile support fine with
  | .error _ => false
  | .ok p => decide (p.retainedDistinctions.length = 28) && p.closedDistinctions.isEmpty

def coarseCheck : Bool := match informationProfile support coarse with
  | .error _ => false
  | .ok p => decide (p.retainedDistinctions.length = 16) && decide (p.closedDistinctions.length = 12)

def positionCheck : Bool := match distinctionPositionTrace labels positions with
  | .error _ => false
  | .ok trace => decide (trace = [("p1","one-Fold-distinction"),("p2","one-Fold-distinction"),("p3","one-Fold-distinction")])

def compositionCheck : Bool := match composeSupport [["a"],["b"]] [["x"],["y"]] with
  | .error _ => false
  | .ok words => decide (words.length = 4)

def witnesses : List Witness := [
  ⟨"complete-support","Three independently held Fold positions generate eight unique exact words.",supportCheck⟩,
  ⟨"fine-ledger","Fine observation retains every distinct support pair and closes none.",fineCheck⟩,
  ⟨"coarse-ledger","First-position observation retains cross-class pairs and closes within-class pairs.",coarseCheck⟩,
  ⟨"position-units","Each of three positions independently realizes the Fold distinction.",positionCheck⟩,
  ⟨"support-composition","Two two-word supports compose into four coordinate-preserving words.",compositionCheck⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.InformationScience.QuantityWitnesses
