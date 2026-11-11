import SFT.Physics.NuclearClosure
namespace SFT.Physics.NuclearCompositions
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation
open SFT.Foundation.FractionReduction SFT.Physics.MechanicalLocation

-- Natural coordinates are host multiplicities of retained excitation occurrences;
-- a zero coordinate denotes an empty direction, not an emitted scientific scalar.
abbrev Pair := Nat × Nat
abbrev Triple := Nat × Nat × Nat

def pairs : Nat → List Pair
 | 0 => [(0,0)]
 | n+1 => (0,n+1) :: (pairs n).map (fun p => (p.1+1,p.2))

def triples : Nat → List Triple
 | 0 => [(0,0,0)]
 | n+1 => ((pairs (n+1)).map (fun p => (0,p.1,p.2))) ++
     ((triples n).map (fun p => (p.1+1,p.2.1,p.2.2)))

def filled : Nat → List Triple
 | 0 => triples 0
 | n+1 => filled n ++ triples (n+1)

def labelled : List Triple → List (Triple × Held)
 | [] => []
 | t::rest => (t,.first)::(t,.second)::labelled rest

theorem pairCount (n : Nat) : (pairs n).length = n+1 := by
 induction n with
 | zero => rfl
 | succ n ih =>
   change ((pairs n).map _).length+1 = _
   rw [mapLength,ih]

theorem shellCount (n : Nat) : 2*(triples n).length = (n+1)*(n+2) := by
 induction n with
 | zero => rfl
 | succ n ih =>
   change 2*(((pairs (n+1)).map _ ++ (triples n).map _).length) = _
   rw [appendLength,mapLength,mapLength,Nat.mul_add,pairCount,ih]
   rw [Nat.mul_comm 2 (n+1+1),Nat.mul_comm (n+1) (n+2)]
   change (n+2)*2+(n+2)*(n+1)=(n+2)*(n+3)
   rw [←Nat.mul_add,Nat.add_comm 2 (n+1)]

theorem labelledCount (rows : List Triple) : (labelled rows).length = 2*rows.length := by
 induction rows with
 | nil => rfl
 | cons t rest ih =>
   change (labelled rest).length+2=2*(rest.length+1)
   rw [ih,Nat.mul_succ]

theorem totalCount (n : Nat) : 3*(labelled (filled n)).length = (n+1)*(n+2)*(n+3) := by
 induction n with
 | zero => rfl
 | succ n ih =>
   rw [labelledCount] at ih ⊢
   change 3*(2*(filled n ++ triples (n+1)).length)=_
   rw [appendLength,Nat.mul_add,Nat.mul_add,ih,shellCount]
   rw [mulAssoc (n+1) (n+2) (n+3)]
   rw [Nat.mul_comm (n+1) ((n+2)*(n+3)),Nat.mul_comm 3 ((n+2)*(n+3))]
   rw [←Nat.mul_add]

theorem exactQuotient (n : Nat) : ((n+1)*(n+2)*(n+3))/3 = (labelled (filled n)).length := by
 rw [←totalCount,divisionMultiple 3 _ (by decide)]
theorem pairSound (n : Nat) (p : Pair) (member : p∈pairs n) : p.1+p.2=n := by
 induction n generalizing p with
 | zero => cases member with
   | head => rfl
   | tail _ h => cases h
 | succ n ih =>
   cases member with
   | head => exact Nat.zero_add _
   | tail _ h =>
     obtain ⟨q,hq,eq⟩ := memMapPreimage (fun p : Pair => (p.1+1,p.2)) p (pairs n) h
     cases eq
     change (q.1+1)+q.2=n+1
     rw [Nat.succ_add,ih q hq]

theorem pairComplete (a b n : Nat) (total : a+b=n) : (a,b)∈pairs n := by
 induction a generalizing b n with
 | zero =>
   rw [Nat.zero_add] at total
   cases total
   cases b with
   | zero => exact .head _
   | succ b => exact .head _
 | succ a ih =>
   rw [Nat.succ_add] at total
   cases n with
   | zero => cases total
   | succ n => exact .tail _ (memMap (fun p : Pair => (p.1+1,p.2)) (a,b) (pairs n)
       (ih b n (Nat.succ.inj total)))

