import SFT.Chemistry.ConformerOrbitProgress
namespace SFT.Chemistry.ConformerAssignmentMembership
open ConformerAssignments ConformerCensus MulticentreSupport MulticentreConnectivity
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

theorem sameWordKeys (left right : Assignment) :
 sameWord left right=true ↔ left.map identityKey=right.map identityKey := by
 induction left generalizing right with
 | nil =>
  cases right with
  | nil => exact ⟨fun _ => rfl,fun _ => rfl⟩
  | cons x xs => exact ⟨(fun h => by cases h),(fun h => by cases h)⟩
 | cons x xs ih =>
  cases right with
  | nil => exact ⟨(fun h => by cases h),(fun h => by cases h)⟩
  | cons y ys =>
   constructor
   · intro matched
     change sameLabel x y && sameWord xs ys=true at matched
     cases head : sameLabel x y with
     | false => rw [head] at matched; cases matched
     | true =>
      rw [head] at matched
      have keys := (sameLabelKey x y).mp head
      exact (congrArg (fun key => key::xs.map identityKey) keys).trans (congrArg (List.cons (identityKey y)) ((ih ys).mp matched))
   · intro equal
     have parts := List.cons.inj equal
     have head := (sameLabelKey x y).mpr parts.1
     have tail := (ih ys).mpr parts.2
     change sameLabel x y && sameWord xs ys=true
     rw [head,tail]
     rfl

theorem wordSelf (word : Assignment) : sameWord word word=true := (sameWordKeys word word).mpr rfl
theorem wordSymmetry (left right : Assignment) (equal : sameWord left right=true) :
 sameWord right left=true := (sameWordKeys right left).mpr ((sameWordKeys left right).mp equal).symm
theorem wordTransitivity (a b c : Assignment) (ab : sameWord a b=true) (bc : sameWord b c=true) :
 sameWord a c=true := (sameWordKeys a c).mpr (((sameWordKeys a b).mp ab).trans ((sameWordKeys b c).mp bc))

theorem containsWitness (rows : List Assignment) (anchor : Assignment) :
 containsAssignment rows anchor=true ↔ ∃ row, row∈rows ∧ sameWord anchor row=true := by
 induction rows with
 | nil => exact ⟨(fun h => by cases h),(fun ⟨row,h,_⟩ => by cases h)⟩
 | cons first rest ih =>
  constructor
  · intro held
    change sameWord anchor first || containsAssignment rest anchor=true at held
    cases head : sameWord anchor first with
    | true => exact ⟨first,List.Mem.head rest,head⟩
    | false =>
     rw [head] at held
     obtain ⟨row,member,matched⟩ := ih.mp held
     exact ⟨row,List.Mem.tail first member,matched⟩
  · intro ⟨row,member,matched⟩
    change sameWord anchor first || containsAssignment rest anchor=true
    cases member with
    | head => rw [matched]; rfl
    | tail _ member =>
     rw [ih.mpr ⟨row,member,matched⟩]
     cases sameWord anchor first <;> rfl

theorem removalMember (remaining orbit : List Assignment) (row : Assignment)
 (member : row∈remaining.filter (fun x => !containsAssignment orbit x)) :
 row∈remaining ∧ containsAssignment orbit row=false := by
 induction remaining with
 | nil => cases member
 | cons first rest ih =>
  change row∈(match !containsAssignment orbit first with
   | true => first::rest.filter (fun x => !containsAssignment orbit x)
   | false => rest.filter (fun x => !containsAssignment orbit x)) at member
  cases removed : containsAssignment orbit first with
  | true =>
   rw [removed] at member
   obtain ⟨held,absent⟩ := ih member
   exact ⟨List.Mem.tail first held,absent⟩
  | false =>
   rw [removed] at member
   cases member with
   | head => exact ⟨List.Mem.head rest,removed⟩
   | tail _ member =>
    obtain ⟨held,absent⟩ := ih member
    exact ⟨List.Mem.tail first held,absent⟩

