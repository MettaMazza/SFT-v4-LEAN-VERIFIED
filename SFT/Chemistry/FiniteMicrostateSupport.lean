import SFT.Chemistry.CrossPropertyMolecularVector
namespace SFT.Chemistry.FiniteMicrostateSupport
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
open SFT.Foundation.ExactOperations
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
structure ChemicalMicrostate where
 stateId : HeldLabel
 composition : HeldLabel
 phase : HeldLabel
 condition : HeldLabel
 internalState : HeldLabel
structure StateFields where
 stateId : LabelInput
 composition : LabelInput
 phase : LabelInput
 condition : LabelInput
 internalState : LabelInput
def stateField (value : LabelInput) (family : String) : Except String HeldLabel :=
 match value with
 | .other => .error "chemical microstate lost a required held identity"
 | .held label => if Text.equal label.family family then .ok label
   else .error "chemical microstate lost a required held identity"
def makeState (fields : StateFields) : Except String ChemicalMicrostate := do
 let id ← stateField fields.stateId "chemical-microstate"
 let composition ← stateField fields.composition "chemical-composition"
 let phase ← stateField fields.phase "phase-identity"
 let condition ← stateField fields.condition "observation-condition"
 let internal ← stateField fields.internalState "internal-state-identity"
 pure ⟨id,composition,phase,condition,internal⟩
def equalState (a b : ChemicalMicrostate) : Bool :=
 equalLabel a.stateId b.stateId && equalLabel a.composition b.composition &&
 equalLabel a.phase b.phase && equalLabel a.condition b.condition && equalLabel a.internalState b.internalState
def distinctStates : List ChemicalMicrostate → Bool
 | [] => true
 | first::rest => !(rest.any (equalState first)) && distinctStates rest
inductive StateInput where
 | state (value : ChemicalMicrostate)
 | other
inductive StatesInput where
 | tuple (values : List StateInput)
 | other
structure MacroObservationFibre where
 macrostateId : HeldLabel
 microstates : List ChemicalMicrostate
def readStates (values : List StateInput) (message : String) : Except String (List ChemicalMicrostate) :=
 values.mapM fun value => match value with
 | .state state => pure state
 | .other => throw message
def makeFibre (macrostate : LabelInput) (input : StatesInput) : Except String MacroObservationFibre := do
 let label ← match macrostate with
  | .other => throw "macro-observation requires a held chemical macrostate"
  | .held value =>
    if Text.equal value.family "chemical-macrostate" then pure value
    else throw "macro-observation requires a held chemical macrostate"
 let raw ← match input with
  | .other | .tuple [] => throw "macro-observation fibre must be finite and nonempty"
  | .tuple (first::rest) => pure (first::rest)
 let states ← readStates raw "macro-observation fibre contains a non-chemical state"
 if !distinctStates states then throw "macro-observation fibre duplicates a microstate"
 pure ⟨label,states⟩
inductive FibreInput where
 | fibre (value : MacroObservationFibre)
 | other
inductive FibresInput where
 | tuple (values : List FibreInput)
 | other
structure FiniteChemicalSupport where
 microstates : List ChemicalMicrostate
 fibres : List MacroObservationFibre
def sameStateSupport (a b : List ChemicalMicrostate) : Bool :=
 (a.all fun state => b.any (equalState state)) && (b.all fun state => a.any (equalState state))
def makeSupport (input : StatesInput) (partition : FibresInput) : Except String FiniteChemicalSupport := do
 let raw ← match input with
  | .other | .tuple [] => throw "chemical support must be generated, finite and nonempty"
  | .tuple (first::rest) => pure (first::rest)
 let states ← readStates raw "chemical support contains a non-chemical state"
 if !distinctStates states then throw "chemical support duplicates a microstate"
 let rawFibres ← match partition with
  | .other | .tuple [] => throw "chemical support requires a finite observation partition"
  | .tuple (first::rest) => pure (first::rest)
 let fibres ← rawFibres.mapM fun value => match value with
  | .fibre fibre => pure fibre
  | .other => throw "'NoneType' object has no attribute 'macrostate_id'"
 if !distinctAtoms (fibres.map MacroObservationFibre.macrostateId) then
  throw "chemical support duplicates a macro-observation identity"
 let flattened := fibres.flatMap MacroObservationFibre.microstates
 if !distinctStates flattened || !sameStateSupport flattened states then
  throw "observation fibres must partition the complete support exactly once"
 pure ⟨states,fibres⟩
