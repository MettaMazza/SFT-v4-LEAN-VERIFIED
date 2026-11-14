from pathlib import Path
import sys,json,dataclasses,shutil
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_spectra_postseal_validation_v1 as src
p=r/'SFT/Physics/AtomicPostsealMeasurement.lean';s=p.read_text();end='end SFT.Physics.AtomicPostsealMeasurement'
extra='''def formalCountCheck : Bool := CubicAtomicSupport.cubicCoordination.toOption.getD 0 == 6
def observedCountCheck : Bool := (cubicObservedCoordination registeredRecord).toOption.getD 0 == 6
def cubicEqualityCheck : Bool := (cubicComparison registeredRecord).toOption.getD false
def lymanRatioCheck : Bool := sameRat ((HydrogenSpectrum.hydrogenTransition (.integer 2) (.integer 1)).toOption.getD zero) (normalize 3 4 (by decide))
def balmerRatioCheck : Bool := sameRat ((HydrogenSpectrum.hydrogenTransition (.integer 3) (.integer 2)).toOption.getD zero) (normalize 5 36 (by decide))
def lymanIntervalCheck : Bool := ((hydrogenComparison registeredRecord).map HydrogenComparison.lymanPassed).toOption.getD false
def balmerIntervalCheck : Bool := ((hydrogenComparison registeredRecord).map HydrogenComparison.balmerPassed).toOption.getD false
'''
for key,upper,lower,num,den in [('lyman',2,1,3,4),('balmer',3,2,5,36)]:
 old=next(line for line in extra.splitlines() if line.startswith('def '+key+'RatioCheck'))
 extra=extra.replace(old,f'def {key}RatioCheck : Bool :=\n let q := ((HydrogenSpectrum.hydrogenTransition (.integer {upper}) (.integer {lower})).toOption.getD zero)\n let expected := normalize {num} {den} (by decide)\n !(q.blt expected) && !(expected.blt q)')
for name in ['formalCountCheck','observedCountCheck','cubicEqualityCheck','lymanRatioCheck','balmerRatioCheck','lymanIntervalCheck','balmerIntervalCheck']:extra+=f'theorem {name}Passed : {name}=true := rfl\n'
for key,label,guard,msg in [('cubic',src.CUBIC_LABEL,'(← cubicComparison record)','sealed cubic count differs from the complete NIST row'),('hydrogen',src.HYDROGEN_LABEL,'(← hydrogenPassed record)','sealed hydrogen vector lies outside a complete NIST interval')]:
 extra+=f'''def {key}Classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 let record ← authoritativeRecord bytes files payload
 if !{guard} then throw {json.dumps(msg)}
 pure {json.dumps(label)}
'''
if 'def formalCountCheck' not in s:s=s.replace(end,extra+end)
for root in [r,c]:(root/'SFT/Physics/AtomicPostsealMeasurement.lean').write_text(s)
for key,n,tag,spec,checks,classification in [('CUBIC',949,'CubicPostsealValidation',src.CUBIC_SPEC,['formalCountCheck','observedCountCheck','cubicEqualityCheck'],'cubicClassification'),('HYDROGEN',950,'HydrogenPostsealValidation',src.HYDROGEN_SPEC,['lymanRatioCheck','balmerRatioCheck','lymanIntervalCheck','balmerIntervalCheck'],'hydrogenClassification')]:
 d=dataclasses.asdict(spec);dims=d.pop('dimensions');wit=d.pop('operational_witnesses');d['target_rows']=[list(row.values()) for row in d['target_rows']];(w/f'atomicvalidation_{key}_spec949.json').write_text(json.dumps(dict(values=d,dimensions=dims,witnesses=wit),indent=2))
 gen=(w/'prepare_vacuum_validations879.py').read_text();a=gen.index('items=');b=gen.index('\nq=',a);gen=gen[:a]+f'items=[{(key,tag,n,checks,classification)!r}]'+gen[b:];gen=gen.replace('VacuumAuthoritativeWitnesses','AtomicPostsealMeasurement').replace('VacuumAuthoritativeRecords','AtomicPostsealRecords').replace("f'SFT-PHYS-VALIDATION-VACUUM-{key}-003_spec879.json'","f'atomicvalidation_{key}_spec949.json'").replace('AtomicPostsealRecords.{classify}','AtomicPostsealMeasurement.{classify}')
 exec(compile(gen,'atomic-original-empirical','exec'),{})
 for suffix in ['Witnesses','Grammar','Evidence','Experiment','Validation']:shutil.copy2(r/'SFT/Physics'/f'{tag}{suffix}.lean',c/'SFT/Physics'/f'{tag}{suffix}.lean')

for root in [r,c]:
 p=root/'SFT/Physics/HydrogenPostsealValidationExperiment.lean';s=p.read_text().replace('targetRows.length = 1','targetRows.length = 2').replace('= [expectedLabel] := rfl','= [expectedLabel,expectedLabel] := rfl');p.write_text(s)