theorem removalContainsSubset (remaining orbit : List Assignment) (anchor : Assignment)
 (held : containsAssignment (remaining.filter (fun x => !containsAssignment orbit x)) anchor=true) :
 containsAssignment remaining anchor=true := by
 obtain ⟨row,member,matched⟩ := (containsWitness _ anchor).mp held
 exact (containsWitness remaining anchor).mpr ⟨row,(removalMember remaining orbit row member).1,matched⟩

theorem removalAnchorAbsent (remaining orbit : List Assignment) (anchor : Assignment)
 (self : containsAssignment orbit anchor=true) :
 containsAssignment (remaining.filter (fun x => !containsAssignment orbit x)) anchor=false := by
 cases held : containsAssignment (remaining.filter (fun x => !containsAssignment orbit x)) anchor with
 | false => rfl
 | true =>
  obtain ⟨row,member,matched⟩ := (containsWitness _ anchor).mp held
  have removed := (removalMember remaining orbit row member).2
  obtain ⟨image,present,anchorImage⟩ := (containsWitness orbit anchor).mp self
  have rowImage := wordTransitivity row anchor image (wordSymmetry anchor row matched) anchorImage
  have yes := (containsWitness orbit row).mpr ⟨image,present,rowImage⟩
  rw [removed] at yes
  cases yes

theorem uniqueOrigins (inputs : List Assignment) : ∀ row, row∈uniqueAssignments inputs → row∈inputs := by
 let add := fun (seen : List Assignment) (row : Assignment) => if containsAssignment seen row then seen else seen++[row]
 have loop (pending seen : List Assignment)
  (pendingInside : ∀ row, row∈pending → row∈inputs) (seenInside : ∀ row, row∈seen → row∈inputs) :
  ∀ row, row∈pending.foldl add seen → row∈inputs := by
  induction pending generalizing seen with
  | nil => exact seenInside
  | cons first rest ih =>
   apply ih
   · intro row member; exact pendingInside row (List.Mem.tail first member)
   · intro row member
     change row∈(if containsAssignment seen first then seen else seen++[first]) at member
     cases existing : containsAssignment seen first with
     | true => rw [existing] at member; exact seenInside row member
     | false =>
      rw [existing] at member
      cases memAppendCases row seen [first] member with
      | inl h => exact seenInside row h
      | inr h =>
       cases h with
       | head => exact pendingInside first (List.Mem.head rest)
       | tail _ h => cases h
 exact loop inputs [] (fun _ h => h) (fun _ h => by cases h)

theorem earliestAfterPrefix (before after remaining : List Assignment) (anchor : Assignment)
 (excluded : ∀ row, row∈before → containsAssignment remaining row=false)
 (active : containsAssignment remaining anchor=true) :
 (before++anchor::after).find? (containsAssignment remaining)=some anchor := by
 induction before with
 | nil =>
  change (match containsAssignment remaining anchor with | true => some anchor | false => _) = some anchor
  rw [active]
 | cons first rest ih =>
  change (match containsAssignment remaining first with
   | true => some first
   | false => (rest++anchor::after).find? (containsAssignment remaining))=some anchor
  rw [excluded first (List.Mem.head rest)]
  exact ih (fun row member => excluded row (List.Mem.tail first member))

theorem noRemainingAfterFullScan (assignments remaining : List Assignment)
 (origin : ∀ row, row∈remaining → row∈assignments)
 (excluded : ∀ row, row∈assignments → containsAssignment remaining row=false) : remaining=[] := by
 cases remaining with
 | nil => rfl
 | cons first rest =>
  have absent := excluded first (origin first (List.Mem.head rest))
  have present := (containsWitness (first::rest) first).mpr ⟨first,List.Mem.head rest,wordSelf first⟩
  rw [absent] at present
  cases present
end SFT.Chemistry.ConformerAssignmentMembership
