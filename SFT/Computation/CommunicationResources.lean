import SFT.Computation.OracleTrace
import SFT.Computation.ExecutionResources
namespace SFT.Computation.CommunicationResources
open SFT.Computation OracleTrace ResourceRecord

-- Query projections retain the source identity together with each observation.
-- The declared answer relation is unchanged; no functional oracle is imposed.
def sentRows (ledger : OracleTrace.Ledger) : List (String × String) :=
  (records ledger).map fun row => (row.identity,row.query)

def receivedRows (ledger : OracleTrace.Ledger) : List (String × String) :=
  (records ledger).map fun row => (row.identity,row.answer)

def queryCount (ledger : OracleTrace.Ledger) : Nat := (records ledger).length

theorem mapLength (f : α → β) (rows : List α) : (rows.map f).length = rows.length := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg Nat.succ ih

theorem completeQueryCounts (ledger : OracleTrace.Ledger) :
    (sentRows ledger).length = queryCount ledger ∧
      (receivedRows ledger).length = queryCount ledger :=
  ⟨mapLength _ _,mapLength _ _⟩

def joinedRows (ledger : OracleTrace.Ledger) : List ((String × String) × (String × String)) :=
  (sentRows ledger).zip (receivedRows ledger)

def restore (row : (String × String) × (String × String)) : AnswerRecord :=
  ⟨row.1.1,row.1.2,row.2.2⟩

theorem reconstructRows (rows : List AnswerRecord) :
    ((rows.map fun row => (row.identity,row.query)).zip
      (rows.map fun row => (row.identity,row.answer))).map restore = rows := by
  induction rows with
  | nil => rfl
  | cons row rest ih =>
    cases row
    exact congrArg (List.cons _) ih

theorem completeQueryReconstruction (ledger : OracleTrace.Ledger) :
    (joinedRows ledger).map restore = records ledger := reconstructRows _

theorem reconstructedSource (registry : List (String × Interface))
    (ledger : OracleTrace.Ledger) (valid : Valid registry ledger)
    (row : AnswerRecord) (held : row ∈ (joinedRows ledger).map restore) :
    Registered registry row := by
  rw [completeQueryReconstruction] at held
  exact retainedSource _ _ valid _ held

theorem unknownIdentityExcluded (registry : List (String × Interface))
    (ledger : OracleTrace.Ledger) (row : AnswerRecord)
    (held : row ∈ records ledger)
    (absent : SFT.InformationScience.EncodingMaps.lookupFirst registry row.identity = none) :
    ¬ Valid registry ledger := undeclaredSourceExcluded _ _ _ held absent

theorem mapAppend (f : α → β) (left right : List α) :
    (left ++ right).map f = left.map f ++ right.map f := by
  induction left with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons (f row)) ih

theorem retainedCommunication (first second : OracleTrace.Ledger) :
    sentRows (append first second) = sentRows first ++ sentRows second ∧
      receivedRows (append first second) = receivedRows first ++ receivedRows second := by
  unfold sentRows receivedRows
  rw [recordsAppend]
  exact ⟨mapAppend _ _ _,mapAppend _ _ _⟩

theorem countAppend (left right : List α) :
    (left ++ right).length = left.length + right.length := by
  induction left with
  | nil => exact (Nat.zero_add _).symm
  | cons row rest ih =>
    change (rest ++ right).length + 1 = (rest.length + 1) + right.length
    rw [ih]
    exact (Nat.add_assoc _ _ _).trans ((congrArg (Nat.add rest.length) (Nat.add_comm right.length 1)).trans (Nat.add_assoc _ _ _).symm)

theorem completeQueryCost (first second : OracleTrace.Ledger) :
    queryCount (append first second) = queryCount first + queryCount second := by
  unfold queryCount
  rw [recordsAppend]
  exact countAppend _ _

theorem registeredComposition (registry : List (String × Interface))
    (first second : OracleTrace.Ledger) (left : Valid registry first)
    (right : Valid registry second) :
    Valid registry (append first second) ∧
      queryCount (append first second) = queryCount first + queryCount second :=
  ⟨validAppend _ _ _ left right,completeQueryCost _ _⟩

theorem singletonQuery (registry : List (String × Interface))
    (row : AnswerRecord) (registered : Registered registry row) :
    Valid registry (.call row .done .done) ∧
      sentRows (.call row .done .done) = [(row.identity,row.query)] ∧
      receivedRows (.call row .done .done) = [(row.identity,row.answer)] ∧
      queryCount (.call row .done .done) = 1 :=
  ⟨.call _ _ _ registered .done .done,rfl,rfl,rfl⟩

