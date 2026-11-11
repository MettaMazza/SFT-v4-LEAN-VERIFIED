import SFT.Chemistry.RedoxTransfer
namespace SFT.Chemistry.ReactionIdentity
open SFT.Foundation.Count.TraceDerivation SFT.Physics.MatterConservedLabels
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 reactants : List String
 products : List String
 conservedCarriers : List HeldLabel
 changedRelations : List HeldLabel

def admit (r : Raw) : Except String Raw :=
 if r.reactants.isEmpty || r.products.isEmpty || r.conservedCarriers.isEmpty || r.changedRelations.isEmpty ||
 !(r.reactants++r.products).all SourceText.nonblank ||
 !(r.conservedCarriers.all fun row => SFT.Host.Text.equal row.family "chemical-carrier") ||
 !(r.changedRelations.all fun row => SFT.Host.Text.equal row.family "chemical-relation-change") then
 .error "reaction trace requires endpoints, conserved carriers and changed relations"
 else .ok r
structure Trace where
 raw : Raw
 accepted : admit raw=.ok raw

structure Placement where
 carrier : HeldLabel
 reactant : String
 product : String

def flow (p : Placement) : Flow HeldLabel String := ⟨p.carrier,p.reactant,.output p.product⟩
def flows (rows : List Placement) := rows.map flow

structure RelationChange where
 label : HeldLabel
 before : String
 after : String
 changed : before ≠ after

-- Source correspondence binds the complete occurrence and relation ledgers
-- to the original four fields; it does not strengthen the raw constructor.
structure Reaction where
 trace : Trace
 placements : List Placement
 allCarriers : placements.map Placement.carrier=trace.raw.conservedCarriers
 inputBound : ∀ row ∈ placements, row.reactant∈trace.raw.reactants
 outputBound : ∀ row ∈ placements, row.product∈trace.raw.products
 firstChange : RelationChange
 furtherChanges : List RelationChange
 allChanges : (firstChange::furtherChanges).map RelationChange.label=trace.raw.changedRelations

theorem sourceCarrierSequence (r : Reaction) :
 (inputs (flows r.placements)).map Prod.fst=r.trace.raw.conservedCarriers := by
 have project : ∀ rows : List Placement, (inputs (flows rows)).map Prod.fst=rows.map Placement.carrier := by
  intro rows
  induction rows with
  | nil => rfl
  | cons p rest ih => exact congrArg (List.cons p.carrier) ih
 exact (project r.placements).trans r.allCarriers

theorem everyCarrierReachesOutput (r : Reaction) :
 (destinations (flows r.placements)).map Prod.fst=r.trace.raw.conservedCarriers :=
 (fullLabelSequenceRetained (flows r.placements)).symm.trans (sourceCarrierSequence r)

theorem noCarrierLoss (rows : List Placement) (test : HeldLabel → Bool) :
 inputCount test (flows rows)=outputCount test (flows rows) := by
 induction rows with
 | nil => rfl
 | cons p rest ih =>
   change (if test p.carrier then _+1 else _)=(if test p.carrier then _+1 else _)
   cases h : test p.carrier
   · exact ih
   · exact congrArg (fun n => n+1) ih

theorem someRelationActuallyChanges (r : Reaction) :
 ∃ c, c∈r.firstChange::r.furtherChanges ∧ c.before≠c.after := ⟨r.firstChange,.head _,r.firstChange.changed⟩

theorem noIdentityAtChangedRelation (r : Reaction)
 (identity : r.firstChange.before=r.firstChange.after) : False := r.firstChange.changed identity

theorem completeChangeLabels (r : Reaction) :
 (r.firstChange::r.furtherChanges).map RelationChange.label=r.trace.raw.changedRelations := r.allChanges

def appendRaw (before next : Raw) : Raw :=
 ⟨before.reactants++next.reactants,before.products++next.products,
 before.conservedCarriers++next.conservedCarriers,before.changedRelations++next.changedRelations⟩

theorem appendRetainsReactant (before next : Raw) (name : String) (held : name∈before.reactants) :
 name∈(appendRaw before next).reactants := memAppendLeft _ _ _ held

theorem appendRetainsProduct (before next : Raw) (name : String) (held : name∈before.products) :
 name∈(appendRaw before next).products := memAppendLeft _ _ _ held

theorem appendRetainsCarrier (before next : Raw) (label : HeldLabel) (held : label∈before.conservedCarriers) :
 label∈(appendRaw before next).conservedCarriers := memAppendLeft _ _ _ held

theorem appendOnlyRegisteredChanges (before next : Raw) :
 (appendRaw before next).changedRelations=before.changedRelations++next.changedRelations := rfl

theorem extendedPlacementLedger (before next : Reaction) :
 (before.placements++next.placements).map Placement.carrier=(appendRaw before.trace.raw next.trace.raw).conservedCarriers := by
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,before.allCarriers,next.allCarriers]; rfl

theorem extendedConservation (before next : Reaction) (test : HeldLabel → Bool) :
 inputCount test (flows (before.placements++next.placements))=outputCount test (flows (before.placements++next.placements)) := noCarrierLoss _ _
def extend (before next : Reaction)
 (accepted : admit (appendRaw before.trace.raw next.trace.raw)=.ok (appendRaw before.trace.raw next.trace.raw)) : Reaction where
 trace := ⟨appendRaw before.trace.raw next.trace.raw,accepted⟩
 placements := before.placements++next.placements
 allCarriers := extendedPlacementLedger before next
 inputBound := by
  intro row held
  cases memAppendCases row before.placements next.placements held with
  | inl prior => exact memAppendLeft _ _ _ (before.inputBound row prior)
  | inr fresh => exact memAppendRight _ _ _ (next.inputBound row fresh)
 outputBound := by
  intro row held
  cases memAppendCases row before.placements next.placements held with
  | inl prior => exact memAppendLeft _ _ _ (before.outputBound row prior)
  | inr fresh => exact memAppendRight _ _ _ (next.outputBound row fresh)
 firstChange := before.firstChange
 furtherChanges := before.furtherChanges++(next.firstChange::next.furtherChanges)
 allChanges := by
  change ((before.firstChange::before.furtherChanges)++(next.firstChange::next.furtherChanges)).map RelationChange.label = _
  rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,before.allChanges,next.allChanges]
  rfl

theorem extensionRetainsChangedRelation (before next : Reaction)
 (accepted : admit (appendRaw before.trace.raw next.trace.raw)=.ok (appendRaw before.trace.raw next.trace.raw)) :
 (extend before next accepted).firstChange=before.firstChange := rfl

def originalRaw : Raw := ⟨["reactant-a","reactant-b"],["product-c"],
 [⟨"chemical-carrier","atom-one",rfl,rfl⟩,⟨"chemical-carrier","atom-two",rfl,rfl⟩],
 [⟨"chemical-relation-change","bond-a-b-to-a-c",rfl,rfl⟩]⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl

def history (reactions : List Reaction) := reactions.map Reaction.trace

theorem base (reaction : Reaction) : history [reaction]=[reaction.trace] := rfl

theorem completeSourceHistory (reactions : List Reaction) (next : Reaction) :
 history (reactions++[next])=history reactions++[next.trace] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Chemistry.ReactionIdentity
