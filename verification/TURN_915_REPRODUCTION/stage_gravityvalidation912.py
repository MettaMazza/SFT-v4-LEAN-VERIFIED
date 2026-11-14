from pathlib import Path
import sys,json,subprocess,hashlib
w=Path('work');v=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform';sys.path.insert(0,str(v.resolve()))
from sft.physics import gravity_spacetime_validation_v1 as src
paths=['sft/physics/gravity_spacetime_validation_v1.py',src.SOURCE_PATH]+[str(Path(src.SOURCE_PATH).parent/k) for k in src.COMPONENTS]
identity={}
for p in paths:
 original=subprocess.check_output(['git','-C',repo,'show',pin+':'+p]);assert (v/p).read_bytes()==original,p;identity[p]=hashlib.sha256(original).hexdigest()
record=src.authoritative_record(v.resolve());(w/'gravityvalidation912_original_record.json').write_text(json.dumps(record,indent=2));(w/'gravityvalidation912_original_classifications.json').write_text(json.dumps(record['complete_classification'],indent=2));(w/'gravityvalidation912_source_identity.json').write_text(json.dumps(identity,indent=2))
s=(w/'prepare_fieldvalidation895.py').read_text().replace('relativistic_field_validation_v1','gravity_spacetime_validation_v1').replace('FieldAuthoritative','GravityAuthoritative').replace('fieldvalidation','gravityvalidation').replace('895','912')
a=s.index('items=');b=s.index('\ncorr=',a)
s=s[:a]+"items=[('CLOCK','GravityClockValidation',912,'clock','weak_gravity_clock_equivalence'),('WAVE','GravityWaveValidation',913,'wave','gravitational_waves'),('HORIZON','GravityHorizonValidation',914,'horizon','horizons_information'),('NONSTANDARD','NonstandardSpacetimeValidation',915,'nonstandard','nonstandard_spacetime')]"+s[b:]
s=s.replace('RELATIVISTIC-FIELD-AUTHORITATIVE-1971-2026','GRAVITY-SPACETIME-AUTHORITATIVE-2017-2026').replace('(.integer 12)','(.integer 13)').replace('relativistic-field source record boundary changed','gravity/spacetime seal boundary changed').replace('complete relativistic-field source vector requires seven sources','gravity/spacetime complete source vector changed').replace('sources.length != 7','sources.length != 6').replace('controls.length != 5','controls.length != 6').replace('complete unfavorable-control vector changed','gravity/spacetime complete source vector changed').replace('relativistic-field component snapshot identity changed','gravity/spacetime component identity changed').replace('relativistic-field source record identity changed','gravity/spacetime source record identity changed').replace('authoritative classification row is missing','gravity/spacetime classification missing').replace('authoritative relativistic-field classification changed','gravity/spacetime authoritative classification changed')
# V3 checks source and unfavorable-row counts before component digests.
s=s.replace(' let record ← payloadBoundary payload\n checkComponents files record\n controlsBoundary record',' let record ← payloadBoundary payload\n let checked ← controlsBoundary record\n checkComponents files checked\n pure checked')
(w/'prepare_gravityvalidation912.py').write_text(s)
print('Pinned source, entire original record and component identities verified; prepared exact source generator')
