import SFT.Foundation.DerivationTrace
namespace SFT.Foundation.DerivationTraceWitnesses
open DerivationTrace ExactOperations ExactPartCarrier FoldDynamics

def threeMoveTrace : Except String (List DerivationRow) :=
  let first := foldPart third
  match takePart one first with
  | .error e => .error e
  | .ok second => .ok [row "Fold" [third] first,
      row "Take" [one,first] second, row "Fold" [second] (foldPart second)]

def exactRows : List DerivationRow :=
  [row "Fold" [third] twoThirds, row "Take" [one,twoThirds] third,
   row "Fold" [third] twoThirds]

theorem takeOneTwoThirds : takePart one twoThirds = .ok third := by
  apply congrArg Except.ok
  apply partEquality <;> rfl

theorem threeMoveTraceExact : threeMoveTrace = .ok exactRows := by
  unfold threeMoveTrace
  rw [thirdFoldsToTwoThirds]
  dsimp only
  rw [takeOneTwoThirds]
  dsimp only
  rw [thirdFoldsToTwoThirds]
  rfl

theorem foldThirdExecuted : execute "Fold" third = .ok twoThirds := by
  rw [foldDispatch,thirdFoldsToTwoThirds]

theorem takeTwoThirdsExecuted : execute "Take" twoThirds = .ok third := by
  rw [takeDispatch,takeOneTwoThirds]

theorem exactRowsReplay : replay exactRows = .ok twoThirds := by
  unfold replay exactRows
  rw [replayConstructedStep "Fold" [third] third twoThirds foldThirdExecuted,
    replayConstructedStep "Take" [one,twoThirds] twoThirds third takeTwoThirdsExecuted,
    replayConstructedStep "Fold" [third] third twoThirds foldThirdExecuted]
  rfl

def replayThreeMove : Except String Part :=
  match threeMoveTrace with
  | .error e => .error e
  | .ok rows => replay rows

theorem threeMoveReplay : replayThreeMove = .ok twoThirds := by
  unfold replayThreeMove
  rw [threeMoveTraceExact]
  exact exactRowsReplay

theorem bothRoutesAgree : replayThreeMove = .ok (foldPart third) := by
  rw [thirdFoldsToTwoThirds,threeMoveReplay]

theorem threeIntermediatesRetained : exactRows.map (fun r => r.output) =
    [twoThirds,third,twoThirds] := rfl

theorem orderedInputIdentitiesRetained : exactRows.map (fun r => r.inputHashes) =
    [[partIdentity third],[partIdentity one,partIdentity twoThirds],[partIdentity third]] := rfl

def firstTwoRows : List DerivationRow :=
  [row "Fold" [third] twoThirds, row "Take" [one,twoThirds] third]

def falsePremiseTrace : List DerivationRow :=
  firstTwoRows ++ [⟨"Select",[],twoThirds,partIdentity twoThirds⟩]

def tamperedRow : DerivationRow :=
  ⟨"Fold",[partIdentity third],third,partIdentity twoThirds⟩

def tamperedTrace : List DerivationRow := firstTwoRows ++ [tamperedRow]

theorem firstTwoReplay : replayFrom third firstTwoRows = .ok third := by
  unfold firstTwoRows
  rw [replayConstructedStep "Fold" [third] third twoThirds foldThirdExecuted,
    replayConstructedStep "Take" [one,twoThirds] twoThirds third takeTwoThirdsExecuted]
  rfl

theorem falsePremiseRejected : replay falsePremiseTrace =
    .error "trace contains an unregistered operation" := by
  unfold replay falsePremiseTrace
  rw [replayAppend firstTwoRows _ third third firstTwoReplay]
  rfl

theorem tamperedOutputMismatch : outputMatches tamperedRow twoThirds = false := by
  change (Host.Text.equal (partIdentity twoThirds) (partIdentity twoThirds) && false) = false
  exact Bool.and_false _

theorem changedOutputRejected (item : DerivationRow) (current result : Part)
    (rest : List DerivationRow) (step : execute item.operation current = .ok result)
    (mismatch : outputMatches item result = false) :
    replayFrom current (item::rest) = .error "trace row does not replay to its bound output" := by
  unfold replayFrom
  rw [step]
  dsimp only
  rw [mismatch]
  rfl

theorem tamperedArtifactRejected : replay tamperedTrace =
    .error "trace row does not replay to its bound output" := by
  unfold replay tamperedTrace
  rw [replayAppend firstTwoRows _ third third firstTwoReplay]
  exact changedOutputRejected tamperedRow third twoThirds [] foldThirdExecuted tamperedOutputMismatch

theorem sourcePrefixPreserved : exactRows.take 2 = firstTwoRows := rfl

theorem falsePremiseReplacement : falsePremiseTrace = exactRows.take 2 ++
    [⟨"Select",[],twoThirds,partIdentity twoThirds⟩] := rfl

theorem tamperingPreservesOtherFields : tamperedRow.operation = "Fold" ∧
    tamperedRow.inputHashes = [partIdentity third] ∧
    tamperedRow.outputHash = partIdentity twoThirds ∧ tamperedRow.output = third :=
  ⟨rfl,rfl,rfl,rfl⟩

end SFT.Foundation.DerivationTraceWitnesses
