import SFT.Materials.CrystalSystems
namespace SFT.Materials.CrystalSystemsProofs
open CrystalSystems SFT.Host SFT.Foundation.CommonRefinement

theorem completeMetricMembership (l a : String) :
 (l,a) ∈ metricGrammar ↔ l ∈ lengthClasses ∧ a ∈ angleClasses :=
 originCellIffSources lengthClasses angleClasses l a

theorem retainedExactly (row : CrystalSystem) : row ∈ retained ↔
 row.lengthClass ∈ lengthClasses ∧ row.angleClass ∈ angleClasses ∧
 systemName row.lengthClass row.angleClass = some row.name := by
 constructor
 · intro held
   obtain ⟨pair,hpair,hrow⟩ := memFlatMapOrigin _ metricGrammar row held
   obtain ⟨l,a⟩ := pair
   have bounds := (completeMetricMembership l a).mp hpair
   change row ∈ (match systemName l a with | none => [] | some name => [(⟨name,l,a⟩ : CrystalSystem)]) at hrow
   cases eq : systemName l a with
   | none => rw [eq] at hrow; cases hrow
   | some name =>
     rw [eq] at hrow
     cases hrow with
     | head => exact ⟨bounds.1,bounds.2,eq⟩
     | tail _ impossible => cases impossible
 · intro h
   obtain ⟨name,l,a⟩ := row
   unfold retained
   apply memFlatMap _ metricGrammar (l,a) (⟨name,l,a⟩ : CrystalSystem)
   · exact (completeMetricMembership l a).mpr ⟨h.1,h.2.1⟩
   · change (⟨name,l,a⟩ : CrystalSystem) ∈ (match systemName l a with | none => [] | some found => [(⟨found,l,a⟩ : CrystalSystem)])
     rw [h.2.2]
     exact List.Mem.head _

theorem lookupSourceRow (l a name : String) (rows : List CrystalSystem)
 (returned : lookup l a rows = some name) : ∃ row, row ∈ rows ∧
 (Text.equal row.lengthClass l && Text.equal row.angleClass a) = true ∧ row.name=name := by
 induction rows with
 | nil => cases returned
 | cons row rows ih =>
   unfold lookup at returned
   split at returned
   · rename_i matched
     exact ⟨row,List.Mem.head _,matched,Option.some.inj returned⟩
   · obtain ⟨found,held,matched,same⟩ := ih returned
     exact ⟨found,List.Mem.tail _ held,matched,same⟩

theorem lookupRejectsUnmatched (l a : String) (rows : List CrystalSystem)
 (unmatched : ∀ row, row ∈ rows → (Text.equal row.lengthClass l && Text.equal row.angleClass a) = false) :
 lookup l a rows = none := by
 induction rows with
 | nil => rfl
 | cons row rows ih =>
   unfold lookup
   rw [unmatched row (List.Mem.head _)]
   exact ih (fun r held => unmatched r (List.Mem.tail _ held))

def rejectedMetrics : List (String × String) :=
 metricGrammar.filter (fun (l,a) => (systemName l a).isNone)

theorem exactRejections : rejectedMetrics =
 [("all-equal","two-right"),("all-equal","all-distinct"),
  ("two-equal","all-equal-nonright"),("two-equal","all-distinct"),
  ("all-distinct","all-equal-nonright")] := rfl

theorem completePartitionCount : retained.length + rejectedMetrics.length = metricGrammar.length := rfl

theorem everyReturnedClassSourceBound (row : CrystalSystem) (held : row ∈ retained) :
 ∃ original, original ∈ compatible ∧
 (Text.equal original.lengthClass row.lengthClass && Text.equal original.angleClass row.angleClass) = true ∧
 original.name=row.name :=
 lookupSourceRow _ _ _ compatible ((retainedExactly row).mp held).2.2
end SFT.Materials.CrystalSystemsProofs
