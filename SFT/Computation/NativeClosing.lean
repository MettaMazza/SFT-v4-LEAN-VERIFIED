import SFT.Computation.LanguageDerivation
namespace SFT.Computation.NativeClosing
open SFT.InformationScience.QuantitySupport SFT.InformationScience.CompressionSupport

def labels : List String := ["held-lower","held-upper"]
def wordsAtDepth (depth : Int) : Except String (List Word) :=
 match depth with
 | .ofNat (n+1) => .ok (words labels (n+1))
 | .ofNat 0 => .error "depth must be a supplied positive finite host count"
 | .negSucc _ => .error "depth must be a supplied positive finite host count"
def wordsThroughDepth (depth : Nat) : List Word := shortThrough labels depth

def suffixTrace : Word → List Word
 | [] => [emptyOne]
 | x::xs => (x::xs)::suffixTrace xs

def closingTrace (word : Word) : Except String (List Word) :=
 if word.isEmpty || !(word.all (fun label => labels.contains label)) then
 .error "a closing trace requires one exact generated Fold word"
 else .ok (suffixTrace word)

theorem exactTraceLength (word : Word) : (suffixTrace word).length=word.length+1 := by
 induction word with
 | nil => rfl
 | cons x xs ih => exact congrArg Nat.succ ih

theorem exactHaltTime (word : Word) : (suffixTrace word).length-1=word.length := by
 rw [exactTraceLength]
 exact Nat.sub_zero _

theorem prependAddsOne (label : String) (word : Word) :
 (suffixTrace (label::word)).length-1=((suffixTrace word).length-1)+1 := by
 rw [exactHaltTime,exactHaltTime]; rfl

theorem everyGeneratedWordHalts (depth : Nat) (word : Word)
 (generated : word ∈ words labels depth) : (suffixTrace word).length-1=depth := by
 rw [exactHaltTime]
 exact ((wordCharacterization _ _ _).mp generated).1

theorem everyWordWithinBound (depth : Nat) (word : Word)
 (generated : word ∈ wordsThroughDepth depth) : (suffixTrace word).length-1 ≤ depth := by
 obtain ⟨width,positive,bound,held⟩ := (shortMembership labels depth word).mp generated
 rw [everyGeneratedWordHalts width word held]
 exact bound

def attainingWord : Nat → Word
 | 0 => []
 | n+1 => "held-lower"::attainingWord n

theorem attainingWordGenerated (depth : Nat) : attainingWord depth ∈ words labels depth := by
 induction depth with
 | zero => exact List.Mem.head []
 | succ n ih => exact (wordsSuccessorMember labels n _).mpr ⟨"held-lower",List.Mem.head _,attainingWord n,ih,rfl⟩

theorem attainingHaltTime (depth : Nat) : (suffixTrace (attainingWord depth)).length-1=depth :=
 everyGeneratedWordHalts depth _ (attainingWordGenerated depth)

theorem maximumCharacterization (depth : Nat) (positive : 0<depth) :
 (∀ word, word ∈ wordsThroughDepth depth → (suffixTrace word).length-1 ≤ depth) ∧
 ∃ word, word ∈ wordsThroughDepth depth ∧ (suffixTrace word).length-1=depth := by
 refine ⟨everyWordWithinBound depth,attainingWord depth,?_,attainingHaltTime depth⟩
 exact (shortMembership labels depth _).mpr ⟨depth,positive,Nat.le_refl _,attainingWordGenerated depth⟩

def maximumTime (times : List Nat) : Nat := times.foldl Nat.max 0
def nativeBusyBeaver (depth : Nat) : Nat :=
 maximumTime ((wordsThroughDepth depth).map (fun word => (suffixTrace word).length-1))

def recurrentLabelTrace (count : Int) : Except String (List String) :=
 match count with
 | .ofNat 0 => .error "recurrence requires a supplied positive finite host count"
 | .negSucc _ => .error "recurrence requires a supplied positive finite host count"
 | .ofNat (n+1) => .ok ((List.range (n+2)).map (fun position =>
     if position%2==0 then "held-lower" else "held-upper"))

