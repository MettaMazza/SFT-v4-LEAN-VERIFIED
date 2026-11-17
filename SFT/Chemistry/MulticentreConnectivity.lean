import SFT.Chemistry.MulticentreDerivation
import SFT.Foundation.CountTrace
namespace SFT.Chemistry.MulticentreConnectivity
open SFT.Chemistry.MulticentreSupport SFT.Chemistry.MulticentreDerivation
open SFT.Physics.CapabilityValues SFT.Foundation.Count.TraceDerivation

-- Proof-only identity keys are the byte lists already compared by sameLabel.
def identityKey (x : HeldLabel) : List Nat × List Nat :=
 (x.family.toUTF8.data.toList.map UInt8.toNat, x.label.toUTF8.data.toList.map UInt8.toNat)

theorem sameLabelKey (a b : HeldLabel) : sameLabel a b = true ↔ identityKey a = identityKey b := by
 have natSelf (n : Nat) : (n == n) = true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 have listEq (xs ys : List Nat) : (xs == ys) = true ↔ xs = ys := by
  induction xs generalizing ys with
  | nil => cases ys with
    | nil => exact ⟨fun _ => rfl, fun _ => rfl⟩
    | cons y ys => exact ⟨(fun h => by cases h), (fun h => by cases h)⟩
  | cons x xs ih => cases ys with
    | nil => exact ⟨(fun h => by cases h), (fun h => by cases h)⟩
    | cons y ys =>
     constructor
     · intro h
       change ((x == y) && (xs == ys)) = true at h
       cases head : (x == y) with
       | false => rw [head] at h; cases h
       | true =>
        rw [head] at h
        have xy : x = y := Nat.eq_of_beq_eq_true head
        cases xy
        exact congrArg (List.cons x) ((ih ys).mp h)
     · intro h
       cases h
       change ((x == x) && (xs == xs)) = true
       have xx : (x == x) = true := natSelf x
       rw [xx, (ih xs).mpr rfl]
       rfl
 unfold sameLabel SFT.Host.Text.equal identityKey
 constructor
 · intro h
   cases family : (a.family.toUTF8.data.toList.map UInt8.toNat == b.family.toUTF8.data.toList.map UInt8.toNat) with
   | false => rw [family] at h; cases h
   | true =>
    rw [family] at h
    exact Prod.ext ((listEq _ _).mp family) ((listEq _ _).mp h)
 · intro h
   have hf := congrArg Prod.fst h
   have hl := congrArg Prod.snd h
   rw [(listEq _ _).mpr hf, (listEq _ _).mpr hl]
   rfl

theorem containsKey (xs : List HeldLabel) (x : HeldLabel) :
 contains xs x = true ↔ identityKey x ∈ xs.map identityKey := by
 induction xs with
 | nil => exact ⟨(fun h => by cases h), (fun h => by cases h)⟩
 | cons y ys ih =>
  constructor
  · intro h
    change (sameLabel x y || contains ys x) = true at h
    cases head : sameLabel x y with
    | true =>
      have eq := (sameLabelKey x y).mp head
      exact eq.symm ▸ List.Mem.head _
    | false => rw [head] at h; exact List.Mem.tail _ (ih.mp h)
  · intro h
    change (sameLabel x y || contains ys x) = true
    have split (k : List Nat × List Nat) (hk : k ∈ identityKey y :: ys.map identityKey) :
      k = identityKey y ∨ k ∈ ys.map identityKey := by
      cases hk with
      | head => exact Or.inl rfl
      | tail _ ht => exact Or.inr ht
    cases split (identityKey x) h with
    | inl eq => rw [(sameLabelKey x y).mpr eq]; rfl
    | inr ht => rw [ih.mpr ht]; cases sameLabel x y <;> rfl

theorem keyLength (xs : List HeldLabel) : (xs.map identityKey).length = xs.length := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg Nat.succ ih

theorem keyAppend (xs ys : List HeldLabel) :
 (xs ++ ys).map identityKey = xs.map identityKey ++ ys.map identityKey := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (identityKey x)) ih

theorem addReachedUnique (xs : List HeldLabel) (x : HeldLabel)
 (unique : (xs.map identityKey).Nodup) : ((addReached xs x).map identityKey).Nodup := by
 unfold addReached
 cases seen : contains xs x with
 | true => exact unique
 | false =>
  change ((xs ++ [x]).map identityKey).Nodup
  rw [keyAppend]
  exact nodupAppendFresh _ _ unique (fun member => by
    have found := (containsKey xs x).mpr member
    rw [seen] at found
    cases found)

