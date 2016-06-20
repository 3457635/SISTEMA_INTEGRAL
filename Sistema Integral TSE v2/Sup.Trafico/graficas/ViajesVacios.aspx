<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ViajesVacios.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ViajesVacios" %>

<%--<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <style type="text/css">
        .auto-style2 {
            width: auto;
        }

        .auto-style3 {
            height: 22px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Viajes Vacios</h3>
    <p>
        Año:
        <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
        &nbsp;Mes
        <asp:DropDownList ID="ddlMes" runat="server" Height="22px"
            Width="120px">
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
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
    </p>
    <table>
        <tr>
            <td>
                <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsViajesVacios"
                    Height="424px" Width="1400px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Vacios"
                            IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" XValueMember="economico" YValueMembers="Vacios"
                            Font="Microsoft Sans Serif, 8pt, style=Bold" Color="192, 192, 0">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY IsLabelAutoFit="False" LineWidth="0">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <LabelStyle Enabled="False" Font="Microsoft Sans Serif, 8pt, style=Bold" />
                            </AxisY>
                            <AxisX Interval="1" IsLabelAutoFit="False">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <LabelStyle Angle="0" />
                            </AxisX>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Arial, 12pt, style=Bold" Name="Title1" Text="VIAJES VACIOS">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
                <asp:SqlDataSource ID="sdsViajesVacios" runat="server"
                    CancelSelectOnNullParameter="False"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="viajes_vacios" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="nMes" SessionField="mes" Type="Int32" />
                        <asp:Parameter DefaultValue="" Name="nId_Equipo" Type="Int32" />
                        <asp:Parameter DefaultValue="Resumen" Name="cTipo" Type="String" />
                        <asp:Parameter DefaultValue="true" Name="lTodos" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <h3>Detalle de Viaje por Unidad</h3>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <caption>
                    &nbsp;</strong><asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                        <ProgressTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/updateProgress.gif" />
                            Espere...
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    </tr>
                    <tr>
                        <td>&nbsp;Económico:<br>
                            <asp:DropDownList ID="ddlUnidad" runat="server" DataSourceID="sdsUnidad" DataTextField="economico" DataValueField="id_equipo">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsUnidad" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT economico, id_equipo FROM equipo_operacion where id_status&lt;&gt;6 and id_tipo_equipo&lt;&gt;107 order by economico"></asp:SqlDataSource>
                        </td>
                        <td>&nbsp;Tipo Viaje:
                            <asp:RadioButtonList ID="rdoTipo" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Selected="True" Value="False">Ver Vacios</asp:ListItem>
                                <asp:ListItem Value="True">Ver Todos</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton2" runat="server" SkinID="ibtnActualizar" />
                        </td>
                    </tr>
                </caption>
            </table>
            <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsDetalleViaje" AutoGenerateColumns="False" 
                    EnableModelValidation="True" AllowSorting="True" >
                <Columns>
                    <asp:BoundField DataField="consecutivo" HeaderText="Consecutivo" />
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
                    <asp:BoundField DataField="inicio_real" HeaderText="Inicio Real" />
                    <asp:BoundField DataField="Trayecto" HeaderText="Trayecto" />
                    <asp:BoundField DataField="Vacio" HeaderText="Vacio" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsDetalleViaje" runat="server"
                CancelSelectOnNullParameter="False"
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                SelectCommand="viajes_vacios" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                    <asp:SessionParameter DefaultValue="0" Name="nMes" SessionField="mes" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlUnidad" Name="nId_Equipo"
                        PropertyName="SelectedValue" />
                    <asp:Parameter DefaultValue="Detalle" Name="cTipo" Type="String" />
                    <asp:ControlParameter ControlID="rdoTipo" DefaultValue="False"
                        Name="lTodos" PropertyName="SelectedValue" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
