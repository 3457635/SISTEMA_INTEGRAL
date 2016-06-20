<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlRendimientoUnidad.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlRendimientoUnidad" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<style type="text/css">

        .auto-style4 {
            width: 100%;
        }
        .auto-style6 {
        width: 387px;
    }
</style>
<%--<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>--%>
<p>
    Fecha inicial:
    <asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarExtender1"
        runat="server" TargetControlID="txbInicio" Format="yyyy/MM/dd">
    </asp:CalendarExtender>
    <%--&nbsp; Fin:&nbsp;<asp:TextBox ID="txbFin" runat="server"></asp:TextBox><asp:CalendarExtender
        ID="CalendarExtender2" TargetControlID="txbFin" runat="server"
        Format="yyyy/MM/dd">
    </asp:CalendarExtender>--%>
    <asp:Label ID="Label1" runat="server" Text="Fecha Final:"></asp:Label>
    <asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarExtender2"
        runat="server" TargetControlID="txbFin" Format="yyyy/MM/dd">
    </asp:CalendarExtender>
    &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
</p>
<p>
    &nbsp;
    <asp:Panel ID="Panel1" runat="server" style="text-align: center">
        <div>
            <table class="auto-style4">
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td>
                        <asp:GridView ID="gvRendimiento0" runat="server" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" datasourceid="sdsRendimiento1" ForeColor="Black" style="font-weight: 700" Width="742px" Visible="False">
                            <Columns>
                                <asp:BoundField DataField="Economico" HeaderText="Economico" SortExpression="Economico" />
                                <asp:BoundField DataField="Fecha_Odometro_Final" HeaderText="Fecha_Odometro_Final" ReadOnly="True" SortExpression="Fecha_Odometro_Final" />
                                <asp:BoundField DataField="Litros" HeaderText="Litros" ReadOnly="True" SortExpression="Litros" />
                                <asp:BoundField DataField="Kilometros" HeaderText="Kilometros" ReadOnly="True" SortExpression="Kilometros" />
                                <asp:BoundField DataField="Rendimiento" HeaderText="Rendimiento" ReadOnly="True" SortExpression="Rendimiento" />
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            </div>
        <asp:SqlDataSource ID="sdsRendimiento1" runat="server" ConnectionString="<%$ ConnectionStrings:DataSourceConnectionString %>" SelectCommand="RendimientoPorBoleta" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </asp:Panel>

</p>


<asp:Chart ID="Chart2" runat="server" DataSourceID="sdsRendimiento"
    Height="512px" Width="1420px">
    <Series>
        <asp:Series IsValueShownAsLabel="True" Label="#VAL{N2}"
            LabelFormat="{0:d2}" Name="Series1" XValueMember="economico"
            YValueMembers="rendimiento">
            <SmartLabelStyle AllowOutsidePlotArea="Yes" />
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1" BackColor="Transparent" BorderWidth="0">
            <AxisY LineColor="Transparent"
                LineWidth="0" Title="RENDIMIENTO">
                <MajorGrid Enabled="False" />
                <MajorTickMark Enabled="False" />
                <MajorGrid Enabled="False"></MajorGrid>
                <MajorTickMark Enabled="False"></MajorTickMark>

                <LabelStyle ForeColor="Transparent" />
            </AxisY>
            <AxisX Interval="1" IsLabelAutoFit="False" LineWidth="0"
                InterlacedColor="Transparent" LineColor="Transparent"
                LineDashStyle="NotSet" Title="UNIDAD">
                <LabelStyle Font="Microsoft Sans Serif, 8pt, style=Bold" />
                <MajorGrid Enabled="False" />
                <MajorGrid Enabled="False"></MajorGrid>
            </AxisX>

            <Area3DStyle Enable3D="True" IsRightAngleAxes="False" Inclination="0"
                Rotation="0" Perspective="15" />
        </asp:ChartArea>
    </ChartAreas>
    <Titles>
        <asp:Title Font="Microsoft Sans Serif, 14pt" Name="Title1" Text="Tractos">
        </asp:Title>
    </Titles>
</asp:Chart>


<p>
<br />


<asp:Chart ID="Chart3" runat="server" DataSourceID="sdsRendimiento0"
    Height="512px" Width="1420px" Palette="SeaGreen">
    <Series>
        <asp:Series IsValueShownAsLabel="True" Label="#VAL{N2}"
            LabelFormat="{0:d2}" Name="Series1" XValueMember="economico"
            YValueMembers="rendimiento">
            <SmartLabelStyle AllowOutsidePlotArea="Yes" />
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1" BackColor="Transparent" BorderWidth="0">
            <AxisY LineColor="Transparent"
                LineWidth="0" Title="RENDIMIENTO">
                <MajorGrid Enabled="False" />
                <MajorTickMark Enabled="False" />
                <MajorGrid Enabled="False"></MajorGrid>
                <MajorTickMark Enabled="False"></MajorTickMark>

                <LabelStyle ForeColor="Transparent" />
            </AxisY>
            <AxisX Interval="1" IsLabelAutoFit="False" LineWidth="0"
                InterlacedColor="Transparent" LineColor="Transparent"
                LineDashStyle="NotSet" Title="UNIDAD">
                <LabelStyle Font="Microsoft Sans Serif, 8pt, style=Bold" />
                <MajorGrid Enabled="False" />
                <MajorGrid Enabled="False"></MajorGrid>
            </AxisX>

            <Area3DStyle Enable3D="True" IsRightAngleAxes="False" Inclination="0"
                Rotation="0" Perspective="15" />
        </asp:ChartArea>
    </ChartAreas>
    <Titles>
        <asp:Title Font="Microsoft Sans Serif, 14pt" Name="Title1" Text="Rabón y Pick up">
        </asp:Title>
    </Titles>
</asp:Chart>
<asp:SqlDataSource ID="sdsRendimiento" runat="server"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="rendimientosPorUnidad" SelectCommandType="StoredProcedure">
    <SelectParameters>
       <%-- <asp:Parameter Name="fin" />--%>
        <asp:ControlParameter ControlID="txbInicio" Name="inicio" PropertyName="Text" />
        <asp:ControlParameter ControlID="txbFin" Name="fin" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>



<asp:SqlDataSource ID="sdsRendimiento0" runat="server"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="rendimientosPorUnidadNoTracto" SelectCommandType="StoredProcedure">
    <SelectParameters>
       <%-- <asp:Parameter Name="fin" />--%>
        <asp:ControlParameter ControlID="txbInicio" Name="inicio" PropertyName="Text" />
        <asp:ControlParameter ControlID="txbFin" Name="fin" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>