theorem addReachedInside (cs xs : List HeldLabel) (x : HeldLabel)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ cs.map identityKey)
 (held : identityKey x ∈ cs.map identityKey) :
 ∀ k, k ∈ (addReached xs x).map identityKey → k ∈ cs.map identityKey := by
 unfold addReached
 cases seen : contains xs x with
 | true => exact inside
 | false =>
  change ∀ k, k ∈ (xs ++ [x]).map identityKey → k ∈ cs.map identityKey
  rw [keyAppend]
  intro k hk
  cases memAppendCases k (xs.map identityKey) [identityKey x] hk with
  | inl old => exact inside k old
  | inr new => cases new with
    | head => exact held
    | tail _ impossible => cases impossible

-- Removing a key is finite bookkeeping for the source's reached-set cardinality.
private def removeKey (xs : List (List Nat × List Nat)) (x : List Nat × List Nat) : List (List Nat × List Nat) :=
 match xs with
 | [] => []
 | y::ys => if y = x then removeKey ys x else y :: removeKey ys x

private theorem removeLengthLe (xs : List (List Nat × List Nat)) (x : List Nat × List Nat) :
 (removeKey xs x).length ≤ xs.length := by
 induction xs with
 | nil => exact Nat.le_refl _
 | cons y ys ih =>
  unfold removeKey
  split
  · exact Nat.le_trans ih (Nat.le_succ _)
  · exact Nat.succ_le_succ ih

private theorem removeShorter (xs : List (List Nat × List Nat)) (x : List Nat × List Nat)
 (member : x ∈ xs) : (removeKey xs x).length < xs.length := by
 induction xs with
 | nil => cases member
 | cons y ys ih =>
  unfold removeKey
  by_cases same : y = x
  · rw [if_pos same]; exact Nat.lt_succ_of_le (removeLengthLe ys x)
  · rw [if_neg same]
    apply Nat.succ_lt_succ
    apply ih
    cases member with
    | head => exact False.elim (same rfl)
    | tail _ h => exact h

private theorem removeRetainsOther (xs : List (List Nat × List Nat)) (x y : List Nat × List Nat)
 (member : y ∈ xs) (other : y ≠ x) : y ∈ removeKey xs x := by
 induction xs with
 | nil => cases member
 | cons z zs ih =>
  unfold removeKey
  by_cases same : z = x
  · rw [if_pos same]
    apply ih
    cases member with
    | head => exact False.elim (other same)
    | tail _ h => exact h
  · rw [if_neg same]
    cases member with
    | head => exact List.Mem.head _
    | tail _ h => exact List.Mem.tail _ (ih h)

private theorem keySetBound (small large : List (List Nat × List Nat)) (nd : small.Nodup)
  (sub : ∀ k, k ∈ small → k ∈ large) : small.length ≤ large.length := by
 induction small generalizing large with
 | nil => exact Nat.zero_le _
 | cons x xs ih =>
  cases nd with
  | cons fresh tail =>
   have shorter := removeShorter large x (sub x (List.Mem.head _))
   have subTail : ∀ k, k ∈ xs → k ∈ removeKey large x := by
    intro k hk
    exact removeRetainsOther large x k (sub k (List.Mem.tail x hk)) (fun eq => fresh k hk eq.symm)
   exact Nat.le_trans (Nat.succ_le_succ (ih _ tail subTail)) shorter

theorem reachedCardinality (cs xs : List HeldLabel)
 (unique : (xs.map identityKey).Nodup)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ cs.map identityKey) : xs.length ≤ cs.length := by
 have h := keySetBound (xs.map identityKey) (cs.map identityKey) unique inside
 rw [keyLength, keyLength] at h
 exact h


theorem scanPreservesRegisteredSet (es : List Edge) (cs xs : List HeldLabel)
 (custody : es.all (fun e => contains cs e.left && contains cs e.right) = true)
 (unique : (xs.map identityKey).Nodup)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ cs.map identityKey) :
 ((scanEdges es xs).map identityKey).Nodup ∧
 (∀ k, k ∈ (scanEdges es xs).map identityKey → k ∈ cs.map identityKey) := by
 induction es generalizing xs with
 | nil => exact ⟨unique,inside⟩
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
    unfold scanEdges
    rw [List.foldl_cons]
    cases incident : (contains xs e.left || contains xs e.right) with
    | false => exact ih xs custody unique inside
    | true =>
     exact ih _ custody (addReachedUnique _ e.right (addReachedUnique xs e.left unique))
       (addReachedInside cs _ e.right
         (addReachedInside cs xs e.left inside ((containsKey cs e.left).mp left))
         ((containsKey cs e.right).mp right))

