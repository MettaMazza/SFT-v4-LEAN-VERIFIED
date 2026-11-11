import SFT.Chemistry.Chirality
namespace SFT.Chemistry.Biomolecular
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.GraphOperations

-- Chemical data precede the downstream relation and are never selected by it.
structure State where
 phase : SFT.Physics.CapabilityValues.HeldLabel
 conformation : SFT.Host.Canonical.Value
 conditions : List (String × SFT.Host.Canonical.Value)

structure Chemical where
 molecule : Chirality.OrientedMolecule
 admitted : MolecularCarrier.admit molecule.carrier=.ok molecule.carrier
 state : State
 source : SFT.Host.Canonical.Value

def composition (chemical : Chemical) := MolecularCarrier.compositionSignature chemical.molecule.carrier

structure BiologicalRelation where
 process : SFT.Physics.CapabilityValues.HeldLabel
 role : SFT.Physics.CapabilityValues.HeldLabel
 context : SFT.Host.Canonical.Value
 source : SFT.Host.Canonical.Value

structure Handoff where
 chemical : Chemical
 firstRelation : BiologicalRelation
 furtherRelations : List BiologicalRelation

def relations (h : Handoff) := h.firstRelation::h.furtherRelations

def base (chemical : Chemical) (relation : BiologicalRelation) : Handoff := ⟨chemical,relation,[]⟩
def appendRelation (h : Handoff) (relation : BiologicalRelation) : Handoff :=
 {h with furtherRelations:=h.furtherRelations++[relation]}

def appendCondition (chemical : Chemical) (coordinate : String × SFT.Host.Canonical.Value) : Chemical :=
 {chemical with state:={chemical.state with conditions:=chemical.state.conditions++[coordinate]}}

def extendCondition (h : Handoff) (coordinate : String × SFT.Host.Canonical.Value) : Handoff :=
 {h with chemical:=appendCondition h.chemical coordinate}

theorem baseComplete (chemical : Chemical) (relation : BiologicalRelation) :
 (base chemical relation).chemical=chemical ∧ relations (base chemical relation)=[relation] := ⟨rfl,rfl⟩

theorem appendedRelationOrder (h : Handoff) (relation : BiologicalRelation) :
 relations (appendRelation h relation)=relations h++[relation] := rfl

theorem priorRelationRetained (h : Handoff) (relation prior : BiologicalRelation)
 (held : prior∈relations h) : prior∈relations (appendRelation h relation) := memAppendLeft _ _ _ held

theorem relationDoesNotChangeChemistry (h : Handoff) (relation : BiologicalRelation) :
 (appendRelation h relation).chemical=h.chemical := rfl

theorem relationPreservesComposition (h : Handoff) (relation : BiologicalRelation) :
 composition (appendRelation h relation).chemical=composition h.chemical := rfl

theorem relationPreservesStructure (h : Handoff) (relation : BiologicalRelation) :
 (appendRelation h relation).chemical.molecule=h.chemical.molecule := rfl

theorem relationPreservesState (h : Handoff) (relation : BiologicalRelation) :
 (appendRelation h relation).chemical.state=h.chemical.state := rfl

theorem relationPreservesSource (h : Handoff) (relation : BiologicalRelation) :
 (appendRelation h relation).chemical.source=h.chemical.source := rfl

theorem chemicalReadoutIndependent {Result : Type} (readout : Chemical → Result)
 (h : Handoff) (relation : BiologicalRelation) :
 readout (appendRelation h relation).chemical=readout h.chemical := rfl

theorem handoffConnected (h : Handoff) :
 MolecularCarrier.connected h.chemical.molecule.carrier.occurrences h.chemical.molecule.carrier.bonds=true :=
 MolecularCarrier.sourceConnectivity ⟨h.chemical.molecule.carrier,h.chemical.admitted⟩

theorem handoffCompleteEndpoints (h : Handoff) :
 ∀ edge∈h.chemical.molecule.carrier.bonds,
 edge.1∈h.chemical.molecule.carrier.occurrences ∧ edge.2∈h.chemical.molecule.carrier.occurrences :=
 MolecularCarrier.allConstituentEndpoints ⟨h.chemical.molecule.carrier,h.chemical.admitted⟩

