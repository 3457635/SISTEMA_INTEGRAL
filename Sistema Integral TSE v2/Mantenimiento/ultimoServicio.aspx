<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ultimoServicio.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ultimoServicio" %>
<%@ Register src="../Controles_Usuario/preventivos.ascx" tagname="preventivos" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
        Equipo:
        <asp:DropDownList ID="ddlEquipo" runat="server" DataSourceID="sdsEquipo" 
            DataTextField="economico" DataValueField="id_equipo" Height="18px" 
            Width="135px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsEquipo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_tipo_equipo] &lt; @id_tipo_equipo) AND ([id_status] = @id_status)) ORDER BY [economico]">
            <SelectParameters>
                <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
                <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
        <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    </p>
    <p>
        <asp:Literal ID="ltlKilometraje" runat="server"></asp:Literal>
    </p>
    <uc1:preventivos ID="preventivos1" runat="server" />
    <br />
    <p>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id" DataSourceID="sdsOdometros" EnableModelValidation="True">
            <Columns>
                <asp:BoundField DataField="id" InsertVisible="False" ReadOnly="True" 
                    SortExpression="id">
                <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:BoundField DataField="reparacion" HeaderText="SERVICIO" 
                    SortExpression="reparacion" />
                <asp:TemplateField HeaderText="ULTIMO">
                    <ItemTemplate>
                        <asp:Literal ID="ltlUltimo" runat="server"></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SIGUIENTE">
                    <ItemTemplate>
                        <asp:Literal ID="ltlSiguiente" runat="server"></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsOdometros" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            SelectCommand="SELECT reparacion, id FROM Tipo_reparacion WHERE (correctivo = 0)">
        </asp:SqlDataSource>
    </p>
    <table class="auto-style4">
        <tr>
            <td>TSE-F-03&nbsp;</td>
            <td>REV. 01</td>
            <td>ABRIL 2016</td>
        </tr>
    </table>
</asp:Content>
