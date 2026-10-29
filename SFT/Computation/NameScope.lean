import SFT.Computation.SyntaxFormation
namespace SFT.Computation.NameScope
open SymbolicEvaluation SymbolicContext NumericalError
open SFT.InformationScience.EncodingMaps
open SFT.Foundation.Count.TraceDerivation

structure Occurrence where
  address : List Direction
  label : String
  value : Option Number

def ledger (environment : Environment) (path : List Direction) : Expr → List Occurrence
 | .value _ => []
 | .outside _ => []
 | .name label => [⟨path,label,lookupFirst environment label⟩]
 | .join left right => ledger environment (path++[.left]) left ++ ledger environment (path++[.right]) right

inductive Located (environment : Environment) : List Direction → Expr → Occurrence → Prop where
 | name (path label) : Located environment path (.name label) ⟨path,label,lookupFirst environment label⟩
 | left (path a b row) : Located environment (path++[.left]) a row → Located environment path (.join a b) row
 | right (path a b row) : Located environment (path++[.right]) b row → Located environment path (.join a b) row

theorem ledgerDerivation (environment : Environment) (path : List Direction) (expression : Expr) (row : Occurrence)
    (member : row ∈ ledger environment path expression) : Located environment path expression row := by
  induction expression generalizing path with
  | value => cases member
  | outside => cases member
  | name label => cases member with | head => exact .name _ _ | tail _ h => cases h
  | join left right il ir =>
    cases memAppendCases _ _ _ member with
    | inl h => exact .left _ _ _ _ (il _ h)
    | inr h => exact .right _ _ _ _ (ir _ h)

theorem derivationLedger (environment : Environment) (path : List Direction) (expression : Expr) (row : Occurrence)
    (proof : Located environment path expression row) : row ∈ ledger environment path expression := by
  induction proof with
  | name => exact List.Mem.head _
  | left path a b row h ih => exact memAppendLeft _ _ _ ih
  | right path a b row h ih => exact memAppendRight _ _ _ ih

theorem completeLedger (environment : Environment) (path : List Direction) (expression : Expr) (row : Occurrence) :
    row ∈ ledger environment path expression ↔ Located environment path expression row :=
  ⟨ledgerDerivation _ _ _ _,derivationLedger _ _ _ _⟩

theorem exactIdentity (environment : Environment) (path : List Direction) (expression : Expr) (row : Occurrence)
    (proof : Located environment path expression row) : row.value = lookupFirst environment row.label := by
  induction proof with
  | name => rfl
  | left path a b row h ih => exact ih
  | right path a b row h ih => exact ih

def bound (row : Occurrence) : Bool := row.value.isSome

def boundRows (environment : Environment) (path : List Direction) (expression : Expr) : List Occurrence :=
  (ledger environment path expression).filter bound

def freeRows (environment : Environment) (path : List Direction) (expression : Expr) : List Occurrence :=
  (ledger environment path expression).filter (fun row => !bound row)

