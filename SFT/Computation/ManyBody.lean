import SFT.Computation.HighDimensional
import SFT.Mathematics.GraphExtension
import SFT.Mathematics.GeometryTopology
namespace SFT.Computation.ManyBody
open SFT.Computation.HighDimensional SFT.Mathematics.DiscreteObjects
open SFT.Mathematics.GraphOperations SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

structure Body where
  name : String
  states : List String

structure Model where
  bodies : List Body
  interactions : List Edge
  graphAdmission : makeGraph (bodies.map Body.name) interactions =
    .ok ⟨bodies.map Body.name,interactions⟩
  localAdmission : ∀ body, body ∈ bodies → body.states.isEmpty = false ∧ distinct body.states = true

def jointModel (model : Model) : HighDimensional.Model where
  axes := model.bodies.map Body.states
  canonical := by
    intro axis member
    obtain ⟨body,held,equal⟩ := memMapPreimage Body.states axis model.bodies member
    rw [← equal]
    exact model.localAdmission body held

def jointSupport (model : Model) : List (List String) := productSupport (jointModel model).axes

theorem completeJointSupport (model : Model) (row : List String) :
    row ∈ jointSupport model ↔ CoordinateTrace (model.bodies.map Body.states) row :=
  completeProduct _ _

theorem bodyCoordinateCount (model : Model) (row : List String) (member : row ∈ jointSupport model) :
    row.length = model.bodies.length := by
  have count := coordinateCount _ _ ((completeJointSupport model row).mp member)
  rw [mapLength] at count
  exact count

theorem jointCardinality (model : Model) :
    (jointSupport model).length = productCardinality (model.bodies.map Body.states) :=
  exactProductCardinality _

theorem interactionEndpoints (model : Model) (edge : Edge) (held : edge ∈ model.interactions) :
    edge.1 ∈ model.bodies.map Body.name ∧ edge.2 ∈ model.bodies.map Body.name :=
  ((graphConstructorMeaning _ _).mp model.graphAdmission).2.2.2 edge held

theorem uniqueBodyIdentities (model : Model) : distinct (model.bodies.map Body.name) = true :=
  ((graphConstructorMeaning _ _).mp model.graphAdmission).2.1

theorem uniqueJointSupport (model : Model) : distinct (jointSupport model) = true :=
  productDistinct (jointModel model).axes (fun axis member => ((jointModel model).canonical axis member).2)

structure Update (model : Model) where
  rows : Relation
  admitted : sparseRelation (jointModel model) rows = .ok rows

def execute (model : Model) (update : Update model) (initial : List String) (trace : Relation) : Option (List String) :=
  HighDimensional.run (jointModel model) update.rows initial trace

theorem executeSource (model : Model) (update : Update model) (initial terminal : List String) (trace : Relation)
    (accepted : execute model update initial trace = some terminal) :
    CoordinateTrace (model.bodies.map Body.states) initial ∧ Execution update.rows initial trace terminal := by
  obtain ⟨relation,admitted,initialHeld,execution⟩ := runSource (jointModel model) update.rows trace initial terminal accepted
  rw [update.admitted] at admitted
  cases admitted
  exact ⟨initialHeld,execution⟩

theorem executeReconstruction (model : Model) (update : Update model) (initial terminal : List String)
    (trace : Relation) (held : CoordinateTrace (model.bodies.map Body.states) initial)
    (execution : Execution update.rows initial trace terminal) :
    execute model update initial trace = some terminal := by
  unfold execute HighDimensional.run
  rw [update.admitted]
  dsimp only
  have initialHeld : has (productSupport (jointModel model).axes) initial = true :=
    (hasIff _ _).mpr ((completeProduct _ _).mpr held)
  rw [ite_eq_left initialHeld]
  exact (replayExactly update.rows trace initial terminal).mpr execution

