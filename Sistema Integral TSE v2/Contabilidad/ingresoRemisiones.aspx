<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ingresoRemisiones.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ingresoRemisiones" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Remisiones</h1>
    <br />
    <asp:LinkButton ID="lnkPendientes" runat="server">Pendientes de Pago</asp:LinkButton>
    <br />
    <br />
    Pagados en:<br />
    Año
    <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp;Mes
            <asp:DropDownList ID="ddlMes" runat="server">
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
    <asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
    <br />
    <br />
    <hr />
    Fecha de Ingreso:
    <asp:TextBox ID="txbFechaIngreso" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarExtender1" TargetControlID="txbFechaIngreso" Format="yyyy/MM/dd" runat="server"></asp:CalendarExtender>
&nbsp;&nbsp;
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
    <hr />
    <br />
    <br />
    Cantidad:
    <asp:Label ID="lblTotal" runat="server" Text="$ 0.00"></asp:Label>
    <br />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="grdViajes" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRemisionesPendientes" EnableModelValidation="True" DataKeyNames="id_viaje">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="ckbViaje" runat="server" AutoPostBack="True" OnCheckedChanged="ckbViaje_CheckedChanged" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="id_viaje" HeaderText="Id" SortExpression="id_viaje" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="ano" SortExpression="ano" />
            <asp:BoundField DataField="consecutivo" HeaderText="ORDEN" SortExpression="consecutivo" />
            <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="FECHA VIAJE" SortExpression="fecha" />
            <asp:BoundField DataField="nombre" HeaderText="EMPRESA" SortExpression="nombre" />
            <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
            <asp:BoundField DataField="equipo" HeaderText="EQUIPO SOLICITADO" SortExpression="equipo" />
            <asp:BoundField DataField="precio" HeaderText="PRECIO" SortExpression="precio" />
            <asp:BoundField DataField="moneda" HeaderText="MONEDA" SortExpression="moneda" />
            <asp:TemplateField HeaderText="FECHA INGRESO">
                <ItemTemplate>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFechaIngreso" EnableModelValidation="True" ShowHeader="False" SkinID="grdAnidado">
                        <Columns>
                            <asp:BoundField DataField="fechaIngreso" DataFormatString="{0:d}" HeaderText="fechaIngreso" SortExpression="fechaIngreso" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFechaIngreso" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT fechaIngreso FROM remisiones WHERE (idViaje = @idViaje)">
                        <SelectParameters>
                            <asp:Parameter Name="idViaje" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsRemisionesPendientes" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="regresarRemisiones" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="mes" Type="Int32" />
            <asp:Parameter Name="ano" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />

</asp:Content>