theorem connectedScanPreservesRegisteredSet (n : Nat) (es : List Edge) (cs xs : List HeldLabel)
 (custody : es.all (fun e => contains cs e.left && contains cs e.right) = true)
 (unique : (xs.map identityKey).Nodup)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ cs.map identityKey) :
 ((connectedScan n es xs).map identityKey).Nodup ∧
 (∀ k, k ∈ (connectedScan n es xs).map identityKey → k ∈ cs.map identityKey) := by
 induction n generalizing xs with
 | zero => exact ⟨unique,inside⟩
 | succ n ih =>
  have next := scanPreservesRegisteredSet es cs xs custody unique inside
  have step : connectedScan (n+1) es xs =
    (if (scanEdges es xs).length > xs.length then connectedScan n es (scanEdges es xs)
      else scanEdges es xs) := rfl
  rw [step]
  by_cases growth : xs.length < (scanEdges es xs).length
  · rw [if_pos growth]
    exact ih _ next.1 next.2
  · rw [if_neg growth]
    exact next

-- Strict growth cannot continue beyond the finite registered-centre count.
theorem scanBoundReachesFixedPoint (n : Nat) (es : List Edge) (cs xs : List HeldLabel)
 (custody : es.all (fun e => contains cs e.left && contains cs e.right) = true)
 (unique : (xs.map identityKey).Nodup)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ cs.map identityKey)
 (budget : cs.length < xs.length + n) :
 scanEdges es (connectedScan n es xs) = connectedScan n es xs := by
 induction n generalizing xs with
 | zero =>
  exact False.elim ((Nat.not_lt_of_ge (reachedCardinality cs xs unique inside)) budget)
 | succ n ih =>
  have next := scanPreservesRegisteredSet es cs xs custody unique inside
  by_cases growth : xs.length < (scanEdges es xs).length
  · have nextBudget : cs.length < (scanEdges es xs).length + n := by
     have inc := Nat.add_le_add_right growth n
     rw [Nat.succ_add] at inc
     exact Nat.lt_of_lt_of_le budget inc
    have step : connectedScan (n+1) es xs = connectedScan n es (scanEdges es xs) := by
     change (if (scanEdges es xs).length > xs.length then
       connectedScan n es (scanEdges es xs) else scanEdges es xs) = _
     exact if_pos growth
    exact (congrArg (scanEdges es) step).trans ((ih _ next.1 next.2 nextBudget).trans step.symm)
  · have fixed := scanEdgesStopsExactly es xs growth
    have step : connectedScan (n+1) es xs = xs := by
     change (if (scanEdges es xs).length > xs.length then
       connectedScan n es (scanEdges es xs) else scanEdges es xs) = xs
     exact (if_neg growth).trans fixed
    exact (congrArg (scanEdges es) step).trans (fixed.trans step.symm)

-- This is the actual bound used by connected, from its actual initial singleton.
theorem registeredInitialScanClosed (first : HeldLabel) (rest : List HeldLabel) (es : List Edge)
 (custody : es.all (fun e => contains (first::rest) e.left && contains (first::rest) e.right) = true) :
 scanEdges es (connectedScan (first::rest).length es [first]) =
 connectedScan (first::rest).length es [first] := by
 apply scanBoundReachesFixedPoint (first::rest).length es (first::rest) [first] custody
 · exact List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
 · intro k hk
   cases hk with
   | head => exact List.Mem.head _
   | tail _ h => cases h
 · change (first::rest).length < 1 + (first::rest).length
   rw [Nat.one_add]
   exact Nat.lt_succ_self _


-- A derivation trace of the original while-loop; this adds no executable rule.
inductive OriginalScanRun (es : List Edge) : List HeldLabel → List HeldLabel → Prop where
 | stopped (xs : List HeldLabel) (halt : ¬ xs.length < (scanEdges es xs).length) :
     OriginalScanRun es xs (scanEdges es xs)
 | advanced (xs result : List HeldLabel) (growth : xs.length < (scanEdges es xs).length)
     (rest : OriginalScanRun es (scanEdges es xs) result) : OriginalScanRun es xs result

theorem boundedScanRunsOriginal (n : Nat) (es : List Edge) (cs xs : List HeldLabel)
 (custody : es.all (fun e => contains cs e.left && contains cs e.right) = true)
 (unique : (xs.map identityKey).Nodup)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ cs.map identityKey)
 (budget : cs.length < xs.length + n) : OriginalScanRun es xs (connectedScan n es xs) := by
 induction n generalizing xs with
 | zero =>
  exact False.elim ((Nat.not_lt_of_ge (reachedCardinality cs xs unique inside)) budget)
 | succ n ih =>
  have next := scanPreservesRegisteredSet es cs xs custody unique inside
  by_cases growth : xs.length < (scanEdges es xs).length
  · have nextBudget : cs.length < (scanEdges es xs).length + n := by
     have inc := Nat.add_le_add_right growth n
     rw [Nat.succ_add] at inc
     exact Nat.lt_of_lt_of_le budget inc
    have step : connectedScan (n+1) es xs = connectedScan n es (scanEdges es xs) := by
     change (if (scanEdges es xs).length > xs.length then
       connectedScan n es (scanEdges es xs) else scanEdges es xs) = _
     exact if_pos growth
    rw [step]
    exact OriginalScanRun.advanced xs _ growth (ih _ next.1 next.2 nextBudget)
  · have step : connectedScan (n+1) es xs = scanEdges es xs := by
     change (if (scanEdges es xs).length > xs.length then
       connectedScan n es (scanEdges es xs) else scanEdges es xs) = _
     exact if_neg growth
    rw [step]
    exact OriginalScanRun.stopped xs growth

