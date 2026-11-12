from pathlib import Path
import subprocess
w=Path('work')
for old in ['matcubic_spec673.py','matcubic_source673.py','prepare_matcubic673.py','prepare_matcubic_protocol673.py','complete_matcubic_spec673.py','build_matcubic673.py','audit_matcubic673.py','run_matcubic_native673.py','check_matcubic_native673.py','check_matcubic_authority673.py']:
 new=old.replace('matcubic','matrotation').replace('673','677');s=(w/old).read_text().replace('matcubic','matrotation').replace('Cubic','Rotation').replace('673','677')
 s=s.replace("MATERIALS_BLUEPRINTS'][10]","MATERIALS_BLUEPRINTS'][11]").replace("MATERIALS_OBLIGATIONS'][10]","MATERIALS_OBLIGATIONS'][11]").replace("MATERIALS_SPECS'][10]","MATERIALS_SPECS'][11]")
 if old=='prepare_matcubic673.py':
  s=s.replace('import SFT.Materials.RotationCoordination','import SFT.Materials.RotationClosure')
  s=s.replace('(match RotationCoordination.simpleRotationCoordination with | .ok n => n == 6 | .error _ => false)','(match RotationCertificate.allowedCrystallographicOrders, RotationCertificate.rotationFactorCertificate with | .ok orders, .ok certificate => (orders.map Subtype.val == [1,2,3,4,6]) && (certificate.leastExcluded.val == 5) | _, _ => false)')
 if old=='run_matcubic_native673.py':
  ops=['RotationFactors','RotationFactorSupport','RotationTotient','RotationFactorDivisibility','RotationFactorPrimality','RotationPrimeSupport','RotationCoprime','RotationCertificate','RotationDegreeBase','RotationResidueBlocks','RotationPrimePower','RotationDegreeLift','RotationDegreeProduct','RotationDegreeFresh','RotationFactorDegree','RotationSmallDegrees','RotationClassification','RotationClosure']
  s=s.replace("modules=['RotationCoordination','Lattice','RotationGrammar','RotationEvidence','MaterialCarrier','MaterialCarrierRetention']",'modules='+repr(ops+['Lattice','RotationGrammar','RotationEvidence','MaterialCarrier','MaterialCarrierRetention']))
 (w/new).write_text(s)
program=w/'constants-recovery/RotationProgram677.lean';program.write_text((w/'constants-recovery/CubicProgram673.lean').read_text().replace('Cubic','Rotation'))
for script in ['prepare_matrotation677.py','prepare_matrotation_protocol677.py','complete_matrotation_spec677.py']:
 subprocess.run(['python3',str(w/script)],check=True)
p=w/'constants-recovery/SFT/Materials/RotationEvidence.lean';s=p.read_text().replace('theorem witness3Passed : witness3 = true := rfl','theorem witness3Passed : witness3 = true := by\n unfold witness3\n rw [RotationClosure.allowedOrdersVerified,RotationClosure.originalCertificateVerified]\n rfl');p.write_text(s)
p=w/'constants-recovery/SFT/Materials/RotationExperiment.lean';s=p.read_text().replace('theorem registeredSpecValid : validateSpec = .ok () := rfl','theorem registeredSpecValid : validateSpec = .ok () := by\n unfold validateSpec\n rw [RotationEvidence.witness3Passed]\n rfl');p.write_text(s)
