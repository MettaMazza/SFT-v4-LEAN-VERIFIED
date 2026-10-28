import SFT.Computation.ComputationalLimit
namespace SFT.Computation.InputExtent
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder
open ResourceRecord SFT.Foundation.Count.TraceDerivation

-- Position cells retain both occupied-position identity and encoded symbol.
-- The original resource operation supplies its original nonempty/unique guard.
def ExactExtent (word : Codeword) (cells : List (String × String)) (ledger : Ledger) : Prop :=
  cells.map Prod.snd = word ∧ resourceLedger word (cells.map Prod.fst) = .ok ledger

theorem mapCount {α β : Type} (f : α → β) (items : List α) :
    (items.map f).length = items.length := by
  induction items with
  | nil => rfl
  | cons head rest ih => exact congrArg Nat.succ ih

theorem completeExtent (word : Codeword) (cells : List (String × String)) (ledger : Ledger)
    (exact : ExactExtent word cells ledger) :
    ledger.timeTrace.map Prod.snd = word ∧ ledger.spaceSupport = cells.map Prod.fst ∧
      ledger.timeCount = word.length ∧ ledger.spaceCount = word.length := by
  have data := recordReconstructs _ _ _ exact.2
  have length : (cells.map Prod.fst).length = word.length := by
    rw [mapCount,← exact.1,mapCount]
  exact ⟨data.1,data.2.1,data.2.2.1,data.2.2.2.trans length⟩

theorem occupiedPositionsUnique (word : Codeword) (cells : List (String × String)) (ledger : Ledger)
    (exact : ExactExtent word cells ledger) :
    SFT.Mathematics.DiscreteObjects.distinct (cells.map Prod.fst) = true :=
  ((ledgerMeaning _ _ _).mp exact.2).1

theorem canonicalInput (source : List String) (support : List Codeword) (encoding : Encoding)
    (decoder : Decoder) (valid : validateEncoding source support encoding = true)
    (inverse : exactDecoder source encoding = some decoder) (item : String) (held : item ∈ source) :
    ∃ word, word ∈ support ∧ lookupFirst encoding item = some word ∧ decode word decoder = .ok item :=
  ModelEncoding.finiteRoundTrip _ _ _ valid _ inverse item held

theorem sameRepresentationSize (word : Codeword) (left right : List (String × String)) (a b : Ledger)
    (first : ExactExtent word left a) (second : ExactExtent word right b) :
    a.spaceCount = b.spaceCount ∧ a.timeCount = b.timeCount := by
  have one := completeExtent _ _ _ first
  have two := completeExtent _ _ _ second
  exact ⟨one.2.2.2.trans two.2.2.2.symm,one.2.2.1.trans two.2.2.1.symm⟩

-- An exact encoding correspondence retains both codewords and both extents;
-- different representations are not silently assigned one invariant size.
theorem representationLedger (first second : Encoding) (item : String)
    (left right : Codeword) (leftCells rightCells : List (String × String)) (a b : Ledger)
    (leftEncoding : lookupFirst first item = some left)
    (rightEncoding : lookupFirst second item = some right)
    (leftSize : ExactExtent left leftCells a) (rightSize : ExactExtent right rightCells b) :
    (item,left) ∈ first ∧ (item,right) ∈ second ∧
      a.spaceCount = left.length ∧ b.spaceCount = right.length :=
  ⟨lookupRow _ _ _ leftEncoding,lookupRow _ _ _ rightEncoding,
    (completeExtent _ _ _ leftSize).2.2.2,(completeExtent _ _ _ rightSize).2.2.2⟩

theorem familyInstance (source : List String) (encoding : Encoding)
    (records : String → Codeword → Prop)
    (family : ∀ item, item ∈ source → ∃ word, lookupFirst encoding item = some word ∧ records item word)
    (item : String) (held : item ∈ source) :
    ∃ word, (item,word) ∈ encoding ∧ records item word := by
  obtain ⟨word,found,recorded⟩ := family item held
  exact ⟨word,lookupRow _ _ _ found,recorded⟩

theorem appendCount {α : Type} (left right : List α) :
    (left ++ right).length = left.length + right.length := by
  induction left with
  | nil => exact (Nat.zero_add right.length).symm
  | cons head rest ih =>
    change (rest ++ right).length + 1 = (rest.length + 1) + right.length
    rw [ih,EnumerationTrace.shiftedIndex,Nat.add_assoc]

theorem compositionSize (left right : Codeword) (aCells bCells combined : List (String × String))
    (a b total : Ledger) (one : ExactExtent left aCells a) (two : ExactExtent right bCells b)
    (joined : ExactExtent (left ++ right) combined total) :
    total.spaceCount = a.spaceCount + b.spaceCount := by
  rw [(completeExtent _ _ _ joined).2.2.2,appendCount,
    (completeExtent _ _ _ one).2.2.2,(completeExtent _ _ _ two).2.2.2]

theorem onePosition : ExactExtent ["held"] [("position-1","held")]
    ⟨[("transition-1","held")],["position-1"],1,1⟩ := ⟨rfl,rfl⟩

theorem successorSize (word : Codeword) (symbol : String)
    (beforeCells afterCells : List (String × String)) (before after : Ledger)
    (old : ExactExtent word beforeCells before) (extended : ExactExtent (word ++ [symbol]) afterCells after) :
    after.spaceCount = before.spaceCount + 1 := by
  rw [(completeExtent _ _ _ extended).2.2.2,appendCount,(completeExtent _ _ _ old).2.2.2]
  rfl
end SFT.Computation.InputExtent