theorem scopePartition (environment : Environment) (path : List Direction) (expression : Expr) (row : Occurrence)
    (member : row ∈ ledger environment path expression) :
    row ∈ boundRows environment path expression ∨ row ∈ freeRows environment path expression := by
  cases h : bound row with
  | true => exact Or.inl ((SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨member,h⟩)
  | false => exact Or.inr ((SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨member,by rw [h]; rfl⟩)

theorem disjointScope (environment : Environment) (path : List Direction) (expression : Expr) (row : Occurrence)
    (a : row ∈ boundRows environment path expression) (b : row ∈ freeRows environment path expression) : False := by
  have ha := ((SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp a).2
  have hb := ((SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp b).2
  rw [ha] at hb
  cases hb

theorem boundSourceRow (environment : Environment) (path : List Direction) (expression : Expr) (row : Occurrence)
    (member : row ∈ boundRows environment path expression) :
    ∃ value, row.value = some value ∧ (row.label,value) ∈ environment := by
  have parts := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp member
  have identity := exactIdentity _ _ _ _ (ledgerDerivation _ _ _ _ parts.1)
  cases hv : row.value with
  | none => have yes := parts.2; change row.value.isSome = true at yes; rw [hv] at yes; cases yes
  | some value => exact ⟨value,rfl,lookupRow _ _ _ (identity.symm.trans hv)⟩

theorem freeHasNoBinding (environment : Environment) (path : List Direction) (expression : Expr) (row : Occurrence)
    (member : row ∈ freeRows environment path expression) : lookupFirst environment row.label = none := by
  have parts := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp member
  have identity := exactIdentity _ _ _ _ (ledgerDerivation _ _ _ _ parts.1)
  cases hv : row.value with
  | none => exact identity.symm.trans hv
  | some value => have no := parts.2; change (!row.value.isSome) = true at no; rw [hv] at no; cases no

def nameCount : Expr → Nat
 | .value _ => 0
 | .outside _ => 0
 | .name _ => 1
 | .join left right => nameCount left + nameCount right

theorem noOmittedOccurrences (environment : Environment) (path : List Direction) (expression : Expr) :
    (ledger environment path expression).length = nameCount expression := by
  induction expression generalizing path with
  | value => rfl
  | outside => rfl
  | name => rfl
  | join left right il ir =>
    change (ledger environment (path++[.left]) left ++ ledger environment (path++[.right]) right).length = _
    rw [SFT.Foundation.CommonRefinement.appendLength,il,ir]
    rfl

theorem scopeExtension (before after : Environment) (expression : Expr) (path : List Direction)
    (unchanged : ∀ label, lookupFirst before label = lookupFirst after label) :
    ledger before path expression = ledger after path expression := by
  induction expression generalizing path with
  | value => rfl
  | outside => rfl
  | name label => change [Occurrence.mk path label (lookupFirst before label)] = _; rw [unchanged]; rfl
  | join left right il ir => change ledger before _ left ++ ledger before _ right = _; rw [il,ir]; rfl

theorem evaluatedNamesBound (environment : Environment) (expression : Expr) (value : Number)
    (evaluated : Evaluation environment expression value) :
    ∀ path row, Located environment path expression row → ∃ found, row.value = some found := by
  induction evaluated with
  | value p => intro path row h; cases h
  | name label value bound =>
    intro path row h
    cases h
    exact ⟨value,bound⟩
  | join left right a b hl hr il ir =>
    intro path row h
    cases h with
    | left _ _ _ _ member => exact il _ _ member
    | right _ _ _ _ member => exact ir _ _ member

theorem successfulScope (environment : Environment) (expression : Expr) (value : Number)
    (accepted : evaluate environment expression = .ok value) :
    ∀ path row, row ∈ ledger environment path expression →
      ∃ found, row.value = some found ∧ lookupFirst environment row.label = some found := by
  intro path row member
  have located := ledgerDerivation _ _ _ _ member
  obtain ⟨found,bound⟩ := evaluatedNamesBound _ _ _ (SymbolicEvaluation.reconstruct _ _ _ accepted) _ _ located
  exact ⟨found,bound,(exactIdentity _ _ _ _ located).symm.trans bound⟩

theorem scopeConstructsEvaluation (environment : Environment) (expression : Expr)
    (generated : Generated expression)
    (resolved : ∀ path row, Located environment path expression row → ∃ found, row.value = some found) :
    ∃ value, Evaluation environment expression value := by
  induction generated with
  | value p => exact ⟨.positive p,.value p⟩
  | name label =>
    obtain ⟨value,bound⟩ := resolved [] ⟨[],label,lookupFirst environment label⟩ (.name [] label)
    exact ⟨value,.name label value bound⟩
  | join left right hl hr il ir =>
    have boundLeft : ∀ path row, Located environment path left row → ∃ found, row.value = some found := by
      intro path row member
      have identity := exactIdentity _ _ _ _ member
      -- Locate the same labelled leaf through any occurrence of the left tree.
      have relocate : ∀ p e r, Located environment p e r →
          ∀ q, ∃ relocated, Located environment q e relocated ∧ relocated.label = r.label ∧ relocated.value = r.value := by
        intro p e r proof
        induction proof with
        | name p label => intro q; exact ⟨⟨q,label,lookupFirst environment label⟩,.name _ _,rfl,rfl⟩
        | left p a b r h ih =>
          intro q; obtain ⟨n,hn,hl,hv⟩ := ih (q++[.left]); exact ⟨n,.left _ _ _ _ hn,hl,hv⟩
        | right p a b r h ih =>
          intro q; obtain ⟨n,hn,hl,hv⟩ := ih (q++[.right]); exact ⟨n,.right _ _ _ _ hn,hl,hv⟩
      obtain ⟨n,hn,hl,hv⟩ := relocate _ _ _ member [.left]
      obtain ⟨found,hf⟩ := resolved [] n (.left [] left right n hn)
      exact ⟨found,hv.symm.trans hf⟩
    have boundRight : ∀ path row, Located environment path right row → ∃ found, row.value = some found := by
      intro path row member
      -- The resolved-value premise can use an arbitrary base path; prefix it
      -- by reconstruction of the same expression's occurrence derivation.
      have relocate : ∀ p e r, Located environment p e r →
          ∀ q, ∃ relocated, Located environment q e relocated ∧ relocated.value = r.value := by
        intro p e r proof
        induction proof with
        | name p label => intro q; exact ⟨⟨q,label,lookupFirst environment label⟩,.name _ _,rfl⟩
        | left p a b r h ih => intro q; obtain ⟨n,hn,hv⟩ := ih (q++[.left]); exact ⟨n,.left _ _ _ _ hn,hv⟩
        | right p a b r h ih => intro q; obtain ⟨n,hn,hv⟩ := ih (q++[.right]); exact ⟨n,.right _ _ _ _ hn,hv⟩
      obtain ⟨n,hn,hv⟩ := relocate _ _ _ member [.right]
      obtain ⟨found,hf⟩ := resolved [] n (.right [] left right n hn)
      exact ⟨found,hv.symm.trans hf⟩
    obtain ⟨a,ha⟩ := il boundLeft
    obtain ⟨b,hb⟩ := ir boundRight
    exact ⟨SymbolicValues.add a b,.join _ _ _ _ ha hb⟩

end SFT.Computation.NameScope
