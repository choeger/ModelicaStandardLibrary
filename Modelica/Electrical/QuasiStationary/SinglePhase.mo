within Modelica.Electrical.QuasiStationary;
package SinglePhase "Single phase AC components"
  extends Modelica.Icons.Library2;

  package Basic "Basic components for AC singlephase models"
    extends Modelica.Icons.Library2;

    model Ground "Electrical ground"

      Interfaces.PositivePin pin
        annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
    equation
      pin.v = Complex(0);
      annotation (Icon(graphics={
            Line(points={{-60,50},{60,50}}),
            Line(points={{-40,30},{40,30}}),
            Line(points={{-20,10},{20,10}}),
            Line(points={{0,90},{0,50}}),
            Text(extent={{100,-40},{-100,0}}, textString=
                                                "%name")}),
        Documentation(info="<html>
<p>
Ground of a single phase circuit. The potential at the ground node is zero.
Every electrical circuit, e.g. a series resonance
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.Examples.SeriesResonance\">
          example</a>, has to contain at least one ground object.
</p>

</html>"));
    end Ground;

    model Resistor "Singlephase linear resistor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Resistance R_ref(start=1)
        "Reference resistance at T_ref";
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
      Modelica.SIunits.Resistance R_actual
        "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
      R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
      v = R_actual*i;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name"),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                  "R=%R_ref")}),
        Documentation(info="<html>
<p>
The linear resistor connects the complex voltage <i><u>v</u></i> with the complex
current <i><u>i</u></i> by <i><u>i</u>*R = <u>v</u></i>.
The resistance <i>R</i> is allowed to be positive, zero, or negative.
</p>

<p>
The resistor model also has an optional
<a href=\"Modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Resistor;

    model Conductor "Singlephase linear conductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Conductance G_ref(start=1)
        "Reference conductance at T_ref";
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
        "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
      Modelica.SIunits.Conductance G_actual
        "Conductance = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
      G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
      i = G_actual*v;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name"),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                  "G=%G_ref")}),
        Documentation(info="<html>

<p>
The linear conductor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = <u>v</u>*G</i>.
The conductance <i>G</i> is allowed to be positive, zero, or negative.
</p>

<p>
The conductor model also has an optional
<a href=\"Modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Conductor;

    model Capacitor "Singlephase linear capacitor"
      extends Interfaces.OnePort;
      import Modelica.Constants.j;
      parameter Modelica.SIunits.Capacitance C(start=1) "Capacitance";
    equation
      i = j*omega*C*v;
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name"),
            Line(
              points={{-14,28},{-14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{14,28},{14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,0},{-14,0}}),
            Line(points={{14,0},{90,0}}),
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                  "C=%C")}),
        Documentation(info="<html>

<p>
The linear capacitor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = j*&omega;*C*<u>v</u></i>.
The capacitance <i>C</i> is allowed to be positive, zero, or negative.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Capacitor;

    model Inductor "Singlephase linear inductor"
      extends Interfaces.OnePort;
      import Modelica.Constants.j;
      parameter Modelica.SIunits.Inductance L(start=1) "Inductance";
    equation
      v = j*omega*L*i;
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name"),
            Ellipse(extent={{-60,-15},{-30,15}}),
            Ellipse(extent={{-30,-15},{0,15}}),
            Ellipse(extent={{0,-15},{30,15}}),
            Ellipse(extent={{30,-15},{60,15}}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                  "L=%L")}),
        Documentation(info="<html>

<p>
The linear inductor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by  <i><u>v</u> = j*&omega;*L*<u>i</u></i>.
The Inductance <i>L</i> is allowed to be positive, zero, or negative.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Inductor;

    model VariableResistor "Singlephase variable resistor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
      Modelica.SIunits.Resistance R_actual
        "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.Blocks.Interfaces.RealInput R_ref
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
      R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
      v = R_actual*i;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name"),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,90},{0,30}},
              color={0,0,255},
              smooth=Smooth.None)}),
        Documentation(info="<html>

<p>
The linear resistor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u>*R = <u>v</u></i>.
The resistance <i>R</i> is given as input signal.
<p>

<p>
The variable resistor model also has an optional
<a href=\"Modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>Note</h4>
<p>
A zero crossing of the R signal could cause singularities due to the actual structure of the connected network.
</p>

<p>
The variable resistor model also has an optional
<a href=\"Modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableResistor;

    model VariableConductor "Singlephase variable conductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
        "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
      Modelica.SIunits.Conductance G_actual
        "Conductance = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.Blocks.Interfaces.RealInput G_ref
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
      G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
      i = G_actual*v;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name"),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,90},{0,30}},
              color={0,0,255},
              smooth=Smooth.None)}),
        Documentation(info="<html>

<p>
The linear conductor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = G*<u>v</u></i>.
The conductance <i>G</i> is given as input signal.
</p>

<p>
The variable conductor model also has an optional
<a href=\"Modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableConductor;

    model VariableCapacitor "Singlephase variable capacitor"
      extends Interfaces.OnePort;
      import Modelica.Constants.j;
      Modelica.Blocks.Interfaces.RealInput C
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      i = j*omega*C*v;
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name"),
            Line(
              points={{-14,28},{-14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{14,28},{14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,0},{-14,0}}),
            Line(points={{14,0},{90,0}}),
            Line(points={{0,90},{0,30}}, color={0,0,255})}),
        Documentation(info="<html>

<p>
The linear capacitor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = j*&omega;*C*<u>v</u></i>.
The capacitance <i>C</i> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable capacitor at quasi stationary operation assumes:<br>
<img src=\"../Images/Electrical/QuasiStationary/SinglePhase/Basic/dc_dt.png\">.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableCapacitor;

    model VariableInductor "Singlephase variable inductor"
      extends Interfaces.OnePort;
      import Modelica.Constants.j;
      Modelica.Blocks.Interfaces.RealInput L
        annotation (Placement(transformation(
            origin={0,108},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      v = j*omega*L*i;
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name"),
            Ellipse(extent={{-60,-15},{-30,15}}),
            Ellipse(extent={{-30,-15},{0,15}}),
            Ellipse(extent={{0,-15},{30,15}}),
            Ellipse(extent={{30,-15},{60,15}}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Line(points={{0,90},{0,8}}, color={0,0,255})}),
        Documentation(info="<html>

<p>
The linear inductor connects the branch voltage <i><u>v</u></i> with the
branch current <i><u>i</u></i> by <i><u>v</u> = j*&omega;*L*<u>i</u></i>. The inductance <i>L</i> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable inductor at quasi stationary operation assumes:<br>
<img src=\"../Images/Electrical/QuasiStationary/SinglePhase/Basic/dl_dt.png\">
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>
</p>
</html>"));
    end VariableInductor;
    annotation (Icon(graphics={
        Line(points={{-100,-40},{-80,-40}}),
        Line(points={{60,-40},{80,-40}}),
        Rectangle(
          extent={{-80,-10},{60,-70}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This package hosts basic models for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic\">MultiPhase.Basic</a>

</html>"));
  end Basic;

  package Ideal "Ideal components for AC singlephase models"
    extends Modelica.Icons.Library2;

    model Idle "Idle branch"
      extends Interfaces.OnePort;
    equation
      i = Complex(0);
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-41,0}}),
            Line(points={{91,0},{40,0}}),
            Text(extent={{-100,100},{100,70}}, textString=
                                                   "%name")}),
        Window(
          x=0.36,
          y=0.16,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
This model is a simple idle branch considering the complex current <i><u>i</u></i> = 0.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short\">Short</a>
</p>
</html>"));
    end Idle;

    model Short "Short cut branch"
      extends Interfaces.OnePort;
    equation
      v = Complex(0);
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{91,0},{-90,0}}),
            Text(extent={{-100,100},{100,70}}, textString=
                                                   "%name")}),
        Window(
          x=0.31,
          y=0.14,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
This model is a simple short cut branch considering the complex voltage <i><u>v</u></i> = 0.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle\">Idle</a>
</p>
</html>"));
    end Short;
    annotation (Icon(graphics={
        Ellipse(extent={{-54,-56},{-46,-64}}),
        Line(points={{-100,-60},{-54,-60}}),
        Line(points={{-47,-58},{30,-10}}),
        Line(points={{30,-60},{80,-60}}),
        Line(points={{30,-40},{30,-60}})}), Documentation(info="<html>
<p>This package hosts ideal models for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Ideal\">MultiPhase.Ideal</a>

</html>"));
  end Ideal;

  package Interfaces "Interfaces for AC singlephase models"
    extends Modelica.Icons.Library2;

    connector Pin "Basic connector"
      Modelica.SIunits.ComplexVoltage v "Complex potential at the node";
      flow Modelica.SIunits.ComplexCurrent i
        "Complex current flowing into the pin";
      annotation (Documentation(info="<html>
<p>
The potential of this connector is the complex voltage and the flow variable is the complex current.
The <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a> and
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a> are
derived from this base connector.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>

</html>"));
    end Pin;

    connector PositivePin "Positive connector"
      extends Pin;
      Modelica.Electrical.QuasiStationary.Types.Reference reference "Reference";
      annotation (Diagram(graphics={Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),
                                Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>

<p>
The positive pin is based on <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angluar velocity of the quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
    end PositivePin;

    connector NegativePin "Negative Connector"
      extends Pin;
      Modelica.Electrical.QuasiStationary.Types.Reference reference "Reference";
      annotation (Diagram(graphics={Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                                Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>

<p>
The negative pin is based on <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angluar velocity of the quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive pin</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
    end NegativePin;

    partial model TwoPin "Two pins"
      Modelica.SIunits.ComplexVoltage v;
      Modelica.SIunits.ComplexCurrent i;
      Modelica.SIunits.AngularVelocity omega = der(pin_p.reference.gamma);
      PositivePin pin_p "Positive pin"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      NegativePin pin_n "Negative pin"
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
    equation
      Connections.branch(pin_p.reference, pin_n.reference);
      pin_p.reference.gamma = pin_n.reference.gamma;
      i = pin_p.i;
      v = pin_p.v - pin_n.v;
      annotation (         Documentation(info="<html>
<p>
This partial model uses a <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a>
and <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a> and defines the complex voltage difference as well as the complex current (into the positive pin). Additionally, the angular velocity of the quasi stationary system is explicitely defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
    end TwoPin;

    partial model OnePort "Two pins, current through"
      extends TwoPin;
    equation
      pin_p.i + pin_n.i = Complex(0);
      annotation (         Documentation(info="<html>
<p>
This partial model is based on <a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.TwoPin\">TwoPin</a> and
additionally considers the complex current balance of the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a> and the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a>.
This model is intended to be used with textual representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.TwoPin\">TwoPin</a>
</p>
</html>"));
    end OnePort;

    partial model AbsoluteSensor "Partial potential sensor"
      extends Modelica.Icons.RotationalSensor;
      Modelica.SIunits.AngularVelocity omega = der(pin.reference.gamma);
      PositivePin pin "Pin"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(transformation(extent=
               {{100,-10},{120,10}}, rotation=0)));
    equation
      pin.i = Complex(0);
      annotation (         Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={0,0,0}),
            Text(
              extent={{-100,100},{100,70}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),
            Line(points={{70,0},{80,0},{90,0},{100,0}}, color={85,170,255})}),
      Documentation(info="<html>
<p>
The absolute sensor partial model provides a single
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive pin</a> to measure the complex voltage. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor\">RelativeSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor\">MultiPhase.Interfaces.AbsoluteSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">MultiPhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
    end AbsoluteSensor;

    partial model RelativeSensor "Partial voltage / current sensor"
      extends Modelica.Icons.RotationalSensor;
      extends OnePort;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      annotation (         Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={0,0,0}),
            Line(points={{70,0},{94,0}}, color={0,0,0}),
            Text(
              extent={{-100,100},{100,70}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),
            Line(points={{0,-70},{0,-80},{0,-90},{0,-100}}, color={85,170,255})}),
      Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a> to measure the complex voltage, current or power. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor\">MultiPhase.Interfaces.AbsoluteSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">MultiPhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
    end RelativeSensor;

    partial model Source "Partial voltage / current source"
      extends OnePort;
    equation
      Connections.root(pin_p.reference);
      annotation (Icon(graphics={
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{100,-100},{-100,-60}}, textString=
                                                   "%name"),
            Line(points={{-90,0},{-50,0}}, color={0,0,0}),
            Line(points={{50,0},{90,0}}, color={0,0,0})}),
      Documentation(info="<html>
<p>
The source partial model relies on the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a> and contains a proper icon.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Source\">MultiPhase.Interfaces.Source</a>.
</p>
</html>"));
    end Source;
    annotation (Icon(graphics={Rectangle(
          extent={{-30,-20},{10,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,255}), Rectangle(extent={{-60,10},{40,-90}}, lineColor={
              0,0,255})}),                        Documentation(info="<html>
<p>This package contains connector specifications and partial models for more complex components.</p>
</html>"));
  end Interfaces;

  package Sensors "AC singlephase sensors"
    extends Modelica.Icons.Library2;

    model PotentialSensor "Potential sensor"
      extends Interfaces.AbsoluteSensor;
    equation
      y = pin.v;
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "V")}),
      Documentation(info="<html>

<p>
This sensor can be used to measure the complex potential.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end PotentialSensor;

    model VoltageSensor "Voltage sensor"
      extends Interfaces.RelativeSensor;
    equation
      i = Complex(0);
      y = v;
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "V")}),
      Documentation(info="<html>
<p>
This sensor can be used to measure the complex voltage.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end VoltageSensor;

    model CurrentSensor "Current sensor"
      extends Interfaces.RelativeSensor;
    equation
      v = Complex(0);
      y = i;
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "I")}),
      Documentation(info="<html>
<p>
This sensor can be used to measure the complex current.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end CurrentSensor;

    model PowerSensor "Power sensor"
      import Modelica.ComplexMath.conj;
      Interfaces.PositivePin currentP
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Interfaces.NegativePin currentN
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Interfaces.PositivePin voltageP
        annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
      Interfaces.NegativePin voltageN
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
               0)));
      output Modelica.SIunits.ComplexCurrent i;
      output Modelica.SIunits.ComplexVoltage v;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y
        annotation (Placement(transformation(
            origin={-80,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      Connections.branch(currentP.reference, currentN.reference);
      currentP.reference.gamma = currentN.reference.gamma;
      Connections.branch(voltageP.reference, voltageN.reference);
      voltageP.reference.gamma = voltageN.reference.gamma;
      currentP.i + currentN.i = Complex(0);
      currentP.v - currentN.v = Complex(0);
      i = currentP.i;
      voltageP.i + voltageN.i = Complex(0);
      voltageP.i = Complex(0);
      v = voltageP.v - voltageN.v;
    //P + j*Q = v * conj(i);
      y = v*conj(i);
      annotation (         Icon(graphics={
            Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,100},{0,70}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={0,0,255}),
            Line(points={{-100,0},{100,0}}, color={0,0,255}),
            Line(points={{0,70},{0,40}}, color={0,0,0}),
            Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
            Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
            Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
            Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "P"),
            Line(points={{-80,-100},{-80,0}}, color={85,170,255})}),
      Documentation(info="<html>

<p>
This sensor can be used to measure the complex apparent power.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
</p>

</html>"));
    end PowerSensor;
    annotation (Icon(graphics={
        Ellipse(
          extent={{-60,10},{40,-90}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-16},{-36,-25}}, color={0,0,0}),
        Line(points={{-35,0},{-25,-14}}, color={0,0,0}),
        Line(points={{-10,7},{-10,-10}}, color={0,0,0}),
        Polygon(
          points={{-12,-24},{-0.5,-27},{2,1.5},{-12,-24}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-10,-40},{-6,-26}}, color={0,0,0}),
        Ellipse(
          extent={{-15,-35},{-5,-45}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{15,0},{5,-14}}, color={0,0,0}),
        Line(points={{30,-15},{16,-25}}, color={0,0,0})}), Documentation(info="<html>
<p>This package hosts sensors for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors\">MultiPhase.Sensors</a>

</html>"));
  end Sensors;

  package Sources "AC singlephase sources"
    extends Modelica.Icons.Library2;

    model VoltageSource "Constant AC voltage"
      extends Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "frequency of the source";
      parameter Modelica.SIunits.Voltage V(start=1) "RMS voltage of the source";
      parameter Modelica.SIunits.Angle phi(start=0) "phase shift of the source";
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = Complex(V*cos(phi), V*sin(phi));
      annotation (Icon(graphics={
            Text(
              extent={{-120,50},{-20,0}},
              lineColor={0,0,255},
              textString=
                      "+"),
            Text(
              extent={{20,50},{120,0}},
              lineColor={0,0,255},
              textString=
                      "-"),
            Line(points={{50,0},{-50,0}}, color={0,0,0})}),
          Documentation(info="<html>

<p>
This is a constant voltage source, specifying the complex voltage by the RMS voltage and the phase shift.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end VoltageSource;

    model VariableVoltageSource "Variable AC voltage"
      extends Interfaces.Source;
      Modelica.Blocks.Interfaces.RealInput f
        annotation (Placement(transformation(
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V
        annotation (Placement(transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = V;
      annotation (Icon(graphics={
            Text(
              extent={{-120,50},{-20,0}},
              lineColor={0,0,255},
              textString=
                      "+"),
            Text(
              extent={{20,50},{120,0}},
              lineColor={0,0,255},
              textString=
                      "-"),
            Line(points={{50,0},{-50,0}}, color={0,0,0})}),
        Documentation(info="<html>

<p>
This is a voltage source with a complex signal input, specifying the complex voltage by the complex RMS voltage components.
Additionally, the frequency of the voltage source is defined by a real signal input.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end VariableVoltageSource;

    model CurrentSource "Constant AC current"
      extends Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "frequency of the source";
      parameter Modelica.SIunits.Current I(start=1) "RMS current of the source";
      parameter Modelica.SIunits.Angle phi(start=0) "phase shift of the source";
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = Complex(I*cos(phi), I*sin(phi));
      annotation (Icon(graphics={
            Line(points={{0,-50},{0,50}}, color={0,0,0}),
            Line(points={{-60,60},{60,60}}, color={0,0,255}),
            Polygon(
              points={{60,60},{30,70},{30,50},{60,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>

<p>
This is a constant current source, specifying the complex current by the RMS current and the phase shift.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end CurrentSource;

    model VariableCurrentSource "Variable AC current"
      extends Interfaces.Source;
      Modelica.Blocks.Interfaces.RealInput f
        annotation (Placement(transformation(
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput I
        annotation (Placement(transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = I;
      annotation (Icon(graphics={
            Line(points={{0,-50},{0,50}}, color={0,0,0}),
            Line(points={{-60,60},{60,60}}, color={0,0,255}),
            Polygon(
              points={{60,60},{30,70},{30,50},{60,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>

<p>
This is a current source with a complex signal input, specifying the complex current by the complex RMS current components.
Additionally, the frequency of the voltage source is defined by a real signal input.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
</p>
</html>"));
    end VariableCurrentSource;
    annotation (Icon(graphics={
        Line(points={{-100,-40},{-60,-40}}),
        Ellipse(
          extent={{-60,10},{40,-90}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{40,-40},{80,-40}})}), Documentation(info="<html>
<p>This package hosts sources for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources\">MultiPhase.Sources</a>

</html>"));
  end Sources;
  annotation (Icon(graphics={Rectangle(extent={{-60,10},{40,-90}}, lineColor={0,
            0,255}), Rectangle(
        extent={{-30,-20},{10,-60}},
        lineColor={0,0,0},
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={0,0,255})}),      Documentation(info="<html>
<p>This package hosts models for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase\">MultiPhase</a>

</html>"));
end SinglePhase;