theorem registeredInitialScanRunsOriginal (first : HeldLabel) (rest : List HeldLabel) (es : List Edge)
 (custody : es.all (fun e => contains (first::rest) e.left && contains (first::rest) e.right) = true) :
 OriginalScanRun es [first] (connectedScan (first::rest).length es [first]) := by
 apply boundedScanRunsOriginal (first::rest).length es (first::rest) [first] custody
 · exact List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
 · intro k hk
   cases hk with
   | head => exact List.Mem.head _
   | tail _ h => cases h
 · change (first::rest).length < 1 + (first::rest).length
   rw [Nat.one_add]
   exact Nat.lt_succ_self _

theorem acceptedConnectivityGuards (m t : HeldLabel) (cs word : List HeldLabel) (es : List Edge) (s : Support)
 (h : construct m t cs es word = .ok s) : (s.edges.all (fun e => contains s.centres e.left && contains s.centres e.right) = true) ∧ connected s.centres s.edges = true := by
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
            · cases held : (es.all fun e => contains cs e.left && contains cs e.right) with
              | false => rw [held] at g6; cases g6
              | true => rfl
            · cases joined : connected cs es with
              | false => rw [joined] at g8; cases g8
              | true => rfl

theorem acceptedInitialScanRunsOriginal (m t : HeldLabel) (cs word : List HeldLabel)
 (es : List Edge) (s : Support) (accepted : construct m t cs es word = .ok s)
 (first : HeldLabel) (rest : List HeldLabel) (centres : s.centres = first::rest) :
 OriginalScanRun s.edges [first] (connectedScan s.centres.length s.edges [first]) := by
 have custody := (acceptedConnectivityGuards m t cs word es s accepted).1
 rw [centres] at custody
 rw [centres]
 exact registeredInitialScanRunsOriginal first rest s.edges custody


theorem equalCountCoversRegistered (cs xs : List HeldLabel)
 (unique : (xs.map identityKey).Nodup)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ cs.map identityKey)
 (sameCount : xs.length = cs.length) :
 ∀ k, k ∈ cs.map identityKey → k ∈ xs.map identityKey := by
 intro k held
 have memberDecision (ys : List (List Nat × List Nat)) : Decidable (k ∈ ys) := by
  induction ys with
  | nil => exact isFalse (fun h => by cases h)
  | cons y ys ih =>
   by_cases same : k = y
   · exact isTrue (same.symm ▸ List.Mem.head _)
   · cases ih with
     | isTrue h => exact isTrue (List.Mem.tail _ h)
     | isFalse absent =>
      exact isFalse (fun h => by
        cases h with
        | head => exact same rfl
        | tail _ ht => exact absent ht)
 letI : Decidable (k ∈ xs.map identityKey) := memberDecision _
 by_cases found : k ∈ xs.map identityKey
 · exact found
 · have smaller := removeShorter (cs.map identityKey) k held
   have included : ∀ y, y ∈ xs.map identityKey → y ∈ removeKey (cs.map identityKey) k := by
    intro y hy
    exact removeRetainsOther _ k y (inside y hy) (fun eq => found (eq ▸ hy))
   have bounded := keySetBound _ _ unique included
   have impossible := Nat.lt_of_le_of_lt bounded smaller
   rw [keyLength, keyLength, sameCount] at impossible
   exact False.elim ((Nat.lt_irrefl _) impossible)

theorem addReachedRetainsKey (xs : List HeldLabel) (x : HeldLabel) (k : List Nat × List Nat)
 (held : k ∈ xs.map identityKey) : k ∈ (addReached xs x).map identityKey := by
 obtain ⟨tail,eq⟩ := addReachedRetainsPrefix xs x
 rw [eq,keyAppend]
 exact memAppendLeft k _ _ held

theorem addReachedHoldsKey (xs : List HeldLabel) (x : HeldLabel) :
 identityKey x ∈ (addReached xs x).map identityKey := by
 unfold addReached
 cases seen : contains xs x with
 | true => exact (containsKey xs x).mp seen
 | false =>
  change identityKey x ∈ (xs ++ [x]).map identityKey
  rw [keyAppend]
  exact memAppendRight _ _ _ (List.Mem.head _)

