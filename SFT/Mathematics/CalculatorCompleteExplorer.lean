import SFT.Mathematics.CalculatorCompleteEvidence
import SFT.Mathematics.CalculatorCompleteController
namespace SFT.Mathematics.CalculatorCompleteExplorer
open SFT.Host SFT.Host.Canonical
open CalculatorCompleteEvidence
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Projections of the original LawSpec and candidate_records outputs; instantiated
-- from the corresponding native entries, not a second scientific grammar.
structure Spec where
 claimId : String
 title : String
 statement : String
 dependencies : List String
 grammarBoundary : String
 exactResult : String
 laws : List String
 limitations : String
 dimensionSizes : List Nat
 candidateIds : List String
 survivorId : String
 witnesses : List (String × Bool)
structure Explorer where
 specs : List Spec
 census : List CensusRow := []
 registrations : List (String × List String) := []
def claimIds (e : Explorer) : List String := e.specs.map Spec.claimId
def spec (e : Explorer) (claimId : String) : Except String Spec :=
 match e.specs.find? (fun s => Text.equal s.claimId claimId) with
 | some s => .ok s
 | none => .error (Text.append "unknown registered Mathematics claim " (CalculatorCompleteController.quoted claimId))
-- Python dictionary construction retains the last row for each duplicate key.
def censusRow (e : Explorer) (claimId : String) : Option CensusRow :=
 e.census.reverse.find? (fun row => Text.equal row.claimId claimId)
def summary (e : Explorer) (claimId : String) : Except String Value := do
 let s ← spec e claimId
 let row := censusRow e claimId
 let hash := match row with | none => .null | some r => r.receiptHash
 let admitted := match row with | none => false | some r => r.modelAdmitted
 pure (.object [("claim_id",.text s.claimId),("title",.text s.title),("statement",.text s.statement),
 ("dependencies",.array (s.dependencies.map Value.text)),("grammar_boundary",.text s.grammarBoundary),
 ("exact_result",.text s.exactResult),("laws",.array (s.laws.map Value.text)),("limitations",.text s.limitations),
 ("candidate_count",.integer (.ofNat (s.dimensionSizes.foldl (·*·) 1))),
 ("receipt_hash",hash),("model_admitted",.boolean admitted)])
def summaries (e : Explorer) : Except String (List Value) := (claimIds e).mapM (summary e)
def dependencies (e : Explorer) (id : String) : List String :=
 match e.registrations.find? (fun row => Text.equal row.1 id) with
 | some row => row.2
 | none => match e.specs.find? (fun s => Text.equal s.claimId id) with
   | none => []
   | some s => s.dependencies
-- The explicit stack is the source recursive DFS: enter marks visited before
-- children; leave appends after children, including cycles and shared parents.
inductive Visit where
 | enter (id : String)
 | leave (id : String)
def chainLoop (e : Explorer) : Nat → List Visit → List String → List String → List String
 | 0,_,_,ordered => ordered
 | fuel+1,todo,seen,ordered => match todo with
   | [] => ordered
   | task::rest => match task with
     | .leave id => chainLoop e fuel rest seen (ordered ++ [id])
     | .enter id => if seen.any (Text.equal id) then chainLoop e fuel rest seen ordered
       else chainLoop e fuel (((dependencies e id).map Visit.enter) ++ [.leave id] ++ rest) (id::seen) ordered
def dependencyChain (e : Explorer) (id : String) : List String :=
 let edges := (e.registrations.map (fun r => r.2.length)).foldl (·+·) 0 + (e.specs.map (fun s => s.dependencies.length)).foldl (·+·) 0
 let nodes := 1 + e.registrations.length + e.specs.length + edges
 chainLoop e (1+2*nodes+edges) [.enter id] [] []
def replay (e : Explorer) (claimId : String) : Except String Value := do
 let s ← spec e claimId
 let survivors := s.candidateIds.filter (Text.equal s.survivorId)
 let hash := match censusRow e claimId with | none => .null | some r => r.receiptHash
 pure (.object [("kind",.text "calculator_law_replay_not_engine_admission"),("claim_id",.text claimId),
 ("candidate_count",.integer (.ofNat s.candidateIds.length)),("eliminated_count",.integer (.ofNat (s.candidateIds.length-survivors.length))),
 ("survivor_id",.text s.survivorId),("witness_results",.array (s.witnesses.map fun (n,b) => .array [.text n,.boolean b])),
 ("dependency_chain",.array ((dependencyChain e claimId).map Value.text)),("official_receipt_hash",hash),
 ("locally_replayed",.boolean (survivors.length==1 && s.witnesses.all Prod.snd)),("engine_admission_issued",.boolean false)])
def replayJSON (e : Explorer) (claimId : String) : Except String String := (replay e claimId).map CalculatorCompleteJSON.document
end SFT.Mathematics.CalculatorCompleteExplorer
