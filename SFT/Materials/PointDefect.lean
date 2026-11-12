import SFT.Materials.Lattice
namespace SFT.Materials.PointDefect
open SFT.Physics SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[17]: use the registered lattice excitation's actual
-- held site, changed word, declared reference and source/action provenance.
abbrev Record (reference : Lattice.Record) := CollectiveLattice.Excitation reference

def actualWord {reference : Lattice.Record} (record : Record reference) (site : String) : List String :=
 if site=record.source then record.changedWord else reference.word site

def changedAt {reference : Lattice.Record} (record : Record reference) (site : String) : Prop :=
 actualWord record site ≠ reference.word site

def localizedSupport {reference : Lattice.Record} (record : Record reference) : List String := [record.source]

theorem changedAtSource {reference : Lattice.Record} (record : Record reference) : changedAt record record.source := by
 unfold changedAt actualWord
 rw [if_pos rfl]
 exact record.departure

theorem otherSiteUnchanged {reference : Lattice.Record} (record : Record reference)
 (site : String) (other : site≠record.source) : actualWord record site=reference.word site := by
 unfold actualWord
 rw [if_neg other]

theorem differenceExactlyAtSource {reference : Lattice.Record} (record : Record reference)
 (site : String) : changedAt record site ↔ site=record.source := by
 constructor
 · intro changed
   by_cases same : site=record.source
   · exact same
   · exact False.elim (changed (otherSiteUnchanged record site same))
 · intro same
   cases same
   exact changedAtSource record

theorem everyDifferenceHeld {reference : Lattice.Record} (record : Record reference)
 (site : String) (changed : changedAt record site) : site ∈ reference.cells.graph.nodes := by
 have same := (differenceExactlyAtSource record site).mp changed
 cases same
 exact record.generated

theorem exactLocalizedSupport {reference : Lattice.Record} (record : Record reference)
 (site : String) : site ∈ localizedSupport record ↔ changedAt record site := by
 constructor
 · intro held
   cases held with
   | head => exact changedAtSource record
   | tail _ impossible => cases impossible
 · intro h
   have same := (differenceExactlyAtSource record site).mp h
   cases same
   exact .head _

theorem leastRetainedSupport {reference : Lattice.Record} (record : Record reference)
 (support : List String) (complete : ∀ site, changedAt record site → site∈support) :
 ∀ site, site∈localizedSupport record → site∈support := by
 intro site held
 exact complete site ((exactLocalizedSupport record site).mp held)

theorem noEmptySupport {reference : Lattice.Record} (record : Record reference) :
 ¬ (∀ site, changedAt record site → site∈([] : List String)) := by
 intro erased
 cases erased record.source (changedAtSource record)

theorem oneSiteSupport {reference : Lattice.Record} (record : Record reference) :
 (localizedSupport record).length=1 := rfl

def observation {reference : Lattice.Record} (record : Record reference) (boundary : String) :=
 (record.source,reference.word record.source,record.changedWord,record.sourceIdentity,record.actionRecord,boundary)

theorem referenceAndActualRetained {reference : Lattice.Record} (record : Record reference) (boundary : String) :
 (observation record boundary).2.1=reference.word record.source ∧
 (observation record boundary).2.2.1=record.changedWord := ⟨rfl,rfl⟩
-- Conversely, every actual/reference pair with exactly one localized
-- difference is represented without altering its words on any held site.
def fromActual (reference : Lattice.Record) (actual : String → List String)
 (site : String) (held : site ∈ reference.cells.graph.nodes)
 (different : actual site ≠ reference.word site)
 (sourceIdentity : String) (actionRecord : SFT.Host.Canonical.Value) : Record reference :=
 ⟨site,held,actual site,different,sourceIdentity,actionRecord⟩

theorem everyLocalizedActualRepresented (reference : Lattice.Record)
 (actual : String → List String) (site : String)
 (held : site ∈ reference.cells.graph.nodes) (different : actual site ≠ reference.word site)
 (localized : ∀ other, other ∈ reference.cells.graph.nodes →
    actual other ≠ reference.word other → other=site)
 (sourceIdentity : String) (actionRecord : SFT.Host.Canonical.Value)
 (other : String) (present : other ∈ reference.cells.graph.nodes) :
 actualWord (fromActual reference actual site held different sourceIdentity actionRecord) other = actual other := by
 by_cases same : other=site
 · cases same
   unfold actualWord fromActual
   rw [if_pos rfl]
 · have unchanged : actual other=reference.word other := by
     by_cases equal : actual other=reference.word other
     · exact equal
     · exact False.elim (same (localized other present equal))
   unfold actualWord fromActual
   rw [if_neg same]
   exact unchanged.symm
end SFT.Materials.PointDefect
