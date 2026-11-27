from pathlib import Path
import json,sys
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_conformerpopulation1495/sft/chemistry').resolve()))
from sft.chemistry import conformer_population_ordering_law_v1 as v
from sft.engine.canonical import canonical_value
c=v.butane_four_site_census();a,g,h=c.generated_assignments;condition=v.HeldLabel('observation-condition','fixed-condition-and-timescale');ratio=v.PositiveRatio.from_pair;empty=v.EMPTY_ONE;rows=[];commands=[]
def record(name,fn,lean,encoder):
 try:out={'ok':canonical_value(fn())}
 except (ValueError,IndexError,KeyError,AttributeError) as e:out={'error':str(e)}
 rows.append({'case':name,'result':out});commands.append('test '+json.dumps(name)+' '+encoder+' ('+lean+')')
heights=[('empty',empty,'.emptyOne'),('other_empty',v.EmptyOne(),'.otherEmptyOne "empty-One"'),('one',ratio(1,1),'.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩'),('three',ratio(3,1),'.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩'),('half_raw',ratio(2,4),'.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩')]
for n,x,lx in heights:
 for m,y,ly in heights:record('take_'+n+'_'+m,lambda x=x,y=y:v.ordered_positive_take(x,y),f'P.orderedTake ({lx}) ({ly})','ratioValue')
for name,trace,word in [('base',(a,a,g,a),'[a,a,g,a]'),('anti_only',(a,a),'[a,a]'),('gauche_only',(g,h),'[g,h]'),('tie',(a,h),'[a,h]'),('successor',(a,a,g,a,h),'[a,a,g,a,h]'),('empty',(),'[]'),('foreign',(v.ExactConformerAssignment((v.HeldLabel('torsion-state','foreign'),)),),'[[foreign]]')]:
 fn=lambda trace=trace:v.conditioned_population_census(c,condition,trace,(empty,ratio(3,1)))
 expr=f'P.conditioned c condition {word} [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]'
 record(name,fn,expr,'populationValue')
 if name not in ['empty','foreign']:
  record(name+'_population_order',lambda fn=fn:fn().population_order(),f'do let x ← {expr}; P.populationOrder x','classesValue')
  record(name+'_energy_order',lambda fn=fn:fn().energy_order(),f'do let x ← {expr}; P.energyOrder x','classesValue')