theorem scanRetainsKey (es : List Edge) (xs : List HeldLabel) (k : List Nat × List Nat)
 (held : k ∈ xs.map identityKey) : k ∈ (scanEdges es xs).map identityKey := by
 obtain ⟨tail,eq⟩ := scanEdgesRetainsPrefix es xs
 rw [eq,keyAppend]
 exact memAppendLeft k _ _ held

theorem connectedScanRetainsKey (n : Nat) (es : List Edge) (xs : List HeldLabel) (k : List Nat × List Nat)
 (held : k ∈ xs.map identityKey) : k ∈ (connectedScan n es xs).map identityKey := by
 induction n generalizing xs with
 | zero => exact held
 | succ n ih =>
  have step : connectedScan (n+1) es xs =
    (if (scanEdges es xs).length > xs.length then connectedScan n es (scanEdges es xs)
      else scanEdges es xs) := rfl
  rw [step]
  split
  · exact ih _ (scanRetainsKey es xs k held)
  · exact scanRetainsKey es xs k held

theorem singleEdgeHoldsEndpoints (e : Edge) (xs : List HeldLabel)
 (touch : contains xs e.left = true ∨ contains xs e.right = true) :
 identityKey e.left ∈ (scanEdges [e] xs).map identityKey ∧
 identityKey e.right ∈ (scanEdges [e] xs).map identityKey := by
 have incident : (contains xs e.left || contains xs e.right) = true := by
  cases touch with
  | inl h => rw [h]; rfl
  | inr h => rw [h]; cases contains xs e.left <;> rfl
 have step : scanEdges [e] xs = addReached (addReached xs e.left) e.right := by
  change (if contains xs e.left || contains xs e.right then
    addReached (addReached xs e.left) e.right else xs) = _
  rw [incident]
  rfl
 rw [step]
 exact ⟨addReachedRetainsKey _ e.right _ (addReachedHoldsKey xs e.left),
   addReachedHoldsKey _ e.right⟩

theorem scanHoldsIncidentEndpoints (es : List Edge) (xs : List HeldLabel) (e : Edge)
 (member : e ∈ es) (touch : contains xs e.left = true ∨ contains xs e.right = true) :
 identityKey e.left ∈ (scanEdges es xs).map identityKey ∧
 identityKey e.right ∈ (scanEdges es xs).map identityKey := by
 induction es generalizing xs with
 | nil => cases member
 | cons head tail ih =>
  have step : scanEdges (head::tail) xs = scanEdges tail (scanEdges [head] xs) := rfl
  rw [step]
  cases member with
  | head =>
   have both := singleEdgeHoldsEndpoints e xs touch
   exact ⟨scanRetainsKey tail _ _ both.1, scanRetainsKey tail _ _ both.2⟩
  | tail _ ht =>
   apply ih _ ht
   cases touch with
   | inl h => exact Or.inl ((containsKey _ e.left).mpr
       (scanRetainsKey [head] xs _ ((containsKey xs e.left).mp h)))
   | inr h => exact Or.inr ((containsKey _ e.right).mpr
       (scanRetainsKey [head] xs _ ((containsKey xs e.right).mp h)))

theorem fixedScanClosesEveryEdge (es : List Edge) (xs : List HeldLabel)
 (fixed : scanEdges es xs = xs) (e : Edge) (member : e ∈ es)
 (touch : contains xs e.left = true ∨ contains xs e.right = true) :
 contains xs e.left = true ∧ contains xs e.right = true := by
 have both := scanHoldsIncidentEndpoints es xs e member touch
 rw [fixed] at both
 exact ⟨(containsKey xs e.left).mpr both.1, (containsKey xs e.right).mpr both.2⟩


theorem scanInsideClosedSet (es : List Edge) (xs closed : List HeldLabel)
 (closure : ∀ e, e ∈ es → (contains closed e.left = true ∨ contains closed e.right = true) →
   contains closed e.left = true ∧ contains closed e.right = true)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ closed.map identityKey) :
 ∀ k, k ∈ (scanEdges es xs).map identityKey → k ∈ closed.map identityKey := by
 induction es generalizing xs with
 | nil => exact inside
 | cons e es ih =>
  have tailClosure : ∀ edge, edge ∈ es →
      (contains closed edge.left = true ∨ contains closed edge.right = true) →
      contains closed edge.left = true ∧ contains closed edge.right = true :=
    fun edge he ht => closure edge (List.Mem.tail e he) ht
  have step : scanEdges (e::es) xs = scanEdges es
    (if contains xs e.left || contains xs e.right then addReached (addReached xs e.left) e.right else xs) := rfl
  rw [step]
  cases incident : (contains xs e.left || contains xs e.right) with
  | false => exact ih xs tailClosure inside
  | true =>
   have touch : contains closed e.left = true ∨ contains closed e.right = true := by
    cases left : contains xs e.left with
    | true => exact Or.inl ((containsKey closed e.left).mpr (inside _ ((containsKey xs e.left).mp left)))
    | false =>
     rw [left] at incident
     exact Or.inr ((containsKey closed e.right).mpr (inside _ ((containsKey xs e.right).mp incident)))
   have endpoints := closure e (List.Mem.head _) touch
   exact ih _ tailClosure (addReachedInside closed _ e.right
     (addReachedInside closed xs e.left inside ((containsKey closed e.left).mp endpoints.1))
     ((containsKey closed e.right).mp endpoints.2))

