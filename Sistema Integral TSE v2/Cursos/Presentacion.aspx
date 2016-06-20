<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Presentacion.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Presentacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <br />
    <br />
    <br />
    <link href="../Styles.css" rel="Stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style2 {
            width: 100%;
        }
        .auto-style3 {
            width: 579px;
        }
    </style>
    <style type="text/css">
        .auto-style4 {
            width: 425px;
            height: 49px;
        }
        .auto-style5 {
            height: 49px;
        }
        .auto-style6 {
            width: 425px;
        }
    </style>
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
        .auto-style5 {
            font-weight: bold;
        }
    </style>
    <style type="text/css">
        .auto-style4 {
            height: 22px;
        }
    </style>
    <style type="text/css">
        .auto-style4 {}
        .auto-style5 {
            width: 153px;
        }
        .auto-style6 {
        }
        .auto-style7 {
            width: 595px;
        }
    </style>
    <style type="text/css">
        .auto-style4 {
            height: 42px;
        }
        .auto-style5 {
            height: 42px;
            width: 150px;
        }
        .auto-style6 {
            height: 42px;
            width: 149px;
        }
        .auto-style7 {
            height: 42px;
            width: 148px;
        }
        .auto-style8 {
            height: 42px;
            width: 78px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style2" style="width: 1030px">
        <tr>
            <td class="auto-style6" colspan="2"><strong>Favor de seleccionar un archivo con formato PDF</strong></td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:FileUpload ID="FuPresentacion" runat="server" Width="569px" style="font-weight: 700" />
            </td>
            <td>
                <asp:Button ID="btnCargar" runat="server" Text="Cargar" style="font-weight: 700" />
            </td>
        </tr>
        
    </table>
    <br/>
    <table>
        <tr>
            <td class="auto-style8">
                <asp:Label ID="lblNumero" runat="server"></asp:Label>
            </td>
            <td class="auto-style4">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Label ID="lblPregunta1" runat="server" style="font-weight: 700" Text="Pregunta"></asp:Label>
            </td>
            <td class="auto-style4">
                <asp:TextBox ID="txtQ1" runat="server" Width="428px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Label ID="lblCorrecta1" runat="server" style="font-weight: 700" Text="Respuesta Correcta"></asp:Label>
            </td>
            <td class="auto-style4">
                <asp:TextBox ID="txtCorrecta1" runat="server" Width="428px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Label ID="lblOp1" runat="server" CssClass="auto-style5" Text="Opcion 1"></asp:Label>
            </td>
            <td class="auto-style4">
                <asp:TextBox ID="txtOp1" runat="server" Width="428px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Label ID="lblOp2" runat="server" CssClass="auto-style5" Text="Opcion 2"></asp:Label>
            </td>
            <td class="auto-style4">
                <asp:TextBox ID="txtOp2" runat="server" Width="428px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style8"></td>
            <td class="auto-style4"></td>
        </tr>
        <tr>
            <td class="auto-style8">
                </td>
            <td class="auto-style4">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn" Height="38px" Width="107px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                &nbsp;</td>
            <td class="auto-style4">
                <asp:SqlDataSource ID="SdsPreguntas" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString3 %>" SelectCommand="SELECT * FROM [PreguntasInduccion]" UpdateCommand="Update PreguntasInduccion set Pregunta=@pregunta, respuesta=@Respuesta, op1=@op1, op2=@op2">
                    <UpdateParameters>
                        <asp:Parameter Name="pregunta" />
                        <asp:Parameter Name="Respuesta" />
                        <asp:Parameter Name="op1" />
                        <asp:Parameter Name="op2" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        </table>

    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" 
        DataSourceID="SdsPreguntas" ForeColor="#333333" GridLines="None" DataKeyNames="Id_Question">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ButtonType="Button" EditText="EDITAR" ShowEditButton="True" />
            <asp:BoundField DataField="Id_Question" HeaderText="Id_Question" InsertVisible="False" ReadOnly="True" SortExpression="Id_Question" />
            <asp:TemplateField HeaderText="Pregunta" SortExpression="Pregunta">
                <EditItemTemplate>
                    <asp:TextBox ID="Pregunta" runat="server" Text='<%# Bind("Pregunta") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Pregunta" runat="server" Text='<%# Bind("Pregunta") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Respuesta" SortExpression="Respuesta">
                <EditItemTemplate>
                    <asp:TextBox ID="Respuesta" runat="server" Text='<%# Bind("Respuesta") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Respuesta" runat="server" Text='<%# Bind("Respuesta") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Op1" SortExpression="Op1">
                <EditItemTemplate>
                    <asp:TextBox ID="Op1" runat="server" Text='<%# Bind("Op1") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Op1" runat="server" Text='<%# Bind("Op1") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Op2" SortExpression="Op2">
                <EditItemTemplate>
                    <asp:TextBox ID="Op2" runat="server" Text='<%# Bind("Op2") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Op2" runat="server" Text='<%# Bind("Op2") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>

</asp:Content>
