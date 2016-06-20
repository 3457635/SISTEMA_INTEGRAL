<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="detalle.aspx.vb" Inherits="Sistema_Integral_TSE_v45.detalle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <asp:Label ID="lblTitulo" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lblFechaInicio" runat="server"></asp:Label>
        -<asp:Label ID="lblFechaFin" runat="server"></asp:Label>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" EnableModelValidation="True" 
            AutoGenerateColumns=False BackColor="White" BorderColor="#3366CC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="4">
            <Columns>
                <asp:BoundField DataField="importe" HeaderText="IMPORTE" 
                    DataFormatString="{0:C}" />
                <asp:BoundField DataField="iva" HeaderText="IVA" DataFormatString="{0:C}" />
                <asp:BoundField DataField="neto" DataFormatString="{0:C}" HeaderText="NETO" />
                <asp:BoundField DataField="cuenta" HeaderText="CUENTA" />
                <asp:BoundField DataField="descripcion" HeaderText="DESCRIPCION" />
                <asp:BoundField DataField="forma_pago" HeaderText="FORMA PAGO" />
                <asp:BoundField DataField="referencia" HeaderText="REFERENCIA" />
            </Columns>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        </asp:GridView>
    </p>
</asp:Content>
