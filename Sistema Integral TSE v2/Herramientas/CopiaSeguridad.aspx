<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="CopiaSeguridad.aspx.vb" Inherits="Sistema_Integral_TSE_v45.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
        .auto-style5 {
            width: 426px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style4">
        <tr>
            <td class="auto-style5">FECHA</td>
            <td>
                <asp:Label ID="lblFecha" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">DESCRIPCION</td>
            <td>
                <asp:TextBox ID="txtDesc" runat="server" Height="75px" TextMode="MultiLine" Width="317px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">RUTA DE ARCHIVO</td>
            <td>
                <asp:TextBox ID="txtRuta" runat="server" Width="324px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRuta" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">PROXIMO RESPALDO</td>
            <td>
                <asp:TextBox ID="txtProximo" runat="server" TextMode="Date" Width="323px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtProximo" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:Button ID="btnGuardar" runat="server" CssClass="btn" Height="40px" style="font-weight: 700" Text="GUARDAR" Width="106px" />
            </td>
        </tr>
    </table>
    <BR />
    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="id" DataSourceID="sdsMantenimiento" ForeColor="Black" GridLines="Vertical" ShowFooter="True">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="fecha" HeaderText="fecha" SortExpression="fecha" />
            <asp:BoundField DataField="descripcion" HeaderText="descripcion" SortExpression="descripcion" />
            <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta" />
            <asp:BoundField DataField="proximo" HeaderText="proximo" SortExpression="proximo" />
        </Columns>
        <FooterStyle BackColor="#CCCC99" />
        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
        <RowStyle BackColor="#F7F7DE" />
        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#FBFBF2" />
        <SortedAscendingHeaderStyle BackColor="#848384" />
        <SortedDescendingCellStyle BackColor="#EAEAD3" />
        <SortedDescendingHeaderStyle BackColor="#575357" />
    </asp:GridView>
    <asp:SqlDataSource ID="sdsMantenimiento" runat="server" ConnectionString="<%$ ConnectionStrings:DataSourceConnectionString %>" DeleteCommand="DELETE FROM [RespaldosBD] WHERE [id] = @id" InsertCommand="INSERT INTO [RespaldosBD] ([fecha], [descripcion], [ruta], [proximo]) VALUES (@fecha, @descripcion, @ruta, @proximo)" SelectCommand="SELECT * FROM [RespaldosBD]" UpdateCommand="UPDATE [RespaldosBD] SET [fecha] = @fecha, [descripcion] = @descripcion, [ruta] = @ruta, [proximo] = @proximo WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="lblFecha" Name="fecha" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDesc" Name="descripcion" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtRuta" Name="ruta" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtProximo" Name="proximo" PropertyName="Text" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="fecha" Type="String" />
            <asp:Parameter Name="descripcion" Type="String" />
            <asp:Parameter Name="ruta" Type="String" />
            <asp:Parameter Name="proximo" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
