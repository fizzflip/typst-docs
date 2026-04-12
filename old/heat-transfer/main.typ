// --- DOCUMENT SETUP ---
#set page(
  paper: "a4",
  margin: (x: 1in, y: 1in),
)

// Font Selection: Linux Libertine is a built-in, elegant serif font in Typst
#set text(
  //  font: "Linux Libertine",
  size: 12pt,
  lang: "en",
)

// Paragraph formatting
#set par(
  justify: true,
  leading: 0.8em,
  first-line-indent: 0em,
)

// Heading styling: No numbering, slightly larger
#set heading(numbering: none)
#show heading: it => block(above: 1.4em, below: 1em, it)

// --- TITLE ---
#align(center)[
  #text(size: 18pt, weight: "bold")[Report on Heat Transfer]
]

// --- INTRODUCTION ---
= Introduction

Heat transfer is a discipline of thermal engineering that concerns the generation, use, conversion, and exchange of thermal energy between physical systems. It is a fundamental phenomenon driven solely by temperature differences, serving as the mechanism by which internal energy flows from one body to another. The study of heat transfer is not merely a theoretical exercise; it is a critical component of physics and engineering that governs the performance of countless natural and engineered systems—from the regulation of global climate patterns and the metabolic processes of the human body to the cooling of high-performance electronics and the design of efficient power plants.



[Image of modes of heat transfer conduction convection radiation]


Unlike thermodynamics, which deals with systems in equilibrium and predicts the amount of energy required to change a system from one state to another, heat transfer focuses specifically on the *rate* at which this energy exchange occurs and the temperature distribution within the system over time. This distinction is vital for engineering applications where the speed of cooling or heating is the primary design constraint.

The process of heat transfer invariably follows the Second Law of Thermodynamics, proceeding spontaneously from a region of higher temperature to a region of lower temperature. This flow of energy continues until the system reaches a state of thermal equilibrium, where the temperature is uniform throughout, and the net heat flux drops to zero. To analyze these complex thermal interactions, the field is divided into three distinct but often simultaneous modes: *Conduction*, *Convection*, and *Radiation*. This report provides a comprehensive examination of these mechanisms, their governing laws, and their practical applications in modern technology.

// --- SECTION 1: CONDUCTION ---
= Conduction

Conduction is the mechanism of heat transfer that occurs between substances that are in direct physical contact. This process does not involve the bulk movement of the material itself. Instead, it occurs due to the exchange of kinetic energy at the microscopic level between the particles (atoms and molecules) of the substances.

#figure(
  image("conduction.svg", width: 70%),
  caption: [Heat conduction mechanism showing atomic vibration and electron movement.],
)

In solids, particularly metals, the primary means of conduction involves two phenomena:

- *Vibration of the atomic lattice:* Atoms and molecules vibrate more vigorously at higher temperatures. These vibrations are transmitted to adjacent, less energetic particles through collisions, passing the energy along the material structure.
- *Movement of free electrons:* In electrically conductive materials (like metals), a large number of free electrons move randomly throughout the material. These electrons carry kinetic energy and rapidly transfer it across the material through collisions with the atomic lattice and other electrons.

== The Phenomenological Law: Fourier's Law of Heat Conduction
The quantitative description of heat conduction is governed by Fourier's Law of Heat Conduction, a fundamental law derived from experimental observation, which states that the rate of heat transfer is proportional to the area perpendicular to the heat flow and the temperature gradient.

The one-dimensional form of Fourier's Law is expressed as:

$ H = (d Q) / (d t) = -k A (d T) / (d x) $

Where:
- $H$ is the rate of heat flow or heat current (measured in Watts, $W$ or $J\/s$).
- $k$ is the thermal conductivity of the material (in $W\/(m dot K)$). This material property indicates how readily a substance conducts heat.
- $A$ is the cross-sectional area perpendicular to the direction of heat flow (in $m^2$).
- $(d T) / (d x)$ is the temperature gradient (in $K\/m$). The gradient represents the rate of temperature change with distance.

