import SFT.Chemistry.MolecularStateTransition
namespace SFT.Chemistry.ConfigurationOrder
open SFT.Physics.CapabilityValues SFT.Host
open SFT.Chemistry.MulticentreSupport (sameLabel)
-- configuration_order_law_v1.py, pinned V3 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
-- Preserve both isinstance(EmptyOne) admission and singleton identity tests.
inductive Height where
 | emptyOne
 | otherEmptyOne : String → Height
 | ratio : PositiveCount → PositiveCount → Height
structure Node where
 carrier : HeldLabel
 coordinate : HeldLabel
 height : Height
 record : HeldLabel

def constructNode (carrier coordinate : HeldLabel) (height : Height) (record : HeldLabel) : Except String Node :=
 if !Text.equal carrier.family "molecular-carrier" || !Text.equal coordinate.family "configuration-coordinate" || !Text.equal record.family "configuration-record" then
  .error "configuration node must retain carrier, coordinate and record"
 else .ok ⟨carrier,coordinate,height,record⟩

def constructPath (nodes : List Node) : Except String (List Node) :=
 match nodes with
 | [] => .error "one configuration path requires one retained molecular carrier"
 | first::rest =>
  if rest.all (fun n => sameLabel n.carrier first.carrier) then .ok nodes
  else .error "one configuration path requires one retained molecular carrier"

def isEmpty : Height → Bool
 | .emptyOne => true
 | .otherEmptyOne _ => false
 | .ratio _ _ => false

def positiveLess (a b : Height) : Except String Bool :=
 match a with
 | .emptyOne => .error "'EmptyOne' object has no attribute 'fraction'"
 | .otherEmptyOne _ => .error "'EmptyOne' object has no attribute 'fraction'"
 | .ratio an ad => match b with
   | .emptyOne => .error "'EmptyOne' object has no attribute 'fraction'"
   | .otherEmptyOne _ => .error "'EmptyOne' object has no attribute 'fraction'"
   | .ratio bn bd => .ok (an.value * bd.value < bn.value * ad.value)

def minimumTriple (left centre right : Height) : Except String Bool :=
 if isEmpty centre then .ok (!isEmpty left && !isEmpty right)
 else if isEmpty left || isEmpty right then .ok false
 else match positiveLess centre left with
 | .error e => .error e
 | .ok l => if l then positiveLess centre right else .ok false

def barrierTriple (left centre right : Height) : Except String Bool :=
 if isEmpty centre || isEmpty left || isEmpty right then
  .ok (!isEmpty centre && (isEmpty left || isEmpty right))
 else match positiveLess left centre with
 | .error e => .error e
 | .ok l => if l then positiveLess right centre else .ok false

def nodeAt (nodes : List Node) (index : Nat) : Option Node :=
 match nodes with
 | [] => none
 | n::rest => match index with
   | 0 => some n
   | k+1 => nodeAt rest k

def localComparison (kind : Bool) (nodes : List Node) (position : Int) : Except String Bool :=
 if position ≤ 0 || position ≥ Int.ofNat nodes.length - 1 then
  .error (if kind then "a local configuration comparison requires two neighbours" else "a barrier comparison requires two neighbours")
 else
  match nodeAt nodes (position.toNat-1) with
  | none => .error "IndexError"
  | some l => match nodeAt nodes position.toNat with
    | none => .error "IndexError"
    | some c => match nodeAt nodes (position.toNat+1) with
      | none => .error "IndexError"
      | some r => if kind then minimumTriple l.height c.height r.height else barrierTriple l.height c.height r.height

def localMinimum := localComparison true
def localBarrier := localComparison false

def triplesFrom (a b : Node) : List Node → List (Node × Node × Node)
 | [] => []
 | c::rest => (a,b,c)::triplesFrom b c rest

def triples (nodes : List Node) : List (Node × Node × Node) :=
 match nodes with
 | [] => []
 | a::tail => match tail with
   | [] => []
   | b::rest => triplesFrom a b rest

-- Source induction_step: retain old nodes, expose exactly the next adjacent triple.
theorem successorRetainsNodes (nodes : List Node) (next : Node) :
 (nodes ++ [next]).take nodes.length = nodes := by
 induction nodes with
 | nil => rfl
 | cons a rest ih => exact congrArg (List.cons a) ih

theorem successorComparison (a b c : Node) (rest : List Node) :
 triples (a::b::c::rest) = (a,b,c)::triples (b::c::rest) := rfl

