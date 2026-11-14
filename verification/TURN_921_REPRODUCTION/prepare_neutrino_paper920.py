from pathlib import Path
import shutil,datetime
w=Path('work');items=[('neutrinosplitting',920,'NeutrinoSplittingEntry','NEUTRINO_SPLITTING',792,'Exact neutrino splitting ladder','neutrino_splitting_structure and NEUTRINO_SPLITTING_SPEC','''The existing least-cover construction supplies the down depth d=5 and the binary carrier b=2. The source mersenne_count operation composes the existing exact positive power and positive predecessor operations:

M(n)=bⁿ−1.

At the source's two prescribed depths,

M(d)=2⁵−1=31,
M(2d)=2¹⁰−1=1023.

Their ratio closes by factorization:

2²ᵈ−1=(2ᵈ−1)(2ᵈ+1),
M(2d)/M(d)=1023/31=33=2⁵+1.

The independent translation route uses the generated covering count b+c=2+3=5, its square 25 and positive predecessor 24. The complete depth-five cell is 1/32, so

t=(1/2⁵)·((5²−1)/5²)
 =(1/32)·(24/25)
 =24/800=3/100.

NeutrinoLadder.neutrinoSplittingStructure executes both routes and checks both exact equalities before returning solar rung, atmospheric rung, rung ratio and translation ratio. completeSplitting proves all four fields; countRatioCrossLock and exactTranslation prove the two displayed numerical identities. mersenneCount delegates to the existing source-bound power and predecessor operations, preserving their input guards. Its fresh source comparison includes positive depths and rejected zero, negative and Boolean inputs.

The source base retains the 31 non-unison positions at depth five. The successor doubles the reach to 1023 positions while retaining the separate depth-five cell and covering-square predecessor route. The two ratios retain their distinct source roles: 33 is the non-unison rung ratio and 3/100 is the physical translation ratio. They are not interchanged or fitted to a measured splitting.'''),('neutrinomass',921,'NeutrinoMassEntry','NEUTRINO_MASS',793,'Positive absolute-neutrino mass-square structure','neutrino_mass_squares and NEUTRINO_MASS_SPEC','''The original operation uses the first positive cell of the complete depth-five support. In units of the sealed solar splitting carrier, the lightest coefficient is

μ₁=1/2⁵=1/32.

The next coefficient adds one solar splitting. The heavy coefficient adds the reciprocal of the preceding physical splitting ratio t=3/100:

μ₂=μ₁+1=1/32+32/32=33/32,
μ₃=μ₁+1/t=1/32+100/3
   =3/96+3200/96=3203/96.

Their exact differences are

μ₂−μ₁=1,
μ₃−μ₁=100/3,
μ₃−μ₂=97/3>0.

Together with μ₁=1/32>0, these establish positive normal ordering:

0<1/32<33/32<3203/96.

NeutrinoLadder.neutrinoMassSquares obtains the cover and splitting from the existing source operations, executes these additions and checks the complete strict ordering. completeMassSquares proves the full three-field result; strictPositiveOrdering proves the original positivity and ordering checks. The original witness compares all three exact coefficients.

The base is the first positive depth-five cell, rather than a numerical zero. The successor adds the already sealed solar and atmospheric differences; no adjustable lightest mass is introduced. The source explicitly states the dimensional boundary: the coefficients are in solar-splitting units, and conversion to eV requires one declared post-seal solar anchor. That measured unit conversion does not select or alter the three coefficients.''')]
for low,n,tag,key,sec,title,source,body in items:
 for suffix in ['science_report.json','core_audit.log','core_build.log']:shutil.copy2(w/('neutrinoladder920_'+suffix),w/(low+str(n)+'_'+suffix))
 s=(w/'register_ckmphysical918.py').read_text().replace("'MatterIdentityGraphs':'Original ckm_physical_identity five-field symbolic graph and proton_electron_identity three-field graph,existing generated counts,exact rational divisions and complete original field proofs.'","'NeutrinoLadder':'Original mersenne_count input guards and power/predecessor composition,complete four-field neutrino_splitting_structure with both cross-locks,and three-field neutrino_mass_squares with strict positive ordering.'").replace('Original entry-specific exact apex or polynomial/share witness through the source identity.','Original exact splitting-ratio or full mass-square witness through the source operation.').replace('check_matteridentity918.py','check_neutrinoladder920.py');(w/f'register_{low}{n}.py').write_text(s)
 shared='The original eight binary axes generate the complete 256-form product. The relation, carrier and dependency axes retain the constructions above; the remaining axes preserve complete enumeration, omission rejection, seal-before-comparison, complete polynomial and control records, and no extra rule. The native entry retains every original candidate, elimination decision, witness, control and closure field.'
 (w/f'paper_{low}{n}_addition.txt').write_text(f'\n{sec}. {title}\n\n'+body+'\n\n'+shared+f'\n\nOriginal V3: sft/physics/matter_flavour_laws_v1.py, mersenne_count, {source}; existing atomic_constants and structural_constants operations. Pin: 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: NeutrinoLadder and {tag}Witnesses/Grammar/Controls/Evidence. Timeline: TURN{n}. Receipt: verification/TURN_{n}_{key}_COMPLETION.json.\n\n[Original source](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/matter_flavour_laws_v1.py); [Native derivation](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/NeutrinoLadder.lean); [Full grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/{tag}Grammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).\n')
 (w/f'timeline{n}_addition.txt').write_text('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+f' — TURN{n}: implemented original {source} with reused generated cover,power,predecessor and exact arithmetic operations. Shared12-declaration core audit empty;complete original4+3 fields and9 count/domain cases match. Native comparison driver required explicit CountInput list annotation;fixed driver without changing scientific operations. Existing full256 grammar and program checks required by registrar before completion. Prepared mathematical section{sec} with intermediate arithmetic,original scientific roles and empirical boundary,source/Lean/timeline references.\n')
print('Prepared sections792–793 and original-entry registrars')
