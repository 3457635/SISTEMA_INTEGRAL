<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="SubirPdfAmericano.aspx.vb" Inherits="Sistema_Integral_TSE_v45.SubirPdfAmericano" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Documentos PDF en Facturación Americana
    </h1><div class="contenido">
    
        <asp:Label ID="lblSeleccione" runat="server">Seleccione la factura que desea subir</asp:Label>
    <asp:FileUpload ID="fileUFacturaAmericana" runat="server" />
    <hr />
    
        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        <asp:Button ID="btnSubir" runat="server" Text="Subir factura" />
        <hr />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" EmptyDataText="Sin archivos" SkinID="GridViewGreen">
            <Columns>
                <asp:BoundField DataField="Text" HeaderText="Factura Americana" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDownload" Text="Descargar PDF" CommandArgument='<%# Eval("Value") %>' runat="server" OnClick="descargaPDF"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:TemplateField>
            <ItemTemplate>
                <asp:LinkButton ID = "lnkDelete" Text = "Borrar" CommandArgument = '<%# Eval("Value") %>' runat = "server"  />
            </ItemTemplate>
        </asp:TemplateField>--%>
            </Columns>

        </asp:GridView>
    </div>
</asp:Content>