The negative sign is a convention indicating that heat flows in the direction of decreasing temperature, following the second law of thermodynamics.

== Thermal Resistance
In the context of steady-state heat flow, it is often useful to draw an analogy between heat flow and electric current flow (Ohm's Law, $V = I R$). This analogy introduces the concept of Thermal Resistance ($R_(t h)$).

For a slab of material with thickness $L$, cross-sectional area $A$, and thermal conductivity $k$, the temperature difference $Delta T = T_("hot") - T_("cold")$ drives the heat flow $H$. Rearranging Fourier's Law:

$ H = (Delta T) / (L \/ k A) = (Delta T) / R_(t h) $

Therefore, the thermal resistance of a slab is:

$ R_(t h) = L / (k A) $

(Measured in $K\/W$ or $degree C\/W$).

== Conduction through Compound Structures
The concept of thermal resistance is particularly useful when analyzing heat flow through multiple layers of different materials, often referred to as a compound slab. This analysis assumes a steady-state condition where the temperature at any point in the material does not change over time, and the heat flow rate ($H$) is constant throughout the entire structure.

#figure(
  image("composite_slabs.jpg", width: 80%),
  caption: [Heat transfer through composite slabs arranged in series and parallel.],
)

=== Slabs in Series
When slabs are placed side-by-side, such that heat flows sequentially through each layer, they are considered to be in series. The total heat flow rate ($H$) is the same through every slab.

The total temperature difference across the entire structure is $Delta T_("total") = T_1 - T_n$. The total thermal resistance ($R_(t h, "total")$) is the sum of the individual thermal resistances:

$
  R_(t h, "total") = R_(t h, 1) + R_(t h, 2) + dots + R_(t h, n) = sum_i L_i / (k_i A)
$

The overall rate of heat flow is:

$
  H = (Delta T_("total")) / R_(t h, "total") = (A(T_1 - T_n)) / (sum_i (L_i \/ k_i))
$

This is an equivalent way to express the formula from the original table:

#table(
  columns: (1fr, 2fr),
  inset: 10pt,
  align: horizon,
  table.header([*Arrangement*], [*Rate of Heat Flow Formula*]),
  [Slabs in Series], $ H = (A(T_1 - T_2)) / (sum_i (L_i \/ k_i)) $,
)

_Note: The original table's formula uses $T_1$ and $T_2$ for the overall temperature difference, implying only two layers or the overall difference across the entire stack._

=== Slabs in Parallel
When slabs are arranged such that heat flows simultaneously through all of them, they are considered to be in parallel. In this case, the temperature difference ($Delta T$) is the same across all slabs, and the total heat flow is the sum of the heat flows through each path.

$ H_("total") = H_1 + H_2 + dots + H_n $

The reciprocal of the total thermal resistance is the sum of the reciprocals of the individual resistances (similar to parallel electrical resistors):

$ 1 / R_(t h, "total") = sum_i 1 / R_(t h, i) = sum_i (k_i A_i) / L $

The overall rate of heat flow is:

$ H = (Delta T) / R_(t h, "total") = (T_1 - T_2) sum_i (k_i A_i) / L $

This aligns with the formula presented in the original content:

#table(
  columns: (1fr, 2fr),
  inset: 10pt,
  align: horizon,
  table.header([*Arrangement*], [*Rate of Heat Flow Formula*]),
  [Slabs in Parallel], $ H = ((T_1 - T_2) sum_i (k_i A_i)) / L $,
)

Where $L$ is the common length for all slabs in parallel.

// --- SECTION 2: CONVECTION ---
= Convection

Convection is the mode of heat transfer that takes place due to the macroscopic, bulk movement of fluids (liquids or gases). Unlike conduction, convection involves the physical transport of matter (the fluid) that carries the thermal energy with it. This process is highly dependent on the fluid's properties, such as density and viscosity.

