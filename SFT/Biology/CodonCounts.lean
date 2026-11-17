import Lean
import SFT.Chemistry.StateEnergyOrder

namespace SFT.Biology.CodonCounts

set_option maxRecDepth 20000
set_option maxHeartbeats 20000000

abbrev Symbol := Nat × Nat
abbrev Word := Symbol × Symbol × Symbol
abbrev Prefix := Symbol × Symbol
abbrev Box := Prefix × List Word

def labels : List Nat := [1, 2]

def heldPairAlphabet : List Symbol :=
  labels.flatMap fun a => labels.map fun b => (a, b)

def codonWords : List Word :=
  heldPairAlphabet.flatMap fun a =>
    heldPairAlphabet.flatMap fun b =>
      heldPairAlphabet.map fun c => (a, b, c)

def wordPrefix (word : Word) : Prefix := (word.1, word.2.1)

def insertWord : List Box → Word → List Box
  | [], word => [(wordPrefix word, [word])]
  | (key, words) :: rest, word =>
    if key == wordPrefix word then (key, words ++ [word]) :: rest
    else (key, words) :: insertWord rest word

def codonBoxes : List Box := codonWords.foldl insertWord []

def boxWidths : List Nat :=
  SFT.Chemistry.StateEnergyOrder.sortPositions
    (codonBoxes.map fun box => box.2.length).eraseDups

def partitionWords : List Word := codonBoxes.flatMap Prod.snd

structure Certificate where
  heldDistinctions : Nat
  alphabetCount : Nat
  wordLength : Nat
  codonCount : Nat
  boxCount : Nat
  boxWidths : List Nat
  alphabetComplete : Bool
  codonCensusComplete : Bool
  partitionComplete : Bool
  eachWordOnce : Bool
  deriving BEq, Repr

def exactCodonCertificate : Certificate := {
  heldDistinctions := 2
  alphabetCount := heldPairAlphabet.length
  wordLength := 3
  codonCount := codonWords.length
  boxCount := codonBoxes.length
  boxWidths := boxWidths
  alphabetComplete := heldPairAlphabet.eraseDups.length == 4
  codonCensusComplete := codonWords.eraseDups.length == 64
  partitionComplete := (codonBoxes.map fun box => box.2.length).foldl Nat.add 0 == codonWords.length
  eachWordOnce := partitionWords.eraseDups.length == codonWords.length
}

def expectedCertificate : Certificate :=
  ⟨2, 4, 3, 64, 16, [4], true, true, true, true⟩

def validateStructuralCounts : Except String Unit :=
  if exactCodonCertificate == expectedCertificate then .ok ()
  else .error "exact Biology codon certificate failed"

theorem alphabetEnumeration : heldPairAlphabet = [(1, 1), (1, 2), (2, 1), (2, 2)] := by rfl
theorem fourSymbols : heldPairAlphabet.length = 4 := by rfl
theorem alphabetDistinct : heldPairAlphabet.Nodup := by decide
theorem sixtyFourWords : codonWords.length = 64 := by rfl
theorem wordsDistinct : codonWords.Nodup := by decide
theorem sixteenBoxes : codonBoxes.length = 16 := by rfl
theorem fourWordsPerBox : boxWidths = [4] := by rfl
theorem partitionReconstructsWords : partitionWords = codonWords := by rfl
theorem completeCertificate : exactCodonCertificate = expectedCertificate := by
  unfold exactCodonCertificate
  rw [fourWordsPerBox]
  rfl
theorem structuralCountsValidated : validateStructuralCounts = .ok () := by
  unfold validateStructuralCounts
  rw [completeCertificate]
  rfl

end SFT.Biology.CodonCounts
