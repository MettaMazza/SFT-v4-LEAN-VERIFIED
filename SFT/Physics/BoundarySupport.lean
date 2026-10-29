import SFT.Physics.SpatialThreeEvidence
namespace SFT.Physics.BoundarySupport
open SFT.Foundation SFT.Foundation.Count.TraceDerivation
open SpatialStability GeneratorOperations

-- A complete independent carrier, with its one held normal at any position.
structure HeldNormal where
 normal : String
 before : List String
 after : List String
 independent : (before ++ normal :: after).Nodup
 separated : ¬ normal ∈ before ++ after

def spatialCarrier (held : HeldNormal) : List String := held.before ++ held.normal :: held.after

def boundaryDirections (held : HeldNormal) : List String := held.before ++ held.after

theorem normalHeld (held : HeldNormal) : held.normal ∈ spatialCarrier held :=
 memAppendRight _ _ _ (List.Mem.head _)

theorem allNonnormalRetained (held : HeldNormal) (direction : String) :
 direction ∈ boundaryDirections held ↔ direction ∈ spatialCarrier held ∧ direction ≠ held.normal := by
 constructor
 · intro member
   have spatial : direction ∈ spatialCarrier held := by
     cases memAppendCases _ _ _ member with
     | inl h => exact memAppendLeft _ _ _ h
     | inr h => exact memAppendRight _ _ _ (List.Mem.tail _ h)
   exact ⟨spatial,fun same => held.separated (same ▸ member)⟩
 · intro ⟨member,different⟩
   cases memAppendCases _ _ _ member with
   | inl h => exact memAppendLeft _ _ _ h
   | inr h => cases h with
     | head => exact False.elim (different rfl)
     | tail _ h => exact memAppendRight _ _ _ h

theorem normalReassembles (held : HeldNormal) :
 (boundaryDirections held).length + 1 = (spatialCarrier held).length := by
 unfold boundaryDirections spatialCarrier
 rw [CommonRefinement.appendLength,CommonRefinement.appendLength]
 change (held.before.length+held.after.length)+1 = held.before.length+(held.after.length+1)
 exact Nat.add_assoc _ _ _

theorem retainedRankTwo (held : HeldNormal) (three : (spatialCarrier held).length = 3) :
 (boundaryDirections held).length = 2 :=
 Nat.succ.inj ((normalReassembles held).trans three)

theorem uniqueRank (rank : Nat) (reassembles : rank+1 = 3) : rank = 2 := Nat.succ.inj reassembles

def boundaryRank : Except String Nat := do
 let dimension ← spatialDimension
 let rank ← positivePredecessor (.integer (.ofNat dimension))
 if rank+1 != dimension then
  .error "ValueError: boundary rank does not reassemble the spatial carrier"
 else .ok rank

theorem boundaryRankTwo : boundaryRank = .ok 2 := by
 unfold boundaryRank
 rw [spatialDimensionThree]
 rfl

theorem pairCellMembership (left right : List String) (a b : String) :
 (a,b) ∈ pairCells left right ↔ a ∈ left ∧ b ∈ right := by
 constructor
 · intro held
   obtain ⟨x,hx,mapped⟩ := CommonRefinement.memFlatMapOrigin _ _ _ held
   obtain ⟨y,hy,same⟩ := memMapPreimage _ _ _ mapped
   have first : x = a := congrArg Prod.fst same
   have second : y = b := congrArg Prod.snd same
   exact ⟨first ▸ hx,second ▸ hy⟩
 · intro ⟨ha,hb⟩
   exact CommonRefinement.memFlatMap _ _ _ _ ha (memMap _ _ _ hb)

theorem pairLeftSuccessor (cell : String) (left right : List String) :
 pairCells (cell :: left) right = right.map (fun b => (cell,b)) ++ pairCells left right := rfl

theorem earlierPairRetained (cell : String) (left right : List String) (a b : String)
 (held : (a,b) ∈ pairCells left right) : (a,b) ∈ pairCells (cell :: left) right :=
 memAppendRight _ _ _ held

theorem pairRightSuccessor (cell : String) (left right : List String) :
 pairCells left (cell :: right) = left.flatMap (fun a => (a,cell) :: right.map (fun b => (a,b))) := rfl

theorem earlierRightPairRetained (cell : String) (left right : List String) (a b : String)
 (held : (a,b) ∈ pairCells left right) : (a,b) ∈ pairCells left (cell :: right) := by
 have h := (pairCellMembership _ _ _ _).mp held
 exact (pairCellMembership _ _ _ _).mpr ⟨h.1,List.Mem.tail _ h.2⟩

theorem scaledPairCount (left right : List String) (scale : Nat)
 (first : left.length = scale) (second : right.length = scale) :
 (pairCells left right).length = scale*scale := by
 rw [pairCellCount,first,second]

theorem pairBase (left right : String) : pairCells [left] [right] = [(left,right)] := rfl

theorem completeBoundaryRank (held : HeldNormal) (three : (spatialCarrier held).length = 3) :
 (boundaryDirections held).length = 2 ∧ boundaryRank = .ok 2 ∧
 ∀ direction, direction ∈ boundaryDirections held ↔
   direction ∈ spatialCarrier held ∧ direction ≠ held.normal :=
 ⟨retainedRankTwo held three,boundaryRankTwo,allNonnormalRetained held⟩

end SFT.Physics.BoundarySupport