theorem recurrenceWitness : recurrentLabelTrace 4 =
 .ok ["held-lower","held-upper","held-lower","held-upper","held-lower"] := rfl

theorem closingOneLower : closingTrace ["held-lower"] = .ok [["held-lower"],emptyOne] := rfl
theorem closingOneUpper : closingTrace ["held-upper"] = .ok [["held-upper"],emptyOne] := rfl

theorem maximumPairUpper (a b bound : Nat) (ha : a≤bound) (hb : b≤bound) : Nat.max a b≤bound := by
 change (if a≤b then b else a)≤bound
 split
 · exact hb
 · exact ha

theorem maximumPairLeft (a b : Nat) : a≤Nat.max a b := by
 change a≤(if a≤b then b else a)
 split
 next h => exact h
 next h => exact Nat.le_refl _

theorem maximumPairRight (a b : Nat) : b≤Nat.max a b := by
 change b≤(if a≤b then b else a)
 split
 · exact Nat.le_refl _
 next h => exact Nat.le_of_lt (Nat.lt_of_not_ge h)

theorem maximumUpper (times : List Nat) (acc bound : Nat) (ha : acc≤bound)
 (ht : ∀ n, n ∈ times → n≤bound) : times.foldl Nat.max acc≤bound := by
 induction times generalizing acc with
 | nil => exact ha
 | cons x xs ih =>
   exact ih (Nat.max acc x) (maximumPairUpper _ _ _ ha (ht x (.head _))) (fun n hn => ht n (.tail _ hn))

theorem maximumRetainsAccumulator (times : List Nat) (acc : Nat) : acc≤times.foldl Nat.max acc := by
 induction times generalizing acc with
 | nil => exact Nat.le_refl _
 | cons x xs ih => exact Nat.le_trans (maximumPairLeft acc x) (ih (Nat.max acc x))

theorem maximumRetainsMember (times : List Nat) (acc n : Nat) (held : n∈times) :
 n≤times.foldl Nat.max acc := by
 induction times generalizing acc with
 | nil => cases held
 | cons x xs ih =>
   cases held with
   | head => exact Nat.le_trans (maximumPairRight acc n) (maximumRetainsAccumulator xs (Nat.max acc n))
   | tail _ member => exact ih (Nat.max acc x) member

theorem nativeBusyBeaverValue (depth : Nat) (positive : 0<depth) : nativeBusyBeaver depth=depth := by
 apply Nat.le_antisymm
 · apply maximumUpper _ 0 depth (Nat.zero_le _)
   intro n hn
   obtain ⟨word,held,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ hn
   cases eq
   exact everyWordWithinBound depth word held
 · obtain ⟨word,held,eq⟩ := (maximumCharacterization depth positive).2
   have member := SFT.Foundation.Count.TraceDerivation.memMap
      (fun word : Word => (suffixTrace word).length-1) word (wordsThroughDepth depth) held
   rw [eq] at member
   exact maximumRetainsMember _ 0 depth member

def admittedBusyBeaver (depth : Int) : Except String Nat :=
 match depth with
 | .ofNat 0 => .error "max() arg is an empty sequence"
 | .negSucc _ => .error "max() arg is an empty sequence"
 | .ofNat (n+1) => .ok (nativeBusyBeaver (n+1))

theorem admittedMaximum (n : Nat) : admittedBusyBeaver (.ofNat (n+1))=.ok (n+1) :=
 congrArg Except.ok (nativeBusyBeaverValue (n+1) (Nat.zero_lt_succ n))

theorem recurrenceHasNoEmptyOne (n : Nat) (trace : List String)
 (returned : recurrentLabelTrace (.ofNat (n+1))=.ok trace) :
 ∀ label, label∈trace → [label]≠emptyOne := by
 cases Except.ok.inj returned
 intro label member
 obtain ⟨position,held,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ member
 cases eq
 split
 · exact by decide
 · exact by decide
end SFT.Computation.NativeClosing