The process typically begins when a fluid comes into contact with a surface at a different temperature. A thermal boundary layer forms near the surface, where heat is transferred primarily by conduction. This heated/cooled fluid then moves away, mixing with the bulk fluid and transporting the thermal energy.

#figure(
  image("licensed-image.jpeg", width: 60%),
  caption: [Natural convection currents generated in a heated liquid.],
)

== Types of Convection
Convection is classified based on the mechanism that drives the fluid motion:

- *Natural (or Free) Convection:* The fluid motion is caused exclusively by density differences that arise from temperature variations within the fluid. For instance, when water is heated from the bottom, the water near the bottom expands, becomes less dense, and rises. Cooler, denser water sinks to replace it, creating a circulating current known as a convection current. Examples include:
  - Heating water in a pot.
  - Atmospheric circulation (wind and weather patterns).
  - Land and sea breezes near coastlines.
- *Forced Convection:* The fluid motion is induced by an external mechanical device, such as a pump, fan, blower, or stirrer. This external force overrides the natural buoyancy forces. Examples include:
  - A forced-air furnace circulating warm air through a house.
  - The cooling system (radiator and fan) in a car engine.
  - A fan blowing air over a hot electronic component (e.g., a computer's CPU heat sink).

== Newton's Law of Cooling (Convective Heat Loss)
While often referred to as Newton's Law of Cooling, the following equation describes the rate of heat transfer (loss or gain) by convection between a surface and a fluid:

$ (d Q) / (d t) = h A (T - T_s) $

Where:
- $(d Q) \/ (d t)$ is the rate of heat transfer (in $W$).
- $h$ is the convection heat transfer coefficient (in $W\/(m^2 dot K)$ or $W\/(m^2 dot degree C)$). This complex parameter is not a material property like $k$ (thermal conductivity); instead, it depends on the fluid's properties, the surface geometry, and the flow conditions (velocity, turbulence).
- $A$ is the surface area across which the heat transfer is taking place (in $m^2$).
- $T$ is the temperature of the body/surface (in $K$ or $degree C$).
- $T_s$ is the temperature of the surrounding fluid (in $K$ or $degree C$).

The equation shows that the rate of heat transfer is directly proportional to the surface area and the temperature difference between the surface and the fluid.

== Significance of Convection
Convection is an extremely efficient mode of heat transfer, which is why it is utilized in virtually all fluid-based thermal systems. Understanding the convection coefficient ($h$) is crucial in engineering design, as it dictates the required surface area for heat exchange in devices like heat exchangers, boilers, and condensers.

// --- SECTION 3: RADIATION ---
= Radiation

Radiation is the transfer of thermal energy through the emission and absorption of electromagnetic waves (primarily in the infrared region). Unlike conduction and convection, radiation does not require a material medium for propagation and is the only mode of heat transfer that can travel through a perfect vacuum. This is the mechanism by which the Sun's energy traverses the vacuum of space to reach the Earth.

Any object whose temperature is above absolute zero (0 K) emits thermal radiation. The intensity and spectrum of this radiation are highly dependent on the object's absolute temperature and the nature of its surface.

#figure(
  image("black_body.svg", width: 70%),
  caption: [Black body radiation spectrum showing intensity vs. wavelength for different temperatures.],
)

== The Ideal Radiator: The Black Body
A black body is an idealized physical body that absorbs all electromagnetic radiation incident upon it, regardless of frequency or angle of incidence. Because it absorbs all incident radiation, it appears black at room temperature. Crucially, a black body is also the most efficient possible emitter of thermal radiation at any given temperature.

== Stefan-Boltzmann Law
The Stefan-Boltzmann Law provides a quantitative relationship for the power radiated by a black body. It states that the total radiant heat energy emitted per unit surface area of a black body across all wavelengths per unit time ($E$) is directly proportional to the fourth power of the body's absolute temperature ($T$).

$ E = sigma T^4 $

Where:
- $E$ is the emissive power (energy radiated per unit area per unit time, in $W\/m^2$).
- $sigma$ is the Stefan-Boltzmann constant ($sigma = 5.67 times 10^(-8) "W"\/(m^2 dot K^4)$).
- $T$ is the absolute temperature of the body (in Kelvin, $K$).

