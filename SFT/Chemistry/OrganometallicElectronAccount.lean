import SFT.Chemistry.OrganometallicBondDerivation
namespace SFT.Chemistry.OrganometallicElectronAccount
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (sameLabel distinctLabels)
inductive PairSupport where
 | empty (identity : String := "empty-One")
 | rows (values : List (List HeldLabel))
def supportRows : PairSupport → List (List HeldLabel)
 | .empty _ => []
 | .rows xs => xs
def forcedCapacity : PositiveCount :=
 let s : PositiveCount := ⟨2,by decide⟩
 let p : PositiveCount := ⟨6,by decide⟩
 let d : PositiveCount := ⟨10,by decide⟩
 ⟨(s.value+p.value)+d.value,by decide⟩
def completePairs (stem : String) (n : PositiveCount) : Except String (List (List HeldLabel)) :=
 (List.range n.value).mapM fun i => do
  let base := Text.intercalate "-" [stem,toString (i+1)]
  let a ← heldLabel "held-electron-occurrence" (Text.append base "-fibre-a")
  let b ← heldLabel "held-electron-occurrence" (Text.append base "-fibre-b")
  pure [a,b]
def removeSuffix (s suffix : String) : String :=
 if Text.isPrefix suffix.toUTF8.data.toList.reverse s.toUTF8.data.toList.reverse then
  String.ofList ((Text.chars s).take ((Text.chars s).length-(Text.chars suffix).length))
 else s
def complementary : List HeldLabel → Bool
 | [a,b] => Text.equal (removeSuffix a.label "fibre-a") (removeSuffix b.label "fibre-b")
 | [] | [_] | _::_::_::_ => false
structure Account where
 entity : HeldLabel
 nonbonded : PairSupport
 bond : PairSupport
 electronCount : PositiveCount
 capacity : PositiveCount
 relation : HeldLabel
 magneticClass : HeldLabel
def account (entity : HeldLabel) (nonbonded bond : PairSupport) (n capacity : PositiveCount)
 (relation magneticClass : HeldLabel) : Except String Account :=
 let pairs := supportRows nonbonded ++ supportRows bond
 let flat := pairs.flatten
 if !Text.equal entity.family "organometallic-entity" then
  .error "electron account requires one retained organometallic entity"
 else if pairs.isEmpty then
  .error "an empty account must be structural EmptyOne, not a positive electron account"
 else if pairs.any (fun pair => !complementary pair) then
  .error "stable diamagnetic account requires complete complementary fibre pairs"
 else if !distinctLabels flat || n.value != flat.length then
  .error "electron count must equal complete distinct held support"
 else if capacity.value != forcedCapacity.value then
  .error "capacity must be generated from exact s, p and d support widths"
 else if n.value > capacity.value || !sameLabel relation ⟨"capacity-relation",(if n.value==capacity.value then "capacity-complete" else "capacity-incomplete"),rfl,by split <;> rfl⟩ then
  .error "electron support exceeds or misstates the forced capacity"
 else if !sameLabel magneticClass ⟨"magnetic-class","diamagnetic",rfl,rfl⟩ then
  .error "complete pair support forces the diamagnetic held class"
 else .ok ⟨entity,nonbonded,bond,n,capacity,relation,magneticClass⟩
def forcePositive (entity : String) (nonbonded bond : PairSupport) : Except String Account := do
 let n ← count ((supportRows nonbonded++supportRows bond).flatten.length)
 let e ← heldLabel "organometallic-entity" entity
 let r ← heldLabel "capacity-relation" (if n.value==forcedCapacity.value then "capacity-complete" else "capacity-incomplete")
 let m ← heldLabel "magnetic-class" "diamagnetic"
 account e nonbonded bond n forcedCapacity r m
inductive Result where
 | empty (identity : String := "empty-One")
 | positive (value : Account)
def forced (entity : String) (nonbonded bond : PairSupport) : Except String Result :=
 match nonbonded,bond with
 | .empty _,.empty _ => .ok (.empty "empty-One")
 | .empty _,.rows _ | .rows _,.empty _ | .rows _,.rows _ => (forcePositive entity nonbonded bond).map Result.positive
def appendPair (a : Account) (destination : String) : Except String Account := do
 if a.electronCount.value==a.capacity.value then
  throw "capacity-complete account rejects an additional pair"
 let existing := supportRows (if Text.equal destination "nonbonded" then a.nonbonded else a.bond)
 let generated ← completePairs destination ⟨existing.length+1,Nat.zero_lt_succ _⟩
 let next := generated.getLastD []
 if Text.equal destination "nonbonded" then
  forcePositive a.entity.label (.rows (existing++[next])) a.bond
 else if Text.equal destination "bond" then
  forcePositive a.entity.label a.nonbonded (.rows (existing++[next]))
 else throw "pair destination must be retained as nonbonded or bond"
def complete : Except String Account := do
 forcePositive "complete" (.rows (← completePairs "nonbonded" ⟨4,by decide⟩)) (.rows (← completePairs "bond" ⟨5,by decide⟩))
def partialAccount : Except String Account := do
 forcePositive "partial" (.empty "empty-One") (.rows (← completePairs "bond" ⟨1,by decide⟩))
def capacityWitness : Bool := forcedCapacity.value==18
def completeWitness : Bool := match complete with
 | .error _ => false
 | .ok a => a.electronCount.value==18 && Text.equal a.relation.label "capacity-complete"
def successorWitness : Bool := match partialAccount with
 | .error _ => false
 | .ok a => match appendPair a "bond" with
  | .error _ => false
  | .ok b => a.electronCount.value==2 && b.electronCount.value==4
def haltWitness : Bool := match complete with
 | .error _ => false
 | .ok a => match appendPair a "bond" with
  | .error _ => true | .ok _ => false
theorem capacityPassed : capacityWitness=true := by decide
theorem completePassed : completeWitness=true := by decide
theorem successorPassed : successorWitness=true := by decide
theorem haltPassed : haltWitness=true := by decide
end SFT.Chemistry.OrganometallicElectronAccount
