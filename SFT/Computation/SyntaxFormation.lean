import SFT.Computation.SymbolicContext
namespace SFT.Computation.SyntaxFormation
open SymbolicEvaluation SymbolicContext NumericalError
open SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

-- Original value/name/join constructors; binding and evaluation are separate.
def formed : Expr → Bool
 | .value value => match value with
   | none => false
   | some number => match number with
     | .zero => false
     | .negative _ => false
     | .positive _ => true
 | .name _ => true
 | .join left right => formed left && formed right
 | .outside _ => false

theorem acceptsDerivation (expression : Expr) (proof : Generated expression) : formed expression = true := by
  induction proof with
  | value => rfl
  | name => rfl
  | join left right a b ihLeft ihRight => exact (andTrue _ _).mpr ⟨ihLeft,ihRight⟩

theorem membershipDerivation (expression : Expr) (accepted : formed expression = true) : Generated expression := by
  induction expression with
  | value v =>
    cases v with
    | none => cases accepted
    | some n => cases n with
      | zero => cases accepted
      | negative p => cases accepted
      | positive p => exact .value p
  | name n => exact .name n
  | join left right il ir =>
    have parts := (andTrue _ _).mp accepted
    exact .join _ _ (il parts.1) (ir parts.2)
  | outside n => cases accepted

theorem membership (expression : Expr) : formed expression = true ↔ Generated expression :=
  ⟨membershipDerivation expression,acceptsDerivation expression⟩

inductive Malformed : Expr → Prop where
 | foreign : Malformed (.value none)
 | zero : Malformed (.value (some .zero))
 | negative (part) : Malformed (.value (some (.negative part)))
 | outside (tag) : Malformed (.outside tag)
 | left (a b) : Malformed a → Malformed (.join a b)
 | right (a b) : Malformed b → Malformed (.join a b)

theorem malformedRejects (expression : Expr) (bad : Malformed expression) : formed expression = false := by
  induction bad with
  | foreign => rfl
  | zero => rfl
  | negative => rfl
  | outside => rfl
  | left a b h ih => change (formed a && formed b) = false; rw [ih]; rfl
  | right a b h ih => change (formed a && formed b) = false; rw [ih]; exact Bool.and_false _

theorem rejectionDerivation (expression : Expr) (rejected : formed expression = false) : Malformed expression := by
  induction expression with
  | value v =>
    cases v with
    | none => exact .foreign
    | some n => cases n with
      | zero => exact .zero
      | negative p => exact .negative p
      | positive p => cases rejected
  | name n => cases rejected
  | outside n => exact .outside n
  | join left right il ir =>
    cases hl : formed left with
    | false => exact .left _ _ (il hl)
    | true =>
      change (formed left && formed right) = false at rejected
      rw [hl] at rejected
      exact .right _ _ (ir rejected)

theorem rejection (expression : Expr) : formed expression = false ↔ Malformed expression :=
  ⟨rejectionDerivation expression,malformedRejects expression⟩

abbrev Row := List Direction × Expr

def lift (direction : Direction) (row : Row) : Row := (direction::row.1,row.2)

def treeRows : Expr → List Row
 | .value v => [([], .value v)]
 | .name n => [([], .name n)]
 | .outside n => [([], .outside n)]
 | .join left right => ([],.join left right) :: ((treeRows left).map (lift .left) ++ (treeRows right).map (lift .right))

theorem rootRetained (expression : Expr) : ([],expression) ∈ treeRows expression := by
  cases expression <;> exact List.Mem.head _

theorem rowFocus (expression : Expr) (row : Row) (member : row ∈ treeRows expression) :
    focus expression row.1 = some row.2 := by
  induction expression generalizing row with
  | value v => cases member with | head => rfl | tail _ h => cases h
  | name n => cases member with | head => rfl | tail _ h => cases h
  | outside n => cases member with | head => rfl | tail _ h => cases h
  | join left right il ir =>
    cases member with
    | head => rfl
    | tail _ h =>
      cases memAppendCases _ _ _ h with
      | inl hl =>
        obtain ⟨r,hm,same⟩ := memMapPreimage _ _ _ hl
        cases same
        exact il _ hm
      | inr hr =>
        obtain ⟨r,hm,same⟩ := memMapPreimage _ _ _ hr
        cases same
        exact ir _ hm

