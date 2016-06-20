<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaCarteraVencida.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaCarteraVencida" %>
<p>
    Año:
    <asp:TextBox ID="txbAnoCartera" runat="server"></asp:TextBox>
    &nbsp; Mes:
    <asp:DropDownList ID="ddlMesCartera" runat="server" SkinID="ddlMes">
    </asp:DropDownList>
    &nbsp;
&nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar"
    Style="width: 14px" />
    &nbsp;<br />
    Cliente:
    <asp:DropDownList ID="ddlClienteCartera" runat="server" DataSourceID="sdsClientes"
        DataTextField="razon_social" DataValueField="id_dato" Height="19px"
        Width="229px">
    </asp:DropDownList>
    <br />
    Moneda::<asp:RadioButtonList ID="rdbMoneda" runat="server">
        <asp:ListItem Selected="True" Value="False">Pesos</asp:ListItem>
        <asp:ListItem Value="True">Dolares</asp:ListItem>
    </asp:RadioButtonList>
    Tamaño de la gráfica:
</p>
<p>
    Ancho:&nbsp;<asp:TextBox
        ID="txbAncho" runat="server" Height="23px" Width="39px">1500</asp:TextBox>
    pixeles
</p>
<p>
    Alto:<asp:TextBox
        ID="txbAlto" runat="server" Height="23px" Width="35px">3000</asp:TextBox>
    pixeles
    <asp:ImageButton ID="ImageButton2" runat="server" Height="16px"
        SkinID="ibtnActualizar" />
    <asp:SqlDataSource ID="sdsClientes" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="clientes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</p>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Chart ID="chtCarteraVencida" runat="server" DataSourceID="SqlDataSource1"
            Height="2137px" RightToLeft="No" Width="1208px">
            <Series>
                <asp:Series ChartArea="ChartArea1" ChartType="Bar" Color="DodgerBlue"
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True"
                    Label="#VAL{C0}" Legend="Legend1" Name="Saldo Actual"
                    XValueMember="razon_social" YValueMembers="Saldo_Actual">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="Bar" Color="DarkOliveGreen"
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True"
                    Label="#VAL{C0}" Legend="Legend1" Name="Sin Promesa"
                    XValueMember="razon_social" YValueMembers="Sin_Promesa">
                    <EmptyPointStyle LegendText="No hay datos" />
                    <SmartLabelStyle MaxMovingDistance="60" />
                </asp:Series>
                <asp:Series ChartType="Bar" Color="0, 192, 0"
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True"
                    Label="#VAL{C0}" Legend="Legend1" Name="Con Promesa"
                    XValueMember="razon_social" YValueMembers="Con_Promesa">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="Bar" Color="Yellow"
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True"
                    Label="#VAL{C0}" Legend="Legend1" Name="Promesa Vencida"
                    XValueMember="razon_social" YValueMembers="Promesa_vencida">
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
<p>
    &nbsp;
</p>
<asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="cartera" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="nCliente" Type="Int32" />
        <asp:Parameter DefaultValue="" Name="nAño" Type="Int32" />
        <asp:Parameter Name="nMes" Type="Int32" />
        <asp:Parameter Name="nDolares" Type="Boolean" />
    </SelectParameters>
</asp:SqlDataSource>


