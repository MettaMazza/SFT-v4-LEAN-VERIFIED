import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.OrbitalSupportPrediction
open SFT.Host ElectronSpinPrediction
abbrev J := SFT.Host.Canonical.Value
-- Original RANK_LABELS, in its exact insertion order. These are the
-- conventional correspondence names in the source prediction document.
def rankLabels : List (String × String) := [
 ("Σ","structural-empty-One"),("Π","first-recurrence"),("Δ","second-recurrence"),("Φ","third-recurrence"),
 ("σ","structural-empty-One"),("π","first-recurrence"),("δ","second-recurrence"),("φ","third-recurrence")]
def lawCounts : List (String × Nat) := [("joining-phase-count",2),("maximum-spatial-occupancy",2)]
def programDocument (electronRows : List PredictionRow) : J :=
 let ranks := rankLabels.zipIdx 1
 let parity := electronRows.zipIdx (rankLabels.length+1)
 let counts := lawCounts.zipIdx (rankLabels.length+electronRows.length+1)
 let rankInstructions := ranks.flatMap fun ((symbol,rank),position) =>
  [instruction "label" (numbered "key-" position) ["source-support-symbol",symbol],
   instruction "label" (numbered "value-" position) ["axis-support-rank",rank]]
 let parityInstructions := parity.flatMap fun (row,position) =>
  [instruction "label" (numbered "key-" position) ["species-spin-parity",row.rowId],
   instruction "label" (numbered "value-" position) ["spin-width-parity",row.requiredSpinWidthParity.label]]
 let countInstructions := counts.flatMap fun ((name,count),position) =>
  [instruction "label" (numbered "key-" position) ["support-law-constant",name],
   instruction "count" (numbered "value-" position) [Canonical.render (.integer (.ofNat count))]]
 let positions := ranks.map Prod.snd ++ parity.map Prod.snd ++ counts.map Prod.snd
 let table := positions.flatMap fun position => [numbered "key-" position,numbered "value-" position]
 .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003-support-law-prediction"),
  ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++
    rankInstructions ++ parityInstructions ++ countInstructions ++
    [instruction "table" "support-law-vector" table,instruction "emit" "" ["support-law-vector"]]))]
end SFT.Chemistry.OrbitalSupportPrediction
