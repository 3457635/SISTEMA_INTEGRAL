<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="SinFactura_detalle.aspx.vb" Inherits="Sistema_Integral_TSE_v45.SinFactura_detalle" %>

<%@ Register Src="../Controles_Usuario/ctlUnfactured.ascx" TagName="ctlUnfactured" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Viajes Sin Factura</h1>
    <p>
        <asp:WebPartManager ID="WebPartManager1" runat="server">
        </asp:WebPartManager>
    </p>
    <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional">
        <ZoneTemplate>
            <uc1:ctlUnfactured ID="ctlUnfactured1" Title="Viajes Sin Factura Agrupados Por Dias Transcurridos" runat="server" />
        </ZoneTemplate>
    </asp:WebPartZone>

    Cliente:
    
        <asp:DropDownList ID="DropDownList1" runat="server"
            DataSourceID="SqlDataSource1" DataTextField="nombre"
            DataValueField="id_empresa">
        </asp:DropDownList>

    &nbsp;<asp:Label ID="Label1" runat="server" Text="Año"></asp:Label>
    <asp:TextBox ID="txbAñoSinFac" runat="server"></asp:TextBox>
    <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar"
        Style="height: 16px; width: 14px;" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="SELECT * FROM [empresas] WHERE (([id_tipo_empresa] = @id_tipo_empresa) AND ([id_status] = @id_status)) ORDER BY [nombre]">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
            <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    Total.<br />
    <asp:Label ID="lblDolares" runat="server"></asp:Label>
    &nbsp;Dls.
    <br />
    <asp:Label ID="lblMn" runat="server"></asp:Label>
    &nbsp;M.N.
    <br />
    <br />

    <center>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" SkinID="GridView1">
            <Columns>


                <asp:TemplateField HeaderText="No.">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="Image2" runat="server" AlternateText="Sin Imagen" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="VERIFICADO">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/ok.png"
                            Visible="<%# bind('verificado') %>" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("verificado") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="orden" HeaderText="ORDEN" />
                <asp:BoundField DataField="nombre" HeaderText="EMPRESA" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" />
                <asp:BoundField DataField="fecha" DataFormatString="{0:d}"
                    HeaderText="FECHA SERVICIO" />
                <asp:BoundField DataField="dias" HeaderText="DIAS" />
                <asp:BoundField DataField="precio" DataFormatString="{0:c}"
                    HeaderText="PRECIO" />
            </Columns>
        </asp:GridView>
        <center />
</asp:Content>
