<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="listasDistribucion.aspx.vb" Inherits="Sistema_Integral_TSE_v45.listasDistribucion" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Lista Distribución</h1>
    <p>
        &nbsp;<strong> Instrucciones: </strong>
    </p>
    <p>
        1.- Crea una nueva lista de distribución.</p>
    <p>
        2.-Asigna la nueva lista de distribución a la empresa y ruta que deceas que 
        reciba las notificaciones del seguimiento.</p>
    <p>
        <asp:Button ID="btnNuevo" runat="server" SkinID="btn" Text="Nueva" />
    &nbsp;&nbsp;
        <asp:Button ID="btnEliminar" runat="server" SkinID="btn" Text="Eliminar" />
        <asp:ConfirmButtonExtender ID="btnEliminar_ConfirmButtonExtender" 
            runat="server" 
            ConfirmText="Al eliminar perdera todos los contactos, esta de acuerdo?" 
            Enabled="True" TargetControlID="btnEliminar">
        </asp:ConfirmButtonExtender>
&nbsp;
    </p>
    <p>
        Empresa:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="sdsEmpresas" DataTextField="nombre" DataValueField="id_empresa" 
            Height="19px" Width="191px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsEmpresas" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_status] = @id_status) AND ([id_tipo_empresa] = @id_tipo_empresa)) ORDER BY [nombre]">
            <SelectParameters>
                <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        &nbsp;</p>
    Nombre:
    <asp:DropDownList ID="ddlLista" runat="server" DataSourceID="sdsListas" 
        DataTextField="nombreLista" DataValueField="idLista" Width="184px" 
        AutoPostBack="True">
    </asp:DropDownList>
    <asp:SqlDataSource ID="sdsListas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        
        SelectCommand="SELECT listaDistribucion.nombreLista, listaDistribucion.idLista FROM listaDistribucion INNER JOIN contactosServicio ON listaDistribucion.idLista = contactosServicio.idLista INNER JOIN precios ON contactosServicio.id_relacion = precios.id_relacion WHERE (listaDistribucion.idStatus = @idStatus) and precios.id_empresa=@idEmpresa">
        <SelectParameters>
            <asp:Parameter DefaultValue="5" Name="idStatus" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" 
                Name="idEmpresa" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
    <br />
    <asp:TextBox ID="txbIdLista" runat="server" Visible="False"></asp:TextBox>
    <br />
    <br />
    <asp:LinkButton ID="lnkAsignarASeguimiento" runat="server">Asignar lista a Seguimiento.</asp:LinkButton>
    <br />
    <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" 
        PopupControlID="Panel1" TargetControlID="Button1" 
        BackgroundCssClass="modalBackground" Drag="True">
    </asp:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" BackColor="white" style="width: 874px" >
        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        <br />
        <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" />
    </asp:Panel>
    <br />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="idCorreo" DataSourceID="sdsCorreos" EnableModelValidation="True">
        <Columns>
            <asp:CommandField DeleteText="Borrar" EditText="Modificar" 
                ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="idCorreo" InsertVisible="False" ReadOnly="True" 
                SortExpression="idCorreo">
            <ItemStyle Font-Size="0pt" />
            </asp:BoundField>
            <asp:BoundField DataField="correo" HeaderText="CORREO" 
                SortExpression="correo" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsCorreos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [correos] WHERE [idCorreo] = @idCorreo" 
        InsertCommand="INSERT INTO [correos] ([correo]) VALUES (@correo)" 
        SelectCommand="SELECT [correo], [idCorreo] FROM [correos] WHERE ([idLista] = @idLista)" 
        UpdateCommand="UPDATE [correos] SET [correo] = @correo WHERE [idCorreo] = @idCorreo">
        <DeleteParameters>
            <asp:Parameter Name="idCorreo" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="correo" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlLista" Name="idLista" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="correo" Type="String" />
            <asp:Parameter Name="idCorreo" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Button ID="Button1" runat="server" />
    <br />
    <br />
    <br />
</asp:Content>
