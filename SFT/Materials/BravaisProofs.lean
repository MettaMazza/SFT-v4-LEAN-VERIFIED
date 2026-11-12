import SFT.Materials.BravaisClasses
namespace SFT.Materials.BravaisProofs
open BravaisClasses SFT.Host

theorem lookupSourceRow (system : String) (allowed : List String)
 (rows : List (String × List String)) (returned : lookupCenterings system rows = .ok allowed) :
 ∃ row, row ∈ rows ∧ Text.equal row.1 system = true ∧ row.2 = allowed := by
 induction rows with
 | nil => cases returned
 | cons row rows ih =>
   unfold lookupCenterings at returned
   split at returned
   · rename_i matched
     exact ⟨row,List.Mem.head _,matched,Except.ok.inj returned⟩
   · obtain ⟨found,held,matched,same⟩ := ih returned
     exact ⟨found,List.Mem.tail _ held,matched,same⟩

theorem lookupUnknownKey (system : String) (rows : List (String × List String))
 (unmatched : ∀ row, row ∈ rows → Text.equal row.1 system = false) :
 lookupCenterings system rows = .error (.keyError system) := by
 induction rows with
 | nil => rfl
 | cons row rows ih =>
   unfold lookupCenterings
   rw [unmatched row (List.Mem.head _)]
   exact ih (fun row held => unmatched row (List.Mem.tail _ held))

def rejectedForms : List (String × String) :=
 (forms CrystalSystems.retained).filter (fun (system,centering) =>
  match centeringPreservesSystem system centering with
  | .ok keep => !keep
  | .error _ => false)

theorem rejectedCount : rejectedForms.length = 21 := rfl

theorem completePartition : expected.length + rejectedForms.length =
 (forms CrystalSystems.retained).length := rfl

end SFT.Materials.BravaisProofs