record('append',lambda:v.append_observation(v.conditioned_population_census(c,condition,(a,a,g,a),(empty,ratio(3,1))),h),'do let x ← P.conditioned c condition [a,a,g,a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]; P.appendObservation x h','populationValue')
record('energy_length',lambda:v.conditioned_population_census(c,condition,(a,),()),'P.conditioned c condition [a] []','populationValue')
record('bad_condition',lambda:v.conditioned_population_census(c,v.HeldLabel('other','fixed'),(a,),(empty,ratio(3,1))),'P.conditioned c badCondition [a] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]','populationValue')
record('observation_length',lambda:v.ConditionedConformerObservation(condition,v.PositiveCount(2),(a,)),'P.observation condition (.count ⟨2,by decide⟩) [a]','observationValue')
record('observation_invalid_boundary',lambda:v.ConditionedConformerObservation(condition,0,(a,)),'P.observation condition .other [a]','observationValue')
record('empty_class',lambda:v.ConformerPopulationRow((),empty,empty,empty),'P.row [] .emptyOne .emptyOne .emptyOne','rowValue')
record('absent_positive_population',lambda:v.ConformerPopulationRow((a,),empty,ratio(1,2),empty),'P.row [a] .emptyOne (.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩) .emptyOne','rowValue')
record('observed_empty_population',lambda:v.ConformerPopulationRow((a,),v.PositiveCount(1),empty,empty),'P.row [a] (.count ⟨1,by decide⟩) .emptyOne .emptyOne','rowValue')
record('raw_ratio_retained',lambda:v.ConformerPopulationRow((a,),v.PositiveCount(2),ratio(2,4),empty),'P.row [a] (.count ⟨2,by decide⟩) (.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩) .emptyOne','rowValue')
record('other_empty_occurrence',lambda:v.ConformerPopulationRow((a,),v.EmptyOne(),empty,empty),'P.row [a] (.otherEmptyOne "empty-One") .emptyOne .emptyOne','rowValue')
record('other_empty_energy',lambda:v.ConformerPopulationRow((a,),empty,empty,v.EmptyOne()),'P.row [a] .emptyOne .emptyOne (.otherEmptyOne "empty-One")','rowValue')
record('other_empty_energy_sort',lambda:v.conditioned_population_census(c,condition,(a,), (empty,v.EmptyOne())).energy_order(),'do let x ← P.conditioned c condition [a] [.emptyOne,.otherEmptyOne "empty-One"]; P.energyOrder x','classesValue')
record('all_energy_tied',lambda:v.conditioned_population_census(c,condition,(a,g),(ratio(2,4),ratio(1,2))).energy_order(),'do let x ← P.conditioned c condition [a,g] [.ratio ⟨⟨2,by decide⟩,⟨4,by decide⟩⟩,.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩]; P.energyOrder x','classesValue')
header=(w/'ConformerCoreProgram1493.lean').read_text().split('def result')[0].replace('import SFT.Chemistry.ConformerCensus','import SFT.Chemistry.ConformerPopulation')
header+='''
namespace P := SFT.Chemistry.ConformerPopulation
open SFT.Chemistry.DihedralTorsion (Ratio Height)
def ratioValue (r : Ratio) : J := .object [("numerator",positive r.numerator),("denominator",positive r.denominator)]
def heightValue : Height → J
 | .emptyOne => .object [("identity",.text "empty-One")]
 | .otherEmptyOne s => .object [("identity",.text s)]
 | .ratio r => ratioValue r
 | .invalid => .null
def occurrenceValue : P.Occurrence → J
 | .emptyOne => .object [("identity",.text "empty-One")]
 | .otherEmptyOne s => .object [("identity",.text s)]
 | .count n => positive n
 | .invalid => .null
def classesValue (groups : List (List Assignment)) : J := .array (groups.map fun g => .array (g.map assignmentValue))
def observationValue (x : P.Observation) : J := .object [("condition",label x.condition),("observation_boundary",positive x.boundary),("trace",.array (x.trace.map assignmentValue))]
def rowValue (x : P.Row) : J := .object [("equivalence_class",.array (x.equivalenceClass.map assignmentValue)),("occurrence_count",occurrenceValue x.occurrence),("population",heightValue x.population),("relative_energy",heightValue x.relativeEnergy)]
def populationValue (x : P.PopulationCensus) : J := .object [("conformers",censusValue x.conformers),("observation",observationValue x.observation),("rows",.array (x.rows.map rowValue))]
def test {α : Type} (name : String) (encode : α→J) (value : Except String α) : J :=
 .object [("case",.text name),("result",match value with | .ok x => .object [("ok",encode x)] | .error e => .object [("error",.text e)])]
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let c ← IO.ofExcept butane
 let a := [anti]; let g := [gaucheForward]; let h := [gaucheReverse]
 let condition : HeldLabel := ⟨"observation-condition","fixed-condition-and-timescale",rfl,rfl⟩
 let badCondition : HeldLabel := ⟨"other","fixed",rfl,rfl⟩
 let foreign : HeldLabel := ⟨"torsion-state","foreign",rfl,rfl⟩
 IO.println (Canonical.render (.array [
'''
header=header.replace('namespace P := SFT.Chemistry.ConformerPopulation','open SFT.Chemistry\n') .replace('P.','ConformerPopulation.')
(w/'ConformerPopulationCases1495.lean').write_text(header+',\n'.join(commands).replace('P.','ConformerPopulation.')+']))\n')
(w/'conformerpopulation1495_cases_expected.json').write_text(json.dumps(rows,indent=2)+'\n')
print('Prepared',len(rows),'fresh original cases')