def finiteMultiplicity (input : FibreInput) : Except String PositiveCount :=
 match input with
 | .other => .error "multiplicity requires one finite macro-observation fibre"
 | .fibre fibre => if h : 0<fibre.microstates.length then .ok ⟨fibre.microstates.length,h⟩
   else .error "positive count must be positive"
inductive SupportInput where
 | support (value : FiniteChemicalSupport)
 | other
def matchingFibres (support : FiniteChemicalSupport) (label : LabelInput) : List MacroObservationFibre :=
 match label with
 | .other => []
 | .held label => support.fibres.filter fun fibre => equalLabel fibre.macrostateId label
def exactStatisticalWeight (input : SupportInput) (label : LabelInput) : Except String Ratio := do
 let support ← match input with
  | .other => throw "statistical weight requires complete finite chemical support"
  | .support support => pure support
 let fibre ← match matchingFibres support label with
  | [fibre] => pure fibre
  | [] | _::_::_ => throw "macro-observation identity is absent or non-unique"
 if numerator : 0<fibre.microstates.length then
  if denominator : 0<support.microstates.length then
   pure (rawRatio (normalizePositive fibre.microstates.length support.microstates.length numerator denominator))
  else throw "positive ratio denominator must be positive"
 else throw "positive ratio numerator must be positive"
def appendGeneratedMicrostate (support : FiniteChemicalSupport) (state : StateInput)
 (macrostate : LabelInput) : Except String FiniteChemicalSupport := do
 let already := match state with
  | .other => false
  | .state state => support.microstates.any (equalState state)
 if already then throw "finite successor must add a new microstate"
 let occupied := match macrostate with
  | .other => false
  | .held label => support.fibres.any fun fibre => equalLabel fibre.macrostateId label
 if occupied then throw "this successor certificate requires a new macro-observation class"
 let added ← makeFibre macrostate (.tuple [state])
 makeSupport (.tuple (support.microstates.map StateInput.state ++ [state]))
  (.tuple ((support.fibres ++ [added]).map FibreInput.fibre))
def equalStates : List ChemicalMicrostate → List ChemicalMicrostate → Bool
 | [],[] => true
 | first::rest,next::tail => equalState first next && equalStates rest tail
 | [],_::_ | _::_,[] => false
def equalFibre (a b : MacroObservationFibre) : Bool :=
 equalLabel a.macrostateId b.macrostateId && equalStates a.microstates b.microstates
def equalFibres : List MacroObservationFibre → List MacroObservationFibre → Bool
 | [],[] => true
 | first::rest,next::tail => equalFibre first next && equalFibres rest tail
 | [],_::_ | _::_,[] => false
def finiteSuccessorPreservesPriorAssignments (support : FiniteChemicalSupport) (state : StateInput)
 (macrostate : LabelInput) : Except String Bool := do
 let extended ← appendGeneratedMicrostate support state macrostate
 let prefixStates := extended.microstates.take (extended.microstates.length-1)
 let prefixFibres := extended.fibres.take (extended.fibres.length-1)
 let lastState := match extended.microstates.getLast?,state with
  | some last,.state state => equalState last state
  | none,_ | some _,.other => false
 let lastFibre := match extended.fibres.getLast?,state with
  | some fibre,.state state => equalStates fibre.microstates [state]
  | none,_ | some _,.other => false
 pure (equalStates prefixStates support.microstates && equalFibres prefixFibres support.fibres && lastState && lastFibre)
-- Multiplicity is the actual positive fibre census, not a supplied degeneracy.
theorem multiplicityIsFibreCount (fibre : MacroObservationFibre) (positive : 0<fibre.microstates.length) :
 finiteMultiplicity (.fibre fibre)=.ok ⟨fibre.microstates.length,positive⟩ := by
 unfold finiteMultiplicity
 dsimp only
 rw [dif_pos positive]