theorem connectedScanInsideClosedSet (n : Nat) (es : List Edge) (xs closed : List HeldLabel)
 (closure : ∀ e, e ∈ es → (contains closed e.left = true ∨ contains closed e.right = true) →
   contains closed e.left = true ∧ contains closed e.right = true)
 (inside : ∀ k, k ∈ xs.map identityKey → k ∈ closed.map identityKey) :
 ∀ k, k ∈ (connectedScan n es xs).map identityKey → k ∈ closed.map identityKey := by
 induction n generalizing xs with
 | zero => exact inside
 | succ n ih =>
  have next := scanInsideClosedSet es xs closed closure inside
  have step : connectedScan (n+1) es xs =
    (if (scanEdges es xs).length > xs.length then connectedScan n es (scanEdges es xs)
      else scanEdges es xs) := rfl
  rw [step]
  by_cases growth : xs.length < (scanEdges es xs).length
  · rw [if_pos growth]
    exact ih _ next
  · rw [if_neg growth]
    exact next

-- V3's connected-successor argument, for the actual connected operation.
theorem connectedFreshCentre (first : HeldLabel) (rest : List HeldLabel) (es : List Edge)
 (anchor fresh : HeldLabel)
 (custody : es.all (fun e => contains (first::rest) e.left && contains (first::rest) e.right) = true)
 (joined : connected (first::rest) es = true)
 (held : contains (first::rest) anchor = true)
 (newCentre : contains (first::rest) fresh = false) :
 connected ((first::rest) ++ [fresh]) (es ++ [(⟨anchor,fresh⟩ : Edge)]) = true := by
 let cs := first::rest
 let enlarged := cs ++ [fresh]
 let added : Edge := ⟨anchor,fresh⟩
 let edges := es ++ [added]
 let oldReached := connectedScan cs.length es [first]
 let reached := connectedScan enlarged.length edges [first]
 have singletonUnique : ([first].map identityKey).Nodup :=
   List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
 have singletonInside : ∀ k, k ∈ [first].map identityKey → k ∈ cs.map identityKey := by
  intro k hk
  cases hk with
  | head => exact List.Mem.head _
  | tail _ h => cases h
 have oldInv := connectedScanPreservesRegisteredSet cs.length es cs [first] custody singletonUnique singletonInside
 have oldCount : oldReached.length = cs.length := Nat.eq_of_beq_eq_true joined
 have oldCovers := equalCountCoversRegistered cs oldReached oldInv.1 oldInv.2 oldCount
 have csInside : ∀ k, k ∈ cs.map identityKey → k ∈ enlarged.map identityKey := by
  intro k hk
  change k ∈ (cs ++ [fresh]).map identityKey
  rw [keyAppend]
  exact memAppendLeft _ _ _ hk
 have freshInside : identityKey fresh ∈ enlarged.map identityKey := by
  change identityKey fresh ∈ (cs ++ [fresh]).map identityKey
  rw [keyAppend]
  exact memAppendRight _ _ _ (List.Mem.head _)
 have liftedCustody : es.all (fun e => contains enlarged e.left && contains enlarged e.right) = true := by
  have lift (remaining : List Edge)
    (h : remaining.all (fun e => contains cs e.left && contains cs e.right) = true) :
    remaining.all (fun e => contains enlarged e.left && contains enlarged e.right) = true := by
   induction remaining with
   | nil => rfl
   | cons e tail ih =>
    change ((contains cs e.left && contains cs e.right) &&
      tail.all (fun e => contains cs e.left && contains cs e.right)) = true at h
    cases l : contains cs e.left with
    | false => rw [l] at h; cases h
    | true =>
     rw [l] at h
     cases r : contains cs e.right with
     | false => rw [r] at h; cases h
     | true =>
      rw [r] at h
      have le := (containsKey enlarged e.left).mpr (csInside _ ((containsKey cs e.left).mp l))
      have re := (containsKey enlarged e.right).mpr (csInside _ ((containsKey cs e.right).mp r))
      change ((contains enlarged e.left && contains enlarged e.right) &&
        tail.all (fun e => contains enlarged e.left && contains enlarged e.right)) = true
      rw [le,re,ih h]
      rfl
  exact lift es custody
 have anchorInside := (containsKey enlarged anchor).mpr (csInside _ ((containsKey cs anchor).mp held))
 have freshCheck := (containsKey enlarged fresh).mpr freshInside
 have newCustody : edges.all (fun e => contains enlarged e.left && contains enlarged e.right) = true := by
  have appendAll (xs ys : List Edge) (p : Edge → Bool) :
    (xs ++ ys).all p = (xs.all p && ys.all p) := by
   induction xs with
   | nil => rfl
   | cons x xs ih =>
    change (p x && (xs ++ ys).all p) = ((p x && xs.all p) && ys.all p)
    rw [ih]
    cases p x <;> cases xs.all p <;> cases ys.all p <;> rfl
  change (es ++ [added]).all _ = true
  rw [appendAll,liftedCustody]
  change (true && ((contains enlarged anchor && contains enlarged fresh) && true)) = true
  rw [anchorInside,freshCheck]
  rfl
 have newInv := connectedScanPreservesRegisteredSet enlarged.length edges enlarged [first]
   newCustody singletonUnique (fun k hk => csInside k (singletonInside k hk))
 have fixed : scanEdges edges reached = reached :=
   registeredInitialScanClosed first (rest ++ [fresh]) edges newCustody
 have oldClosed : ∀ e, e ∈ es →
     (contains reached e.left = true ∨ contains reached e.right = true) →
     contains reached e.left = true ∧ contains reached e.right = true := by
  intro e he ht
  exact fixedScanClosesEveryEdge edges reached fixed e (memAppendLeft _ _ _ he) ht
 have seedInside : ∀ k, k ∈ [first].map identityKey → k ∈ reached.map identityKey := by
  intro k hk
  exact connectedScanRetainsKey enlarged.length edges [first] k hk
 have oldInside := connectedScanInsideClosedSet cs.length es [first] reached oldClosed seedInside
 have anchorReached : contains reached anchor = true :=
   (containsKey reached anchor).mpr (oldInside _ (oldCovers _ ((containsKey cs anchor).mp held)))
 have both := fixedScanClosesEveryEdge edges reached fixed added
   (memAppendRight _ _ _ (List.Mem.head _)) (Or.inl anchorReached)
 have freshReached : identityKey fresh ∈ reached.map identityKey := (containsKey reached fresh).mp both.2
 have freshAbsent : identityKey fresh ∉ oldReached.map identityKey := by
  intro hf
  have contradiction := (containsKey cs fresh).mpr (oldInv.2 _ hf)
  rw [newCentre] at contradiction
  cases contradiction
 have extendedUnique : ((oldReached ++ [fresh]).map identityKey).Nodup := by
  rw [keyAppend]
  exact nodupAppendFresh _ _ oldInv.1 freshAbsent
 have extendedInside : ∀ k, k ∈ (oldReached ++ [fresh]).map identityKey → k ∈ reached.map identityKey := by
  rw [keyAppend]
  intro k hk
  cases memAppendCases k (oldReached.map identityKey) [identityKey fresh] hk with
  | inl ho => exact oldInside k ho
  | inr hf => cases hf with
    | head => exact freshReached
    | tail _ h => cases h
 have lower := reachedCardinality reached (oldReached ++ [fresh]) extendedUnique extendedInside
 have upper := reachedCardinality enlarged reached newInv.1 newInv.2
 have appendOne (xs : List HeldLabel) (x : HeldLabel) : (xs ++ [x]).length = xs.length + 1 := by
  induction xs with
  | nil => rfl
  | cons y ys ih => exact congrArg Nat.succ ih
 have countEq : reached.length = enlarged.length := by
  apply Nat.le_antisymm upper
  change _ ≤ reached.length
  change (cs ++ [fresh]).length ≤ reached.length
  rw [appendOne]
  rw [appendOne,oldCount] at lower
  exact lower
 change (reached.length == enlarged.length) = true
 rw [countEq]
 have self (n : Nat) : (n == n) = true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 exact self _


