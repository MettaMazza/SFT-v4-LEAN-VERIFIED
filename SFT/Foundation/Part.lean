import SFT.Foundation.CountRepresentation
/-! Exact source part.py relation domains and seven-criterion product.
No cross-partition equivalence or division operation is introduced. -/
namespace SFT.Foundation.Part

inductive Coverage where
  | incomplete | complete

def coverageName : Coverage → String
  | .incomplete => "incomplete"
  | .complete => "complete"

inductive Overlap where
  | disjoint | overlapping

def overlapName : Overlap → String
  | .disjoint => "disjoint"
  | .overlapping => "overlapping"

inductive Fibre where
  | unequal | equal

def fibreName : Fibre → String
  | .unequal => "unequal"
  | .equal => "equal"

inductive Selection where
  | empty | within | outside

def selectionName : Selection → String
  | .empty => "empty"
  | .within => "within"
  | .outside => "outside"

inductive HeldCount where
  | absent | present

def heldName : HeldCount → String
  | .absent => "held-absent"
  | .present => "held-present"

inductive WholeCount where
  | absent | present

def wholeName : WholeCount → String
  | .absent => "whole-absent"
  | .present => "whole-present"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  coverage : Coverage
  overlap : Overlap
  fibre : Fibre
  selection : Selection
  held : HeldCount
  whole : WholeCount
  extra : Extra

def sourceFields (c : Candidate) : List String := [coverageName c.coverage, overlapName c.overlap, fibreName c.fibre, selectionName c.selection, heldName c.held, wholeName c.whole, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)

def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Part coordinate has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]

def survives (c : Candidate) : Bool :=
  SFT.Host.Text.equal (coverageName c.coverage) "complete" &&
  SFT.Host.Text.equal (overlapName c.overlap) "disjoint" &&
  SFT.Host.Text.equal (fibreName c.fibre) "equal" &&
  SFT.Host.Text.equal (selectionName c.selection) "within" &&
  SFT.Host.Text.equal (heldName c.held) "held-present" &&
  SFT.Host.Text.equal (wholeName c.whole) "whole-present" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (coverageName c.coverage) "incomplete" then "The partition does not retain the complete structural One." else
  if SFT.Host.Text.equal (overlapName c.overlap) "overlapping" then "Overlapping fibres count shared structure more than once." else
  if SFT.Host.Text.equal (fibreName c.fibre) "unequal" then "Unequal fibres do not make held and whole counts an exact part coordinate." else
  if SFT.Host.Text.equal (selectionName c.selection) "empty" then "An empty selection supplies no positive part." else
  if SFT.Host.Text.equal (selectionName c.selection) "outside" then "The selection contains material outside the registered whole partition." else
  if SFT.Host.Text.equal (heldName c.held) "held-absent" then "Without the held count the selected portion is not identified." else
  if SFT.Host.Text.equal (wholeName c.whole) "whole-absent" then "Without the whole count the selection has no exact partition reference." else
  if SFT.Host.Text.equal (extraName c.extra) "has-extra" then "The coordinate adds a scale or datum not supplied by the partition." else
  "The exact held and whole counts identify a nonempty contained selection of an equal, disjoint and complete partition."

def generationRule : String := "Generate the complete product of partition coverage, partition overlap, fibre equality, selection relation, held-count presence, whole-count presence and unforced-extra-coordinate presence."
def grammarBoundary : String := "All coordinate forms for a selection relative to a registered finite partition of the structural One, classified only by completeness, disjointness, equal-fibre status, selection containment, the two exact positive count records and unforced extra data."

def candidates : List Candidate :=
  ([Coverage.incomplete,.complete]).flatMap fun coverage =>
  ([Overlap.disjoint,.overlapping]).flatMap fun overlap =>
  ([Fibre.unequal,.equal]).flatMap fun fibre =>
  ([Selection.empty,.within,.outside]).flatMap fun selection =>
  ([HeldCount.absent,.present]).flatMap fun held =>
  ([WholeCount.absent,.present]).flatMap fun whole =>
  ([Extra.noExtra,.hasExtra]).map fun extra =>
  ⟨coverage,overlap,fibre,selection,held,whole,extra⟩

def survivor : Candidate := ⟨.complete,.disjoint,.equal,.within,.present,.present,.noExtra⟩

set_option maxRecDepth 10000 in
theorem generatedCardinality : candidates.length = 192 := rfl

set_option maxRecDepth 10000 in
set_option maxHeartbeats 4000000 in
theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk coverage overlap fibre selection held whole extra =>
    cases coverage <;> cases overlap <;> cases fibre <;> cases selection <;> cases held <;> cases whole <;> cases extra
    all_goals repeat first | exact List.Mem.head _ | apply List.Mem.tail

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  cases c with
  | mk coverage overlap fibre selection held whole extra =>
    cases coverage <;> cases overlap <;> cases fibre <;> cases selection <;> cases held <;> cases whole <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.coverage = .complete ∧ c.overlap = .disjoint ∧ c.fibre = .equal ∧
  c.selection = .within ∧ c.held = .present ∧ c.whole = .present ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk coverage overlap fibre selection held whole extra =>
      obtain ⟨hc,ho,hf,hs,hh,hw,he⟩ := h
      cases hc; cases ho; cases hf; cases hs; cases hh; cases hw; cases he
      rfl

theorem missingHeldCountRejected (c : Candidate) : survives {c with held := .absent} ≠ true := by
  intro h
  have impossible : HeldCount.absent = .present := ((acceptanceIffExactCriteria _).mp h).2.2.2.2.1
  cases impossible

theorem missingWholeCountRejected (c : Candidate) : survives {c with whole := .absent} ≠ true := by
  intro h
  have impossible : WholeCount.absent = .present := ((acceptanceIffExactCriteria _).mp h).2.2.2.2.2.1
  cases impossible

theorem incompletePartitionRejected (c : Candidate) : survives {c with coverage := .incomplete} ≠ true := by
  intro h
  have impossible : Coverage.incomplete = .complete := ((acceptanceIffExactCriteria _).mp h).1
  cases impossible

theorem overlappingPartitionRejected (c : Candidate) : survives {c with overlap := .overlapping} ≠ true := by
  intro h
  have impossible : Overlap.overlapping = .disjoint := ((acceptanceIffExactCriteria _).mp h).2.1
  cases impossible

theorem unequalFibresRejected (c : Candidate) : survives {c with fibre := .unequal} ≠ true := by
  intro h
  have impossible : Fibre.unequal = .equal := ((acceptanceIffExactCriteria _).mp h).2.2.1
  cases impossible

theorem emptySelectionRejected (c : Candidate) : survives {c with selection := .empty} ≠ true := by
  intro h
  have impossible : Selection.empty = .within := ((acceptanceIffExactCriteria _).mp h).2.2.2.1
  cases impossible

theorem outsideSelectionRejected (c : Candidate) : survives {c with selection := .outside} ≠ true := by
  intro h
  have impossible : Selection.outside = .within := ((acceptanceIffExactCriteria _).mp h).2.2.2.1
  cases impossible

theorem extraCoordinateRejected (c : Candidate) : survives {c with extra := .hasExtra} ≠ true := by
  intro h
  have impossible : Extra.hasExtra = .noExtra := ((acceptanceIffExactCriteria _).mp h).2.2.2.2.2.2
  cases impossible

end SFT.Foundation.Part
