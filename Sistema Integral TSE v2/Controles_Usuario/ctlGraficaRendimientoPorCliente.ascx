<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaRendimientoPorCliente.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaRendimientoPorCliente" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>

<p>
    Año:
    <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp; Mes:
    <asp:DropDownList ID="ddlMes" runat="server" Width="169px">
        <asp:ListItem Value="1">Enero</asp:ListItem>
        <asp:ListItem Value="2">Febrero</asp:ListItem>
        <asp:ListItem Value="3">Marzo</asp:ListItem>
        <asp:ListItem Value="4">Abril</asp:ListItem>
        <asp:ListItem Value="5">Mayo</asp:ListItem>
        <asp:ListItem Value="6">Junio</asp:ListItem>
        <asp:ListItem Value="7">Julio</asp:ListItem>
        <asp:ListItem Value="8">Agosto</asp:ListItem>
        <asp:ListItem Value="9">Septiembre</asp:ListItem>
        <asp:ListItem Value="10">Octubre</asp:ListItem>
        <asp:ListItem Value="11">Noviembre</asp:ListItem>
        <asp:ListItem Value="12">Diciembre</asp:ListItem>
    </asp:DropDownList>
&nbsp;
&nbsp;&nbsp;</p>
<p>
    Tipo de Vehiculo :
    <asp:DropDownList ID="ddlVehiculo" runat="server" Width="157px">
        <asp:ListItem Value="102">Tracto</asp:ListItem>
        <asp:ListItem Value="103">Rabon</asp:ListItem>
        <asp:ListItem Value="105">Pick Up</asp:ListItem>
    </asp:DropDownList>
&nbsp;
    <asp:ImageButton ID="ibtnActualizar" runat="server" SkinID="ibtnActualizar" />
</p>
<p>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="rendimientoPorCliente" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlMes" Name="mes" 
            PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="txbAno" Name="ano" PropertyName="Text" 
            Type="Int32" />
        <asp:ControlParameter ControlID="ddlVehiculo" Name="tipo_equipo" 
            PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>


        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" 
        RightToLeft="No" Width="500px">
            <Series>
                <asp:Series ChartArea="ChartArea1" Color="ForestGreen" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                    Label="#VAL{N2}" Legend="Legend1" Name="Rendimiento" 
                    XValueMember="Expr1" YValueMembers="promedio" IsVisibleInLegend="False">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisY Title="Rendimiento" TitleForeColor="Blue">
                        <MajorGrid Enabled="False" />
<MajorGrid Enabled="False"></MajorGrid>

                        <LabelStyle Format="{0:N0}" TruncatedLabels="True" />
                    </AxisY>
                    <AxisX Interval="1" Title="Cliente" TitleForeColor="Blue">
                        <MajorGrid Enabled="False" />
<MajorGrid Enabled="False"></MajorGrid>

                        <LabelStyle Angle="90" TruncatedLabels="True" />
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
            <Legends>
                <asp:Legend BackImageAlignment="Bottom" Name="Legend1">
                </asp:Legend>
            </Legends>
            <Titles>
                <asp:Title Font="Arial, 10pt" ForeColor="Blue" Name="Title1" 
                    Text="Rendimiento Por Cliente">
                </asp:Title>
            </Titles>
        </asp:Chart>
    </p>

