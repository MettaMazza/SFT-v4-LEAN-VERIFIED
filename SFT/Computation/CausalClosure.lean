import SFT.Computation.ProgramVerification
import SFT.Mathematics.GeometryTopology
namespace SFT.Computation.CausalClosure
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation
abbrev Edge := String × String

-- A positive path has at least one original edge; no reflexive edge is inserted.
inductive Path (edges : List Edge) : String → String → Prop where
 | edge (left right : String) (held : (left,right) ∈ edges) : Path edges left right
 | join (left middle right : String) (first : Path edges left middle) (second : Path edges middle right) : Path edges left right

def linked (rows : List Edge) (edge : Edge) : Bool :=
  rows.any (fun first => rows.any (fun second =>
    decide (first.1 = edge.1 ∧ first.2 = second.1 ∧ second.2 = edge.2)))

theorem linkedMeaning (rows : List Edge) (edge : Edge) : linked rows edge = true ↔
    ∃ first second, first ∈ rows ∧ second ∈ rows ∧
      first.1 = edge.1 ∧ first.2 = second.1 ∧ second.2 = edge.2 := by
  constructor
  · intro h
    obtain ⟨first,one,tail⟩ := (anyTrueIff _ _).mp h
    obtain ⟨second,two,held⟩ := (anyTrueIff _ _).mp tail
    exact ⟨first,second,one,two,of_decide_eq_true held⟩
  · intro ⟨first,second,one,two,held⟩
    exact (anyTrueIff _ _).mpr ⟨first,one,(anyTrueIff _ _).mpr ⟨second,two,decide_eq_true held⟩⟩

-- The finite pairSupport is the complete admitted pair support. Internal set
-- membership is represented by selecting precisely the held pair cells.
def expand (pairSupport rows : List Edge) : List Edge :=
  pairSupport.filter (fun edge => has rows edge || linked rows edge)

theorem expansionMeaning (pairSupport rows : List Edge) (edge : Edge) :
    edge ∈ expand pairSupport rows ↔ edge ∈ pairSupport ∧ (edge ∈ rows ∨ linked rows edge = true) := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    refine ⟨p.1,?_⟩
    cases held : has rows edge with
    | true => exact Or.inl ((hasIff _ _).mp held)
    | false => rw [held] at p; exact Or.inr p.2
  · intro ⟨present,decision⟩
    apply (filterMemberIff _ _ _).mpr
    refine ⟨present,?_⟩
    cases decision with
    | inl held => rw [(hasIff _ _).mpr held]; rfl
    | inr joined => rw [joined]; cases has rows edge <;> rfl

theorem preservesOriginal (pairSupport rows : List Edge) (edge : Edge)
    (support : edge ∈ pairSupport) (held : edge ∈ rows) : edge ∈ expand pairSupport rows :=
  (expansionMeaning _ _ _).mpr ⟨support,Or.inl held⟩

theorem joinsHeld (pairSupport rows : List Edge) (left middle right : String)
    (support : (left,right) ∈ pairSupport) (first : (left,middle) ∈ rows) (second : (middle,right) ∈ rows) :
    (left,right) ∈ expand pairSupport rows :=
  (expansionMeaning _ _ _).mpr ⟨support,Or.inr ((linkedMeaning _ _).mpr
    ⟨(left,middle),(middle,right),first,second,rfl,rfl,rfl⟩)⟩

theorem expansionSound (original pairSupport rows : List Edge)
    (sound : ∀ edge, edge ∈ rows → Path original edge.1 edge.2)
    (edge : Edge) (held : edge ∈ expand pairSupport rows) : Path original edge.1 edge.2 := by
  cases ((expansionMeaning _ _ _).mp held).2 with
  | inl old => exact sound edge old
  | inr joined =>
    obtain ⟨first,second,one,two,start,interface,finish⟩ := (linkedMeaning _ _).mp joined
    have a := sound first one
    have b := sound second two
    rw [start,interface] at a
    rw [finish] at b
    exact .join _ _ _ a b

inductive Rounds (pairSupport original : List Edge) : List Edge → Prop where
 | base : Rounds pairSupport original original
 | next (rows : List Edge) (prior : Rounds pairSupport original rows) : Rounds pairSupport original (expand pairSupport rows)

theorem roundsSound (pairSupport original rows : List Edge) (rounds : Rounds pairSupport original rows) :
    ∀ edge, edge ∈ rows → Path original edge.1 edge.2 := by
  induction rounds with
  | base => intro edge held; exact .edge _ _ held
  | next rows prior ih => exact expansionSound original pairSupport rows ih

def Closed (rows : List Edge) : Prop :=
  ∀ left middle right, (left,middle) ∈ rows → (middle,right) ∈ rows → (left,right) ∈ rows

theorem fixedPointClosed (pairSupport rows : List Edge)
    (supported : ∀ left middle right, (left,middle) ∈ rows → (middle,right) ∈ rows → (left,right) ∈ pairSupport)
    (fixed : ∀ edge, edge ∈ expand pairSupport rows → edge ∈ rows) : Closed rows :=
  fun left middle right first second => fixed _ (joinsHeld _ _ _ _ _ (supported _ _ _ first second) first second)

theorem pathLeast (original closed : List Edge)
    (contains : ∀ edge, edge ∈ original → edge ∈ closed) (transitive : Closed closed)
    (left right : String) (path : Path original left right) : (left,right) ∈ closed := by
  induction path with
  | edge left right held => exact contains _ held
  | join left middle right first second ihLeft ihRight => exact transitive _ _ _ ihLeft ihRight

theorem exactClosure (pairSupport original rows : List Edge) (rounds : Rounds pairSupport original rows)
    (contains : ∀ edge, edge ∈ original → edge ∈ rows) (transitive : Closed rows) (left right : String) :
    (left,right) ∈ rows ↔ Path original left right :=
  ⟨roundsSound _ _ _ rounds _,pathLeast _ _ contains transitive _ _⟩

theorem cycleBoundary (pairSupport original rows : List Edge) (rounds : Rounds pairSupport original rows)
    (contains : ∀ edge, edge ∈ original → edge ∈ rows) (transitive : Closed rows) :
    (∀ state, ¬ (state,state) ∈ rows) ↔ ∀ state, ¬ Path original state state := by
  constructor
  · intro noCycles state path
    exact noCycles state ((exactClosure _ _ _ rounds contains transitive _ _).mpr path)
  · intro noCycles state held
    exact noCycles state ((exactClosure _ _ _ rounds contains transitive _ _).mp held)

theorem roundsPreserve (pairSupport original rows : List Edge)
    (supported : ∀ edge, edge ∈ original → edge ∈ pairSupport)
    (rounds : Rounds pairSupport original rows) : ∀ edge, edge ∈ original → edge ∈ rows := by
  induction rounds with
  | base => exact fun _ h => h
  | next rows prior ih => intro edge held; exact preservesOriginal _ _ _ (supported edge held) (ih edge held)

theorem pathEndpoints (events : List String) (original : List Edge)
    (supported : ∀ edge, edge ∈ original → edge.1 ∈ events ∧ edge.2 ∈ events)
    (left right : String) (path : Path original left right) : left ∈ events ∧ right ∈ events := by
  induction path with
  | edge left right held => exact supported _ held
  | join left middle right first second ihLeft ihRight => exact ⟨ihLeft.1,ihRight.2⟩

theorem emptyPathImpossible (left right : String) : ¬ Path [] left right := by
  intro path
  induction path with
  | edge left right held => cases held
  | join left middle right first second ihLeft ihRight => exact ihLeft

end SFT.Computation.CausalClosure
