<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Documentos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Documentos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Documentos de cada área</h1>
    <div class="contenido">
        <asp:Label ID="lblSeleccione" runat="server">Seleccione el documento en su máquina</asp:Label>
    <asp:FileUpload ID="fileUDocumentos" runat="server" />
        <br />
    &nbsp;<asp:RadioButtonList ID="rbAreas" runat="server" DataSourceID="SqlDataSource1" DataTextField="nombre_area" DataValueField="nombre_area" RepeatDirection="Horizontal" Visible="False">
        </asp:RadioButtonList>
    <hr />
        <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
        <asp:Button ID="btnSubir" runat="server" Text="Subir Documento" />
        <hr /><br />
        <asp:Label ID="Label1" runat="server" Text="Ver documento por área:" Visible="False"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="nombre_area" DataValueField="nombre_area" Visible="False">
        </asp:DropDownList>
        
        &nbsp;<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" EmptyDataText="Sin archivos" SkinID="GridViewGreen">
             <Columns>
                <asp:BoundField DataField="Text" HeaderText="Documento" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDownload" Text="Descargar Documento" CommandArgument='<%# Eval("Value") %>' runat="server" OnClick="descargaArchivo"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:TemplateField>
            <ItemTemplate>
                <asp:LinkButton ID = "lnkDelete" Text = "Borrar" CommandArgument = '<%# Eval("Value") %>' runat = "server"  />
            </ItemTemplate>
        </asp:TemplateField>--%>
            </Columns>
    </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="select nombre_area from documentacion_areas where nivel = 2"></asp:SqlDataSource>
        <asp:TreeView ID="TreeView1" runat="server" MaxDataBindDepth="2" Visible="False">
            <Nodes>
                <asp:TreeNode PopulateOnDemand="True" Text="Manuales" Value="Manuales"></asp:TreeNode>
            </Nodes>
        </asp:TreeView>
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" Visible="False">
            <Columns>
                <asp:BoundField DataField="nombre" HeaderText="Documento" />
                <asp:TemplateField HeaderText="Archivo">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton2" runat="server" Text="descargar" CommandArgument='<%# Eval("id_documento_area")%>'  OnClick="descargaDoc" ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server">Descargar </asp:LinkButton>
            </EmptyDataTemplate>
        </asp:GridView>
        <hr />
        </div>
</asp:Content>
