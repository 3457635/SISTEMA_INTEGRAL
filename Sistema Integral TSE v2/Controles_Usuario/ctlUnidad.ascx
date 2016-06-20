<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlUnidad.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlUnidad" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<style type="text/css">
    .style1
    {
        font-family: Arial, Helvetica, sans-serif;
    }
    .style6
    {
        font-family: Arial, Helvetica, sans-serif;
        color: #FFFFFF;
    }
    .style7
    {
        width: 328px;
    }
</style>

Unidad:
<asp:DropDownList ID="DropDownList1" runat="server" 
    DataSourceID="SqlDataSource1" DataTextField="economico" 
    DataValueField="id_equipo" Height="17px" Width="164px" AutoPostBack="True">
</asp:DropDownList>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    
    SelectCommand="SELECT
CONVERT (nvarchar, eo.economico) + ' - ' + CONVERT (nvarchar, te.equipo) as economico 
, [id_equipo] FROM equipo_operacion eo JOIN tipo_equipos te on te.id_tipo_equipo = eo.id_tipo_equipo WHERE ([id_status] = @id_status) ORDER BY [economico]
">
    <SelectParameters>
        <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<p>
    <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" />
&nbsp;<asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
&nbsp;<asp:Button ID="btnBaja" runat="server" Text="Baja" />
&nbsp;<asp:TextBox ID="txbIdEquipo" runat="server" Visible="False"></asp:TextBox>
</p>
<asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
<asp:Panel ID="pnlUnidad" runat="server" BackColor="#336600" Width="377px">
    <table cellspacing="0" class="style1">
        <tr>
            <td class="style6">
                Economico:
            </td>
            <td class="style7">
                <asp:TextBox ID="txbEconomico" runat="server" Height="23px" Width="68px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Placa:</td>
            <td class="style7">
                <asp:TextBox ID="txbPlaca" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Marca:</td>
            <td class="style7">
                <asp:DropDownList ID="ddlMarca" runat="server" DataSourceID="SqlDataSource2" 
                    DataTextField="marca" DataValueField="id_marca">
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [marca], [id_marca] FROM [marcas] ORDER BY [marca]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style6">
                No. Serie</td>
            <td class="style7">
                <asp:TextBox ID="txbSerie" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Vehiculo:</td>
            <td class="style7">
                <asp:DropDownList ID="ddlVehiculo" runat="server" DataSourceID="SqlDataSource3" 
                    DataTextField="equipo" DataValueField="id_tipo_equipo">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [id_tipo_equipo], [equipo] FROM [tipo_equipos] ">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Año:</td>
            <td class="style7">
                <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Tipo de Uso</td>
            <td class="style7">
                <asp:DropDownList ID="ddlTipoUso" runat="server" DataSourceID="sdsTipoUso" DataTextField="uso" DataValueField="Id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsTipoUso" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT * FROM [TipoUsoUnidad]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Base</td>
            <td class="style7">
                <asp:DropDownList ID="ddlBase" runat="server" Width="120px">
                    <asp:ListItem Value="1110000000">X-56</asp:ListItem>
                    <asp:ListItem Value="1000000003">Emmo</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
&nbsp;</asp:Panel>
<asp:DropShadowExtender ID="dse" runat="server"
    TargetControlID="pnlUnidad" 
    Opacity=".8" 
    Rounded="true"     
    TrackPosition="true" />

<asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" 
    ConfirmText="Desea dar de baja el equipo? " TargetControlID="btnBaja">
</asp:ConfirmButtonExtender>

   
    
