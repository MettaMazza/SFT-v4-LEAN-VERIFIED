from pathlib import Path
import subprocess
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
def sub(s):
 for a,b in [('ElectroweakMeasured','CommonMeasured'),('electroweak1056','commonmeasured1057'),('Program1056','Program1057'),('Empirical1056','Empirical1057'),('electroweak_measured_value_successor','common_scale_measured_value_successor'),('ElectroweakMeasuredValueSuccessorValidator','CommonScaleMeasuredValueSuccessorValidator'),('CommonMeasuredValueSuccessorValidator','CommonScaleMeasuredValueSuccessorValidator'),('SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053','SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054'),("'electroweak',1056","'commonmeasured',1057")]:s=s.replace(a,b)
 return s
for k in ['program','fresh','grammar','independent','empirical','original']:(w/f'check_commonmeasured1057_{k}.py').write_text(sub((w/f'check_electroweak1056_{k}.py').read_text()))
for old,new in [('run_electroweak1056_native.py','run_commonmeasured1057_native.py'),('prepare_electroweak1056_empirical_native.py','prepare_commonmeasured1057_empirical_native.py'),('audit_electroweak1056.py','audit_commonmeasured1057.py')]: (w/new).write_text(sub((w/old).read_text()))
(w/'constants-recovery/CommonMeasuredEmpirical1057.lean').write_text(sub((w/'constants-recovery/ElectroweakMeasuredEmpirical1056.lean').read_text()));(r/'CommonMeasuredProgram1057.lean').write_text(sub((r/'ElectroweakMeasuredProgram1056.lean').read_text()))
p=w/'check_commonmeasured1057_original.py';s=p.read_text().replace('complete original electroweak empirical validator with two target rows','complete original common-scale empirical validator with three target rows');p.write_text(s)
rel='generated/physics/common_scale_measured_value_successor_validator_v1.py';p=w/'v3-runtime500'/rel;p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]))
