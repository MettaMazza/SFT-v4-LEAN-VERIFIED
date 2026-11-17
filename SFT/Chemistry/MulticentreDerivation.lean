import SFT.Chemistry.MulticentreSupport
import Lean
namespace SFT.Chemistry.MulticentreDerivation
open SFT.Chemistry.MulticentreSupport SFT.Physics.CapabilityValues

theorem sameWordLength (xs ys : List HeldLabel) (h : sameWord xs ys = true) : xs.length = ys.length := by
 induction xs generalizing ys with
 | nil => cases ys with
   | nil => rfl
   | cons y ys => cases h
 | cons x xs ih => cases ys with
   | nil => cases h
   | cons y ys =>
    change (sameLabel x y && sameWord xs ys) = true at h
    cases head : sameLabel x y with
    | false => rw [head] at h; cases h
    | true => rw [head] at h; exact congrArg Nat.succ (ih ys h)

theorem allContainedUnderCons (xs ys : List HeldLabel) (y : HeldLabel)
 (h : xs.all (contains ys) = true) : xs.all (contains (y::ys)) = true := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change (contains ys x && xs.all (contains ys)) = true at h
  cases hx : contains ys x with
  | false => rw [hx] at h; cases h
  | true =>
   rw [hx] at h
   have tail := ih h
   change ((sameLabel x y || contains ys x) && xs.all (contains (y::ys))) = true
   rw [hx,tail]
   cases sameLabel x y <;> rfl

theorem sameWordCellsInside (xs ys : List HeldLabel) (h : sameWord xs ys = true) : xs.all (contains ys) = true := by
 induction xs generalizing ys with
 | nil => rfl
 | cons x xs ih => cases ys with
   | nil => cases h
   | cons y ys =>
    change (sameLabel x y && sameWord xs ys) = true at h
    cases head : sameLabel x y with
    | false => rw [head] at h; cases h
    | true =>
     rw [head] at h
     have tail := allContainedUnderCons xs ys y (ih ys h)
     change ((sameLabel x y || contains ys x) && xs.all (contains (y::ys))) = true
     rw [head,tail]
     rfl

-- The actual V3 constructor supplies both premises; neither is assumed by its caller.
theorem acceptedMeaning (m t : HeldLabel) (cs word : List HeldLabel) (es : List Edge) (s : Support)
 (h : construct m t cs es word = .ok s) : 3 ≤ s.centres.length ∧ sameWord s.electronSupport s.centres = true := by
 unfold construct at h
 cases g1 : (!SFT.Host.Text.equal m.family "molecular-carrier") with
 | true =>
  rw [g1] at h
  try dsimp only at h
  cases h
 | false =>
  rw [g1] at h
  try dsimp only at h
  cases g2 : (!(sameLabel t ribbon || sameLabel t surface || sameLabel t volume)) with
  | true =>
   rw [g2] at h
   try dsimp only at h
   cases h
  | false =>
   rw [g2] at h
   try dsimp only at h
   cases g3 : (decide (cs.length<3) || !distinct cs) with
   | true =>
    rw [g3] at h
    try dsimp only at h
    cases h
   | false =>
    rw [g3] at h
    try dsimp only at h
    cases g4 : (!(cs.all fun c => SFT.Host.Text.equal c.family "molecular-centre")) with
    | true =>
     rw [g4] at h
     try dsimp only at h
     cases h
    | false =>
     rw [g4] at h
     try dsimp only at h
     cases g5 : (!distinctEdges es) with
     | true =>
      rw [g5] at h
      try dsimp only at h
      cases h
     | false =>
      rw [g5] at h
      try dsimp only at h
      cases g6 : (!(es.all fun e => contains cs e.left && contains cs e.right)) with
      | true =>
       rw [g6] at h
       try dsimp only at h
       cases h
      | false =>
       rw [g6] at h
       try dsimp only at h
       cases g7 : (!sameWord word cs) with
       | true =>
        rw [g7] at h
        try dsimp only at h
        cases h
       | false =>
        rw [g7] at h
        try dsimp only at h
        cases g8 : (!connected cs es) with
        | true =>
         rw [g8] at h
         try dsimp only at h
         cases h
        | false =>
         rw [g8] at h
         try dsimp only at h
         cases g9 : (sameLabel t ribbon && !(es.length+1==cs.length && ((degrees cs es).filter (· == 1)).length==2 && (degrees cs es).all (fun d => d==1 || d==2))) with
         | true =>
          rw [g9] at h
          try dsimp only at h
          cases h
         | false =>
          rw [g9] at h
          try dsimp only at h
          cases g10 : (sameLabel t surface && !(es.length==cs.length && (degrees cs es).all (· == 2))) with
          | true =>
           rw [g10] at h
           try dsimp only at h
           cases h
          | false =>
           rw [g10] at h
           try dsimp only at h
           cases g11 : (sameLabel t volume && !(decide (cs.length>=4) && decide (es.length>cs.length) && (degrees cs es).any (· >= 3))) with
           | true =>
            rw [g11] at h
            try dsimp only at h
            cases h
           | false =>
            rw [g11] at h
            try dsimp only at h
            cases h
            constructor
            · change 3 ≤ cs.length
              cases small : decide (cs.length<3) with
              | true => rw [small] at g3; cases g3
              | false => exact Nat.le_of_not_gt (of_decide_eq_false small)
            · cases hw : sameWord word cs with
              | false => rw [hw] at g7; cases g7
              | true => rfl