theorem sameWordFreshExtension (word cs : List HeldLabel) (fresh : HeldLabel)
 (retained : sameWord word cs = true) : sameWord (word ++ [fresh]) (cs ++ [fresh]) = true := by
 induction word generalizing cs with
 | nil => cases cs with
   | nil =>
    change (sameLabel fresh fresh && true) = true
    rw [(sameLabelKey fresh fresh).mpr rfl]
    rfl
   | cons c cs => cases retained
 | cons w word ih => cases cs with
   | nil => cases retained
   | cons c cs =>
    change (sameLabel w c && sameWord word cs) = true at retained
    cases head : sameLabel w c with
    | false => rw [head] at retained; cases retained
    | true =>
     rw [head] at retained
     change (sameLabel w c && sameWord (word ++ [fresh]) (cs ++ [fresh])) = true
     rw [head,ih cs retained]
     rfl

theorem connectedRetainsAdditionalEdges (first : HeldLabel) (rest : List HeldLabel)
 (oldEdges newEdges : List Edge)
 (oldCustody : oldEdges.all (fun e => contains (first::rest) e.left && contains (first::rest) e.right) = true)
 (newCustody : newEdges.all (fun e => contains (first::rest) e.left && contains (first::rest) e.right) = true)
 (edgesRetained : ∀ e, e ∈ oldEdges → e ∈ newEdges)
 (joined : connected (first::rest) oldEdges = true) : connected (first::rest) newEdges = true := by
 let cs := first::rest
 let oldReached := connectedScan cs.length oldEdges [first]
 let reached := connectedScan cs.length newEdges [first]
 have unique : ([first].map identityKey).Nodup :=
   List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
 have inside : ∀ k, k ∈ [first].map identityKey → k ∈ cs.map identityKey := by
  intro k hk
  cases hk with
  | head => exact List.Mem.head _
  | tail _ h => cases h
 have oldInv := connectedScanPreservesRegisteredSet cs.length oldEdges cs [first] oldCustody unique inside
 have newInv := connectedScanPreservesRegisteredSet cs.length newEdges cs [first] newCustody unique inside
 have fixed : scanEdges newEdges reached = reached := registeredInitialScanClosed first rest newEdges newCustody
 have closed : ∀ e, e ∈ oldEdges →
   (contains reached e.left = true ∨ contains reached e.right = true) →
   contains reached e.left = true ∧ contains reached e.right = true := by
  intro e he ht
  exact fixedScanClosesEveryEdge newEdges reached fixed e (edgesRetained e he) ht
 have oldInside := connectedScanInsideClosedSet cs.length oldEdges [first] reached closed
   (fun k hk => connectedScanRetainsKey cs.length newEdges [first] k hk)
 have lower := reachedCardinality reached oldReached oldInv.1 oldInside
 have upper := reachedCardinality cs reached newInv.1 newInv.2
 have oldCount : oldReached.length = cs.length := Nat.eq_of_beq_eq_true joined
 rw [oldCount] at lower
 have countEq := Nat.le_antisymm upper lower
 change (reached.length == cs.length) = true
 rw [countEq]
 have self (n : Nat) : (n == n) = true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 exact self _

