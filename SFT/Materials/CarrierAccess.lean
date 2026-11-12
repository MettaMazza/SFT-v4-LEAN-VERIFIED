import SFT.Mathematics.GraphPathCompleteness
namespace SFT.Materials.CarrierAccess
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects

-- The original occupied/access support is fully enumerated, not sampled.
def pairs (occupied accessible : List String) : List Edge :=
 occupied.flatMap (fun source => accessible.map (fun target => (source,target)))

def paths (graph : GeneratedGraph) (occupied accessible : List String) :=
 (pairs occupied accessible).filter (fun edge => reachable graph edge.1 edge.2)

theorem pairMembership (occupied accessible : List String) (source target : String) :
 (source,target) ∈ pairs occupied accessible ↔ source∈occupied ∧ target∈accessible := by
 induction occupied with
 | nil =>
   constructor
   · intro h; cases h
   · intro h; cases h.1
 | cons first rest ih =>
   change (source,target) ∈ accessible.map (fun x => (first,x)) ++ pairs rest accessible ↔ _
   constructor
   · intro h
     cases SFT.Foundation.Count.TraceDerivation.memAppendCases _ _ _ h with
     | inl h =>
       obtain ⟨x,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage (fun x => (first,x)) _ accessible h
       have hs : first = source := congrArg Prod.fst same
       have ht : x = target := congrArg Prod.snd same
       exact ⟨hs ▸ List.Mem.head _,ht ▸ held⟩
     | inr h => have h := ih.mp h; exact ⟨.tail _ h.1,h.2⟩
   · intro h
     cases h.1 with
     | head =>
       exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _
         (SFT.Foundation.Count.TraceDerivation.memMap (fun x => (source,x)) target accessible h.2)
     | tail _ h' => exact SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (ih.mpr ⟨h',h.2⟩)

theorem connectionExactly (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
 (accepted : makeGraph nodes edges=.ok graph) (occupied accessible : List String) (source target : String) :
 (source,target)∈paths graph occupied accessible ↔
 source∈occupied ∧ target∈accessible ∧ PathWitness graph source target := by
 constructor
 · intro h
   have p := (filterMemberIff _ _ _).mp h
   have members := (pairMembership _ _ _ _).mp p.1
   exact ⟨members.1,members.2,(admittedReachabilityIffPath nodes edges graph accepted source target).mp p.2⟩
 · intro h
   exact (filterMemberIff _ _ _).mpr ⟨(pairMembership _ _ _ _).mpr ⟨h.1,h.2.1⟩,
     (admittedReachabilityIffPath nodes edges graph accepted source target).mpr h.2.2⟩

theorem noConnectionExactly (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
 (accepted : makeGraph nodes edges=.ok graph) (occupied accessible : List String) :
 paths graph occupied accessible=[] ↔
 ∀ source, source∈occupied → ∀ target, target∈accessible → ¬ PathWitness graph source target := by
 constructor
 · intro empty source hs target ht path
   have member := (connectionExactly nodes edges graph accepted occupied accessible source target).mpr ⟨hs,ht,path⟩
   rw [empty] at member
   cases member
 · intro absent
   cases result : paths graph occupied accessible with
   | nil => rfl
   | cons edge rest =>
     have member : edge∈paths graph occupied accessible := result ▸ List.Mem.head _
     have h := (connectionExactly nodes edges graph accepted occupied accessible edge.1 edge.2).mp member
     exact False.elim (absent edge.1 h.1 edge.2 h.2.1 h.2.2)
end SFT.Materials.CarrierAccess
