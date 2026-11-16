from pathlib import Path
import sys,json,subprocess,os,hashlib
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import particle_mode_generation_terminal_law_v1 as original
q=lambda s:json.dumps(s,ensure_ascii=False)
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return [cv(v)for v in x]
 if isinstance(x,dict):return {k:cv(v)for k,v in x.items()}
 return x
def count(x):return '.boolean '+str(x).lower() if type(x)is bool else '.integer ('+str(x)+')'
def val(x):
 if x is None:return '.null'
 if type(x)is bool:return '.boolean '+str(x).lower()
 if type(x)is int:return '.integer ('+str(x)+')'
 if type(x)is str:return '.text '+q(x)
 if type(x)is list:return '.array ['+','.join(val(v)for v in x)+']'
 if type(x)is dict:return '.object ['+','.join('('+q(k)+','+val(v)+')'for k,v in x.items())+']'
 raise TypeError(x)
items=[]
for f in [False,True,-1,0,1,2,3,4,5]:
 for v in [-1,0,1,2,3,4,8,27,81]:items.append(('least_cover_depth',[f,v]))
for n in list(range(1,41))+[64,129]:items.append(('place_recurrent_particle_modes',[[f'trace-{i}'for i in range(n)]]))
for xs in [[],['a','a'],[''],['a',''],[1],[True],[None],[[]],[{}],['a',[]],[1,{}],['é','λ','粒子']]:items.append(('place_recurrent_particle_modes',[xs]))
for d in [False,True,-2,0]+list(range(1,25))+[64,128]:items.append(('colour_binary_dual',[d]))
for name in ['generation_coordinates','transition_mode_certificate','mass_pattern_transport','theorem_certificate']:items.append((name,[]))
s='''import SFT.Physics.ParticleModeCertificate
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.ParticleModeCertificate SFT.Physics.LeptonIntervals SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def n (v : Nat) : Value := .integer (.ofNat v)
def ratio (v : Rat) : Value := .array [.integer v.num,n v.den]
def rats (vs : List Rat) : Value := .array (vs.map ratio)
def ns (vs : List Nat) : Value := .array (vs.map n)
def enc {α : Type} (f : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",f v)]
def coordinates (v : ParticleModeCoordinates.Coordinates) : Value := .object [("labels",ns v.labels),("half_fibre",rats v.halfFibre),("one_fibre",rats v.oneFibre),("fixed_five",rats v.fixedFive),("quarter_modes",rats v.quarterModes),("all_three",.boolean v.allThree),("order_isomorphic",.boolean v.orderIsomorphic),("coordinates_are_mass_values",.boolean v.coordinatesAreMassValues)]
def transition (v : ParticleModeCoordinates.Transition) : Value := .object [("sites",rats v.sites),("adjacent",rats v.adjacent),("outer",ratio v.outer),("separation_units",ns v.separationUnits),("squared_multiplicity",ns v.squaredMultiplicity),("separations_are_universal_observed_mixing_rates",.boolean v.universalObservedMixingRates),("terminal_mixing_carriers_required",.boolean v.terminalMixingCarriersRequired),("complete",.boolean v.complete)]
def cover (v : ParticleModeCover.Cover) : Value := .object [("factor",n v.factor),("volume",n v.volume),("depth",n v.depth),("prior_capacity",n v.priorCapacity),("capacity",n v.capacity),("minimal",.boolean v.minimal)]
def placement (v : ParticleModePlacement.Placement) : Value := .object [("trace_count",n v.traceCount),("depth",n v.depth),("capacity",n v.capacity),("placements",.array (v.placements.map (fun (s,r)=>.array [.text s,ratio r]))),("complete",.boolean v.complete),("injective",.boolean v.injective),("internal_depth_not_spatial_dimension",.boolean v.internalDepthNotSpatialDimension)]
def transport (v : ParticleModeTransport.Transport) : Value := .object [("generation_labels",ns v.generationLabels),("site_coordinates",.object [("half_fibre",rats v.halfFibre),("one_fibre",rats v.oneFibre),("fixed_five",rats v.fixedFive),("quarter_modes",rats v.quarterModes)]),("charged_lepton_cubic_pair_sum",ratio v.chargedLeptonCubicPairSum),("charged_lepton_cubic_product",ratio v.chargedLeptonCubicProduct),("down_quark_cubic",rats v.downQuarkCubic),("up_quark_cubic",rats v.upQuarkCubic),("neutrino_mass_squares",.object (v.neutrinoMassSquares.map (fun (k,r)=>(k,ratio r)))),("site_order_selects_root_order_only",.boolean v.siteOrderSelectsRootOrderOnly),("old_site_fraction_equals_mass_claim_rejected",.boolean v.oldSiteFractionEqualsMassClaimRejected),("complete_sector_table",.boolean v.completeSectorTable)]
def cert (v : Certificate) : Value := .object [("fibres",.boolean v.fibres),("coordinates",.boolean v.coordinates),("cover",.boolean v.cover),("placement",.boolean v.placement),("mass",.boolean v.mass),("dual",.boolean v.dual),("reach",.boolean v.reach),("transition",.boolean v.transition)]
'''
expected=[]
for name,args in items:
 try:expected.append({'ok':cv(getattr(original,name)(*args))})
 except (ValueError,TypeError) as e:expected.append({'error':str(e)})
 if name=='least_cover_depth':expr=f'enc cover (ParticleModeCover.leastCoverDepth ({count(args[0])}) ({count(args[1])}))'
 elif name=='place_recurrent_particle_modes':expr='enc placement (ParticleModePlacement.placeRecurrentParticleModes ['+','.join(val(v)for v in args[0])+'])'
 elif name=='colour_binary_dual':expr=f'enc ratio (ParticleModeTransport.colourBinaryDual ({count(args[0])}))'
 else:expr={'generation_coordinates':'enc coordinates ParticleModeCoordinates.generationCoordinates','transition_mode_certificate':'enc transition ParticleModeCoordinates.transitionModeCertificate','mass_pattern_transport':'enc transport ParticleModeTransport.massPatternTransport','theorem_certificate':'enc cert theoremCertificate'}[name]
 s+='#eval IO.println (render ('+expr+'))\n'
p=w/'particlemode1056_operations_cases.lean';p.write_text(s);x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'particlemode1056_operations_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];actual=[json.loads(t)for t in x.stdout.splitlines()];assert actual==expected,[(items[i],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1]
mods=['ParticleModeCover','ParticleModeCoordinates','ParticleModeTransport','ParticleModePlacement','ParticleModeCertificate'];(w/'particlemode1056_operations_report.json').write_text(json.dumps(dict(status='PASS',cases=len(items),source_operation=sorted(set(n for n,a in items)),source_sha256=hashlib.sha256((w/'particlemode1055_law.py').read_bytes()).hexdigest(),native_sha256={m:hashlib.sha256((r/f'SFT/Physics/{m}.lean').read_bytes()).hexdigest()for m in mods},all_fields_and_errors=True),indent=2));print('PASS',len(items),'complete records and errors, original V3 operations')
