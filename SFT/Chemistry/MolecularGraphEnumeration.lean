import SFT.Chemistry.MolecularGraphCarrier
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularGraphEnumeration
open SFT.Host MolecularGraphCarrier
-- computational_chemistry_laws_v1.py:_permutation_count and
-- canonical_graph_code: complete product of permutations, then least exact word.
def factorial : Nat → Nat
 | 0 => 1
 | n+1 => (n+1)*factorial n
def permutationCount (cells : List (List Nat)) : Nat :=
 cells.foldl (fun total cell => total * factorial cell.length) 1
-- Select each position once, in the input order used by itertools.permutations.
def selections : List Nat → List (Nat × List Nat)
 | [] => []
 | x::xs => (x,xs)::((selections xs).map fun (y,ys) => (y,x::ys))
def permutationsAt : Nat → List Nat → List (List Nat)
 | 0,_ => [[]]
 | n+1,items => (selections items).flatMap fun (held,rest) =>
   (permutationsAt n rest).map (List.cons held)
def permutations (items : List Nat) : List (List Nat) := permutationsAt items.length items
def cellOrders : List (List Nat) → List (List Nat)
 | [] => [[]]
 | cell::rest => (permutations cell).flatMap fun order =>
   (cellOrders rest).map (fun suffix => order++suffix)
def stringListLE : List String → List String → Bool
 | [],_ => true
 | _::_,[] => false
 | a::as,b::bs => if Text.equal a b then stringListLE as bs else Text.le a b
def atomWordLE : List (List String) → List (List String) → Bool
 | [],_ => true
 | _::_,[] => false
 | a::as,b::bs => if stringListLE a b && stringListLE b a then atomWordLE as bs
   else stringListLE a b
abbrev BondWordRow := Nat × Nat × Nat × String
def bondRowLE (a b : BondWordRow) : Bool :=
 if a.1 == b.1 then
  if a.2.1 == b.2.1 then
   if a.2.2.1 == b.2.2.1 then Text.le a.2.2.2 b.2.2.2
   else a.2.2.1 ≤ b.2.2.1
  else a.2.1 ≤ b.2.1
 else a.1 ≤ b.1
def insertBond (row : BondWordRow) : List BondWordRow → List BondWordRow
 | [] => [row]
 | first::rest => if bondRowLE row first then row::first::rest else first::insertBond row rest
def sortBonds : List BondWordRow → List BondWordRow
 | [] => []
 | first::rest => insertBond first (sortBonds rest)
def bondWordLE : List BondWordRow → List BondWordRow → Bool
 | [],_ => true
 | _::_,[] => false
 | a::as,b::bs => if bondRowLE a b && bondRowLE b a then bondWordLE as bs else bondRowLE a b
structure Code where
 atomWord : List (List String)
 bondWord : List BondWordRow
def codeLE (a b : Code) : Bool :=
 if atomWordLE a.atomWord b.atomWord && atomWordLE b.atomWord a.atomWord
 then bondWordLE a.bondWord b.bondWord else atomWordLE a.atomWord b.atomWord
def newPosition (old : Nat) (order : List Nat) : Nat :=
 ((order.zipIdx).find? (fun row => row.1 == old)).map (fun row => row.2+1) |>.getD 0
def atIndex {α : Type} : List α → Nat → Option α
 | [],_ => none
 | first::_,0 => some first
 | _::rest,n+1 => atIndex rest n
def wordForOrder (graph : Graph) (order : List Nat) : Code :=
 ⟨order.map (fun old => (atIndex graph.atoms (old-1)).map atomLabel |>.getD []),
 sortBonds (graph.bonds.map fun bond =>
  let left := newPosition bond.left.value order
  let right := newPosition bond.right.value order
  (min left right,max left right,bond.order.value,bond.orientation))⟩
def candidates (graph : Graph) (cells : List (List Nat)) : List Code :=
 (cellOrders cells).map (wordForOrder graph)
def least : List Code → Option Code
 | [] => none
 | first::rest => some (rest.foldl (fun best candidate => if codeLE best candidate then best else candidate) first)
def enumerateCode (graph : Graph) (cells : List (List Nat)) (limit : SFT.Physics.CapabilityValues.PositiveCount) : Except String Code :=
 if permutationCount cells > limit.value then .error "declared canonical enumeration resource exhausted"
 else match least (candidates graph cells) with
 | none => .error "canonical graph enumeration produced no form"
 | some code => .ok code
-- The resource decision precedes enumeration, exactly as in the source.
theorem resourceExhausted (graph : Graph) (cells : List (List Nat))
 (limit : SFT.Physics.CapabilityValues.PositiveCount)
 (exhausted : permutationCount cells > limit.value) :
 enumerateCode graph cells limit = .error "declared canonical enumeration resource exhausted" := by
 unfold enumerateCode
 rw [if_pos exhausted]
theorem allCandidatesRetained (graph : Graph) (cells : List (List Nat)) :
 candidates graph cells = (cellOrders cells).map (wordForOrder graph) := rfl
theorem emptyCellProduct : cellOrders [] = [[]] := rfl
theorem permutationLength (n : Nat) (items result : List Nat)
 (member : result ∈ permutationsAt n items) : result.length = n := by
 induction n generalizing items result with
 | zero =>
  change result ∈ [[]] at member
  cases member with
  | head => rfl
  | tail _ impossible => cases impossible
 | succ n ih =>
  change result ∈ (selections items).flatMap (fun pair =>
   (permutationsAt n pair.2).map (List.cons pair.1)) at member
  obtain ⟨pair,_,mapped⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ member
  obtain ⟨suffix,present,equal⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ mapped
  cases equal
  exact congrArg Nat.succ (ih pair.2 suffix present)
theorem atomWordRetainsEveryPosition (graph : Graph) (order : List Nat) :
 (wordForOrder graph order).atomWord.length = order.length := by
 change (order.map (fun old => (atIndex graph.atoms (old-1)).map atomLabel |>.getD [])).length = order.length
 exact SFT.Foundation.CommonRefinement.mapLength _ _
end SFT.Chemistry.MolecularGraphEnumeration
