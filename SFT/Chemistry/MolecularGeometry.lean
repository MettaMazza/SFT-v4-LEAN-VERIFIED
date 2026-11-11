import SFT.Chemistry.MolecularCarrier
import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.MolecularGeometry
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Relation where
 left : String
 right : String
 orientation : HeldLabel

def admit (row : Relation) : Except String Relation :=
 if !SourceText.nonblank row.left || !SourceText.nonblank row.right || decide (row.left=row.right) then
  .error "geometry relates two distinct atomic occurrences"
 else .ok row

def pairs : List String → List Edge
 | [] => []
 | first::rest => rest.map (fun next => (first,next)) ++ pairs rest

def unique : List Edge → List Edge
 | [] => []
 | first::rest => if has (unique rest) first then unique rest else first::unique rest

def required (nodes : List String) : List Edge := unique ((pairs nodes).map MolecularCarrier.normalizedEdge)
def observed (nodes : List String) (rows : List Relation) : List Edge :=
 unique ((rows.filter (fun row => has nodes row.left && has nodes row.right)).map
  (fun row => MolecularCarrier.normalizedEdge (row.left,row.right)))
def sameSet (left right : List Edge) : Bool := left.all (has right) && right.all (has left)
def completeGeometry (carrier : MolecularCarrier.Raw) (rows : List Relation) : Bool :=
 decide (rows.length=(observed carrier.occurrences rows).length) &&
 sameSet (observed carrier.occurrences rows) (required carrier.occurrences)

