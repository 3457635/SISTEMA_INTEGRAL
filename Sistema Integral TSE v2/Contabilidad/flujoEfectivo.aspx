<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="flujoEfectivo.aspx.vb" Inherits="Sistema_Integral_TSE_v45.flujoEfectivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Flujo de Efectivo</h1>
    Año
    <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnBuscar" runat="server" Text="Buscar" />
    <br />
    <br />
        <asp:Chart ID="Chart3" runat="server" DataSourceID="sdsFlujo" 
            Height="304px" Width="2704px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="Promesa Por Cobrar" IsValueShownAsLabel="True" 
                    Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1" 
                    LabelAngle="90" XValueMember="semana" YValueMembers="promesa_cliente">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True" 
                    LabelFormat="{0:c0}" Legend="Legend1" Name="Promesa Por Pagar" XValueMember="semana" 
                    YValueMembers="Promesa_Proveedor">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Name="Pagos Clientes" IsValueShownAsLabel="True" 
                    Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}"  LabelAngle="90" 
                    Legend="Legend1" XValueMember="semana" YValueMembers="pago_cliente">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True" 
                    LabelFormat="{0:c0}" Legend="Legend1" Name="Pago Proveedor" 
                    XValueMember="semana" YValueMembers="pago_proveedor">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1"
         BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0" 
                    BorderColor="Silver">
                    <AxisY LineWidth="0">
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Enabled="False" />
                    </AxisY>
                    <AxisX Interval="1">
                        <MajorGrid Enabled="False" />
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Row" Alignment="Far" 
                    DockedToChartArea="ChartArea1" IsDockedInsideChartArea="False" 
                    TableStyle="Wide">
                    <Position Height="7.920792" Width="19.4968548" />
                </asp:Legend>
            </Legends>
        </asp:Chart>


            <asp:SqlDataSource ID="sdsFlujo" runat="server" 
        CancelSelectOnNullParameter="False" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="Flujo" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="nTipo_Cambio" Type="Decimal" />
                    <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text" 
                        Type="Int32" />
                </SelectParameters>
    </asp:SqlDataSource>
<br />

</asp:Content>