-- The source permits any further edges retaining endpoint custody.
theorem connectedFreshCentreWithAdditionalEdges (first : HeldLabel) (rest : List HeldLabel)
 (es extra : List Edge) (anchor fresh : HeldLabel)
 (custody : es.all (fun e => contains (first::rest) e.left && contains (first::rest) e.right) = true)
 (joined : connected (first::rest) es = true)
 (held : contains (first::rest) anchor = true)
 (newCentre : contains (first::rest) fresh = false)
 (firstCustody : (es ++ [(⟨anchor,fresh⟩ : Edge)]).all
   (fun e => contains ((first::rest) ++ [fresh]) e.left && contains ((first::rest) ++ [fresh]) e.right) = true)
 (completeCustody : ((es ++ [(⟨anchor,fresh⟩ : Edge)]) ++ extra).all
   (fun e => contains ((first::rest) ++ [fresh]) e.left && contains ((first::rest) ++ [fresh]) e.right) = true) :
 connected ((first::rest) ++ [fresh]) ((es ++ [(⟨anchor,fresh⟩ : Edge)]) ++ extra) = true := by
 exact connectedRetainsAdditionalEdges first (rest ++ [fresh]) _ _ firstCustody completeCustody
   (fun e he => memAppendLeft e _ extra he)
   (connectedFreshCentre first rest es anchor fresh custody joined held newCentre)


theorem acceptedConnectedWordSuccessor (m t : HeldLabel) (cs word : List HeldLabel)
 (es : List Edge) (s : Support) (accepted : construct m t cs es word = .ok s)
 (anchor fresh : HeldLabel) (held : contains s.centres anchor = true)
 (newCentre : contains s.centres fresh = false) :
 connected (s.centres ++ [fresh]) (s.edges ++ [(⟨anchor,fresh⟩ : Edge)]) = true ∧
 sameWord (s.electronSupport ++ [fresh]) (s.centres ++ [fresh]) = true := by
 have guards := acceptedConnectivityGuards m t cs word es s accepted
 have wordMeaning := acceptedMeaning m t cs word es s accepted
 constructor
 · cases shape : s.centres with
   | nil => rw [shape] at held; cases held
   | cons first rest =>
    have custody := guards.1
    have joined := guards.2
    rw [shape] at custody joined held newCentre
    exact connectedFreshCentre first rest s.edges anchor fresh custody joined held newCentre
 · exact sameWordFreshExtension s.electronSupport s.centres fresh wordMeaning.2

end SFT.Chemistry.MulticentreConnectivity