theorem conditionRetained (chemical : Chemical) (coordinate prior : String × SFT.Host.Canonical.Value)
 (held : prior∈chemical.state.conditions) : prior∈(appendCondition chemical coordinate).state.conditions :=
 memAppendLeft _ _ _ held

theorem conditionExtensionExact (chemical : Chemical) (coordinate : String × SFT.Host.Canonical.Value) :
 (appendCondition chemical coordinate).state.conditions=chemical.state.conditions++[coordinate] := rfl

theorem conditionDoesNotEraseCarrier (h : Handoff) (coordinate : String × SFT.Host.Canonical.Value) :
 (extendCondition h coordinate).chemical.molecule=h.chemical.molecule ∧
 relations (extendCondition h coordinate)=relations h := ⟨rfl,rfl⟩

-- A structure-changing chemical successor carries the new source admission;
-- no biological role is an input to molecular admission or branch construction.
def appendChemicalBranch (chemical : Chemical) (fresh element : String)
 (orientation : Chirality.OrientationWord) (links : List String)
 (accepted : MolecularCarrier.admit (Chirality.appendMolecularBranch chemical.molecule fresh element orientation links).carrier=
  .ok (Chirality.appendMolecularBranch chemical.molecule fresh element orientation links).carrier) : Chemical :=
 {chemical with molecule:=Chirality.appendMolecularBranch chemical.molecule fresh element orientation links,admitted:=accepted}

theorem chemicalBranchRetainsAtom (chemical : Chemical) (fresh element name : String)
 (orientation : Chirality.OrientationWord) (links : List String) (accepted)
 (held : name∈chemical.molecule.carrier.occurrences) :
 name∈(appendChemicalBranch chemical fresh element orientation links accepted).molecule.carrier.occurrences :=
 Chirality.branchRetainsOldAtom _ _ _ _ _ _ held

theorem chemicalBranchRetainsBond (chemical : Chemical) (fresh element : String)
 (orientation : Chirality.OrientationWord) (links : List String) (accepted)
 (edge : Edge) (held : edge∈chemical.molecule.carrier.bonds) :
 edge∈(appendChemicalBranch chemical fresh element orientation links accepted).molecule.carrier.bonds :=
 Chirality.branchRetainsOldBond _ _ _ _ _ _ held

theorem chemicalBranchRetainsOrientation (chemical : Chemical) (fresh element name : String)
 (orientation : Chirality.OrientationWord) (links : List String) (accepted) (different : name≠fresh) :
 Chirality.wordAt name (appendChemicalBranch chemical fresh element orientation links accepted).molecule.orientations=
 Chirality.wordAt name chemical.molecule.orientations :=
 Chirality.branchRetainsOldOrientation _ _ _ _ _ _ different

theorem chemicalBranchRetainsCompositionRows (chemical : Chemical) (fresh element : String)
 (orientation : Chirality.OrientationWord) (links : List String) (accepted) :
 (appendChemicalBranch chemical fresh element orientation links accepted).molecule.carrier.elements=
 chemical.molecule.carrier.elements++[element] := rfl

def appendRelations : Handoff → List BiologicalRelation → Handoff
 | h,[] => h
 | h,relation::rest => appendRelations (appendRelation h relation) rest

theorem finiteRelationsPreserveChemistry (h : Handoff) (added : List BiologicalRelation) :
 (appendRelations h added).chemical=h.chemical := by
 induction added generalizing h with
 | nil => rfl
 | cons relation rest ih => exact ih (appendRelation h relation)

theorem finiteRelationsRetainPrior (h : Handoff) (added : List BiologicalRelation) (prior : BiologicalRelation)
 (held : prior∈relations h) : prior∈relations (appendRelations h added) := by
 induction added generalizing h with
 | nil => exact held
 | cons relation rest ih => exact ih (appendRelation h relation) (priorRelationRetained h relation prior held)

theorem differentChemicalRecordsRemainDifferent (a b : Handoff) (ra rb : BiologicalRelation)
 (different : a.chemical≠b.chemical) : (appendRelation a ra).chemical≠(appendRelation b rb).chemical := different

theorem chemicalAndBiologicalUpdatesCommute (h : Handoff)
 (coordinate : String × SFT.Host.Canonical.Value) (relation : BiologicalRelation) :
 appendRelation (extendCondition h coordinate) relation=extendCondition (appendRelation h relation) coordinate := rfl

end SFT.Chemistry.Biomolecular
