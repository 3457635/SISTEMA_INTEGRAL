<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaCartera.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaCartera" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
    <br />
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="cartera" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="nCliente" Type="Int32" />
                <asp:ControlParameter ControlID="txbAno" DefaultValue="" Name="nAño" 
                    PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="ddlMes" Name="nMes" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="rdbMoneda" Name="nDolares" 
                    PropertyName="SelectedValue" Type="Boolean" DefaultValue="False" />
            </SelectParameters>
        </asp:SqlDataSource>
        Año:
        <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
        &nbsp; Mes:
        <asp:DropDownList ID="ddlMes" runat="server" SkinID="ddlMes">
        </asp:DropDownList>
        &nbsp; &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" 
            style="width: 14px" />
        &nbsp;<br /> Cliente:
        <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsClientes" 
            DataTextField="razon_social" DataValueField="id_dato" Height="16px" 
            Width="114px">
        </asp:DropDownList>
        <br />
        Moneda:<asp:RadioButtonList ID="rdbMoneda" runat="server">
            <asp:ListItem Selected="True" Value="False">Pesos</asp:ListItem>
            <asp:ListItem Value="True">Dolares</asp:ListItem>
        </asp:RadioButtonList>
        &nbsp;<asp:SqlDataSource ID="sdsClientes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="clientes" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        Tamaño de gráfica:<br /> Ancho:
        <asp:TextBox ID="txbAncho" runat="server" Width="72px">1500</asp:TextBox>
        pixeles<br /> Alto:&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txbAlto" runat="server" Width="72px">3000</asp:TextBox>
        pixeles&nbsp;
        <asp:ImageButton ID="ImageButton2" runat="server" SkinID="ibtnActualizar" />
        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" 
            Height="1500px" RightToLeft="No" Width="3000px">
            <Series>
                <asp:Series ChartArea="ChartArea1" ChartType="Bar" Color="Yellow" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                    Label="#VAL{C0}" Legend="Legend1" Name="Saldo Anterior" 
                    XValueMember="razon_social" YValueMembers="Saldo_Anterior">
                </asp:Series>
                <asp:Series ChartType="Bar" Color="DarkOliveGreen" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                    Label="#VAL{C0}" Legend="Legend1" Name="Ventas" XValueMember="razon_social" 
                    YValueMembers="Ventas">
                    <EmptyPointStyle LegendText="No hay datos" />
                    <SmartLabelStyle MaxMovingDistance="60" />
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="Bar" Color="0, 192, 0" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                    Label="#VAL{C0}" Legend="Legend1" Name="Pagos" XValueMember="razon_social" 
                    YValueMembers="Pagos">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="Bar" Color="DodgerBlue" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                    Label="#VAL{C0}" Legend="Legend1" Name="Saldo Actual" 
                    XValueMember="razon_social" YValueMembers="Saldo_Actual">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisY Title="Ingreso" TitleForeColor="Blue">
                        <MajorGrid Enabled="False" />
                        <LabelStyle Format="{0:c0}" TruncatedLabels="True" />
                    </AxisY>
                    <AxisX Interval="1" Title="Clientes" TitleForeColor="Blue">
                        <MajorGrid Enabled="False" />
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
                    Text="Ingresos Por Cliente (Pesos)">
                </asp:Title>
            </Titles>
        </asp:Chart>
    </ContentTemplate>
</asp:UpdatePanel>
<br />