theorem acceptedIrreducible (m t : HeldLabel) (cs word : List HeldLabel) (es : List Edge) (s : Support)
 (h : construct m t cs es word = .ok s) : irreducible s = true := by
 obtain ⟨lower,wordKept⟩ := acceptedMeaning m t cs word es s h
 have retained := sameWordCellsInside s.electronSupport s.centres wordKept
 unfold irreducible
 rw [retained]
 have bound : decide (s.centres.length ≥ 3) = true := by
  exact decide_eq_true lower
 rw [bound]
 rfl

theorem acceptedWordAtLeastThree (m t : HeldLabel) (cs word : List HeldLabel) (es : List Edge) (s : Support)
 (h : construct m t cs es word = .ok s) : 3 ≤ s.electronSupport.length := by
 obtain ⟨lower,wordKept⟩ := acceptedMeaning m t cs word es s h
 rw [sameWordLength s.electronSupport s.centres wordKept]
 exact lower

theorem acceptedWordNotPair (m t : HeldLabel) (cs word : List HeldLabel) (es : List Edge) (s : Support)
 (h : construct m t cs es word = .ok s) (a b : HeldLabel) : s.electronSupport ≠ [a,b] := by
 intro paired
 have lower := acceptedWordAtLeastThree m t cs word es s h
 rw [paired] at lower
 change 3 ≤ 2 at lower
 exact Nat.not_succ_le_self 2 lower

-- Source _connected: an edge scan only appends previously unreached centres.
theorem addReachedRetainsPrefix (xs : List HeldLabel) (x : HeldLabel) :
 ∃ tail, addReached xs x = xs ++ tail := by
 have appendNil (ys : List HeldLabel) : ys ++ [] = ys := by
  induction ys with
  | nil => rfl
  | cons y ys ih => exact congrArg (List.cons y) ih
 unfold addReached
 cases h : contains xs x with
 | false => exact ⟨[x], rfl⟩
 | true => exact ⟨[], (appendNil xs).symm⟩

theorem scanEdgesRetainsPrefix (es : List Edge) (xs : List HeldLabel) :
 ∃ tail, scanEdges es xs = xs ++ tail := by
 have appendNil (ys : List HeldLabel) : ys ++ [] = ys := by
  induction ys with
  | nil => rfl
  | cons y ys ih => exact congrArg (List.cons y) ih
 have appendAssoc (as bs cs : List HeldLabel) : (as ++ bs) ++ cs = as ++ (bs ++ cs) := by
  induction as with
  | nil => rfl
  | cons a as ih => exact congrArg (List.cons a) ih
 induction es generalizing xs with
 | nil => exact ⟨[], (appendNil xs).symm⟩
 | cons e es ih =>
  unfold scanEdges
  rw [List.foldl_cons]
  cases incident : (contains xs e.left || contains xs e.right) with
  | false =>
   exact ih xs
  | true =>
   obtain ⟨leftTail, hl⟩ := addReachedRetainsPrefix xs e.left
   obtain ⟨rightTail, hr⟩ := addReachedRetainsPrefix (addReached xs e.left) e.right
   obtain ⟨scanTail, hs⟩ := ih (addReached (addReached xs e.left) e.right)
   refine ⟨leftTail ++ (rightTail ++ scanTail), ?_⟩
   change scanEdges es (addReached (addReached xs e.left) e.right) = _
   rw [hs, hr, hl, appendAssoc, appendAssoc]

