from pathlib import Path
w=Path('work')
s=(w/'prepare_thermalequilibrium1036_grammar.py').read_text().replace('equilibrium1035_law.py','spinstatistics1043_law.py').replace('thermal_equilibrium_response_terminal_law_v1','spin_statistics_condensation_terminal_law_v1').replace('thermalequilibrium1036_spec','spinstatistics1046_spec').replace('ThermalEquilibriumResponse','SpinStatisticsCondensation').replace('memMap _ noise _ hnoise','memMap _ ground _ hground')
exec(compile(s,'adapted_original_8axis_generator','exec'))
