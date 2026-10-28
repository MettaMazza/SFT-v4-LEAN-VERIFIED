import SFT.Computation.AssemblyDecomposition
namespace SFT.Computation.ModelSimulation
open StateTransition StateComposition

-- The registered step-or-trace simulation condition, expressed on the exact
-- source Path. An encoding is the supplied translation, not a fitted constant.
def StepSimulation (source target : System) (encode : String → String) : Prop :=
  ∀ state action next, step source state action = .ok next →
    ∃ actions before, Path target (encode state) actions before (encode next)

-- One retained target action list per simulated source step is the explicit
-- overhead ledger. No fixed overhead, one-step restriction or timing is assumed.
def flattened : List (List String) → List String
 | [] => []
 | segment :: rest => segment ++ flattened rest

theorem pathSimulation (source target : System) (encode : String → String)
    (simulation : StepSimulation source target encode) (initial terminal : String)
    (actions before : List String) (path : Path source initial actions before terminal) :
    ∃ ledger targetBefore,
      ledger.length = actions.length ∧
      Path target (encode initial) (flattened ledger) targetBefore (encode terminal) := by
  induction path with
  | identity state => exact ⟨[],[],rfl,.identity (encode state)⟩
  | next state action next actions before terminal edge later ih =>
    obtain ⟨segment,segmentBefore,head⟩ := simulation state action next edge
    obtain ⟨ledger,targetBefore,length,tail⟩ := ih
    exact ⟨segment :: ledger,segmentBefore ++ targetBefore,congrArg Nat.succ length,
      pathSerial _ _ _ _ _ _ _ _ head tail⟩

theorem simulatedObservation (source target : System) (encode : String → String)
    (simulation : StepSimulation source target encode) (initial terminal : String)
    (actions before : List String) (path : Path source initial actions before terminal)
    (held : encode initial ∈ target.states) :
    ∃ ledger targetBefore,
      ledger.length = actions.length ∧
      run target (encode initial) (flattened ledger) = .ok (targetBefore ++ [encode terminal]) := by
  obtain ⟨ledger,targetBefore,length,translated⟩ := pathSimulation _ _ _ simulation _ _ _ _ path
  exact ⟨ledger,targetBefore,length,(runAdmission _ _ _ _).mpr
    ⟨held,(runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ translated)⟩⟩

theorem reconstructedTerminal (decode encode : String → String) (terminal : String)
    (reconstruction : decode (encode terminal) = terminal)
    (observed : String) (preserved : observed = encode terminal) :
    decode observed = terminal := by
  rw [preserved]; exact reconstruction

theorem identitySimulation (system : System) : StepSimulation system system (fun state => state) := by
  intro state action next edge
  exact ⟨[action],[state],.next state action next [] [] next edge (.identity next)⟩

theorem composeSimulation (first second third : System) (encode decode : String → String)
    (one : StepSimulation first second encode) (two : StepSimulation second third decode) :
    StepSimulation first third (fun state => decode (encode state)) := by
  intro state action next edge
  obtain ⟨actions,before,path⟩ := one state action next edge
  obtain ⟨ledger,finalBefore,length,translated⟩ := pathSimulation _ _ _ two _ _ _ _ path
  exact ⟨flattened ledger,finalBefore,translated⟩

theorem flattenedAppend (left right : List (List String)) :
    flattened (left ++ right) = flattened left ++ flattened right := by
  induction left with
  | nil => rfl
  | cons segment rest ih =>
    change segment ++ flattened (rest ++ right) = _
    rw [ih]
    exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm

theorem ledgerSuccessor (ledger : List (List String)) (segment : List String) :
    flattened (ledger ++ [segment]) = flattened ledger ++ segment := by
  rw [flattenedAppend]
  change flattened ledger ++ (segment ++ []) = _
  have empty : segment ++ [] = segment := by
    induction segment with
    | nil => rfl
    | cons x xs ih => exact congrArg (List.cons x) ih
  rw [empty]

end SFT.Computation.ModelSimulation
