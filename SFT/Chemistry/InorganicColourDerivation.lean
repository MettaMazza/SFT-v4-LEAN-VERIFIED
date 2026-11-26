import SFT.Chemistry.InorganicColour
namespace SFT.Chemistry.InorganicColourDerivation
open SFT.Physics.CapabilityValues InorganicColour
-- Both classes use the original membership predicate; their counts exhaust each incident occurrence.
theorem complementaryCount (incident absorbed : List HeldLabel) :
 (incident.filter (containsLabel absorbed)).length+(complement incident absorbed).length=incident.length := by
 induction incident with
 | nil => rfl
 | cons x xs ih =>
  change ((x::xs).filter (containsLabel absorbed)).length+((x::xs).filter (fun y => !containsLabel absorbed y)).length=_
  rw [List.filter,List.filter]
  cases h : containsLabel absorbed x with
  | false => change (xs.filter (containsLabel absorbed)).length+(complement xs absorbed).length+1=xs.length+1; exact congrArg Nat.succ ih
  | true =>
   change (xs.filter (containsLabel absorbed)).length+1+(complement xs absorbed).length=xs.length+1
   rw [Nat.add_right_comm]; exact congrArg Nat.succ ih
theorem complementAppend (incident absorbed : List HeldLabel) (x : HeldLabel) :
 complement (incident++[x]) absorbed = complement incident absorbed ++ (if containsLabel absorbed x then [] else [x]) := by
 induction incident with
 | nil =>
  change ([x].filter (fun y => !containsLabel absorbed y))=_
  rw [List.filter]
  cases containsLabel absorbed x <;> rfl
 | cons y ys ih =>
  change ((y::(ys++[x])).filter (fun z => !containsLabel absorbed z))=_
  rw [List.filter]
  change (match !containsLabel absorbed y with | true => y::complement (ys++[x]) absorbed | false => complement (ys++[x]) absorbed)=
   ((y::ys).filter (fun z => !containsLabel absorbed z))++_
  rw [List.filter]
  rw [ih]
  cases containsLabel absorbed y <;> rfl

theorem retainedAppend (incident absorbed : List HeldLabel) (x : HeldLabel) (notAbsorbed : containsLabel absorbed x=false) :
 complement (incident++[x]) absorbed=complement incident absorbed++[x] := by
 rw [complementAppend,notAbsorbed]; rfl
theorem containsAppend (absorbed : List HeldLabel) (x y : HeldLabel) :
 containsLabel (absorbed++[x]) y=(containsLabel absorbed y || sameLabel y x) := by
 induction absorbed with
 | nil => change (sameLabel y x || false)=(false || sameLabel y x); cases sameLabel y x <;> rfl
 | cons z zs ih =>
  change (sameLabel y z || containsLabel (zs++[x]) y)=((sameLabel y z || containsLabel zs y)||sameLabel y x)
  rw [ih]; exact (Bool.or_assoc _ _ _).symm
theorem oldRetainedPreserved (incident absorbed : List HeldLabel) (x : HeldLabel)
 (fresh : ∀ y, List.Mem y incident → sameLabel y x=false) :
 complement incident (absorbed++[x])=complement incident absorbed := by
 induction incident with
 | nil => rfl
 | cons y ys ih =>
  have hy := fresh y (List.Mem.head ys)
  have rest : ∀ z, List.Mem z ys → sameLabel z x=false := fun z hz => fresh z (List.Mem.tail y hz)
  change ((y::ys).filter (fun z => !containsLabel (absorbed++[x]) z))=((y::ys).filter (fun z => !containsLabel absorbed z))
  rw [List.filter,List.filter,containsAppend,hy,Bool.or_false]
  cases containsLabel absorbed y with
  | false => exact congrArg (List.cons y) (ih rest)
  | true => exact ih rest
theorem sameLabelSelf (x : HeldLabel) : sameLabel x x=true := by
 have numberSelf : ∀ n : Nat, Nat.beq n n=true := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 have self : ∀ ns : List Nat, (ns==ns)=true := by
  intro ns
  induction ns with
  | nil => rfl
  | cons n ns ih =>
   change (Nat.beq n n && (ns==ns))=true
   rw [numberSelf,ih]
   rfl
 unfold sameLabel SFT.Host.Text.equal
 rw [self,self]
 rfl
theorem absorbedAppend (incident absorbed : List HeldLabel) (x : HeldLabel)
 (fresh : ∀ y, List.Mem y incident → sameLabel y x=false) :
 complement (incident++[x]) (absorbed++[x])=complement incident absorbed := by
 rw [complementAppend,oldRetainedPreserved incident absorbed x fresh,containsAppend,sameLabelSelf]
 have emptyRight : ∀ xs : List HeldLabel, xs++[]=xs := by
  intro xs
  induction xs with
  | nil => rfl
  | cons a xs ih => exact congrArg (List.cons a) ih
 cases containsLabel absorbed x <;> exact emptyRight _
def twoBase : Except String (List Absorption) := do
 let t ← witnessTransition
 let a ← heldLabel "observation-distinction" "first"
 let b ← heldLabel "observation-distinction" "second"
 let first ← selective t [a,b] [a]
 let second ← selective t [a,b] [b]
 return [first,second]
def twoBaseWitness : Bool := match twoBase with
 | .error _ => false
 | .ok rows => rows.length==2 && rows.all (fun a => (absorbedCount a).value==1 && (retainedCount a).value==1)
theorem twoBasePassed : twoBaseWitness=true := by decide
theorem successorGap (source target : PositiveCount) (ordered : source.value<target.value) :
 (target.value+1)-source.value=(target.value-source.value)+1 := by
 have step : ∀ low high : Nat, low<high → (high+1)-low=(high-low)+1 := by
  intro low
  induction low with
  | zero => intro high h; rfl
  | succ low ih =>
   intro high h
   cases high with
   | zero => exact False.elim (Nat.not_lt_zero _ h)
   | succ high =>
    rw [Nat.succ_sub_succ_eq_sub,Nat.succ_sub_succ_eq_sub]
    exact ih high (Nat.lt_of_succ_lt_succ h)
 exact step source.value target.value ordered
-- The transition source and target identities are retained when only its target order is extended.
def successorState (s : State) : State := {s with orderPosition := ⟨s.orderPosition.value+1,Nat.zero_lt_succ _⟩}
theorem successorIdentity (s : State) : (successorState s).complexIdentity=s.complexIdentity ∧
 (successorState s).carrierKind=s.carrierKind ∧ (successorState s).stateIdentity=s.stateIdentity := ⟨rfl,rfl,rfl⟩
end SFT.Chemistry.InorganicColourDerivation