theorem scanEdgesLengthMonotone (es : List Edge) (xs : List HeldLabel) :
 xs.length ≤ (scanEdges es xs).length := by
 have appendLength (as bs : List HeldLabel) : (as ++ bs).length = as.length + bs.length := by
  induction as with
  | nil => exact (Nat.zero_add _).symm
  | cons a as ih =>
   change (as ++ bs).length + 1 = (as.length + 1) + bs.length
   rw [ih, Nat.succ_add]
 obtain ⟨tail,h⟩ := scanEdgesRetainsPrefix es xs
 rw [h, appendLength]
 exact Nat.le_add_right _ _

-- The Python stopping test is exactly a fixed point, not loss of a retained centre.
theorem scanEdgesStopsExactly (es : List Edge) (xs : List HeldLabel)
 (stopped : ¬ xs.length < (scanEdges es xs).length) : scanEdges es xs = xs := by
 have appendLength (as bs : List HeldLabel) : (as ++ bs).length = as.length + bs.length := by
  induction as with
  | nil => exact (Nat.zero_add _).symm
  | cons a as ih =>
   change (as ++ bs).length + 1 = (as.length + 1) + bs.length
   rw [ih, Nat.succ_add]
 obtain ⟨tail,h⟩ := scanEdgesRetainsPrefix es xs
 have size : xs.length + tail.length ≤ xs.length := by
  rw [h, appendLength] at stopped
  exact Nat.le_of_not_gt stopped
 have emptySize : tail.length = 0 := by
  cases n : tail.length with
  | zero => rfl
  | succ k =>
   rw [n] at size
   exact False.elim ((Nat.not_succ_le_self xs.length)
     (Nat.le_trans (Nat.succ_le_succ (Nat.le_add_right xs.length k)) size))
 have empty : tail = [] := List.eq_nil_of_length_eq_zero emptySize
 have appendNil (ys : List HeldLabel) : ys ++ [] = ys := by
  induction ys with
  | nil => rfl
  | cons y ys ih => exact congrArg (List.cons y) ih
 rw [h, empty, appendNil]

theorem connectedScanAtFixedPoint (n : Nat) (es : List Edge) (xs : List HeldLabel)
 (fixed : scanEdges es xs = xs) : connectedScan n es xs = xs := by
 cases n with
 | zero => rfl
 | succ n =>
  unfold connectedScan
  rw [fixed]
  exact if_neg (Nat.lt_irrefl _)


-- Constructor endpoint custody closes the reached set once all centres are present.
theorem scanRegisteredCentresFixed (es : List Edge) (cs : List HeldLabel)
 (custody : es.all (fun e => contains cs e.left && contains cs e.right) = true) :
 scanEdges es cs = cs := by
 induction es with
 | nil => rfl
 | cons e es ih =>
  change ((contains cs e.left && contains cs e.right) &&
    es.all (fun e => contains cs e.left && contains cs e.right)) = true at custody
  cases left : contains cs e.left with
  | false => rw [left] at custody; cases custody
  | true =>
   rw [left] at custody
   cases right : contains cs e.right with
   | false => rw [right] at custody; cases custody
   | true =>
    rw [right] at custody
    change scanEdges es (if contains cs e.left || contains cs e.right then
      addReached (addReached cs e.left) e.right else cs) = cs
    have l : addReached cs e.left = cs := by unfold addReached; rw [left]; rfl
    have r : addReached cs e.right = cs := by unfold addReached; rw [right]; rfl
    rw [left, right, l, r]
    exact ih custody

theorem scanEdgesConcatenation (first rest : List Edge) (cs : List HeldLabel) :
 scanEdges (first ++ rest) cs = scanEdges rest (scanEdges first cs) := by
 induction first generalizing cs with
 | nil => rfl
 | cons e es ih =>
  exact ih (if contains cs e.left || contains cs e.right then
    addReached (addReached cs e.left) e.right else cs)

-- Original connected-successor step: attach a fresh centre to a retained endpoint.
theorem attachedCentreReached (es : List Edge) (cs : List HeldLabel) (anchor fresh : HeldLabel)
 (custody : es.all (fun e => contains cs e.left && contains cs e.right) = true)
 (held : contains cs anchor = true) (newCentre : contains cs fresh = false) :
 scanEdges (es ++ [⟨anchor,fresh⟩]) cs = cs ++ [fresh] := by
 rw [scanEdgesConcatenation, scanRegisteredCentresFixed es cs custody]
 change (if contains cs anchor || contains cs fresh then
    addReached (addReached cs anchor) fresh else cs) = cs ++ [fresh]
 have anchorRetained : addReached cs anchor = cs := by
  unfold addReached
  rw [held]
  rfl
 rw [held, newCentre, anchorRetained]
 unfold addReached
 rw [newCentre]
 rfl

end SFT.Chemistry.MulticentreDerivation
