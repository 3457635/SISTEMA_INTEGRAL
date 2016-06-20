<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="recargaParcial.aspx.vb" Inherits="Sistema_Integral_TSE_v45.recargaParcial" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register src="../Controles_Usuario/ctlNuevasRecargasParciales.ascx" tagname="ctlNuevasRecargasParciales" tagprefix="uc1" %>
<%@ Register src="../Controles_Usuario/ctlRecargasParciales.ascx" tagname="ctlRecargasParciales" tagprefix="uc2" %>
<%@ Register src="../Controles_Usuario/ctlRecargasParcialesRegistradas.ascx" tagname="ctlRecargasParcialesRegistradas" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script src="Scripts/bootstrap.min.js" type="text/css"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <H1>Recargas Parciales</H1> 
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0"  EnableDragToReorder="true"  MultiPageID="RadMultiPage1">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Nueva Recarga" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Recargas Registradas">
                    </telerik:RadTab>
                </Tabs>             
            </telerik:RadTabStrip>
           <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
               <telerik:RadPageView ID="RadPageView1" runat="server"><uc1:ctlNuevasRecargasParciales ID="ctlNuevasRecargasParciales1" runat="server" /></telerik:RadPageView>
               <telerik:RadPageView ID="RadPageView2" runat="server"><uc3:ctlRecargasParcialesRegistradas ID="ctlRecargasParcialesRegistradas1" runat="server" /></telerik:RadPageView>
    </telerik:RadMultiPage>
           <br /> 
    </asp:Content>
