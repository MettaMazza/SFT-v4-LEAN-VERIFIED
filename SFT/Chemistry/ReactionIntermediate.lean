import SFT.Chemistry.ReactionMechanism
namespace SFT.Chemistry.ReactionIntermediate
open SFT.Foundation.Count.TraceDerivation
structure Raw where
 species : String
 producedBy : String
 consumedBy : String

def admit (r : Raw) : Except String Raw :=
 if !SourceText.nonblank r.species || !SourceText.nonblank r.producedBy ||
 !SourceText.nonblank r.consumedBy || decide (r.producedBy=r.consumedBy) then
 .error "intermediate requires distinct producing and consuming steps"
 else .ok r
structure Witness where
 raw : Raw
 accepted : admit raw=.ok raw

-- The ordered decomposition records actual positions, including repeated step names.
structure Occurrence where
 witness : Witness
 before : List ReactionMechanism.BoundStep
 producing : ReactionMechanism.BoundStep
 between : List ReactionMechanism.BoundStep
 consuming : ReactionMechanism.BoundStep
 after : List ReactionMechanism.BoundStep
 producerName : producing.step.raw.identity=witness.raw.producedBy
 consumerName : consuming.step.raw.identity=witness.raw.consumedBy
 produced : witness.raw.species∈producing.reaction.trace.raw.products
 consumed : witness.raw.species∈consuming.reaction.trace.raw.reactants

def word (o : Occurrence) := o.before++(o.producing::(o.between++(o.consuming::o.after)))

theorem productionRetained (o : Occurrence) : o.producing∈word o :=
 memAppendRight _ _ _ (.head _)
theorem consumptionRetained (o : Occurrence) : o.consuming∈word o :=
 memAppendRight _ _ _ (.tail _ (memAppendRight _ _ _ (.head _)))

def producerPosition (o : Occurrence) := o.before.length
def consumerPosition (o : Occurrence) := o.before.length+1+o.between.length

theorem productionPrecedesConsumption (o : Occurrence) : producerPosition o < consumerPosition o :=
 Nat.lt_of_lt_of_le (Nat.lt_succ_self _) (Nat.le_add_right _ _)

def pairTrace (o : Occurrence) :=
 [(o.witness.raw.species,o.producing.step.raw.identity),(o.witness.raw.species,o.consuming.step.raw.identity)]
theorem completePairIdentity (o : Occurrence) :
 pairTrace o=[(o.witness.raw.species,o.witness.raw.producedBy),(o.witness.raw.species,o.witness.raw.consumedBy)] := by
 unfold pairTrace
 rw [o.producerName,o.consumerName]

-- The internal occurrence contributes the same species to production and consumption.
def pairedProducts (o : Occurrence) := [o.witness.raw.species]
def pairedReactants (o : Occurrence) := [o.witness.raw.species]
theorem pairedContributionCancels (o : Occurrence) : pairedProducts o=pairedReactants o := rfl

theorem cancellingPairPreservesResidual (o : Occurrence) (remainingProducts remainingReactants : List String)
 (balanced : remainingProducts=remainingReactants) :
 pairedProducts o++remainingProducts=pairedReactants o++remainingReactants :=
 congrArg (List.cons o.witness.raw.species) balanced

def occurrences (species : String) (rows : List String) :=
 (rows.filter fun row => SFT.Host.Text.equal species row).length

structure Bound where
 occurrence : Occurrence
 mechanism : ReactionMechanism.BoundMechanism
 fullWord : word occurrence=mechanism.steps
 netBalance : occurrences occurrence.witness.raw.species mechanism.overall.trace.raw.reactants=
  occurrences occurrence.witness.raw.species mechanism.overall.trace.raw.products

theorem allInternalStatesRetained (b : Bound) :
 b.mechanism.firstState::ReactionMechanism.outputs b.mechanism.mechanism.raw.steps =
 ReactionMechanism.inputs b.mechanism.mechanism.raw.steps++[b.mechanism.finalState] :=
 ReactionMechanism.internalStatesCancel b.mechanism

theorem producerInCompleteMechanism (b : Bound) : b.occurrence.producing∈b.mechanism.steps := by
 rw [← b.fullWord]; exact productionRetained b.occurrence

theorem consumerInCompleteMechanism (b : Bound) : b.occurrence.consuming∈b.mechanism.steps := by
 rw [← b.fullWord]; exact consumptionRetained b.occurrence

theorem absentNetEndpointChange (b : Bound) :
 occurrences b.occurrence.witness.raw.species b.mechanism.overall.trace.raw.reactants=
 occurrences b.occurrence.witness.raw.species b.mechanism.overall.trace.raw.products := b.netBalance

def extend (o : Occurrence) (next : ReactionMechanism.BoundStep) : Occurrence :=
 {o with after := o.after++[next]}
theorem successorKeepsIdentity (o : Occurrence) (next : ReactionMechanism.BoundStep) :
 (extend o next).witness=o.witness := rfl
theorem successorKeepsOrder (o : Occurrence) (next : ReactionMechanism.BoundStep) :
 producerPosition (extend o next)<consumerPosition (extend o next) := productionPrecedesConsumption o

theorem successorKeepsPair (o : Occurrence) (next : ReactionMechanism.BoundStep) :
 pairTrace (extend o next)=pairTrace o := rfl

theorem successorWord (o : Occurrence) (next : ReactionMechanism.BoundStep) :
 word (extend o next)=word o++[next] := by
 change o.before++(o.producing::(o.between++(o.consuming::(o.after++[next])))) =
  (o.before++(o.producing::(o.between++(o.consuming::o.after))))++[next]
 rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative]
 apply congrArg (fun xs => o.before++xs)
 apply congrArg (List.cons o.producing)
 exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative o.between (o.consuming::o.after) [next]).symm

def base (w : Witness) (p c : ReactionMechanism.BoundStep)
 (hp : p.step.raw.identity=w.raw.producedBy) (hc : c.step.raw.identity=w.raw.consumedBy)
 (produced : w.raw.species∈p.reaction.trace.raw.products)
 (consumed : w.raw.species∈c.reaction.trace.raw.reactants) : Occurrence :=
 ⟨w,[],p,[],c,[],hp,hc,produced,consumed⟩

theorem baseWord (w : Witness) (p c : ReactionMechanism.BoundStep)
 (hp : p.step.raw.identity=w.raw.producedBy) (hc : c.step.raw.identity=w.raw.consumedBy)
 (produced : w.raw.species∈p.reaction.trace.raw.products)
 (consumed : w.raw.species∈c.reaction.trace.raw.reactants) :
 word (base w p c hp hc produced consumed)=[p,c] := rfl

theorem cancelMatchedContribution (products reactants : Nat)
 (paired : products+1=reactants+1) : products=reactants := Nat.succ.inj paired

end SFT.Chemistry.ReactionIntermediate
