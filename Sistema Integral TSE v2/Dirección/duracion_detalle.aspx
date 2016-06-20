<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="duracion_detalle.aspx.vb" Inherits="Sistema_Integral_TSE_v45.diasXviaje" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        &nbsp;</p>
    <p>
        <br />
    </p>
    <p>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            EnableModelValidation="True" SkinID="GridView1">
            <Columns>
                <asp:BoundField DataField="orden" HeaderText="ORDEN" />
                <asp:BoundField DataField="nombre" HeaderText="CLIENTE" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" />
                <asp:BoundField DataField="f_serv" HeaderText="FECHA SERVICIO" 
                    DataFormatString="{0:d}" />
                <asp:BoundField DataField="f_pago" HeaderText="FECHA COBRO" 
                    DataFormatString="{0:d}" />
                <asp:BoundField DataField="dias" HeaderText="DIAS TRANSCURRIDOS" />
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
