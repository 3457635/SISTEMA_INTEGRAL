<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaEgresos.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaEgresos" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<p>
Ano:<asp:TextBox ID="txbAno" runat="server"></asp:TextBox>&nbsp;<asp:ImageButton 
        ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
            </p>
<p>
        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2" 
            Height="399px" Width="1606px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="Programado" XValueMember="mes" 
                CustomProperties="DrawingStyle=Cylinder, MaxPixelPointWidth=50" ShadowOffset="2"
                    YValueMembers="programado" IsValueShownAsLabel="True" 
                    Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1" LabelAngle="90">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Name="Egresado" XValueMember="mes" 
                 CustomProperties="DrawingStyle=Cylinder, MaxPixelPointWidth=50" ShadowOffset="2"
                    YValueMembers="pagado" IsValueShownAsLabel="True" 
                    Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}"  LabelAngle="90" 
                    Legend="Legend1">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1"
         BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0" 
                    BorderColor="Silver">
                    <AxisY Title="egresos">
                    </AxisY>
                    <AxisX Title="mes" Interval="1">
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                    <Position Height="9.547739" Width="6.85358238" />
                </asp:Legend>
            </Legends>
        </asp:Chart>


        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            
                    
                    SelectCommand="egresosDelAno" 
        SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txbAno" Name="year" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
            </p>

