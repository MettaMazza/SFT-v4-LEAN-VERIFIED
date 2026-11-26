import SFT.Chemistry.ConformerGenerationProofs
namespace SFT.Chemistry.ConformerUniqueness
open SFT.Physics.CapabilityValues ConformerCarrier ConformerAssignments
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

-- Original HeldTorsionAlphabet requires distinct retained states. This theorem
-- derives nonduplication of its complete Cartesian generation from that condition.
theorem generatedExactlyOnce (alphabets : List Alphabet)
 (distinctStates : ∀ a, a ∈ alphabets → a.states.Pairwise (fun x y => x ≠ y)) :
 (productStates alphabets).Pairwise (fun x y => x ≠ y) := by
 induction alphabets with
 | nil =>
  exact List.Pairwise.cons (fun _ impossible => by cases impossible) List.Pairwise.nil
 | cons a rest ih =>
  have tailUnique := ih (fun b member => distinctStates b (List.Mem.tail a member))
  have prefixUnique (state : HeldLabel) (suffixes : List Assignment)
   (tailUnique : suffixes.Pairwise (fun x y => x ≠ y)) :
   (suffixes.map (List.cons state)).Pairwise (fun x y => x ≠ y) := by
   induction tailUnique with
   | nil => exact List.Pairwise.nil
   | @cons suffix suffixes separated unique localIH =>
    refine List.Pairwise.cons ?_ localIH
    intro other member same
    obtain ⟨original,present,mapped⟩ := memMapPreimage (List.cons state) other suffixes member
    rw [← mapped] at same
    exact separated original present (List.cons.inj same).2
  have appendSeparated (left right : List Assignment)
   (leftUnique : left.Pairwise (fun x y => x ≠ y))
   (rightUnique : right.Pairwise (fun x y => x ≠ y))
   (separated : ∀ x, x ∈ left → ∀ y, y ∈ right → x ≠ y) :
   (left++right).Pairwise (fun x y => x ≠ y) := by
   induction leftUnique with
   | nil => exact rightUnique
   | @cons first remaining differs unique localIH =>
    refine List.Pairwise.cons ?_ (localIH (fun x member y present => separated x (List.Mem.tail first member) y present))
    intro y member
    cases memAppendCases y remaining right member with
    | inl present => exact differs y present
    | inr present => exact separated first (List.Mem.head remaining) y present
  have blocks (states : List HeldLabel) (unique : states.Pairwise (fun x y => x ≠ y)) :
   (states.flatMap (fun state => (productStates rest).map (List.cons state))).Pairwise (fun x y => x ≠ y) := by
   induction unique with
   | nil => exact List.Pairwise.nil
   | @cons state remaining differs unique localIH =>
    apply appendSeparated _ _ (prefixUnique state (productStates rest) tailUnique) localIH
    intro left inLeft right inRight same
    obtain ⟨suffix,_,leftForm⟩ := memMapPreimage (List.cons state) left (productStates rest) inLeft
    obtain ⟨next,present,mapped⟩ := memFlatMapOrigin _ _ _ inRight
    obtain ⟨other,_,rightForm⟩ := memMapPreimage (List.cons next) right (productStates rest) mapped
    rw [← leftForm,← rightForm] at same
    exact differs next present (List.cons.inj same).1
  exact blocks a.states (distinctStates a (List.Mem.head rest))
end SFT.Chemistry.ConformerUniqueness
