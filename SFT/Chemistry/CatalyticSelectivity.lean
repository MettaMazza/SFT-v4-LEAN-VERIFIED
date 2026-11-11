import SFT.Chemistry.CatalyticPathway
import SFT.Mathematics.ProbabilityModes
namespace SFT.Chemistry.CatalyticSelectivity
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
open SFT.Mathematics.ProbabilityModes
structure Raw where
 species : List HeldLabel
 reactions : List (PositiveCount × PositiveCount)
def admit (r : Raw) : Except String Raw :=
 if r.species.isEmpty || r.reactions.isEmpty then .error "network requires species and reaction support" else .ok r

structure Event where
 product : String
 pathway : CatalyticPathway.Selected
 sourceRecord : SFT.Host.Canonical.Value
 productBinding : pathway.comparison.alternative.activation.mechanism.finalState=product

structure Observation where
 first : Event
 rest : List Event
 reactants : List String
 catalyst : HeldLabel
 conditions : HeldLabel
 method : HeldLabel
 boundary : HeldLabel
 consumed : List HeldLabel
 consumedCount : PositiveCount
 completeConsumption : consumed.length=consumedCount.value
 completeProducts : List String
 completeCensus : ∀ label, label∈completeProducts ↔ label∈((first::rest).map Event.product)
 sharedInput : ∀ event∈first::rest,
  event.pathway.comparison.alternative.activation.mechanism.overall.trace.raw.reactants=reactants
 sharedCatalyst : ∀ event∈first::rest, event.pathway.comparison.cycle.raw.entering=catalyst
 sharedConditions : ∀ event∈first::rest, event.pathway.comparison.alternative.conditions=conditions

def trace (o : Observation) := (o.first::o.rest).map Event.product
def selected (o : Observation) := modeLabels (trace o)
def count (o : Observation) (product : String) := occurrences (trace o) product

theorem completeSelection (o : Observation) (product : String) :
 product∈selected o ↔ product∈o.completeProducts ∧ ∀ other, other∈o.completeProducts → count o other≤count o product := by
 constructor
 · intro h
   have m := (modeMembership _ _).mp h
   exact ⟨(o.completeCensus _).mpr m.1,fun other held => m.2 other ((o.completeCensus _).mp held)⟩
 · intro h
   apply (modeMembership _ _).mpr
   exact ⟨(o.completeCensus _).mp h.1,fun other held => h.2 other ((o.completeCensus _).mpr held)⟩

theorem selectedExists (o : Observation) : ∃ product, product∈selected o :=
 modeExists _ (fun h => by cases h)

theorem everyTieRetained (o : Observation) (product other : String)
 (chosen : product∈selected o) (held : other∈o.completeProducts)
 (tie : count o other=count o product) : other∈selected o :=
 modeRetainsEveryTie _ _ _ chosen ((o.completeCensus _).mp held) tie

theorem lowerProductExcluded (o : Observation) (product other : String)
 (otherHeld : other∈o.completeProducts) (lower : count o product<count o other) :
 ¬product∈selected o := by
 intro h
 exact Nat.not_lt_of_ge ((completeSelection o product).mp h |>.2 other otherHeld) lower

theorem strictWinnerUnique (o : Observation) (product : String)
 (held : product∈o.completeProducts)
 (strict : ∀ other, other∈o.completeProducts → other≠product → count o other<count o product) :
 product∈selected o ∧ ∀ other, other∈selected o → other=product := by
 constructor
 · apply (completeSelection _ _).mpr
   refine ⟨held,?_⟩
   intro other h
   by_cases same : other=product
   · rw [same]; exact Nat.le_refl _
   · exact Nat.le_of_lt (strict other h same)
 · intro other h
   have m := (completeSelection _ _).mp h
   by_cases same : other=product
   · exact same
   · exact False.elim (Nat.not_lt_of_ge (m.2 product held) (strict other m.1 same))

theorem noDuplicateChosenLabels (o : Observation) :
 SFT.Mathematics.DiscreteObjects.distinct (selected o)=true := modeDistinct _

theorem sharedConsumptionOrder (o : Observation) (a b : String) (less : count o a<count o b) :
 count o a*o.consumedCount.value<count o b*o.consumedCount.value :=
 Nat.mul_lt_mul_of_pos_right less o.consumedCount.positive

theorem tieAtSameConsumption (o : Observation) (a b : String) (same : count o a=count o b) :
 count o a*o.consumedCount.value=count o b*o.consumedCount.value :=
 congrArg (fun n => n*o.consumedCount.value) same