theorem focusRetained (expression subtree : Expr) (path : List Direction)
    (found : focus expression path = some subtree) : (path,subtree) ∈ treeRows expression := by
  induction path generalizing expression subtree with
  | nil => cases found; exact rootRetained _
  | cons direction rest ih =>
    cases expression with
    | value v => cases found
    | name n => cases found
    | outside n => cases found
    | join left right =>
      cases direction with
      | left =>
        have inner := ih left subtree found
        exact List.Mem.tail _ (memAppendLeft _ _ _ (memMap (lift .left) _ _ inner))
      | right =>
        have inner := ih right subtree found
        exact List.Mem.tail _ (memAppendRight _ _ _ (memMap (lift .right) _ _ inner))

theorem completeTree (expression : Expr) (row : Row) :
    row ∈ treeRows expression ↔ focus expression row.1 = some row.2 :=
  ⟨rowFocus _ _,fun h => focusRetained _ _ _ h⟩

def constructorIdentity : Expr → String
 | .value _ => "value"
 | .name _ => "name"
 | .join _ _ => "join"
 | .outside tag => tag

theorem constructorAlphabet (expression : Expr) (proof : Generated expression) :
    constructorIdentity expression = "value" ∨ constructorIdentity expression = "name" ∨ constructorIdentity expression = "join" := by
  cases proof with
  | value => exact Or.inl rfl
  | name => exact Or.inr (Or.inl rfl)
  | join => exact Or.inr (Or.inr rfl)

theorem nameWithoutMeaning (name : String) :
    formed (.name name) = true ∧ evaluate [] (.name name) = .error "unbound name" := ⟨rfl,rfl⟩

theorem generatedContextComposition (context : Context) (expression : Expr)
    (outside : GeneratedContext context) (inside : formed expression = true) :
    formed (plug context expression) = true :=
  acceptsDerivation _ (plugGenerated _ _ outside (membershipDerivation _ inside))

theorem uniqueOccurrence (expression left right : Expr) (path : List Direction)
    (a : (path,left) ∈ treeRows expression) (b : (path,right) ∈ treeRows expression) : left = right :=
  Option.some.inj ((rowFocus _ _ a).symm.trans (rowFocus _ _ b))

theorem everySubtreeFormed (expression : Expr) (row : Row)
    (accepted : formed expression = true) (member : row ∈ treeRows expression) : formed row.2 = true := by
  obtain ⟨context,same,location⟩ := focusContext _ _ _ (rowFocus _ _ member)
  have gen := membershipDerivation _ accepted
  rw [← same] at gen
  exact acceptsDerivation _ (generatedDecomposition _ _ gen).2

theorem everyConstructorRegistered (expression : Expr) (row : Row)
    (accepted : formed expression = true) (member : row ∈ treeRows expression) :
    constructorIdentity row.2 = "value" ∨ constructorIdentity row.2 = "name" ∨ constructorIdentity row.2 = "join" :=
  constructorAlphabet _ (membershipDerivation _ (everySubtreeFormed _ _ accepted member))

theorem malformedOccurrenceRejects (expression : Expr) (row : Row)
    (member : row ∈ treeRows expression) (malformed : Malformed row.2) : formed expression = false := by
  cases decision : formed expression with
  | false => rfl
  | true =>
    have valid := everySubtreeFormed _ _ decision member
    have invalid := malformedRejects _ malformed
    rw [valid] at invalid
    cases invalid

theorem joinRetainsLeft (left right : Expr) (row : Row) (member : row ∈ treeRows left) :
    lift .left row ∈ treeRows (.join left right) :=
  List.Mem.tail _ (memAppendLeft _ _ _ (memMap (lift .left) _ _ member))

theorem joinRetainsRight (left right : Expr) (row : Row) (member : row ∈ treeRows right) :
    lift .right row ∈ treeRows (.join left right) :=
  List.Mem.tail _ (memAppendRight _ _ _ (memMap (lift .right) _ _ member))

theorem joinAdmission (left right : Expr) :
    formed (.join left right) = true ↔ formed left = true ∧ formed right = true := andTrue _ _

theorem literalBase (part : SFT.Foundation.ExactOperations.PositiveFraction) :
    formed (.value (some (.positive part))) = true ∧
    treeRows (.value (some (.positive part))) = [([], .value (some (.positive part)))] := ⟨rfl,rfl⟩

end SFT.Computation.SyntaxFormation
