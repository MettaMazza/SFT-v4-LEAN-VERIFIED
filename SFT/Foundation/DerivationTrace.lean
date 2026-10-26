import SFT.Foundation.FoldDynamics
import SFT.Host.Canonical

namespace SFT.Foundation.DerivationTrace
open ExactOperations ExactPartCarrier

structure DerivationRow where
  operation : String
  inputHashes : List String
  output : Part
  outputHash : String

def partIdentity (p : Part) : String := Host.Canonical.identity <|
  .object [("value", .object [("numerator", .integer p.numerator),
    ("denominator", .integer p.denominator)])]

def row (operation : String) (inputs : List Part) (output : Part) : DerivationRow :=
  ⟨operation, inputs.map partIdentity, output, partIdentity output⟩

def execute (operation : String) (current : Part) : Except String Part :=
  if Host.Text.equal operation "Fold" then .ok (foldPart current)
  else if Host.Text.equal operation "Take" then takePart one current
  else .error "trace contains an unregistered operation"

def outputMatches (item : DerivationRow) (result : Part) : Bool :=
  Host.Text.equal (partIdentity result) item.outputHash &&
    (result.numerator == item.output.numerator && result.denominator == item.output.denominator)

def replayFrom (current : Part) : List DerivationRow → Except String Part
  | [] => .ok current
  | item::rest => match execute item.operation current with
    | .error e => .error e
    | .ok result => if outputMatches item result then replayFrom result rest
      else .error "trace row does not replay to its bound output"

def replay (trace : List DerivationRow) : Except String Part :=
  replayFrom FoldDynamics.third trace

-- Ordered row construction for the source closure's finite successor induction.
def stepInputs (operation : String) (current : Part) : List Part :=
  if Host.Text.equal operation "Take" then [one,current] else [current]

def recordFrom (current : Part) : List String → Except String (List DerivationRow × Part)
  | [] => .ok ([],current)
  | operation::rest => match execute operation current with
    | .error e => .error e
    | .ok result => match recordFrom result rest with
      | .error e => .error e
      | .ok (rows,terminal) => .ok (row operation (stepInputs operation current) result :: rows,terminal)

theorem identityBytesReflexive (xs : List Nat) : (xs == xs) = true := by
  induction xs with
  | nil => rfl
  | cons n ns ih =>
    change (n == n && (ns == ns)) = true
    have same : (n == n) = true := by change decide (n = n) = true; exact decide_eq_true rfl
    rw [same,ih]
    rfl

theorem constructedOutputMatches (op : String) (inputs : List Part) (p : Part) :
    outputMatches (row op inputs p) p = true := by
  unfold outputMatches row Host.Text.equal
  have hn : (p.numerator == p.numerator) = true := by
    change decide (p.numerator = p.numerator) = true; exact decide_eq_true rfl
  have hd : (p.denominator == p.denominator) = true := by
    change decide (p.denominator = p.denominator) = true; exact decide_eq_true rfl
  rw [identityBytesReflexive,hn,hd]
  rfl

theorem emptyReplay (p : Part) : replayFrom p [] = .ok p := rfl

theorem replayConstructedStep (op : String) (inputs : List Part) (p q : Part)
    (accepted : execute op p = .ok q) (rest : List DerivationRow) :
    replayFrom p (row op inputs q :: rest) = replayFrom q rest := by
  change ((match execute op p with
    | .error e => .error e
    | .ok result => if outputMatches (row op inputs q) result then replayFrom result rest
      else .error "trace row does not replay to its bound output") : Except String Part) = _
  rw [accepted]
  dsimp only
  rw [constructedOutputMatches]
  rfl

theorem generatedTraceReplays (operations : List String) (initial : Part)
    (rows : List DerivationRow) (terminal : Part)
    (generated : recordFrom initial operations = .ok (rows,terminal)) :
    replayFrom initial rows = .ok terminal := by
  induction operations generalizing initial rows terminal with
  | nil =>
    change Except.ok ([],initial) = Except.ok (rows,terminal) at generated
    cases generated
    rfl
  | cons op ops ih =>
    cases h : execute op initial with
    | error e => unfold recordFrom at generated; rw [h] at generated; cases generated
    | ok next =>
      cases t : recordFrom next ops with
      | error e => unfold recordFrom at generated; rw [h] at generated; dsimp only at generated; rw [t] at generated; cases generated
      | ok pair =>
        obtain ⟨tail,last⟩ := pair
        unfold recordFrom at generated
        rw [h] at generated; dsimp only at generated; rw [t] at generated
        cases generated
        rw [replayConstructedStep op (stepInputs op initial) initial next h]
        exact ih next tail terminal t

theorem replayAppend (left right : List DerivationRow) (initial middle : Part)
    (accepted : replayFrom initial left = .ok middle) :
    replayFrom initial (left ++ right) = replayFrom middle right := by
  induction left generalizing initial with
  | nil => cases accepted; rfl
  | cons item tail ih =>
    cases h : execute item.operation initial with
    | error e => unfold replayFrom at accepted; rw [h] at accepted; cases accepted
    | ok next =>
      cases v : outputMatches item next with
      | false => unfold replayFrom at accepted; rw [h] at accepted; dsimp only at accepted; rw [v] at accepted; cases accepted
      | true =>
        change replayFrom initial (item :: (tail ++ right)) = _
        unfold replayFrom at accepted ⊢
        rw [h] at accepted ⊢
        dsimp only at accepted ⊢
        rw [v] at accepted ⊢
        rw [ite_eq_left rfl]
        exact (ih next accepted).trans (by cases right <;> rfl)

theorem finiteSuccessorReplay (rows : List DerivationRow) (initial current next : Part)
    (op : String) (inputs : List Part)
    (prior : replayFrom initial rows = .ok current)
    (step : execute op current = .ok next) :
    replayFrom initial (rows ++ [row op inputs next]) = .ok next := by
  rw [replayAppend rows [row op inputs next] initial current prior,
    replayConstructedStep op inputs current next step]
  rfl

theorem emptySourceReplay : replay [] = .ok FoldDynamics.third := rfl

theorem foldDispatch (p : Part) : execute "Fold" p = .ok (foldPart p) := rfl

theorem takeDispatch (p : Part) : execute "Take" p = takePart one p := rfl

theorem unregisteredSelect (p : Part) :
    execute "Select" p = .error "trace contains an unregistered operation" := rfl

end SFT.Foundation.DerivationTrace