theorem tripleSound (n : Nat) (p : Triple) (member : p∈triples n) : p.1+p.2.1+p.2.2=n := by
 induction n generalizing p with
 | zero => cases member with
   | head => rfl
   | tail _ h => cases h
 | succ n ih =>
   cases memAppendCases p _ _ member with
   | inl h =>
     obtain ⟨q,hq,eq⟩ := memMapPreimage (fun p : Pair => (0,p.1,p.2)) p (pairs (n+1)) h
     cases eq
     change 0+q.1+q.2=n+1
     rw [Nat.zero_add]
     exact pairSound _ q hq
   | inr h =>
     obtain ⟨q,hq,eq⟩ := memMapPreimage (fun p : Triple => (p.1+1,p.2.1,p.2.2)) p (triples n) h
     cases eq
     change (q.1+1)+q.2.1+q.2.2=n+1
     rw [Nat.succ_add,Nat.succ_add,ih q hq]

theorem tripleComplete (a b c n : Nat) (total : a+b+c=n) : (a,b,c)∈triples n := by
 induction a generalizing b c n with
 | zero =>
   rw [Nat.zero_add] at total
   cases n with
   | zero =>
     have bzero := Nat.eq_zero_of_add_eq_zero_left total
     have czero := Nat.eq_zero_of_add_eq_zero_right total
     cases bzero; cases czero
     exact .head _
   | succ n =>
     apply memAppendLeft
     exact memMap (fun p : Pair => (0,p.1,p.2)) (b,c) (pairs (n+1)) (pairComplete b c _ total)
 | succ a ih =>
   rw [Nat.succ_add,Nat.succ_add] at total
   cases n with
   | zero => cases total
   | succ n =>
     apply memAppendRight
     exact memMap (fun p : Triple => (p.1+1,p.2.1,p.2.2)) (a,b,c) (triples n)
       (ih b c n (Nat.succ.inj total))

theorem filledSound (n : Nat) (p : Triple) (member : p∈filled n) : p.1+p.2.1+p.2.2≤n := by
 induction n with
 | zero => exact Nat.le_of_eq (tripleSound 0 p member)
 | succ n ih =>
   cases memAppendCases p _ _ member with
   | inl h => exact Nat.le_trans (ih h) (Nat.le_succ n)
   | inr h => exact Nat.le_of_eq (tripleSound (n+1) p h)

theorem filledComplete (a b c n : Nat) (total : a+b+c≤n) : (a,b,c)∈filled n := by
 induction n with
 | zero => exact tripleComplete a b c 0 (Nat.eq_zero_of_le_zero total)
 | succ n ih =>
   cases Nat.eq_or_lt_of_le total with
   | inl eq => exact memAppendRight _ _ _ (tripleComplete a b c (n+1) eq)
   | inr lt => exact memAppendLeft _ _ _ (ih (Nat.le_of_lt_succ lt))

theorem pairsDistinct (n : Nat) : (pairs n).Nodup := by
 induction n with
 | zero => exact .cons (fun _ h => by cases h) .nil
 | succ n ih =>
   apply List.Pairwise.cons
   · intro p member eq
     obtain ⟨q,hq,same⟩ := memMapPreimage (fun p : Pair => (p.1+1,p.2)) p (pairs n) member
     have impossible := congrArg Prod.fst (eq.trans same.symm)
     cases impossible
   · apply nodupMapInjective _ _ _ ih
     intro a b eq
     have first := congrArg (fun p : Pair => p.1) eq
     have rest := congrArg (fun p : Pair => p.2) eq
     exact Prod.ext (Nat.succ.inj first) rest

