<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Viaje_Vuelta.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Viaje_de_Vuelta" 
    title="Untitled Page" %>
<%@ Register src="../Controles_Usuario/ctlViajesSinRegreso.ascx" tagname="ctlViajesSinRegreso" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Asignar un nuevo viaje a una orden.</p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id_orden" AllowPaging="True" 
            EnableModelValidation="True" SkinID="GridView1">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="id_orden" />
                <asp:BoundField DataField="orden" HeaderText="ORDEN" />
                <asp:BoundField DataField="nombre" HeaderText="CLIENTE" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" />
            </Columns>
        </asp:GridView>
    </p>
    <asp:Panel ID="Panel1" runat="server">
        Orden;<br /> Año:&nbsp;<asp:TextBox ID="txbAno" runat="server" Width="92px"></asp:TextBox>
        &nbsp;- Consecutivo:&nbsp;<asp:TextBox ID="txbConsecutivo" runat="server"></asp:TextBox>
        &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" 
            style="height: 16px" />
        <br />
        <br />
        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
    </asp:Panel>
    <p>
        &nbsp;</p>
    <uc1:ctlViajesSinRegreso ID="ctlViajesSinRegreso1" runat="server" />
</asp:Content>
