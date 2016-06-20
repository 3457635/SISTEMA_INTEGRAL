<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="OrdenServicio.aspx.vb" Inherits="Sistema_Integral_TSE_v45.OrdenServicio" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Formatos de Salida<br />
&nbsp;<table style="width: 100%">
        <tr>
            <td style="width: 405px">
                Orden:
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsOrdenes" 
                    DataTextField="orden" DataValueField="id_viaje" AutoPostBack="True">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsOrdenes" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) + '(' + dbo.empresas.nombre + ')' AS orden, viajes.id_viaje FROM viajes INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa ORDER BY ordenes.consecutivo DESC">
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <br />
    <br />
    Orden de Servicio:
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="830px" 
        Height="271px">
        <LocalReport ReportPath="Sup.Trafico\rptOrdenServicio.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" Name="DataSet3" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource4" Name="DataSet4" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSet2" />
                <rsweb:ReportDataSource DataSourceId="odsOrden" Name="orden" />
                <rsweb:ReportDataSource DataSourceId="odsTrayectos" Name="dsTrayecto2" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <br />
   
    Liquidación:<rsweb:ReportViewer ID="ReportViewer2" runat="server" 
        Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="815px">
        <LocalReport ReportPath="Sup.Trafico\liquidacion3.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" Name="dsEquipo" />
                <rsweb:ReportDataSource DataSourceId="odsOrden" 
                    Name="dsOrden2" />
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="dsChofer" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetEmpleados" 
        
        TypeName="Sistema_Integral_TSE_v2.dsOrdenServicioTableAdapters.personasTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="id_viaje" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsOrden" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetDia" 
        TypeName="Sistema_Integral_TSE_v2.dsOrdenServicioTableAdapters.obtener_ordenTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="id_viaje" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetEquipo" 
        TypeName="Sistema_Integral_TSE_v2.dsOrdenServicioTableAdapters.EquipoTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="id_viaje" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetComunicaciones" 
        TypeName="Sistema_Integral_TSE_v2.dsOrdenServicioTableAdapters.ComunicacionTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="id_viaje" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
   
    <asp:ObjectDataSource ID="odsTrayectos" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetTrayecto2" 
        TypeName="Sistema_Integral_TSE_v2.dsOrdenServicioTableAdapters.llave_trayectosTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="id_viaje" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
   
</asp:Content>
