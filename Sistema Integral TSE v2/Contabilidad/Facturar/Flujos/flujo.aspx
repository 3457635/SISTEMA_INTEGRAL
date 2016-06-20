<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master"
    CodeBehind="flujo.aspx.vb" Inherits="Sistema_Integral_TSE_v45.flujo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
        Flujo de Efectivo.</p>
    <p>
       
    </p>
    <p>
        Año:<asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
    </p>
    <p>
        Trimestre:<asp:DropDownList ID="ddlTrimestre" runat="server">
            <asp:ListItem Value="1">1er. Trimestre</asp:ListItem>
            <asp:ListItem Value="2">2do. Trimestre</asp:ListItem>
            <asp:ListItem Value="3">3er. Trimestre</asp:ListItem>
            <asp:ListItem Value="4">4to. Trimestre</asp:ListItem>
        </asp:DropDownList>
    &nbsp;<asp:Label ID="lblMensaje" runat="server"></asp:Label>
    </p>
    <p>
        &nbsp;</p>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">        
            <contenttemplate>
            <asp:Button ID="Button1" runat="server" Text="Calcular" />                 
                    <asp:PlaceHolder ID="plhFlujo" runat="server"></asp:PlaceHolder>
     </contenttemplate>       
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/updateProgress.gif"></asp:Image>
            Procesando...<br />
            <br />
            Esta operación puede tardar algunos minutos.
            <br />
            Por favor espere.
        </ProgressTemplate>
    </asp:UpdateProgress>
   
    <p>
    </p>
</asp:Content>
