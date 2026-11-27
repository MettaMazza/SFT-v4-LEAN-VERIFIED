from pathlib import Path
import json,sys,dataclasses
w=Path('work');stage=w/'pinned_nucleophilic1496';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry.nucleophilic_substitution_law_v1 import _states_and_paths,forced_substitution_path,extend_retained_substrate,HeldPair,electron,occurrence
from sft.engine.exact import PositiveCount,HeldLabel
c,one,two=_states_and_paths();edge=one.ordered_transitions[0]
cases=[('short',lambda:forced_substitution_path(c,(c.source,),())),('wrong_source',lambda:forced_substitution_path(c,one.ordered_states[::-1],one.ordered_transitions)),('gap',lambda:forced_substitution_path(c,one.ordered_states,(dataclasses.replace(edge,occurrence=PositiveCount(2)),))),('adjacency',lambda:forced_substitution_path(c,one.ordered_states,(dataclasses.replace(edge,entry=one.terminal),))),('action',lambda:forced_substitution_path(c,one.ordered_states,(dataclasses.replace(edge,action=HeldLabel('substitution-action','cleave-displaced-support')),))),('old_successor',lambda:extend_retained_substrate(c,two,c.centre,HeldPair(electron('fresh1'),electron('fresh2')))),('wrong_successor_family',lambda:extend_retained_substrate(c,two,HeldLabel('other','fresh'),HeldPair(electron('fresh1'),electron('fresh2'))))]
out=[]
for name,fn in cases:
 try:fn();out.append({'case':name,'error':'accepted'})
 except Exception as e:out.append({'case':name,'error':str(e)})
(w/'nucleophilic1497_path_cases_expected.json').write_text(json.dumps(out,indent=2)+'\n')
s='''import SFT.Chemistry.NucleophilicWitnesses
open SFT.Chemistry SFT.Chemistry.NucleophilicCarrier SFT.Chemistry.NucleophilicPath SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def result {α : Type} (name : String) (x : Except String α) : J := .object [("case",.text name),("error",.text (match x with | .ok _ => "accepted" | .error e => e))]
def main : IO Unit := do
 let (c,one,two) ← IO.ofExcept NucleophilicWitnesses.sourcePaths
 let edge ← IO.ofExcept (itemAt one.transitions 0)
 let fresh ← IO.ofExcept (do pair (← electron "fresh1") (← electron "fresh2"))
 let label ← IO.ofExcept (heldLabel "substitution-action" "cleave-displaced-support")
 let other ← IO.ofExcept (heldLabel "other" "fresh")
 IO.println (SFT.Host.Canonical.render (.array [
  result "short" (forcedPath c [c.source] []),
  result "wrong_source" (forcedPath c one.states.reverse one.transitions),
  result "gap" (forcedPath c one.states [{edge with occurrence:=⟨2,by decide⟩}]),
  result "adjacency" (forcedPath c one.states [{edge with entry:=one.terminal}]),
  result "action" (forcedPath c one.states [{edge with action:=label}]),
  result "old_successor" (extend c two c.centre fresh),
  result "wrong_successor_family" (extend c two other fresh)]))
''';(w/'NucleophilicPathCases1497.lean').write_text(s)
s=(w/'check_nucleophilic1496_paths.py').read_text().replace('NucleophilicPaths1496','NucleophilicPathCases1497').replace('nucleophilic1496_paths','nucleophilic1497_path_cases');(w/'check_nucleophilic1497_path_cases.py').write_text(s)
