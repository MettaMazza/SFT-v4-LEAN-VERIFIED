import SFT.Chemistry.PairExchangeTargets
import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.PairExchangePrediction
open SFT.Host
open ElectronSpinPrediction (instruction numbered)
abbrev J := Canonical.Value
-- Original prediction_program_document's three ordered loops, followed by
-- its maximum-occupancy count. These are the universal rule labels; no target
-- state identity, measured energy or observed ordering is present here.
def sectorRows : List (String × String × String × String) := [
 ("positive-One-width","alternating-exchange","preserving-exchange","same-cell-admitted"),
 ("positive-three-width","preserving-exchange","alternating-exchange","same-cell-excluded")]
def sectorEntries : List (String × String × String × String) :=
 sectorRows.flatMap fun (width,spin,spatial,cell) => [
  ("spin-exchange-by-multiplicity",width,"exchange-class",spin),
  ("spatial-exchange-by-multiplicity",width,"exchange-class",spatial),
  ("same-cell-by-multiplicity",width,"same-cell-status",cell)]
def productEntries : List (String × String × String × String) :=
 [("preserving","preserving","preserving-exchange"),
  ("preserving","alternating","alternating-exchange"),
  ("alternating","preserving","alternating-exchange"),
  ("alternating","alternating","preserving-exchange")].map fun (left,right,value) =>
  ("exchange-product",Text.intercalate "-with-" [left,right],"exchange-class",value)
def lawEntries : List (String × String × String × String) := [
 ("pair-exchange-law","total-electron-pair","exchange-class","alternating-exchange"),
 ("pair-exchange-law","same-support-partners","exchange-law-result","distinct-complementary-state-identities"),
 ("pair-exchange-law","energy-order","exchange-law-result","retained-observation-not-universal-sign")]
def labelInstructions (position : Nat) (entry : String × String × String × String) : List J :=
 let (keyFamily,keyLabel,valueFamily,valueLabel) := entry
 [instruction "label" (numbered "key-" position) [keyFamily,keyLabel],
  instruction "label" (numbered "value-" position) [valueFamily,valueLabel]]
def predictionDocument (actualHash schema : String) (rows : List PairExchangeTargets.Identity) : Except String J := do
 let _ ← PairExchangeTargets.identities actualHash schema rows
 let labels := sectorEntries++productEntries++lawEntries
 let terminal := labels.length+1
 let instructions := [instruction "input" "premise" ["registered-premise"]] ++
  (labels.zipIdx 1).flatMap (fun (entry,i) => labelInstructions i entry) ++
  [instruction "label" (numbered "key-" terminal) ["pair-exchange-law","maximum-orbital-occupancy"],
   instruction "count" (numbered "value-" terminal) ["2"],
   instruction "table" "complete-pair-exchange-law" ((List.range terminal).flatMap fun i => [numbered "key-" (i+1),numbered "value-" (i+1)]),
   instruction "emit" "" ["complete-pair-exchange-law"]]
 return .object [("schema",.text "sft-v3-fold-program/1"),
  ("program_id",.text "SFT-EXP-CHEM-MOLECULAR-EXCLUSION-EXCHANGE-006-pair-exchange-law-prediction"),
  ("instructions",.array instructions)]
#print axioms sectorRows
#print axioms sectorEntries
#print axioms productEntries
#print axioms lawEntries
#print axioms labelInstructions
#print axioms predictionDocument
end SFT.Chemistry.PairExchangePrediction
