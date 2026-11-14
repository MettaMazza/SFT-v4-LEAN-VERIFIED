exec(open('work/check_scattering969_core.py').read().split('expected=[];fields=[];counts={}')[0])
s=s[:s.index('#eval')]
s+='''def pairs (xs : List (Rat × Rat)) : Value := .array (xs.map (fun (a,b) => .array [frac a,frac b]))
def certificate (c : Certificate) : Value := .object [
 ("forward_transfer",.array (c.forwardTransfer.map frac)),("transfer_parts",.array (c.transferParts.map frac)),
 ("coulomb_normalized_angular_density",pairs c.angularDensity),
 ("coulomb_cumulative_impact_area",.array (c.cumulativeArea.map (fun (a,b) => .array [frac a,opt b]))),
 ("coulomb_annular_interval_density",.array (c.annularDensity.map (fun (a,b,d) => .array [frac a,frac b,frac d]))),
 ("coulomb_annular_product_identity",.array (c.annularIdentity.map Value.boolean)),
 ("coulomb_charge_doubling_ratio",frac c.chargeDoublingRatio),("coulomb_energy_doubling_ratio",frac c.energyDoublingRatio),
 ("photon_shift_in_compton_carriers",pairs c.photonShifts),("photon_outgoing_over_incident_at_equal_rest_energy",pairs c.photonEnergy),
 ("photon_conservation_transfer_at_equal_rest_energy",pairs c.conservationTransfer),
 ("right_angle_high_energy_ceiling",frac c.rightAngleCeiling),("backscatter_high_energy_ceiling",frac c.backscatterCeiling),
 ("positive_successor_steps",.array (c.successorSteps.map frac)),("positive_ceiling_gaps",.array (c.ceilingGaps.map frac))]
#eval IO.println (render (.array [result certificate formalCertificate,
'''
def enc(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
 if isinstance(x,(tuple,list)):return list(map(enc,x))
 return x
expected=[enc(src.formal_certificate())];fields=[]
axes=[('amplitude_carrier','amplitudeCarrier','AMPLITUDE_CARRIERS'),('cross_section_measure','crossSectionMeasure','CROSS_SECTION_MEASURES'),('coulomb_angular_law','coulombAngularLaw','COULOMB_ANGULAR_LAWS'),('coulomb_scale_law','coulombScaleLaw','COULOMB_SCALE_LAWS'),('photon_shift_law','photonShiftLaw','PHOTON_SHIFT_LAWS'),('photon_energy_law','photonEnergyLaw','PHOTON_ENERGY_LAWS'),('target_boundary','targetBoundary','TARGET_BOUNDARIES'),('extension','extension','EXTENSIONS')]
proof='import SFT.Physics.ScatteringRutherfordCompton\nnamespace SFT.Physics.ScatteringRutherfordComptonProofs\nopen ScatteringRutherfordCompton\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n'
for py,lean,labels in axes:
 fn=getattr(src,py+'_is_forced')
 for i,v in enumerate((*getattr(src,labels),'bad')):
  try:expected.append(fn(v))
  except ValueError as e:expected.append({'error':str(e)})
  fields.append(f'result Value.boolean ({lean}IsForced {q(v)})')
  if v!='bad':proof+=f'theorem {lean}{i} : {lean}IsForced {q(v)} = .ok {str(fn(v)).lower()} := rfl\n'
proof+='end SFT.Physics.ScatteringRutherfordComptonProofs\n'
for root in [c,w/'constants-recovery']:(root/'SFT/Physics/ScatteringRutherfordComptonProofs.lean').write_text(proof)
p=w/'constants-recovery/ScatteringCertificate969.lean';p.write_text(s+',\n'.join(fields)+']))\n')
env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True);a=json.loads(out);assert a==expected,[(i,a[i],v) for i,v in enumerate(expected) if a[i]!=v]
(w/'scattering969_certificate_report.json').write_text(json.dumps(dict(status='PASS',certificate=a[0],forcing_cases=len(expected)-1,lean_sha256=hashlib.sha256((c/'SFT/Physics/ScatteringRutherfordCompton.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS complete15fieldcertificate andall30forcing/invalid cases')
