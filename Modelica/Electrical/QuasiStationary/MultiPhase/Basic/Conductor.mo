within Modelica.Electrical.QuasiStationary.MultiPhase.Basic;
model Conductor "Multiphase linear conductor"
  extends Interfaces.TwoPlug;
  parameter Modelica.SIunits.Conductance G_ref[m](start=fill(1,m));
  parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15,m)
    "Reference temperatures";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
    "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
  SinglePhase.Basic.Conductor conductor[m](
    final G_ref=G_ref,
    final T_ref=T_ref,
    final alpha_ref=alpha_ref,
    each final useHeatPort=useHeatPort,
    final T=T) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(plugToPins_p.pin_p, conductor.pin_p) 
    annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
          {-39,0},{-10,0}},
        color={85,170,255}));
  connect(conductor.pin_n, plugToPins_n.pin_n) 
    annotation (Line(points={{10,0},{39,0},{39,2.44929e-016},{68,2.44929e-016}},
                                            color={85,170,255}));
  connect(conductor.heatPort, heatPort) 
    annotation (Line(points={{0,-10},{0,-32.5},{1.16573e-015,-32.5},{1.16573e-015,
          -55},{0,-55},{0,-100}},
                               color={191,0,0}));
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
        Text(
          extent={{100,-80},{-100,-40}},
          lineColor={0,0,0},
          textString=
               "m=%m")}),                             Diagram(graphics),
  Documentation(info="<html>
<p>
The linear resistor connects the complex currents <i><u>i</u></i> with the complex
voltages <i><u>v</u></i> by <i><u>v</u>*G = <u>i</u></i>, 
using <i>m</i> <a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>single phase Conductors</a>.
</p>

<p>
The conductor model also has <i>m</i> optional 
<a href=\"Modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>. 
A linear temperature dependency of the conductances for enabled heat ports is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor>Resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor>Capacitor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor>Inductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor>Variable resistor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor>Variable conductor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor>Variable capacitor</a>, 
<a href=Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
end Conductor;