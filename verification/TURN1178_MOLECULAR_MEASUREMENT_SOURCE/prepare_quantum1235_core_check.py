from pathlib import Path
import json,sys
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1235/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.molecular_measurement_law_v1 import MolecularObservationMap
from sft.engine.exact import HeldLabel
from dataclasses import replace
families=['prepared-molecular-state','molecular-observation-class','molecular-readout-record','post-observation-molecular-state','measurement-instrument','measurement-condition'];fields=['prepared_state','probe_class','outcome_record','post_observation_state','instrument','condition'];leanfields=['preparedState','probeClass','outcomeRecord','postObservationState','instrument','condition'];base=dict(zip(fields,[HeldLabel(f,'v')for f in families]));base.update(retained_coordinates=(HeldLabel('retained-molecular-coordinate','r'),),closed_coordinates=(HeldLabel('closed-molecular-coordinate','c'),));cases=[('valid',{},'m')]
for f,lf in zip(fields,leanfields):cases.append((f,{f:HeldLabel('wrong','v')},'{m with '+lf+':=⟨"wrong","v",by rfl,by rfl⟩}'))
cases.extend([('empty-retained',dict(retained_coordinates=()),'{m with retainedCoordinates:=[]}'),('empty-closed',dict(closed_coordinates=()),'{m with closedCoordinates:=[]}'),('overlap',dict(closed_coordinates=(HeldLabel('closed-molecular-coordinate','r'),)),'{m with closedCoordinates:=[⟨"closed-molecular-coordinate","r",by rfl,by rfl⟩]}'),('duplicate-retained',dict(retained_coordinates=base['retained_coordinates']*2),'{m with retainedCoordinates:=m.retainedCoordinates++m.retainedCoordinates}'),('duplicate-closed',dict(closed_coordinates=base['closed_coordinates']*2),'{m with closedCoordinates:=m.closedCoordinates++m.closedCoordinates}'),('wrong-retained-family',dict(retained_coordinates=(HeldLabel('closed-molecular-coordinate','r'),)),'{m with retainedCoordinates:=[⟨"closed-molecular-coordinate","r",by rfl,by rfl⟩]}'),('wrong-closed-family',dict(closed_coordinates=(HeldLabel('retained-molecular-coordinate','c'),)),'{m with closedCoordinates:=[⟨"retained-molecular-coordinate","c",by rfl,by rfl⟩]}')]);expected=[]
for name,change,_ in cases:
 try:
  m=MolecularObservationMap(**dict(base,**change));result=dict(accepted=True,reconstructs=[m.reconstructs(k)for k in ['r','c','missing']])
 except ValueError as e:result=dict(accepted=False,error=str(e))
 expected.append(dict(name=name,**result))
(w/'quantum1235_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
s='''import SFT.Chemistry.MolecularMeasurement
open SFT.Chemistry.MolecularMeasurement SFT.Host.Canonical
def m : Observation := ⟨⟨"prepared-molecular-state","v",by rfl,by rfl⟩,⟨"molecular-observation-class","v",by rfl,by rfl⟩,[⟨"retained-molecular-coordinate","r",by rfl,by rfl⟩],[⟨"closed-molecular-coordinate","c",by rfl,by rfl⟩],⟨"molecular-readout-record","v",by rfl,by rfl⟩,⟨"post-observation-molecular-state","v",by rfl,by rfl⟩,⟨"measurement-instrument","v",by rfl,by rfl⟩,⟨"measurement-condition","v",by rfl,by rfl⟩⟩
def outcome (name : String) (o : Observation) : Value := match validate o with
 | .error e => .object [("name",.text name),("accepted",.boolean false),("error",.text e)]
 | .ok r => .object [("name",.text name),("accepted",.boolean true),("reconstructs",.array (["r","c","missing"].map (fun k => .boolean (reconstructs r k))))]
def main : IO Unit := IO.println (render (.array ['''+','.join('outcome '+json.dumps(name)+' ('+expr+')'for name,_,expr in cases)+']))\n';(w/'MolecularMeasurementCoreProgram1235.lean').write_text(s)
print('Prepared14 original accepted/rejected/reconstruction cases')
