<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Autorizaciones.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Autorizaciones" 
    title="TSE SI" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            
            
            
            
            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, dbo.empresas.nombre AS CLIENTE, dbo.llave_rutas.ruta AS RUTA, viajes.id_viaje, tipo_equipos.equipo, fechas.fecha, llegadaDestinos.fecha AS Expr1 
FROM Ordenes
 INNER JOIN 
viajes 
ON Ordenes.id_orden = viajes.id_orden 
INNER JOIN 
precios 
ON viajes.id_relacion = precios.id_relacion 
INNER JOIN dbo.empresas 
ON precios.id_empresa = dbo.empresas.id_empresa 
INNER JOIN dbo.llave_rutas 
ON precios.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN tipo_equipos 
ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo 
INNER JOIN fechas_viaje 
ON viajes.id_viaje = fechas_viaje.id_viaje
 INNER JOIN fechas 
ON fechas_viaje.id_fecha = fechas.id_fecha 
AND fechas_viaje.id_fecha = fechas.id_fecha 
AND fechas_viaje.id_fecha = fechas.id_fecha 
LEFT OUTER JOIN llegadaDestinos ON viajes.id_viaje = llegadaDestinos.idViaje WHERE (viajes.id_status = 1) AND (fechas.tipo_fecha = 1) ORDER BY Ordenes.id_orden DESC">
        </asp:SqlDataSource>
        Viajes pendientes por autorizar.
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id_viaje" DataSourceID="SqlDataSource1" BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
            EnableModelValidation="True">
            <RowStyle ForeColor="#000066" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                
                <asp:BoundField DataField="id_viaje" 
                    InsertVisible="False" ReadOnly="True" SortExpression="id_viaje" >
                <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" 
                    SortExpression="ORDEN" />               
                <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" 
                    SortExpression="CLIENTE" />
                <asp:BoundField DataField="RUTA" HeaderText="RUTA" SortExpression="RUTA" />
                <asp:BoundField DataField="equipo" HeaderText="VEHICULO" 
                    SortExpression="equipo" />
                
                <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" 
                    HeaderText="ORIGEN" SortExpression="fecha" />
                <asp:BoundField DataField="Expr1" DataFormatString="{0:dd/MM/yyyy HH:mm}" 
                    HeaderText="DESTINO" SortExpression="Expr1" />
                
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
    </p>
   
    <asp:Button ID="Button1" runat="server" Enabled="False" />
    <asp:ModalPopupExtender ID="mdlHolder" runat="server" TargetControlID="button1"
                    PopupControlID="pnlModificar"  BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>
    
    <asp:Panel ID="pnlModificar" runat="server" BackColor="White">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        
        
            <ContentTemplate>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <table class="auto-style4">
                    <tr>
                        <td class="auto-style5">
                            <table style="vertical-align:bottom">
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="lblIdViaje" runat="server" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style7">&nbsp;</td>
                                    <td class="auto-style6" style="width: 90%">
                                        <asp:LinkButton ID="lnkAceptar" runat="server">Aceptar</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style8">&nbsp;</td>
                                    <td style="width: 90%">
                                        <asp:LinkButton ID="lnkRechazar" runat="server">Rechazar</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableModelValidation="True">
                                <Columns>
                                    <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" SortExpression="ORDEN" />
                                    <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" SortExpression="CLIENTE" />
                                    <asp:BoundField DataField="RUTA" HeaderText="RUTA" SortExpression="RUTA" />
                                    <asp:BoundField DataField="VEHICULO" HeaderText="VEHICULO" SortExpression="VEHICULO" />
                                </Columns>
                            </asp:GridView>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                    
                    
                    
                    SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, dbo.empresas.nombre AS CLIENTE, dbo.llave_rutas.ruta AS RUTA, variables.variable AS VEHICULO FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN variables ON precios.id_tipo_recurso = variables.id_variable WHERE (viajes.id_viaje = @id_viaje) ORDER BY Ordenes.id_orden DESC">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="GridView1" Name="id_viaje" 
                                        PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
            
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </ContentTemplate>
        
        
        </asp:UpdatePanel>
        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" />
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
        .auto-style5 {
            width: 275px;
            text-align: right;
        }
        .auto-style6 {
            text-align: right;
        }
        .auto-style7 {
            text-align: right;
            width: 232px;
        }
        .auto-style8 {
            width: 232px;
        }
    </style>
</asp:Content>

