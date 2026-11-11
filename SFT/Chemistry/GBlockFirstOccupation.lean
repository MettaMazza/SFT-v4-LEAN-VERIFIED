import SFT.Chemistry.GBlockOrder
namespace SFT.Chemistry.GBlockFirstOccupation
open GBlockOperations SFT.Physics.GeneratorOperations

-- Every atom preceding the returned one has an empty occupation at this coordinate.
theorem firstScanExact (scan : List Nat) (p o : CountInput) (n : Nat)
 (found : firstOn scan p o = .ok n) :
 ∃ before after rows, scan = before ++ n::after ∧
 subshellOccupation (.integer (.ofNat n)) p o = .ok rows ∧ rows.isEmpty = false ∧
 ∀ earlier, earlier ∈ before → subshellOccupation (.integer (.ofNat earlier)) p o = .ok [] := by
 induction scan with
 | nil => cases found
 | cons a rest ih =>
   cases step : subshellOccupation (.integer (.ofNat a)) p o with
   | error e => rw [firstOn,step] at found; cases found
   | ok rows =>
     cases rows with
     | nil =>
       have later : firstOn rest p o = .ok n := by
         rw [firstOn,step] at found
         exact found
       obtain ⟨before,after,held,eq,hit,nonempty,prior⟩ := ih later
       refine ⟨a::before,after,held,?_,hit,nonempty,?_⟩
       · exact congrArg (List.cons a) eq
       · intro earlier member
         cases member with
         | head => exact step
         | tail _ h => exact prior earlier h
     | cons x xs =>
       have equal : a=n := by
         have h : (Except.ok a : Except String Nat) = .ok n := by
           rw [firstOn,step] at found
           exact found
         exact Except.ok.inj h
       cases equal
       exact ⟨[],rest,x::xs,rfl,step,rfl,fun _ h => by cases h⟩
end SFT.Chemistry.GBlockFirstOccupation