== Real Bodies (Grey Bodies) and Emissivity
For a real object, often called a grey body, the energy radiated is less than that of an ideal black body. This reduction is accounted for by the emissivity ($e$), a dimensionless property of the surface that ranges from 0 to 1.

$ E = e sigma T^4 $

Where:
- $e$ is the emissivity of the surface. For a black body, $e = 1$. For a highly reflective surface (e.g., polished silver), $e$ is close to 0.

== Net Radiative Heat Exchange
When an object at temperature $T$ is situated within surroundings at temperature $T_s$, the object simultaneously emits radiation and absorbs radiation from the surroundings. The net rate of heat loss ($P_("net")$) due to radiation is the difference between the power emitted and the power absorbed:

$ P_("net") = (d Q) / (d t) = "Power Emitted" - "Power Absorbed" $

Assuming the surroundings also behave like a black body (or have the same emissivity as the object), the net rate of heat loss from a body with surface area $A$ is:

$ (d Q) / (d t) = e sigma A (T^4 - T_s^4) $

This is a critically important formula, as it governs the radiative cooling or heating of all objects exposed to their environment.

== Wien's Displacement Law
While the Stefan-Boltzmann Law determines the total energy radiated, Wien's Displacement Law determines the wavelength ($lambda_("max")$) at which the intensity of the radiation is a maximum.

$ lambda_("max") T = b $

Where $b$ is Wien's displacement constant ($b approx 2.898 times 10^(-3) "m" dot K$).

This law explains why hotter objects glow with light of a shorter wavelength (e.g., a piece of iron glows red, then white-hot as its temperature increases), and why the Sun (T $approx$ 5800 K) peaks in the visible light spectrum, while the Earth (T $approx$ 300 K) peaks in the infrared (heat) spectrum.

// --- SECTION 4: THERMAL EXPANSION ---
= Thermal Expansion of Solids and Liquids

When a substance is heated, the average kinetic energy of its constituent particles increases. While this explains the temperature rise, the actual expansion is due to the nature of the inter-atomic forces.

== Microscopic Origin of Expansion
At the atomic level, particles vibrate within a potential energy well. If this potential well were perfectly symmetric (like a simple harmonic oscillator), an increase in vibration amplitude would not change the average position of the particle. However, the inter-atomic potential is *asymmetric* (steeper at short distances due to repulsion and shallower at long distances due to attraction). As the vibrational energy increases with temperature, the particle spends more time at larger separations, causing the average inter-atomic distance to increase. This cumulative effect on a macroscopic scale manifests as thermal expansion.



== Linear Expansion
For one-dimensional solids (like a rod or a cable), the change in length ($Delta L$) is typically the most significant parameter. It is proportional to the original length ($L_0$) and the change in temperature ($Delta T$).

$ Delta L = alpha L_0 Delta T $

Where $alpha$ is the coefficient of linear expansion (in $K^(-1)$ or $degree C^(-1)$). The final length $L$ is:

$ L = L_0 (1 + alpha Delta T) $

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 8pt,
    align: (left, center),
    table.header([*Material*], [*Coefficient* $alpha$ ($10^(-6) \/ K$)]),
    [Aluminum], [23],
    [Copper], [17],
    [Steel], [11 -- 13],
    [Glass (Pyrex)], [3.2],
    [Invar (Fe-Ni alloy)], [0.7],
  ),
  caption: [Typical Coefficients of Linear Expansion ($alpha$) at 20$degree$C],
)

== Area Expansion
For two-dimensional solids (like a metal plate or a hole in a washer), the change in area ($Delta A$) is proportional to the original area ($A_0$) and the change in temperature ($Delta T$).

$ Delta A = beta A_0 Delta T $

Where $beta$ is the coefficient of area (or superficial) expansion. For isotropic materials, the relationship is governed by geometry:
$ beta approx 2 alpha $