theorem triplesDistinct (n : Nat) : (triples n).Nodup := by
 induction n with
 | zero => exact .cons (fun _ h => by cases h) .nil
 | succ n ih =>
   apply SFT.Foundation.FoldAssembly.disjointAppendNodup
   · exact nodupMapInjective (fun p : Pair => (0,p.1,p.2))
       (fun a b eq => congrArg Prod.snd eq) _ (pairsDistinct (n+1))
   · apply nodupMapInjective _ _ _ ih
     intro a b eq
     have first := congrArg (fun p : Triple => p.1) eq
     have rest := congrArg (fun p : Triple => p.2) eq
     exact Prod.ext (Nat.succ.inj first) rest
   · intro p left right
     obtain ⟨q,hq,eq⟩ := memMapPreimage (fun p : Pair => (0,p.1,p.2)) p (pairs (n+1)) left
     obtain ⟨t,ht,same⟩ := memMapPreimage (fun p : Triple => (p.1+1,p.2.1,p.2.2)) p (triples n) right
     have impossible := congrArg Prod.fst (eq.trans same.symm)
     cases impossible

theorem filledDistinct (n : Nat) : (filled n).Nodup := by
 induction n with
 | zero => exact triplesDistinct 0
 | succ n ih =>
   apply SFT.Foundation.FoldAssembly.disjointAppendNodup _ _ ih (triplesDistinct (n+1))
   intro p left right
   have before := filledSound n p left
   have atNext := tripleSound (n+1) p right
   rw [atNext] at before
   exact Nat.not_succ_le_self n before

theorem exactDivisibility (n : Nat) : (n+1)*(n+2)*(n+3)%3=0 := by
 let count := (n+1)*(n+2)*(n+3)
 have h := remainderQuotient count 3 (by decide)
 change count%3+3*(count/3)=count at h
 have quotient : count/3=(labelled (filled n)).length := exactQuotient n
 rw [quotient,totalCount] at h
 have subtracted := congrArg (fun x => x-count) h
 rw [SFT.Foundation.ExactCast.addSubtract] at subtracted
 exact subtracted.trans (Nat.sub_self count)

theorem oscillatorCountsCompleteSupport (n : Nat) :
 NuclearClosure.oscillatorClosure (.integer (.ofNat (n+1))) = .ok (labelled (filled n)).length := by
 rw [NuclearClosure.oscillatorExpression,exactDivisibility]
 change Except.ok (((n+1)*(n+2)*(n+3))/3)=_
 rw [exactQuotient]

theorem labelledHasTriple (rows : List Triple) (state : Triple × Held)
 (member : state∈labelled rows) : state.1∈rows := by
 induction rows with
 | nil => cases member
 | cons t rest ih =>
   cases member with
   | head => exact .head _
   | tail _ h => cases h with
     | head => exact .head _
     | tail _ prior => exact .tail _ (ih prior)

theorem everyTripleHasBothLabels (rows : List Triple) (t : Triple) (label : Held)
 (member : t∈rows) : (t,label)∈labelled rows := by
 induction rows with
 | nil => cases member
 | cons x rest ih =>
   cases member with
   | head => cases label with
     | first => exact .head _
     | second => exact .tail _ (.head _)
   | tail _ h => exact .tail _ (.tail _ (ih h))

theorem labelledDistinct (rows : List Triple) (distinct : rows.Nodup) : (labelled rows).Nodup := by
 induction distinct with
 | nil => exact .nil
 | @cons t rest fresh distinct ih =>
   apply List.Pairwise.cons
   · intro state member eq
     cases member with
     | head => cases eq
     | tail _ old => exact fresh state.1 (labelledHasTriple rest state old) (congrArg Prod.fst eq)
   · apply List.Pairwise.cons
     · intro state member eq
       exact fresh state.1 (labelledHasTriple rest state member) (congrArg Prod.fst eq)
     · exact ih

theorem completeStatesDistinct (n : Nat) : (labelled (filled n)).Nodup :=
 labelledDistinct _ (filledDistinct n)

theorem completeStateMembership (n a b c : Nat) (label : Held) :
 ((a,b,c),label)∈labelled (filled n) ↔ a+b+c≤n := by
 constructor
 · intro h
   exact filledSound n (a,b,c) (labelledHasTriple _ _ h)
 · intro h
   exact everyTripleHasBothLabels _ _ label (filledComplete a b c n h)

end SFT.Physics.NuclearCompositions
