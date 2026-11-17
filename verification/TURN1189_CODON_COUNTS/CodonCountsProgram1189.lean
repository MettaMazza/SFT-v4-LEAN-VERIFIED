import SFT.Biology.CodonCounts
open Lean SFT.Biology.CodonCounts

def symbolJson (s : Symbol) : Json := toJson [s.1, s.2]
def wordJson (w : Word) : Json := Json.arr #[symbolJson w.1, symbolJson w.2.1, symbolJson w.2.2]
def wordsJson (words : List Word) : Json := Json.arr (words.map wordJson).toArray

def main : IO Unit := do
 let c := exactCodonCertificate
 let certificate := Json.mkObj [
  ("held_distinctions", toJson c.heldDistinctions),
  ("alphabet_count", toJson c.alphabetCount),
  ("word_length", toJson c.wordLength),
  ("codon_count", toJson c.codonCount),
  ("box_count", toJson c.boxCount),
  ("box_widths", toJson c.boxWidths),
  ("alphabet_complete", toJson c.alphabetComplete),
  ("codon_census_complete", toJson c.codonCensusComplete),
  ("partition_complete", toJson c.partitionComplete),
  ("each_word_once", toJson c.eachWordOnce)]
 let boxes := codonBoxes.map fun (key, words) =>
  Json.arr #[Json.arr #[symbolJson key.1, symbolJson key.2], wordsJson words]
 let validation := match validateStructuralCounts with
  | .ok () => Json.null
  | .error message => toJson message
 IO.println (Json.mkObj [
  ("held_pair_alphabet", Json.arr (heldPairAlphabet.map symbolJson).toArray),
  ("codon_words", wordsJson codonWords),
  ("codon_boxes", Json.arr boxes.toArray),
  ("exact_codon_certificate", certificate),
  ("validation", validation)]).compress