theorem sameSetMeaning (left right : List Edge) : sameSet left right=true ↔
 (∀ edge ∈ left, edge ∈ right) ∧ (∀ edge ∈ right, edge ∈ left) := by
 constructor
 · intro success
   have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp success
   exact ⟨fun edge held => (hasIff _ _).mp (SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ both.1 edge held),
     fun edge held => (hasIff _ _).mp (SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ both.2 edge held)⟩
 · intro both
   apply (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
   exact ⟨(allTrueIffMembers _ _).mpr (fun edge held => (hasIff _ _).mpr (both.1 edge held)),
     (allTrueIffMembers _ _).mpr (fun edge held => (hasIff _ _).mpr (both.2 edge held))⟩

theorem completeMeaning (carrier : MolecularCarrier.Raw) (rows : List Relation) :
 completeGeometry carrier rows=true ↔
 rows.length=(observed carrier.occurrences rows).length ∧
 (∀ edge ∈ observed carrier.occurrences rows, edge ∈ required carrier.occurrences) ∧
 (∀ edge ∈ required carrier.occurrences, edge ∈ observed carrier.occurrences rows) := by
 constructor
 · intro success
   have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp success
   exact ⟨of_decide_eq_true both.1,(sameSetMeaning _ _).mp both.2⟩
 · intro all
   exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr ⟨decide_eq_true all.1,(sameSetMeaning _ _).mpr all.2⟩

theorem pairSuccessor (nodes : List String) (fresh : String) (edge : Edge) :
 edge ∈ pairs (nodes++[fresh]) ↔ edge ∈ pairs nodes ∨ edge ∈ nodes.map (fun prior => (prior,fresh)) := by
 induction nodes with
 | nil => constructor <;> intro h <;> cases h <;> contradiction
 | cons first rest ih =>
   constructor
   · intro member
     cases memAppendCases edge ((rest++[fresh]).map (fun next => (first,next))) (pairs (rest++[fresh])) member with
     | inl head =>
       obtain ⟨next,held,equal⟩ := memMapPreimage (fun next => (first,next)) edge (rest++[fresh]) head
       cases memAppendCases next rest [fresh] held with
       | inl old => exact .inl (memAppendLeft _ _ _ (equal ▸ memMap _ _ _ old))
       | inr added =>
         cases added with
         | head => exact .inr (equal ▸ .head _)
         | tail _ impossible => cases impossible
     | inr tail =>
       cases ih.mp tail with
       | inl old => exact .inl (memAppendRight _ _ _ old)
       | inr added => exact .inr (.tail _ added)
   · intro member
     cases member with
     | inl old =>
       cases memAppendCases edge (rest.map (fun next => (first,next))) (pairs rest) old with
       | inl head =>
         obtain ⟨next,held,equal⟩ := memMapPreimage (fun next => (first,next)) edge rest head
         exact memAppendLeft _ _ _ (equal ▸ memMap _ _ _ (memAppendLeft _ _ _ held))
       | inr tail => exact memAppendRight _ _ _ (ih.mpr (.inl tail))
     | inr added =>
       cases added with
       | head => exact memAppendLeft _ _ _ (memMap _ _ _ (memAppendRight fresh rest [fresh] (.head [])))
       | tail _ old => exact memAppendRight _ _ _ (ih.mpr (.inr old))

theorem uniqueMeaning (edges : List Edge) (edge : Edge) : edge ∈ unique edges ↔ edge ∈ edges := by
 induction edges with
 | nil => exact ⟨fun h => h,fun h => h⟩
 | cons first rest ih =>
   unfold unique
   split
   · rename_i present
     have held := (hasIff _ _).mp present
     constructor
     · intro h; exact .tail _ (ih.mp h)
     · intro h
       cases h with
       | head => exact held
       | tail _ tail => exact ih.mpr tail
   · constructor
     · intro h
       cases h with
       | head => exact .head _
       | tail _ tail => exact .tail _ (ih.mp tail)
     · intro h
       cases h with
       | head => exact .head _
       | tail _ tail => exact .tail _ (ih.mpr tail)

theorem requiredSuccessor (nodes : List String) (fresh : String) (edge : Edge) :
 edge ∈ required (nodes++[fresh]) ↔ edge ∈ required nodes ∨
 ∃ prior ∈ nodes, MolecularCarrier.normalizedEdge (prior,fresh)=edge := by
 constructor
 · intro member
   obtain ⟨pair,held,equal⟩ := memMapPreimage MolecularCarrier.normalizedEdge edge (pairs (nodes++[fresh])) ((uniqueMeaning _ _).mp member)
   cases (pairSuccessor nodes fresh pair).mp held with
   | inl old => exact .inl ((uniqueMeaning _ _).mpr (equal ▸ memMap _ _ _ old))
   | inr added =>
     obtain ⟨prior,priorHeld,same⟩ := memMapPreimage (fun prior => (prior,fresh)) pair nodes added
     cases same
     exact .inr ⟨prior,priorHeld,equal⟩
 · intro member
   apply (uniqueMeaning _ _).mpr
   cases member with
   | inl old =>
     obtain ⟨pair,held,equal⟩ := memMapPreimage MolecularCarrier.normalizedEdge edge (pairs nodes) ((uniqueMeaning _ _).mp old)
     exact equal ▸ memMap _ _ _ ((pairSuccessor nodes fresh pair).mpr (.inl held))
   | inr added =>
     obtain ⟨prior,held,equal⟩ := added
     exact equal ▸ memMap _ _ _ ((pairSuccessor nodes fresh (prior,fresh)).mpr (.inr (memMap _ _ _ held)))

def orientation : HeldLabel := ⟨"orientation","first-ray",rfl,rfl⟩
def baseRelation : Relation := ⟨"atom-occurrence-one","atom-occurrence-two",orientation⟩
theorem baseRelationAdmitted : admit baseRelation=.ok baseRelation := rfl
theorem firstMoleculeHasOneCompleteRelation : completeGeometry MolecularCarrier.originalDiatomic [baseRelation]=true := rfl

def appendRelations (before added : List Relation) := before++added
theorem priorOrientationsRetained (before added : List Relation) (row : Relation) (held : row∈before) :
 row∈appendRelations before added := memAppendLeft _ _ _ held

-- The source stores relative held orientations, not absolute host coordinates.
def orientationRelabel (f : HeldLabel → HeldLabel) (row : Relation) : Relation :=
 ⟨row.left,row.right,f row.orientation⟩

theorem relabelRetainsEndpoints (f : HeldLabel → HeldLabel) (row : Relation) :
 (orientationRelabel f row).left=row.left ∧ (orientationRelabel f row).right=row.right := ⟨rfl,rfl⟩

theorem relabelRetainsAdmission (f : HeldLabel → HeldLabel) (row : Relation)
 (accepted : admit row=.ok row) : admit (orientationRelabel f row)=.ok (orientationRelabel f row) := by
 unfold admit at accepted ⊢
 split at accepted
 · cases accepted
 · rename_i guards
   change (if (!SourceText.nonblank row.left || !SourceText.nonblank row.right || decide (row.left=row.right))=true then _ else _)=_
   rw [ite_eq_right guards]

def relativeRecord (row : Relation) := (row.left,row.right,row.orientation)
theorem completeOrientationRecord (row : Relation) :
 relativeRecord row=(row.left,row.right,row.orientation) := rfl
end SFT.Chemistry.MolecularGeometry