== Volume Expansion
For three-dimensional solids and liquids, the change in volume ($Delta V$) is the most relevant property.

$ Delta V = gamma V_0 Delta T $

Where $gamma$ is the coefficient of volume expansion. For isotropic solids, $gamma approx 3 alpha$. Liquids generally have much higher volume expansion coefficients than solids because their intermolecular forces are weaker.

== Thermal Stress
If a material is prevented from expanding or contracting—for example, a steel beam rigidly fixed at both ends—significant internal forces are generated. This is known as thermal stress.
If a rod of length $L_0$ is clamped so it cannot expand by $Delta L = alpha L_0 Delta T$, the compressive stress ($sigma$) developed is:

$ sigma = F / A = -E alpha Delta T $

Where $E$ is the Young's Modulus of the material. This force can be immense, sufficient to buckle railway tracks or crack concrete, necessitating the use of expansion joints in bridges and buildings.



== Applications: The Bimetallic Strip
A practical application of differential expansion is the bimetallic strip. Two strips of metals with different expansion coefficients (e.g., brass and steel) are bonded together. When heated, the strip with the higher $alpha$ expands more, causing the composite strip to bend towards the side of the metal with the lower $alpha$.



This principle is widely used in mechanical thermostats, circuit breakers, and thermometers.

== Anomalous Expansion of Water
//Water exhibits a unique and ecologically vital behavior near its freezing point. Unlike most substances that continually contract as they cool, water contracts as it cools down to $4^{circ} C$, but then _expands_ as it cools further from $4^circ C$ to $0^circ C$.
//


//This means water reaches its maximum density at $4^circ C$ ($1000 "kg"/m^3$). As a result, ice ($0^circ C$) is less dense than liquid water and floats. In winter, this allows the top layer of a lake to freeze while the deeper water remains liquid at $approx 4^circ C$, preserving aquatic life.

// --- SECTION 5: CALORIMETRY ---
= Calorimetry and Phase Changes

Calorimetry is the science of measuring heat flow. It relies on the principle of conservation of energy (the first law of thermodynamics).

== Specific Heat Capacity
The specific heat capacity ($c$) of a substance is the amount of heat energy ($Q$) required to raise the temperature of a unit mass ($m$) of that substance by one degree (Celsius or Kelvin).

$ Q = m c Delta T $

//Where $Q$ is the heat energy (in $J$), $m$ is the mass (in $kg$), and $c$ is the specific heat capacity (in $J\/(kg dot K)$).
//
== Latent Heat
A phase change (e.g., melting, boiling) occurs at a constant temperature. The heat energy required to change the state of a substance without changing its temperature is called latent heat ($L$).

$ Q = m L $

- *Latent Heat of Fusion ($L_f$):* The heat required per unit mass to change a substance from solid to liquid (melting) or from liquid to solid (freezing).
- *Latent Heat of Vaporization ($L_v$):* The heat required per unit mass to change a substance from liquid to gas (boiling/vaporization) or from gas to liquid (condensation).



[Image of heating curve of water phase change]


== Principle of Calorimetry
When two bodies (or a body and its surroundings) are brought together, the heat lost by the hot body must equal the heat gained by the cold body, assuming an isolated system:

$ "Heat Lost" = "Heat Gained" $
$ (m_1 c_1 Delta T_1) = (m_2 c_2 Delta T_2) $

This principle is fundamental to experiments involving mixtures and temperature determination.

// --- SECTION 6: SUMMARY AND COMPARATIVE ANALYSIS ---
= Summary and Comparative Analysis

Understanding when and how each mode of heat transfer dominates is key to solving real-world thermal problems. While the modes are often taught in isolation, they rarely occur that way in practice.

== Comparative Overview
The following table summarizes the fundamental differences between the three modes.

