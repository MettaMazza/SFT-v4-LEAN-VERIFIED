import SFT.Materials.MaterialInterface
import SFT.Materials.MaterialCarrier
namespace SFT.Materials.CompositeOrganization
open SFT.Physics.MechanicalConservation
open SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[62]: retain constituent carriers and the declared
-- interface architecture. The original statement supplies no mixture fit.
structure Constituent (Composition : Type) where
 identity : String
 material : MaterialCarrier.Record Composition

structure Interface (Composition Content Traction : Type) where
 left : Constituent Composition
 right : Constituent Composition
 distinct : left.identity ≠ right.identity
 payload : MaterialInterface.Payload Content Traction
 contentBound : ∀ t ∈ payload.content,
  MaterialInterface.onBoundary (left.identity,right.identity) t
 tractionBound : ∀ t ∈ payload.traction,
  MaterialInterface.onBoundary (left.identity,right.identity) t
 barrier : SFT.Host.Canonical.Value

structure Record (Composition Content Traction : Type) where
 first : Constituent Composition
 second : Constituent Composition
 distinct : first.identity ≠ second.identity
 rest : List (Constituent Composition)
 interfaces : List (Interface Composition Content Traction)
 endpoints : ∀ i ∈ interfaces, i.left ∈ first::second::rest ∧ i.right ∈ first::second::rest
 architecture : SFT.Host.Canonical.Value
 scale : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {Composition Content Traction : Type}

def constituents (r : Record Composition Content Traction) := r.first::r.second::r.rest

def content (r : Record Composition Content Traction) := r.interfaces.flatMap (fun i => i.payload.content)
def traction (r : Record Composition Content Traction) := r.interfaces.flatMap (fun i => i.payload.traction)

theorem distinguishableConstituents (r : Record Composition Content Traction) : r.first ≠ r.second :=
 fun h => r.distinct (congrArg Constituent.identity h)

theorem allContentConserved (r : Record Composition Content Traction) :
 outgoingSupport (content r) = incomingSupport (content r) := completeConservation _

theorem allTractionConserved (r : Record Composition Content Traction) :
 outgoingSupport (traction r) = incomingSupport (traction r) := completeConservation _

theorem eachContentFromInterface (r : Record Composition Content Traction) (t : Transfer String Content)
 (held : t ∈ content r) : ∃ i ∈ r.interfaces, t ∈ i.payload.content :=
 SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ held

theorem eachTractionFromInterface (r : Record Composition Content Traction) (t : Transfer String Traction)
 (held : t ∈ traction r) : ∃ i ∈ r.interfaces, t ∈ i.payload.traction :=
 SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ held

theorem contentUsesDeclaredInterface (r : Record Composition Content Traction) (t : Transfer String Content)
 (held : t ∈ content r) : ∃ i ∈ r.interfaces,
 MaterialInterface.onBoundary (i.left.identity,i.right.identity) t := by
 obtain ⟨i,hi,ht⟩ := eachContentFromInterface r t held
 exact ⟨i,hi,i.contentBound t ht⟩

theorem tractionUsesDeclaredInterface (r : Record Composition Content Traction) (t : Transfer String Traction)
 (held : t ∈ traction r) : ∃ i ∈ r.interfaces,
 MaterialInterface.onBoundary (i.left.identity,i.right.identity) t := by
 obtain ⟨i,hi,ht⟩ := eachTractionFromInterface r t held
 exact ⟨i,hi,i.tractionBound t ht⟩

def appendInterface (r : Record Composition Content Traction) (i : Interface Composition Content Traction)
 (bound : i.left ∈ constituents r ∧ i.right ∈ constituents r) : Record Composition Content Traction :=
 { r with
  interfaces := r.interfaces++[i]
  endpoints := by
   intro j held
   cases memAppendCases j r.interfaces [i] held with
   | inl prior => exact r.endpoints j prior
   | inr added => cases added with
     | head => exact bound
     | tail _ impossible => cases impossible }

theorem successorConstituents (r : Record Composition Content Traction) (i : Interface Composition Content Traction)
 (bound : i.left ∈ constituents r ∧ i.right ∈ constituents r) :
 constituents (appendInterface r i bound) = constituents r := rfl

theorem successorContent (r : Record Composition Content Traction) (i : Interface Composition Content Traction)
 (bound : i.left ∈ constituents r ∧ i.right ∈ constituents r) :
 content (appendInterface r i bound) = content r++i.payload.content := by
 change (r.interfaces++[i]).flatMap (fun j => j.payload.content) = r.interfaces.flatMap (fun j => j.payload.content)++i.payload.content
 generalize r.interfaces = is
 induction is with
 | nil =>
   change i.payload.content++[] = i.payload.content
   generalize i.payload.content = xs
   induction xs with
   | nil => rfl
   | cons x xs ih => exact congrArg (List.cons x) ih
 | cons first rest ih =>
   change first.payload.content ++ ((rest++[i]).flatMap _) = (first.payload.content++rest.flatMap _)++i.payload.content
   rw [ih, SFT.Mathematics.ExactTraceArithmetic.appendAssociative]

def record (r : Record Composition Content Traction) := (r,content r,traction r)

theorem wholeInputRetained (r : Record Composition Content Traction) : (record r).1 = r := rfl

def records (rs : List (Record Composition Content Traction)) := rs.map record

theorem base (r : Record Composition Content Traction) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Composition Content Traction)) (r : Record Composition Content Traction) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.CompositeOrganization
