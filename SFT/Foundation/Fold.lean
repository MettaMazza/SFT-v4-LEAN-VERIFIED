import SFT.Foundation.FoldDerivation
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.Fold
set_option maxRecDepth 10000

inductive Coverage where
  | incomplete | complete

def coverageName : Coverage → String
  | .incomplete => "incomplete"
  | .complete => "complete"

inductive Overlap where
  | overlapping | disjoint

def overlapName : Overlap → String
  | .overlapping => "overlapping"
  | .disjoint => "disjoint"

inductive Fibre where
  | unequal | equal

def fibreName : Fibre → String
  | .unequal => "unequal"
  | .equal => "equal"

inductive Extension where
  | identity | first | later

def extensionName : Extension → String
  | .identity => "identity"
  | .first => "first-extension"
  | .later => "later-extension"

inductive Labels where
  | absent | same | distinctHeld

def labelsName : Labels → String
  | .absent => "labels-absent"
  | .same => "labels-same"
  | .distinctHeld => "labels-distinct-held"

inductive Return where
  | absent | present

def returnRelationName : Return → String
  | .absent => "return-absent"
  | .present => "return-present"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  coverage : Coverage
  overlap : Overlap
  fibre : Fibre
  extension : Extension
  labels : Labels
  returnRelation : Return
  extra : Extra

def sourceFields (c : Candidate) : List String := [coverageName c.coverage, overlapName c.overlap, fibreName c.fibre, extensionName c.extension, labelsName c.labels, returnRelationName c.returnRelation, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)

def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Fold proposal has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]

def survives (c : Candidate) : Bool :=
  SFT.Host.Text.equal (coverageName c.coverage) "complete" &&
  SFT.Host.Text.equal (overlapName c.overlap) "disjoint" &&
  SFT.Host.Text.equal (fibreName c.fibre) "equal" &&
  SFT.Host.Text.equal (extensionName c.extension) "first-extension" &&
  SFT.Host.Text.equal (labelsName c.labels) "labels-distinct-held" &&
  SFT.Host.Text.equal (returnRelationName c.returnRelation) "return-present" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (coverageName c.coverage) "incomplete" then "It loses part of the structural One rather than transforming the whole." else
  if SFT.Host.Text.equal (overlapName c.overlap) "overlapping" then "Overlapping fibres repeat shared structure and do not form an exact partition." else
  if SFT.Host.Text.equal (fibreName c.fibre) "unequal" then "Unequal fibres introduce an allocation distinction not supplied by the unqualified One." else
  if SFT.Host.Text.equal (extensionName c.extension) "identity" then "The identity count has no nontrivial fibre distinction." else
  if SFT.Host.Text.equal (extensionName c.extension) "later-extension" then "A later count extension is not minimal because the first extension is already nontrivial." else
  if SFT.Host.Text.equal (labelsName c.labels) "labels-absent" then "Without labels the generated fibres are not operationally distinguishable." else
  if SFT.Host.Text.equal (labelsName c.labels) "labels-same" then "The same label collapses the proposed distinction back to one observational class." else
  if SFT.Host.Text.equal (returnRelationName c.returnRelation) "return-absent" then "Without a retained return relation the complete fibre assembly is not identified with the One." else
  if SFT.Host.Text.equal (extraName c.extra) "has-extra" then "It adds a parameter or datum not supplied by the admitted dependencies." else
  "It is the first nontrivial count extension into equal disjoint held-labelled fibres with a complete return relation and no added data."

def generationRule : String := "Generate the complete product of whole coverage, fibre overlap, fibre equality, positive-count extension class, label relation, return relation and unforced-extra-data presence."
def grammarBoundary : String := "All transformations of the structural One classified as identity, the first generated positive-count extension or a later extension, together with exhaustive whole-preservation, fibre, label, return and extra-data relations required for a nontrivial reversible distinction."

def candidates : List Candidate :=
  ([Coverage.incomplete,.complete]).flatMap fun coverage =>
  ([Overlap.overlapping,.disjoint]).flatMap fun overlap =>
  ([Fibre.unequal,.equal]).flatMap fun fibre =>
  ([Extension.identity,.first,.later]).flatMap fun extension =>
  ([Labels.absent,.same,.distinctHeld]).flatMap fun labels =>
  ([Return.absent,.present]).flatMap fun returnRelation =>
  ([Extra.noExtra,.hasExtra]).map fun extra =>
  ⟨coverage,overlap,fibre,extension,labels,returnRelation,extra⟩

def survivor : Candidate := ⟨.complete,.disjoint,.equal,.first,.distinctHeld,.present,.noExtra⟩

theorem generatedCardinality : candidates.length = 288 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk coverage overlap fibre extension labels returnRelation extra =>
    have hcoverage : coverage ∈ [Coverage.incomplete,.complete] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoverlap : overlap ∈ [Overlap.overlapping,.disjoint] := by
      cases overlap <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfibre : fibre ∈ [Fibre.unequal,.equal] := by
      cases fibre <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.identity,.first,.later] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlabels : labels ∈ [Labels.absent,.same,.distinctHeld] := by
      cases labels <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturnRelation : returnRelation ∈ [Return.absent,.present] := by
      cases returnRelation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ overlap _ hoverlap
    apply CommonRefinement.memFlatMap _ _ fibre _ hfibre
    apply CommonRefinement.memFlatMap _ _ extension _ hextension
    apply CommonRefinement.memFlatMap _ _ labels _ hlabels
    apply CommonRefinement.memFlatMap _ _ returnRelation _ hreturnRelation
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 4000000 in
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  cases c with
  | mk coverage overlap fibre extension labels returnRelation extra =>
    cases coverage <;> cases overlap <;> cases fibre <;> cases extension <;> cases labels <;> cases returnRelation <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.coverage = .complete ∧ c.overlap = .disjoint ∧ c.fibre = .equal ∧ c.extension = .first ∧ c.labels = .distinctHeld ∧ c.returnRelation = .present ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk coverage overlap fibre extension labels returnRelation extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem coverageIncompleteRejected (c : Candidate) (h : c.coverage = .incomplete) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem overlapOverlappingRejected (c : Candidate) (h : c.overlap = .overlapping) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.overlap eq
    rw [h] at field
    cases field

theorem fibreUnequalRejected (c : Candidate) (h : c.fibre = .unequal) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fibre eq
    rw [h] at field
    cases field

theorem extensionIdentityRejected (c : Candidate) (h : c.extension = .identity) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

theorem extensionLaterRejected (c : Candidate) (h : c.extension = .later) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

theorem labelsAbsentRejected (c : Candidate) (h : c.labels = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.labels eq
    rw [h] at field
    cases field

theorem labelsSameRejected (c : Candidate) (h : c.labels = .same) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.labels eq
    rw [h] at field
    cases field

theorem returnRelationAbsentRejected (c : Candidate) (h : c.returnRelation = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.returnRelation eq
    rw [h] at field
    cases field

theorem extraHasExtraRejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.Fold