-- Statistical weight retains the original exact reduction of the two counts.
theorem selectedFibreWeight (support : FiniteChemicalSupport) (label : LabelInput)
 (fibre : MacroObservationFibre) (selected : matchingFibres support label=[fibre])
 (numerator : 0<fibre.microstates.length) (denominator : 0<support.microstates.length) :
 exactStatisticalWeight (.support support) label=
 .ok (rawRatio (normalizePositive fibre.microstates.length support.microstates.length numerator denominator)) := by
 unfold exactStatisticalWeight
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 rw [selected]
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 rw [dif_pos numerator,dif_pos denominator]

-- These are the five original executable witnesses, with their original states.
def firstState : ChemicalMicrostate := ⟨⟨"chemical-microstate","first",rfl,rfl⟩,⟨"chemical-composition","held-composition",rfl,rfl⟩,⟨"phase-identity","held-phase",rfl,rfl⟩,⟨"observation-condition","held-condition",rfl,rfl⟩,⟨"internal-state-identity","first-internal",rfl,rfl⟩⟩
def secondState : ChemicalMicrostate := ⟨⟨"chemical-microstate","second",rfl,rfl⟩,⟨"chemical-composition","held-composition",rfl,rfl⟩,⟨"phase-identity","held-phase",rfl,rfl⟩,⟨"observation-condition","held-condition",rfl,rfl⟩,⟨"internal-state-identity","second-internal",rfl,rfl⟩⟩
def thirdState : ChemicalMicrostate := ⟨⟨"chemical-microstate","third",rfl,rfl⟩,⟨"chemical-composition","held-composition",rfl,rfl⟩,⟨"phase-identity","held-phase",rfl,rfl⟩,⟨"observation-condition","held-condition",rfl,rfl⟩,⟨"internal-state-identity","third-internal",rfl,rfl⟩⟩
def fourthState : ChemicalMicrostate := ⟨⟨"chemical-microstate","fourth",rfl,rfl⟩,⟨"chemical-composition","held-composition",rfl,rfl⟩,⟨"phase-identity","held-phase",rfl,rfl⟩,⟨"observation-condition","held-condition",rfl,rfl⟩,⟨"internal-state-identity","fourth-internal",rfl,rfl⟩⟩
def lowFibre : MacroObservationFibre := ⟨⟨"chemical-macrostate","low-class",rfl,rfl⟩,[firstState,secondState]⟩
def highFibre : MacroObservationFibre := ⟨⟨"chemical-macrostate","high-class",rfl,rfl⟩,[thirdState]⟩
def witnessSupport : FiniteChemicalSupport := ⟨[firstState,secondState,thirdState],[lowFibre,highFibre]⟩
def witnessStates : StatesInput := .tuple (witnessSupport.microstates.map StateInput.state)
def witnessFibres : FibresInput := .tuple (witnessSupport.fibres.map FibreInput.fibre)
def successorLabel : HeldLabel := ⟨"chemical-macrostate","successor-class",rfl,rfl⟩
theorem completePartitionWitness : makeSupport witnessStates witnessFibres=.ok witnessSupport := rfl
theorem exactMultiplicityWitness : (finiteMultiplicity (.fibre lowFibre)).map (fun n => n.value)=.ok 2 := rfl
theorem exactWeightWitness :
 exactStatisticalWeight (.support witnessSupport) (.held lowFibre.macrostateId)=.ok ⟨⟨2,by decide⟩,⟨3,by decide⟩⟩ ∧
 exactStatisticalWeight (.support witnessSupport) (.held highFibre.macrostateId)=.ok ⟨⟨1,by decide⟩,⟨3,by decide⟩⟩ := ⟨rfl,rfl⟩
theorem overlapRejectedWitness : makeSupport witnessStates
 (.tuple [.fibre lowFibre,.fibre ⟨highFibre.macrostateId,[secondState,thirdState]⟩])=
 .error "observation fibres must partition the complete support exactly once" := rfl
theorem finiteSuccessorWitness : finiteSuccessorPreservesPriorAssignments witnessSupport (.state fourthState) (.held successorLabel)=.ok true := rfl
end SFT.Chemistry.FiniteMicrostateSupport
