from pathlib import Path
import json
s=Path('work/prepare_sector498.py').read_text();start=s.index("s=Path('work/prepare_colour496.py')");s='from pathlib import Path\nimport ast,json,itertools\n'+s[start:]
s=s.replace('SectorInventory498_expanded.py','source_boundary_growth497.py').replace('SectorInventory','BoundaryMeasurement').replace('sector_witness498','boundary_witness499').replace('prepare_sector498_adapter','prepare_boundary499_adapter').replace('sector498_modules','boundary499_modules').replace('SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003','SFT-PHYS-MEAS-BOUNDARY-GROWTH-001').replace("'ColourCouplingDerivation','BoundaryMeasurement'","'ColourCouplingDerivation','BoundaryGrowthDiscriminator'").replace("['check0','check1','check2','check3','check4']","['check0','check1','check2']").replace('4096','1024').replace('with sector :=','with source :=').replace("'i==11'","'i==9'").replace("['rfl']*12","['rfl']*10").replace('range(12)','range(10)').replace('; cases h10; cases h11','')
s=s.replace("fields=['sector','charge','mediator','coupling','running','singlet','mixing','mass','inventory','measurement','record','extension']", "fields=['source','distance','response','scale','candidates','selection','stopping','target','record','extension']").replace("mods=['BoundaryMeasurement','BoundaryMeasurementGrammarBase']","mods=['BoundaryGrowthDiscriminator','BoundaryMeasurementGrammarBase']")
s=s.replace("Path('work/prepare_boundary499_adapter.py').write_text(s)","s=s.replace('reject the form missing the first structural preservation','reject the generated form missing the first preservation').replace('reject forbidden values, target feedback and extra laws','reject excluded capabilities, values or authority paths')\nPath('work/prepare_boundary499_adapter.py').write_text(s)")
Path('work/prepare_boundary499_generated.py').write_text(s)
w='''import SFT.Physics.BoundaryGrowthDiscriminator
namespace SFT.Physics.BoundaryMeasurementWitnesses
open BoundaryGrowthDiscriminator SFT.Physics.LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
'''
for i,call in enumerate(['checkedCompatible (.fraction (normalize 3 1 (by decide))) (.fraction (normalize 27 1 (by decide))) (.fraction (normalize 27 1 (by decide)))','checkedCompatible (.fraction (normalize 2 1 (by decide))) (.fraction (normalize 7 1 (by decide))) (.fraction (normalize 9 1 (by decide)))','checkedStopCertificate (normalize 5 2 (by decide)) (normalize 40 1 (by decide))']):
 expr='ns == [3]' if i<2 else 'ns'
 w+=f'def check{i} : Bool := match {call} with | .error _ => false | .ok ns => {expr}\ntheorem check{i}Passed : check{i} = true := rfl\n'
w+='def witnesses : List Witness := [WITNESS_ROWS]\ntheorem allWitnessesPass : witnesses.all Witness.passed = true := rfl\nend SFT.Physics.BoundaryMeasurementWitnesses\n'
Path('work/boundary_witness499.txt').write_text(w)
exec(compile(s,'boundary_adapter','exec'),{})
