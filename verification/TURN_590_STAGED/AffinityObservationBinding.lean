import SFT.InformationScience.SymbolLedger
import SFT.Chemistry.AffinityClosure
namespace SFT.Chemistry.AffinityObservationBinding
open SFT.InformationScience.SymbolObservation SFT.InformationScience.SymbolClasses
open SFT.Foundation.Count.TraceDerivation

-- Source dependency: symbols_distinguishability/law.py, observed_label and
-- observation_classes. Retain the actual source observation; do not replace it
-- with an assumed equality test on a new representation of recurrence words.
structure Endpoint (observation : Observation) where
 atom : String
 symbol : Symbol
 label : String
 source : observedLabel observation symbol=.ok label

def sameClass {observation : Observation} (a b : Endpoint observation) : Prop := a.label=b.label

theorem sourceClassExactly {observation : Observation} (a b : Endpoint observation) :
 sameClass a b ↔ distinguishable observation a.symbol b.symbol=.ok false := by
 rw [labelledDistinction _ _ _ _ _ a.source b.source]
 constructor
 · intro same
   change a.label=b.label at same
   rw [decide_eq_false (fun different => different same)]
 · intro result
   by_cases same : a.label=b.label
   · exact same
   · rw [decide_eq_true same] at result; cases result

theorem sourceLabelUnique {observation : Observation} (a : Endpoint observation) (label : String)
 (held : (a.symbol,label)∈observation) : label=a.label :=
 observedUnique observation a.symbol a.label label a.source held

theorem endpointExists (alphabet : List Symbol) (observation : Observation)
 (valid : validateObservation alphabet observation=true) (atom : String) (symbol : Symbol)
 (held : symbol∈alphabet) : ∃ endpoint : Endpoint observation, endpoint.atom=atom ∧ endpoint.symbol=symbol := by
 obtain ⟨label,found,_⟩ := validatedLookup alphabet observation valid symbol held
 exact ⟨⟨atom,symbol,label,found⟩,rfl,rfl⟩

theorem exactFibre {observation : Observation} (alphabet : List Symbol) (rows : Observation)
 (collected : collectRows observation alphabet=.ok rows) (a b : Endpoint observation)
 (ha : a.symbol∈alphabet) :
 sameClass a b ↔ a.symbol∈fibre rows b.label := by
 constructor
 · intro same
   apply (collectedFibre alphabet observation rows collected a.symbol b.label).mpr
   exact ⟨ha,same ▸ a.source⟩
 · intro member
   have found := ((collectedFibre alphabet observation rows collected a.symbol b.label).mp member).2
   exact Except.ok.inj (a.source.symm.trans found)

def tieEdges {observation : Observation} (rows : List (Endpoint observation)) : List (String × String) :=
 rows.flatMap fun a => (rows.filter fun b => decide (a.label=b.label)).map fun b => (a.atom,b.atom)

theorem sameClassEdge {observation : Observation} (rows : List (Endpoint observation))
 (a b : Endpoint observation) (ha : a∈rows) (hb : b∈rows) (same : sameClass a b) :
 (a.atom,b.atom)∈tieEdges rows := by
 apply SFT.Foundation.CommonRefinement.memFlatMap _ rows a _ ha
 apply memMap (fun b : Endpoint observation => (a.atom,b.atom)) b
 exact (SFT.Mathematics.DiscreteObjects.filterMemberIff _ rows b).mpr ⟨hb,decide_eq_true same⟩

theorem sourceEquivalentTied {observation : Observation} (rows : List (Endpoint observation))
 (comparisons : AffinityClosure.Relation) (a b : Endpoint observation) (ha : a∈rows) (hb : b∈rows)
 (closed : distinguishable observation a.symbol b.symbol=.ok false) :
 AffinityClosure.Tied (tieEdges rows++comparisons) a.atom b.atom := by
 have same := (sourceClassExactly a b).mpr closed
 exact ⟨.step .identity (memAppendLeft _ _ _ (sameClassEdge rows a b ha hb same)),
   .step .identity (memAppendLeft _ _ _ (sameClassEdge rows b a hb ha same.symm))⟩

theorem equivalentCannotBeStrict {observation : Observation} (rows : List (Endpoint observation))
 (comparisons : AffinityClosure.Relation) (a b : Endpoint observation) (ha : a∈rows) (hb : b∈rows)
 (closed : distinguishable observation a.symbol b.symbol=.ok false) :
 ¬ (AffinityClosure.Precedes (tieEdges rows++comparisons) a.atom b.atom ∧
     ¬AffinityClosure.Precedes (tieEdges rows++comparisons) b.atom a.atom) :=
 fun strict => strict.2 (sourceEquivalentTied rows comparisons a b ha hb closed).2

-- Complete source pair census is reused, including the closed/tied alternatives.
theorem sourcePairCensus (alphabet : List Symbol) (observation : Observation)
 (valid : validateObservation alphabet observation=true) :
 ∃ retained closed, SFT.InformationScience.SymbolLedger.distinctionLedger alphabet observation=.ok (retained,closed) ∧
   ∀ pair, pair∈SFT.InformationScience.SymbolLedger.pairs alphabet ↔ pair∈retained ∨ pair∈closed := by
 obtain ⟨retained,closed,ledger⟩ := SFT.InformationScience.SymbolLedger.validatedLedger alphabet observation valid
 exact ⟨retained,closed,ledger,SFT.InformationScience.SymbolLedger.ledgerExhausts alphabet observation valid retained closed ledger⟩
end SFT.Chemistry.AffinityObservationBinding