#figure(
  table(
    columns: (1.5fr, 3fr, 1.5fr, 2fr, 2fr),
    inset: 8pt,
    align: (left, left, left, left, left),
    table.header(
      [*Mode*],
      [*Mechanism*],
      [*Medium Required*],
      [*Driving Potential*],
      [*Governing Law*],
    ),
    [*Conduction*],
    [Microscopic collision of particles and movement of electrons.],
    [Yes (Solid, Liquid, Gas)],
    [Temp. Gradient ($nabla T$)],
    [Fourier's Law],

    [*Convection*],
    [Macroscopic bulk motion of fluid mixing with conduction.],
    [Yes (Fluid)],
    [Temp. Difference ($Delta T$)],
    [Newton's Law of Cooling],

    [*Radiation*],
    [Emission and absorption of electromagnetic waves.],
    [No (Vacuum or transparent)],
    [Diff. of fourth powers ($T^4 - T_s^4$)],
    [Stefan-Boltzmann Law],
  ),
  caption: [Comparison of Heat Transfer Modes],
)

== Coupled Heat Transfer
In most engineering scenarios, multiple modes of heat transfer occur simultaneously. This is known as multimode or coupled heat transfer. The total heat transfer rate is the sum of the rates from individual modes.



Consider the classic example of a hot coffee mug sitting on a table:
- *Conduction:* Heat flows through the ceramic wall of the mug to the outer surface. Heat also conducts from the bottom of the mug directly into the table.
- *Natural Convection:* The air adjacent to the hot outer surface of the mug warms up, rises, and is replaced by cooler air, carrying heat away.
- *Radiation:* The hot surface of the mug emits infrared radiation to the cooler walls of the room.
- *Evaporation (Latent Heat):* Water molecules with high kinetic energy escape from the liquid surface, removing significant energy (phase change cooling).

== Dominance of Modes
Determining which mode dominates is critical for simplifying analysis:
1. *Solids:* Conduction is usually the only mode, unless the solid is transparent to radiation (like glass at high temperatures).
2. *Fluids:* Convection usually dominates over conduction, except in very thin fluid layers (boundary layers) or highly viscous fluids where motion is restricted.
3. *Vacuum:* Radiation is the _only_ mechanism.
4. *High Temperatures:* Radiation becomes significant because it scales with $T^4$. For example, in a boiler furnace, radiation accounts for the majority of heat transfer, whereas at room temperature, it is often negligible compared to convection.

== Thermal Circuits
Complex problems are often modeled using the electrical analogy.
- *Series Circuit:* Heat flows through a wall (resistance 1) and then convects to the air (resistance 2). $R_("total") = R_("cond") + R_("conv")$.
- *Parallel Circuit:* Heat leaves a surface via both convection and radiation simultaneously. $1 / R_("total") = 1 / R_("conv") + 1 / R_("rad")$.

// --- SECTION 7: APPLICATIONS ---
= Applications and Engineering Relevance

The principles of heat transfer are not merely academic concepts; they form the bedrock of numerous engineering applications essential to modern life. From keeping our homes habitable to managing the thermal loads of high-performance computing, these applications rely on manipulating the rates of conduction, convection, and radiation.

== Thermal Insulation (Conduction)
Reducing heat transfer is often as important as enhancing it. Insulation materials act as thermal barriers to maintain temperature gradients.

=== Mechanisms of Insulation
Most insulators (like Styrofoam, fiberglass, mineral wool, or aerogel) function by trapping pockets of gas (usually air) within a solid matrix. Since air has an extremely low thermal conductivity ($k approx 0.026 "W/mK"$) compared to solids, preventing the air from circulating (suppressing convection) results in a material with high thermal resistance.



=== Building Insulation and R-Value
In the construction industry, the insulating power of a material is rated by its *R-value*, which is a measure of thermal resistance per unit area.

$ "R-value" = (Delta T) / dot(q)'' = L / k $

Where $L$ is thickness and $k$ is thermal conductivity. Higher R-values indicate better insulating properties. Double-glazed windows utilize this principle by sandwiching a layer of inert gas (argon or krypton) between two panes of glass to reduce conductive and convective losses.

=== Vacuum Insulation
The most effective insulation eliminates the medium entirely. Cryogenic storage tanks and high-end thermos flasks use a vacuum jacket (Dewar flask). By removing the air, conduction and convection are eliminated, leaving only radiation, which is minimized by silvering the surfaces to reduce emissivity ($e$).

== Heat Exchangers (Convection)
Heat exchangers are devices designed to efficiently transfer heat from one fluid to another without mixing them. They are ubiquitous in engineering.



[Image of shell and tube heat exchanger diagram]


=== Flow Arrangements
The efficiency of a heat exchanger depends heavily on the direction of fluid flow:
- *Parallel Flow:* Both fluids enter at the same end and flow in the same direction. The outlet temperature of the cold fluid can never exceed the outlet temperature of the hot fluid.
- *Counter Flow:* Fluids enter at opposite ends and flow in opposite directions. This maintains a nearly constant temperature difference ($Delta T$) across the length of the exchanger. Crucially, the cold fluid can exit at a temperature _higher_ than the hot fluid's exit temperature, making this arrangement thermodynamically superior.
- *Cross Flow:* Fluids move perpendicular to each other (common in car radiators).



=== Common Applications
- *HVAC Systems:* Evaporators and condensers transfer heat between refrigerant and air to cool or heat buildings.
- *Power Plants:* Boilers and condensers are massive heat exchangers used to generate steam from combustion gases and condense it back to water using cooling towers.
- *Automotive Radiators:* A liquid-to-air exchanger that uses forced convection (fan and vehicle motion) to reject engine waste heat.

== Electronics Cooling (Heat Pipes and Heat Sinks)
As microprocessors become more powerful, the heat flux (power density) increases, requiring advanced thermal management to prevent failure.

=== Finned Heat Sinks
To increase the rate of convective cooling ($dot(Q) = h A Delta T$), engineers attach metal components with fins to the heat source. This drastically increases the surface area ($A$) available for heat transfer to the air.

=== Heat Pipes
A heat pipe is a passive, two-phase heat transfer device with extremely high effective thermal conductivity (often $100 times$ better than copper).
1. *Evaporation:* A working fluid (like water or ammonia) vaporizes at the hot interface (CPU), absorbing latent heat.
2. *Transport:* The vapor travels to the cold end of the pipe.
3. *Condensation:* The vapor condenses back into a liquid, releasing the latent heat to the fins.
4. *Return:* The liquid returns to the hot end via capillary action through a wick structure.



== Radiative Cooling and Heating
Radiative heat transfer is employed in applications where conduction and convection are insufficient or impossible.

- *Solar Thermal Collectors:* These devices use "selective surfaces" that have high absorptivity ($alpha$) in the solar spectrum (visible light) but low emissivity ($e$) in the infrared spectrum. This allows them to absorb sunlight efficiently while minimizing heat loss back to the environment.
- *Spacecraft Thermal Control:* In the vacuum of space, radiation is the only way to reject heat. Spacecraft are wrapped in Multi-Layer Insulation (MLI)—blankets of highly reflective aluminized Mylar—to block solar radiation. Conversely, "radiators" (panels with high emissivity) face deep space to dump internal waste heat.
- *Thermal Imaging:* Infrared cameras detect radiation emitted by objects in the $8-14 mu m$ range. Since emission is a function of temperature ($E = e sigma T^4$), these cameras can map temperature distributions non-intrusively, used in everything from medical diagnostics to finding electrical faults in grid infrastructure.

// --- SECTION 8: UNSTEADY-STATE HEAT TRANSFER ---
= Unsteady-State (Transient) Heat Transfer

Up to this point, our analysis has primarily focused on steady-state heat transfer, where the temperature at any point in the body does not change with time. Transient or unsteady-state heat transfer, however, involves temperature changing over time.

== Lumped Capacitance Method
For small objects with high thermal conductivity (where the internal thermal resistance is very small compared to the external convective resistance), the temperature throughout the object can be assumed to be uniform at any given instant. This simplifies the analysis greatly. This approach is called the Lumped Capacitance Method.

The temperature of the object ($T$) as a function of time ($t$) when cooling in a surrounding fluid ($T_infinity$) is given by:

$ (T(t) - T_infinity) / (T_i - T_infinity) = e^(-((h A) / (rho V c_p)) t) $

Where:
- $T_i$ is the initial temperature.
- $rho$ is the density of the object.
- $V$ is the volume of the object.
- $c_p$ is the specific heat capacity.

The term in the exponent, $h A \/ (rho V c_p)$, has units of $1\/"time"$ and is related to the rate of cooling.

== Characteristic Time and Biot Number
Two important dimensionless numbers are used to evaluate the validity of the lumped capacitance model:

*Biot Number (Bi):* Compares the internal conductive resistance to the external convective resistance.
$ "Bi" = (h L_c) / k $
Where $L_c$ is the characteristic length ($V\/A$). If $"Bi" < 0.1$, the lumped capacitance model is generally valid, indicating that heat is transferred internally much faster than it is transferred externally.

*Fourier Number (Fo):* Represents the ratio of heat conduction rate to the rate of thermal energy storage. It is used in more complex transient analyses.

The study of transient heat transfer is vital for predicting the time required for a material to heat up or cool down, which is essential in processes like curing, annealing, and food preservation.

// --- SECTION 9: ENVIRONMENTAL ---
= Environmental and Global Heat Transfer

Heat transfer principles govern planetary and atmospheric dynamics.

== Atmospheric Convection
The Earth's climate is driven by massive convection currents. Solar radiation (radiation) heats the Earth's surface unevenly. The heated air rises, and cooler air sinks, creating atmospheric pressure differences that manifest as wind. This large-scale convection distributes heat around the globe, regulating temperature extremes.

== Greenhouse Effect (Radiation)
The greenhouse effect is a phenomenon based on selective radiation absorption. The Earth's atmosphere is transparent to incoming short-wavelength solar radiation. The Earth's surface absorbs this energy, heats up, and re-emits it as long-wavelength infrared (heat) radiation. Greenhouse gases (like $"CO"_2$ and water vapor) absorb this outgoing infrared radiation, trapping heat within the atmosphere and maintaining a habitable global temperature.



[Image of greenhouse effect mechanism]


// --- SECTION 10: MEASURING TEMPERATURE ---
= Measuring Temperature

Accurate measurement of temperature is essential for all heat transfer applications. Thermometry is the field dedicated to this measurement.

== Temperature Scales
The three most common temperature scales are:
- *Celsius ($degree C$):* Based on the freezing point of water ($0degree C$) and the boiling point of water ($100degree C$).
- *Fahrenheit ($degree F$):* An older scale still used in some countries.
- *Kelvin ($K$):* The absolute thermodynamic temperature scale. $0 K$ (absolute zero) is the point at which all thermal motion ceases.

Conversion Formulas:
$ T(K) = T(degree C) + 273.15 $
$ T(degree F) = 9 / 5 T(degree C) + 32 $

== Thermometers
Thermometers rely on a thermometric property (a physical property that changes linearly with temperature) to measure temperature.

#table(
  columns: (1.5fr, 3fr, 2fr),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Thermometer Type*], [*Thermometric Property*], [*Typical Range*]
  ),
  [Liquid-in-glass],
  [Volume expansion of liquid (e.g., Mercury, Alcohol)],
  [-39$degree C$ to 357$degree C$],

  [Resistance Temperature Detector (RTD)],
  [Electrical resistance of a metal (e.g., Platinum)],
  [-200$degree C$ to 850$degree C$],

  [Thermocouple],
  [Seebeck effect (voltage generated between two dissimilar metals)],
  [Very wide range],

  [Pyrometer],
  [Thermal radiation emitted ($E prop T^4$)],
  [High temperatures only (> 600$degree C$)],
)

The choice of thermometer depends on the required accuracy, range, and the specific application environment.