def sourceTrace (o : Observation) :=
 ((o.first::o.rest).map (fun e => (e.product,CatalyticPathway.sourceTrace e.pathway.comparison,e.sourceRecord)),
 o.reactants,o.catalyst,o.conditions,o.method,o.boundary,o.consumed,o.completeProducts)

theorem occurrenceAppend (left right : List String) (label : String) :
 occurrences (left++right) label=occurrences left label+occurrences right label := by
 induction left with
 | nil => exact (Nat.zero_add _).symm
 | cons head rest ih =>
   change occurrences (head::(rest++right)) label=occurrences (head::rest) label+occurrences right label
   rw [occurrencesCons,occurrencesCons,ih]
   by_cases same : head=label
   · rw [if_pos same,if_pos same]
     exact Nat.add_right_comm _ _ _
   · rw [if_neg same,if_neg same]

theorem absentOccurrence (word : List String) (label : String) (absent : label∉word) :
 occurrences word label=0 := by
 induction word with
 | nil => rfl
 | cons head rest ih =>
   have different : head≠label := fun same => absent (same ▸ List.Mem.head rest)
   rw [occurrencesCons,if_neg different,ih (fun h => absent (.tail _ h))]

theorem newProductPreservesPriorCounts (o : Observation) (freshEvents : List Event) (old : String)
 (fresh : old∉freshEvents.map Event.product) :
 occurrences (trace o++freshEvents.map Event.product) old=count o old := by
 rw [occurrenceAppend,absentOccurrence _ _ fresh,Nat.add_zero]
 rfl

theorem extendedSelectionExactly (o : Observation) (freshEvents : List Event) (product : String) :
 product∈modeLabels (trace o++freshEvents.map Event.product) ↔
 product∈trace o++freshEvents.map Event.product ∧
 ∀ other, other∈trace o++freshEvents.map Event.product →
 occurrences (trace o++freshEvents.map Event.product) other≤occurrences (trace o++freshEvents.map Event.product) product :=
 modeMembership _ _

theorem oldEventsRetained (o : Observation) (freshEvents : List Event) (event : Event)
 (held : event∈o.first::o.rest) : event∈(o.first::o.rest)++freshEvents :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem extendedProductHistory (o : Observation) (freshEvents : List Event) :
 ((o.first::o.rest)++freshEvents).map Event.product=trace o++freshEvents.map Event.product :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem extendedTieRetained (o : Observation) (freshEvents : List Event) (a b : String)
 (chosen : a∈modeLabels (trace o++freshEvents.map Event.product))
 (held : b∈trace o++freshEvents.map Event.product)
 (tie : occurrences (trace o++freshEvents.map Event.product) b=occurrences (trace o++freshEvents.map Event.product) a) :
 b∈modeLabels (trace o++freshEvents.map Event.product) := modeRetainsEveryTie _ _ _ chosen held tie
structure Extension where
 prior : Observation
 following : Observation
 fresh : List Event
 completeEvents : following.first::following.rest=(prior.first::prior.rest)++fresh
 sameReactants : following.reactants=prior.reactants
 sameCatalyst : following.catalyst=prior.catalyst
 sameConditions : following.conditions=prior.conditions
 sameMethod : following.method=prior.method
 sameBoundary : following.boundary=prior.boundary
 sameConsumption : following.consumed=prior.consumed

theorem actualExtendedTrace (e : Extension) : trace e.following=trace e.prior++e.fresh.map Event.product := by
 unfold trace
 rw [e.completeEvents,SFT.Mathematics.ExactTraceArithmetic.mapAppend]

theorem actualPriorCountPreserved (e : Extension) (old : String)
 (fresh : old∉e.fresh.map Event.product) : count e.following old=count e.prior old := by
 unfold count
 rw [actualExtendedTrace]
 exact newProductPreservesPriorCounts _ _ _ fresh

theorem actualUpdatedClass (e : Extension) :
 selected e.following=modeLabels (trace e.prior++e.fresh.map Event.product) := by
 unfold selected
 rw [actualExtendedTrace]

theorem actualConsumptionRetained (e : Extension) : e.following.consumedCount.value=e.prior.consumedCount.value := by
 rw [← e.following.completeConsumption,← e.prior.completeConsumption,e.sameConsumption]
end SFT.Chemistry.CatalyticSelectivity
