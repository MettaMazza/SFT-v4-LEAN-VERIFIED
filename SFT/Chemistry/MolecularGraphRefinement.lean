import SFT.Chemistry.MolecularGraphEnumeration
import SFT.Host.SHA256Chunks
namespace SFT.Chemistry.MolecularGraphRefinement
open SFT.Host MolecularGraphCarrier MolecularGraphEnumeration
-- Exact typed signatures for _refined_cells. The first round carries atom
-- labels; following rounds carry the positive ranks of distinct signatures.
structure Signature (α : Type) where
 label : List String
 neighbours : List (Nat × String × α)
def neighbourhoodLE (le : α → α → Bool) (a b : Nat × String × α) : Bool :=
 if a.1 == b.1 then
  if Text.equal a.2.1 b.2.1 then le a.2.2 b.2.2 else Text.le a.2.1 b.2.1
 else a.1 ≤ b.1
def insertRow (le : α → α → Bool) (row : α) : List α → List α
 | [] => [row]
 | first::rest => if le row first then row::first::rest else first::insertRow le row rest
def sortedRows (le : α → α → Bool) : List α → List α
 | [] => []
 | first::rest => insertRow le first (sortedRows le rest)
def rowsLE (le : α → α → Bool) : List α → List α → Bool
 | [],_ => true
 | _::_,[] => false
 | a::as,b::bs => if le a b && le b a then rowsLE le as bs else le a b
def signatureLE (le : α → α → Bool) (a b : Signature α) : Bool :=
 if stringListLE a.label b.label && stringListLE b.label a.label
 then rowsLE (neighbourhoodLE le) a.neighbours b.neighbours
 else stringListLE a.label b.label
def distinctRows (le : α → α → Bool) : List α → List α
 | [] => []
 | first::rest => if rest.any (fun next => le first next && le next first)
   then distinctRows le rest else first::distinctRows le rest
def positions (graph : Graph) : List Nat := (List.range graph.atoms.length).map (fun n => n+1)
def labelAt (graph : Graph) (position : Nat) : List String :=
 (atIndex graph.atoms (position-1)).map atomLabel |>.getD []
def signatures (graph : Graph) (colour : Nat → α) (le : α → α → Bool) : List (Signature α) :=
 (positions graph).map fun position =>
  ⟨labelAt graph position,sortedRows (neighbourhoodLE le)
   ((neighbours graph (Int.ofNat position)).map fun (next,order,orientation) =>
    (order,orientation,colour next))⟩
def rankSignatures (le : α → α → Bool) (values : List (Signature α)) : List Nat :=
 let compare := signatureLE le
 let ordered := sortedRows compare (distinctRows compare values)
 values.map fun value =>
  ((ordered.zipIdx).find? (fun row => compare value row.1 && compare row.1 value)).map (fun row => row.2+1) |>.getD 0
def initialSuccessor (graph : Graph) : List Nat :=
 rankSignatures stringListLE (signatures graph (labelAt graph) stringListLE)
def successor (graph : Graph) (colours : List Nat) : List Nat :=
 rankSignatures (fun a b => a ≤ b)
  (signatures graph (fun position => (atIndex colours (position-1)).getD 0) (fun a b => a ≤ b))
-- Partitions are compared by membership in the same colour class, not by the
-- names assigned to ranks. Both maps have the same original position domain.
def samePartition (leftEq rightEq : Nat → Nat → Bool) (domain : List Nat) : Bool :=
 domain.all (fun a => domain.all (fun b => leftEq a b == rightEq a b))
def initialStable (graph : Graph) (next : List Nat) : Bool :=
 samePartition
  (fun a b => stringListLE (labelAt graph a) (labelAt graph b) && stringListLE (labelAt graph b) (labelAt graph a))
  (fun a b => (atIndex next (a-1)).getD 0 == (atIndex next (b-1)).getD 0) (positions graph)
def stable (left right : List Nat) : Bool :=
 samePartition (fun a b => (atIndex left (a-1)).getD 0 == (atIndex left (b-1)).getD 0)
  (fun a b => (atIndex right (a-1)).getD 0 == (atIndex right (b-1)).getD 0)
  ((List.range left.length).map (fun n => n+1))
def cells (colours : List Nat) : List (List Nat) :=
 let ranks := sortedRows (fun a b => a ≤ b) (distinctRows (fun a b => a ≤ b) colours)
 ranks.map fun rank => ((colours.zipIdx).filterMap fun (colour,index) =>
  if colour == rank then some (index+1) else none)
theorem positionsRetainSupport (graph : Graph) : (positions graph).length = graph.atoms.length := by
 unfold positions
 rw [SFT.Foundation.CommonRefinement.mapLength]
 have lengthRange : ∀ n, (List.range n).length = n := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
   rw [SFT.Host.SHA256Chunks.rangeShift]
   change ((List.range n).map Nat.succ).length + 1 = n+1
   rw [SFT.Foundation.CommonRefinement.mapLength,ih]
 exact lengthRange _
theorem signatureSupport (graph : Graph) (colour : Nat → α) (le : α → α → Bool) :
 (signatures graph colour le).length = graph.atoms.length := by
 unfold signatures
 rw [SFT.Foundation.CommonRefinement.mapLength,positionsRetainSupport]
theorem initialSuccessorSupport (graph : Graph) : (initialSuccessor graph).length = graph.atoms.length := by
 unfold initialSuccessor rankSignatures
 rw [SFT.Foundation.CommonRefinement.mapLength,signatureSupport]
end SFT.Chemistry.MolecularGraphRefinement