theorem executedTerminal (model : Model) (update : Update model) (initial terminal : List String)
    (trace : Relation) (accepted : execute model update initial trace = some terminal) : terminal ∈ jointSupport model := by
  have source := executeSource model update initial terminal trace accepted
  exact (completeJointSupport model terminal).mpr
    (executionTerminal (jointModel model) update.rows update.rows trace update.admitted initial terminal source.1 source.2)

theorem serialExecution (model : Model) (update : Update model) (initial middle terminal : List String)
    (left right : Relation) (first : execute model update initial left = some middle)
    (second : execute model update middle right = some terminal) :
    execute model update initial (left ++ right) = some terminal := by
  have a := executeSource model update initial middle left first
  have b := executeSource model update middle terminal right second
  exact executeReconstruction model update initial terminal _ a.1
    (executionComposition update.rows left right initial middle terminal a.2 b.2)

theorem successorExecution (model : Model) (update : Update model) (initial terminal next : List String)
    (trace : Relation) (prior : execute model update initial trace = some terminal)
    (edge : (terminal,next) ∈ update.rows) :
    execute model update initial (trace ++ [(terminal,next)]) = some next := by
  have source := executeSource model update initial terminal trace prior
  exact executeReconstruction model update initial next _ source.1
    (executionComposition update.rows trace [(terminal,next)] initial terminal next source.2
      (.step edge (.identity next)))

def missingCombinations (model : Model) (held : Collection) : Collection :=
  (jointSupport model).filter (fun row => !has held row)

def extraCombinations (model : Model) (held : Collection) : Collection :=
  held.filter (fun row => !has (jointSupport model) row)

theorem missingExactly (model : Model) (held : Collection) (row : List String) :
    row ∈ missingCombinations model held ↔ row ∈ jointSupport model ∧ ¬ row ∈ held := by
  constructor
  · intro member
    have p := (filterMemberIff _ _ _).mp member
    refine ⟨p.1,?_⟩
    intro presentMember
    have h := (hasIff _ _).mpr presentMember
    rw [h] at p
    cases p.2
  · intro h
    apply (filterMemberIff _ _ _).mpr
    refine ⟨h.1,?_⟩
    cases present : has held row with
    | false => rfl
    | true => exact False.elim (h.2 ((hasIff _ _).mp present))

def factorizationAccepted (model : Model) (held : Collection) : Bool :=
  (jointSupport model).all (has held) && held.all (has (jointSupport model))