theorem priorComparisonsRetained (a b : Node) (rest : List Node) (next : Node) :
 (triplesFrom a b (rest ++ [next])).take rest.length = triplesFrom a b rest := by
 induction rest generalizing a b with
 | nil => rfl
 | cons c tail ih => exact congrArg (List.cons (a,b,c)) (ih b c)

theorem completeComparisonCount (a b : Node) (rest : List Node) :
 (triplesFrom a b rest).length = rest.length := by
 induction rest generalizing a b with
 | nil => rfl
 | cons c tail ih => exact congrArg Nat.succ (ih b c)

theorem exactlyOneNewComparison (a b : Node) (rest : List Node) (next : Node) :
 (triplesFrom a b (rest ++ [next])).length = (triplesFrom a b rest).length + 1 := by
 rw [completeComparisonCount, completeComparisonCount]
 induction rest with
 | nil => rfl
 | cons c tail ih => exact congrArg Nat.succ ih

theorem emptyRejected : constructPath [] = .error "one configuration path requires one retained molecular carrier" := rfl

theorem singleAccepted (n : Node) : constructPath [n] = .ok [n] := rfl

theorem structuralBasin (a b c d : PositiveCount) :
 minimumTriple (.ratio a b) .emptyOne (.ratio c d) = .ok true := rfl

theorem positiveBasin (a b c d e f : PositiveCount) :
 minimumTriple (.ratio a b) (.ratio c d) (.ratio e f) =
 .ok (decide (c.value * b.value < a.value * d.value) &&
 decide (c.value * f.value < e.value * d.value)) := by
 unfold minimumTriple isEmpty positiveLess
 change (if decide (c.value * b.value < a.value * d.value) then Except.ok (decide (c.value * f.value < e.value * d.value)) else Except.ok false) = _
 cases decide (c.value * b.value < a.value * d.value) <;> rfl

theorem positiveBarrier (a b c d e f : PositiveCount) :
 barrierTriple (.ratio a b) (.ratio c d) (.ratio e f) =
 .ok (decide (a.value * d.value < c.value * b.value) &&
 decide (e.value * d.value < c.value * f.value)) := by
 unfold barrierTriple isEmpty positiveLess
 change (if decide (a.value * d.value < c.value * b.value) then Except.ok (decide (e.value * d.value < c.value * f.value)) else Except.ok false) = _
 cases decide (a.value * d.value < c.value * b.value) <;> rfl

def witnessNode (name : String) (height : Height) : Except String Node := do
 constructNode (← heldLabel "molecular-carrier" "ethanol")
  (← heldLabel "configuration-coordinate" name) height (← heldLabel "configuration-record" name)
def witnessPath : Except String (List Node) := do
 let left ← witnessNode "left" (.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)
 let basin ← witnessNode "basin" .emptyOne
 let right ← witnessNode "right" (.ratio ⟨3,by decide⟩ ⟨1,by decide⟩)
 let barrier ← witnessNode "barrier" (.ratio ⟨5,by decide⟩ ⟨1,by decide⟩)
 let terminal ← witnessNode "terminal" (.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)
 constructPath [left,basin,right,barrier,terminal]
def basinWitness : Bool := match witnessPath with
 | .error _ => false
 | .ok nodes => match localMinimum nodes 1 with
   | .error _ => false
   | .ok result => result
def barrierWitness : Bool := match witnessPath with
 | .error _ => false
 | .ok nodes => match localBarrier nodes 3 with
   | .error _ => false
   | .ok result => result
def pathWitness : Bool := match witnessPath with
 | .error _ => false
 | .ok nodes => nodes.length == 5
def invalidWitness : Bool := match constructPath [] with
 | .error _ => true
 | .ok _ => false
theorem basinWitnessPassed : basinWitness = true := rfl
theorem barrierWitnessPassed : barrierWitness = true := rfl
theorem pathWitnessPassed : pathWitness = true := rfl
theorem invalidWitnessPassed : invalidWitness = true := rfl

#print axioms priorComparisonsRetained
#print axioms completeComparisonCount
#print axioms exactlyOneNewComparison
#print axioms isEmpty
#print axioms positiveLess
#print axioms constructNode
#print axioms constructPath
#print axioms minimumTriple
#print axioms barrierTriple
#print axioms localComparison
#print axioms triples
#print axioms successorComparison
#print axioms successorRetainsNodes
#print axioms emptyRejected
#print axioms singleAccepted
#print axioms structuralBasin
#print axioms positiveBasin
#print axioms positiveBarrier
#print axioms basinWitnessPassed
#print axioms barrierWitnessPassed
#print axioms pathWitnessPassed
#print axioms invalidWitnessPassed
end SFT.Chemistry.ConfigurationOrder
