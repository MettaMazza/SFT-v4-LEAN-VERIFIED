from pathlib import Path
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry'
p=r/'MolecularCorrespondence.lean';s=p.read_text();a=s.index('def decodeRows');b=s.index('\nstructure Execution',a)
s=s[:a]+'''def decodeRows (rows : List (Word × Word)) : List (String × String) :=
 rows.flatMap (fun row => match row.1 with
  | [] => []
  | source::sources => match sources with
    | _::_ => []
    | [] => match row.2 with
      | [] => []
      | target::targets => match targets with
        | [] => [(source,target)]
        | _::_ => [])
def observationMap (words : List Word) : Classification :=
 words.flatMap (fun word => match word with
  | [] => []
  | label::rest => match rest with
    | [] => [(word,label)]
    | _::_ => [])
def measurementRecords (state : State) : Except String (List (List Record)) :=
 state.branches.mapM' fun branch => do
  match branch.1 with
  | [] => throw "molecular execution did not retain singleton words"
  | label::rest => match rest with
    | [] => return (← observe state (observationMap (support state)) label).2
    | _::_ => throw "molecular execution did not retain singleton words"
''' +s[b:]
s=s.replace('restored.branches == initial.branches && restored.phaseCycle == initial.phaseCycle','decide (restored.branches = initial.branches ∧ restored.phaseCycle = initial.phaseCycle)');p.write_text(s)
p=r/'MolecularCorrespondenceDerivation.lean';s=p.read_text();s=s.replace('''  | [label] => return (← observe state (observationMap (support state)) label).2
  | _ => throw "molecular execution did not retain singleton words"''','''  | [] => throw "molecular execution did not retain singleton words"
  | label::rest => match rest with
    | [] => return (← observe state (observationMap (support state)) label).2
    | _::_ => throw "molecular execution did not retain singleton words"''')
s=s.replace('''   | [label] => (observe state (observationMap (support state)) label).map Prod.snd
   | _ => Except.error "molecular execution did not retain singleton words"''','''   | [] => Except.error "molecular execution did not retain singleton words"
   | label::rest => match rest with
     | [] => (observe state (observationMap (support state)) label).map Prod.snd
     | _::_ => Except.error "molecular execution did not retain singleton words"''')
s=s.replace('''   | [name] => (observe state (observationMap (support state)) name).map Prod.snd
   | _ => Except.error "molecular execution did not retain singleton words"''','''   | [] => Except.error "molecular execution did not retain singleton words"
   | name::rest => match rest with
     | [] => (observe state (observationMap (support state)) name).map Prod.snd
     | _::_ => Except.error "molecular execution did not retain singleton words"''')
a=s.index(' change Except.ok (Execution.mk');s=s[:a]+''' change Except.ok (Execution.mk _ _ _ _
  (decide (initialBranches rows = initialBranches rows ∧ phaseCycle = phaseCycle))) = .ok execution
 rw [decide_eq_true (And.intro rfl rfl)]
end SFT.Chemistry.MolecularCorrespondenceDerivation
''';p.write_text(s)