theorem successorQuery (registry : List (String × Interface))
    (ledger : OracleTrace.Ledger) (valid : Valid registry ledger)
    (row : AnswerRecord) (registered : Registered registry row) :
    Valid registry (append ledger (.call row .done .done)) ∧
      records (append ledger (.call row .done .done)) = records ledger ++ [row] ∧
      queryCount (append ledger (.call row .done .done)) = queryCount ledger + 1 :=
  ⟨validAppend _ _ _ valid (.call _ _ _ registered .done .done),
    recordsAppend _ _,completeQueryCost _ _⟩

-- resourceLedger retains the declared occupied/local support separately from
-- the protocol observation trace. It does not identify that support with output.
theorem retainedLocalKnowledge (trace localKnowledge : List String)
    (resources : ResourceRecord.Ledger)
    (recorded : resourceLedger trace localKnowledge = .ok resources) :
    resources.timeTrace.map Prod.snd = trace ∧ resources.spaceSupport = localKnowledge ∧
      resources.timeCount = trace.length ∧ resources.spaceCount = localKnowledge.length :=
  recordReconstructs _ _ _ recorded

open UniversalInterpretation
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder
open StateTransition StateComposition

-- The certificate binds the exact registered protocol execution, the declared
-- distributed input, local support and external answers. Registry arguments
-- are explicit source carriers, not fitted scientific parameters.
def Certificate (protocols : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (inputs : List (String × String)) (participant : String)
    (oracles : List (String × Interface)) (queries : OracleTrace.Ledger)
    (trace localKnowledge : List String) (resources : ResourceRecord.Ledger) : Prop :=
  (∃ name request, decode code decoder = .ok name ∧
    lookupFirst protocols name = some request ∧
    lookupFirst inputs participant = some request.initial ∧
    run request.machine request.initial request.actions = .ok trace) ∧
  Valid oracles queries ∧ resourceLedger trace localKnowledge = .ok resources

theorem protocolReplay (protocols : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (inputs : List (String × String)) (participant : String)
    (oracles : List (String × Interface)) (queries : OracleTrace.Ledger)
    (trace localKnowledge : List String) (resources : ResourceRecord.Ledger)
    (certificate : Certificate protocols decoder code inputs participant oracles queries
      trace localKnowledge resources) :
    interpret protocols decoder code = some (.ok trace) := by
  obtain ⟨name,request,decoded,selected,input,executed⟩ := certificate.1
  rw [exactRequest _ _ _ _ _ decoded selected,executed]

theorem distributedInputRetained (protocols : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (inputs : List (String × String)) (participant : String)
    (oracles : List (String × Interface)) (queries : OracleTrace.Ledger)
    (trace localKnowledge : List String) (resources : ResourceRecord.Ledger)
    (certificate : Certificate protocols decoder code inputs participant oracles queries
      trace localKnowledge resources) :
    ∃ name request, (name,request) ∈ protocols ∧
      (participant,request.initial) ∈ inputs ∧
      run request.machine request.initial request.actions = .ok trace := by
  obtain ⟨name,request,decoded,selected,input,executed⟩ := certificate.1
  exact ⟨name,request,lookupRow _ _ _ selected,lookupRow _ _ _ input,executed⟩

theorem resultCertificate (protocols : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (inputs : List (String × String)) (participant : String)
    (oracles : List (String × Interface)) (queries : OracleTrace.Ledger)
    (trace localKnowledge : List String) (resources : ResourceRecord.Ledger)
    (certificate : Certificate protocols decoder code inputs participant oracles queries
      trace localKnowledge resources) :
    (∃ name request before terminal, (name,request) ∈ protocols ∧
      trace = before ++ [terminal] ∧
      Path request.machine request.initial request.actions before terminal ∧
      before.length = request.actions.length) ∧
    (∀ row, row ∈ records queries → Registered oracles row) ∧
    resources.timeTrace.map Prod.snd = trace ∧ resources.spaceSupport = localKnowledge := by
  have replayed := protocolReplay _ _ _ _ _ _ _ _ _ _ certificate
  have resource := recordReconstructs _ _ _ certificate.2.2
  exact ⟨completeTrace _ _ _ _ replayed,
    fun row held => retainedSource _ _ certificate.2.1 row held,resource.1,resource.2.1⟩

theorem unregisteredProtocolExcluded (protocols : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (inputs : List (String × String)) (participant name : String)
    (oracles : List (String × Interface)) (queries : OracleTrace.Ledger)
    (trace localKnowledge : List String) (resources : ResourceRecord.Ledger)
    (decoded : decode code decoder = .ok name) (absent : lookupFirst protocols name = none) :
    ¬ Certificate protocols decoder code inputs participant oracles queries trace localKnowledge resources := by
  intro certificate
  have replayed := protocolReplay _ _ _ _ _ _ _ _ _ _ certificate
  rw [unregisteredDescription _ _ _ _ decoded absent] at replayed
  cases replayed

end SFT.Computation.CommunicationResources
