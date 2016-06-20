<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Programacion_servicios.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Programacion_servicios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Programación de Servicios</h1>
    <hr />
    <p>Tipo de Equipo:<asp:DropDownList ID="ddlTipoEquipo" runat="server" 
            AutoPostBack="True" DataSourceID="sqlTiposEquipos" DataTextField="equipo" 
            DataValueField="id_tipo_equipo">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sqlTiposEquipos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [id_tipo_equipo], [equipo] FROM [tipo_equipos]">
        </asp:SqlDataSource>
    </p>
    <p>Unidad:<asp:DropDownList ID="ddlUnidad" runat="server" 
            DataSourceID="sqlUnidades" DataTextField="unidad" 
            DataValueField="id_equipo" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sqlUnidades" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT equipo_operacion.id_equipo, equipo_operacion.economico + ' ' + marcas.marca AS unidad FROM equipo_operacion INNER JOIN marcas ON equipo_operacion.id_marca = marcas.id_marca WHERE (equipo_operacion.id_tipo_equipo = @id_tipo_equipo) order by equipo_operacion.economico">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlTipoEquipo" Name="id_tipo_equipo" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>Servicio:<asp:DropDownList ID="ddlReparacion" runat="server" 
            DataSourceID="sdsServicios" DataTextField="reparacion" DataValueField="id">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsServicios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [reparacion], [id] FROM [Tipo_reparacion] WHERE ([correctivo] = @correctivo)">
            <SelectParameters>
                <asp:Parameter DefaultValue="false" Name="correctivo" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>Distancia:<asp:TextBox ID="txbDistancia" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txbDistancia" Display="Dynamic" ErrorMessage="*">Campo Obligatorio</asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
        <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    </p>
    <hr />
</asp:Content>
