from pathlib import Path
import sys,json,dataclasses,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((w/'pinned1318/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import molecular_dipole_law_v1 as src
from sft.claim_evidence import EMPTY_ONE,EmptyOne,PositiveRatio
from sft.engine.exact import HeldLabel,PositiveCount
from sft.engine.canonical import canonical_value
q=lambda s:json.dumps(s,ensure_ascii=False);pc=lambda n:'⟨'+str(n)+',by decide⟩';label=lambda x:'⟨'+q(x.family)+','+q(x.label)+',by decide,by decide⟩'
def ratio(x):return '⟨'+pc(x.numerator.value)+','+pc(x.denominator.value)+'⟩'
def native(x):return '⟨'+label(x.axis)+','+label(x.orientation)+','+ratio(x.magnitude)+'⟩'
cases=[];expected=[]
def case(fn,expression):
 try:out={'ok':canonical_value(fn())}
 except Exception as e:out={'error':str(e)}
 expected.append(out);cases.append(expression)
def component(i,n,d):return src.DipoleComponent(HeldLabel('dipole-axis','axis-'+str(i)),HeldLabel('held-dipole-orientation','side-'+str(i)),PositiveRatio.from_pair(n,d))
def squared(components):
 if isinstance(components,tuple):expr='(.tuple ['+','.join('(.component '+native(c)+')'if isinstance(c,src.DipoleComponent)else '.invalid'for c in components)+'])'
 else:expr='.other'
 case(lambda:src.exact_squared_magnitude(components),'heightResult (exactSquaredMagnitude '+expr+')')
squared(())
for n,d in itertools.product(range(1,5),range(1,4)):squared((component(1,n,d),))
for k in range(2,6):squared(tuple(component(i,i+1,i+2)for i in range(k)))
squared((component(1,3,5),component(2,4,5)));squared((component(1,1,2),component(1,3,4)));squared((None,));squared((component(1,1,1),None));squared([]);squared(None)
for axis,orientation,value in [(HeldLabel('wrong','a'),HeldLabel('held-dipole-orientation','o'),PositiveRatio.from_pair(1,2)),(HeldLabel('dipole-axis','a'),HeldLabel('wrong','o'),PositiveRatio.from_pair(1,2)),(HeldLabel('dipole-axis','a'),HeldLabel('held-dipole-orientation','o'),EMPTY_ONE),(HeldLabel('dipole-axis','a'),HeldLabel('held-dipole-orientation','o'),PositiveRatio.from_pair(2,4))]:
 expr='(.ratio '+ratio(value)+')'if isinstance(value,PositiveRatio)else '.emptyOne';case(lambda a=axis,o=orientation,v=value:src.DipoleComponent(a,o,v),'componentResult (component '+label(axis)+' '+label(orientation)+' '+expr+')')
def carrier_expr(c):return '⟨'+','.join(label(x)for x in [c.species,c.molecular_state,c.geometry,c.charge_distinction_carrier,c.symmetry])+',['+','.join(label(x)for x in c.component_axes)+'],'+label(c.magnitude_definition)+'⟩'
carriers=src.registered_molecular_dipole_carriers()
for c in carriers:case(lambda c=c:dict(carrier=c,magnitude_class=c.structural_magnitude_class),'carrierResult (validateCarrier '+carrier_expr(c)+')')
for field,value in [('species',HeldLabel('wrong','H2O')),('molecular_state',HeldLabel('wrong','state')),('geometry',HeldLabel('wrong','geometry')),('charge_distinction_carrier',HeldLabel('wrong','charge')),('symmetry',HeldLabel('molecular-symmetry','unregistered')),('component_axes',()),('component_axes',(HeldLabel('wrong','principal-b'),)),('magnitude_definition',HeldLabel('dipole-magnitude-definition','changed'))]:
 c=carriers[2];fields={f.name:getattr(c,f.name)for f in dataclasses.fields(c)};fields[field]=value
 # Render the exact invalid input without invoking Python's constructor early.
 from types import SimpleNamespace
 raw=SimpleNamespace(**fields)
 case(lambda fields=fields:src.MolecularDipoleCarrier(**fields),'carrierResult (validateCarrier '+carrier_expr(raw)+')')
header='''import SFT.Chemistry.MolecularDipoleMagnitude
open SFT.Chemistry.MolecularDipoleMagnitude SFT.Physics.CapabilityValues
open SFT.Chemistry.DihedralTorsion (Height)
abbrev J := SFT.Host.Canonical.Value
def error (s : String) : J := .object [("error",.text s)]
def heightResult : Except String Height → J
 | .error e => error e
 | .ok .emptyOne => .object [("ok",canonical (.emptyOne "empty-One"))]
 | .ok (.ratio r) => .object [("ok",canonical (.ratio r.numerator r.denominator))]
 | _ => error "unexpected height"
def componentValue (c : Component) : J := .object [("axis",canonical (.label c.axis)),
 ("orientation",canonical (.label c.orientation)),("magnitude",canonical (.ratio c.magnitude.numerator c.magnitude.denominator))]
def componentResult : Except String Component → J
 | .error e => error e
 | .ok c => .object [("ok",componentValue c)]
def carrierValue (c : Carrier) : J := .object [("species",canonical (.label c.species)),
 ("molecular_state",canonical (.label c.state)),("geometry",canonical (.label c.geometry)),
 ("charge_distinction_carrier",canonical (.label c.charge)),("symmetry",canonical (.label c.symmetry)),
 ("component_axes",.array (c.axes.map fun a => canonical (.label a))),("magnitude_definition",canonical (.label c.definition))]
def carrierResult : Except String Carrier → J
 | .error e => error e
 | .ok c => .object [("ok",.object [("carrier",carrierValue c),("magnitude_class",canonical (.label (structuralMagnitudeClass c)))])]
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
'''
(w/'MolecularDipoleCases1318.lean').write_text(header+',\n'.join(cases)+']))\n');(w/'dipole1318_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n');print('Prepared',len(cases),'original cases')