theorem factorizationExactly (model : Model) (held : Collection) :
    factorizationAccepted model held = true ↔ ∀ row, row ∈ held ↔ row ∈ jointSupport model := by
  constructor
  · intro accepted row
    have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp accepted
    exact ⟨fun member => (hasIff _ _).mp ((allTrueIffMembers _ _).mp both.2 row member),
      fun member => (hasIff _ _).mp ((allTrueIffMembers _ _).mp both.1 row member)⟩
  · intro equal
    apply (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
    exact ⟨(allTrueIffMembers _ _).mpr (fun row member => (hasIff _ _).mpr ((equal row).mpr member)),
      (allTrueIffMembers _ _).mpr (fun row member => (hasIff _ _).mpr ((equal row).mp member))⟩

def correlationLedger (model : Model) (held : Collection) : List (List String × Bool) :=
  (jointSupport model).map (fun row => (row,has held row))

theorem correlationExactly (model : Model) (held : Collection) (row : List String) (present : Bool) :
    (row,present) ∈ correlationLedger model held ↔ row ∈ jointSupport model ∧ has held row = present := by
  constructor
  · intro member
    obtain ⟨original,source,equal⟩ := memMapPreimage (fun row => (row,has held row)) (row,present) _ member
    cases equal
    exact ⟨source,rfl⟩
  · intro h
    have member := memMap (fun row => (row,has held row)) row (jointSupport model) h.1
    rw [h.2] at member
    exact member

theorem jointBodySuccessor (original extended : Model) (body : Body)
    (bodies : extended.bodies = original.bodies ++ [body]) (row : List String) (value : String)
    (prior : row ∈ jointSupport original) (held : value ∈ body.states) :
    row ++ [value] ∈ jointSupport extended := by
  unfold jointSupport jointModel
  dsimp only
  rw [bodies,SFT.Mathematics.ExactTraceArithmetic.mapAppend]
  exact coordinateSuccessor (original.bodies.map Body.states) row body.states value prior held

structure Configuration (model : Model) where
  rows : Collection
  presentation : SFT.Foundation.FormConstruction.TupleValue
  admitted : heldSelection (jointSupport model) rows = .ok presentation

theorem configurationContained (model : Model) (configuration : Configuration model)
    (row : List String) (member : row ∈ configuration.rows) : row ∈ jointSupport model :=
  heldSelectionContained _ _ _ configuration.admitted row member

theorem configurationDistinct (model : Model) (configuration : Configuration model) : distinct configuration.rows = true := by
  have admitted := configuration.admitted
  unfold heldSelection at admitted
  cases unique : distinct configuration.rows with
  | true => rfl
  | false =>
    rw [unique] at admitted
    have guard : (configuration.rows.any (fun row => !has (jointSupport model) row) || !false) = true := by
      cases configuration.rows.any (fun row => !has (jointSupport model) row) <;> rfl
    rw [ite_eq_left guard] at admitted
    cases admitted

def configurationFactorization (model : Model) (configuration : Configuration model) : Bool :=
  factorizationAccepted model configuration.rows

theorem configurationFactorizationExactly (model : Model) (configuration : Configuration model) :
    configurationFactorization model configuration = true ↔
      ∀ row, row ∈ jointSupport model → row ∈ configuration.rows := by
  constructor
  · intro accepted row held
    exact ((factorizationExactly model configuration.rows).mp accepted row).mpr held
  · intro complete
    exact (factorizationExactly model configuration.rows).mpr
      (fun row => ⟨configurationContained model configuration row,complete row⟩)

theorem missingCombinationRejects (model : Model) (configuration : Configuration model) (row : List String)
    (missing : row ∈ missingCombinations model configuration.rows) :
    configurationFactorization model configuration = false := by
  have evidence := (missingExactly model configuration.rows row).mp missing
  cases result : configurationFactorization model configuration with
  | false => rfl
  | true => exact False.elim (evidence.2 ((configurationFactorizationExactly model configuration).mp result row evidence.1))

def singleBody (body : Body) (canonical : body.states.isEmpty = false ∧ distinct body.states = true) : Model where
  bodies := [body]
  interactions := []
  graphAdmission := by rfl
  localAdmission := by
    intro held member
    cases member with
    | head => exact canonical
    | tail _ h => cases h

theorem singleBodyMember (body : Body) (canonical : body.states.isEmpty = false ∧ distinct body.states = true)
    (state : String) : [state] ∈ jointSupport (singleBody body canonical) ↔ state ∈ body.states := by
  constructor
  · intro member
    have trace := (completeJointSupport _ _).mp member
    cases trace with
    | cons held tail => exact held
  · intro held
    exact (completeJointSupport _ _).mpr (.cons held .nil)

structure ResourceLedger where
  bodies : Nat
  interactions : Nat
  jointRows : Nat
  updateRows : Nat
  executedRows : Nat

def resourceLedger (model : Model) (update : Update model) (trace : Relation) : ResourceLedger :=
  ⟨model.bodies.length,model.interactions.length,(jointSupport model).length,update.rows.length,trace.length⟩

theorem exactResources (model : Model) (update : Update model) (trace : Relation) :
    (resourceLedger model update trace).bodies = model.bodies.length ∧
    (resourceLedger model update trace).interactions = model.interactions.length ∧
    (resourceLedger model update trace).jointRows = productCardinality (model.bodies.map Body.states) ∧
    (resourceLedger model update trace).updateRows = update.rows.length ∧
    (resourceLedger model update trace).executedRows = trace.length :=
  ⟨rfl,rfl,jointCardinality model,rfl,rfl⟩

end SFT.Computation.ManyBody
