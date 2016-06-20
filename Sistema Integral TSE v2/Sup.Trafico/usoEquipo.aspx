<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="usoEquipo.aspx.vb" Inherits="Sistema_Integral_TSE_v45.usoEquipo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <script>
    </script>
    <style type="text/css">
        .auto-style2 {
            width: auto;
        }

        .auto-style3 {
            height: 22px;
        }
    </style>
</asp:Content>

<asp:Content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="server">
    <h3>Uso de Equipos</h3>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
        <ProgressTemplate>
            <asp:Image ID="imgUpdate" runat="server"
                ImageUrl="~/imagenes/updateProgress.gif" />
            Espere...
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table class="style5">
                <tr>
                    <td>Inicio<asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>

                        <asp:CalendarExtender ID="txbInicio_CalendarExtender" runat="server" Format="yyyy/MM/dd"
                            Enabled="True" TargetControlID="txbInicio">
                        </asp:CalendarExtender>
                        &nbsp;Vehiculo:
                <asp:DropDownList ID="ddlVehiculo" runat="server">
                    <asp:ListItem Selected="True">Tracto</asp:ListItem>
                    <asp:ListItem>Rabon</asp:ListItem>
                    <asp:ListItem>Pick Up</asp:ListItem>
                </asp:DropDownList>
                        &nbsp;<asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                            <asp:ListItem Selected="True" Value="true">Ver porcentaje</asp:ListItem>
                            <asp:ListItem Value="false">Ver cantidad de unidades</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Chart ID="Chart10" runat="server" DataSourceID="sdsUtilizacionEquipo"
                            Height="424px" Width="726px" BorderlineColor="Black"
                            BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <Series>
                                <asp:Series ChartArea="ChartArea1" Name="Semana Anterior"
                                    IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                                    Legend="Legend1"
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" XValueMember="Día" YValueMembers="SemAnt" Color="128, 64, 0">
                                </asp:Series>
                                <asp:Series ChartArea="ChartArea1" Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" Legend="Legend1" Name="Semana Actual" XValueMember="Día" YValueMembers="SemAct" Color="192, 192, 0">
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
                                        <LabelStyle Angle="90" />
                                    </AxisX>
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                                    Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                        <asp:SqlDataSource ID="sdsUtilizacionEquipo" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Utilizacion_Unidades" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txbInicio" Name="dFecha_inicial" PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="ddlVehiculo" Name="cEquipo" PropertyName="SelectedValue" Type="String" />
                                <asp:ControlParameter ControlID="RadioButtonList1" Name="porcentaje" PropertyName="SelectedValue" Type="Boolean" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnConsultar" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

