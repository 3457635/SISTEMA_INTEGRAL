<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="lecturaBomba.aspx.vb" Inherits="Sistema_Integral_TSE_v45.lecturaBomba" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 128px;
            height: 80px;
        }

        .auto-style4 {
            width: 128px;
        }

        .auto-style5 {
            width: 368px;
        }

        .auto-style6 {
            width: 28px;
        }

        .auto-style7 {
            width: 30px;
        }

        .auto-style8 {
            width: 77px;
        }

        .auto-style9 {
            width: 83px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Lectura de Bomba de Diesel</h1>
    <div>
        <div class="float-left">
            <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
            <asp:HiddenField ID="hfldIdLectura" runat="server" />
            <table class="auto-style5">
                <tr>
                    <td class="auto-style6">Año</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
                    </td>
                    <td class="auto-style7">Mes</td>
                    <td class="auto-style8">
                        <asp:DropDownList ID="ddlMes" runat="server" SkinID="ddlMes">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style9">
                        <asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <br />
        <div class="float-left">
            <div class="editor-label">Fecha Lectura</div>
            <div class="editor-field">
                <asp:TextBox ID="txbFechaLectura" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1" Format="yyyy/MM/dd" runat="server" TargetControlID="txbFechaLectura">
                </asp:CalendarExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txbFechaLectura" ErrorMessage="Campo Obligatorio" SetFocusOnError="True" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
            </div>
            <div class="editor-label">Hora </div>
            <div class="editor-field">
                <asp:TextBox ID="txbHoraLectura" runat="server"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txbHoraLectura" MaskType="Time" Mask="99:99" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txbHoraLectura" ErrorMessage="Campo Obligatorio" SetFocusOnError="True" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
            </div>
            <div class="editor-label">Lectura</div>
            <div class="editor-field">
                <asp:TextBox ID="txbLectura" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txbLectura" ErrorMessage="Campo Obligatorio" SetFocusOnError="True" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
            </div>
            <div class="editor-label">&nbsp;</div>

            <div class="editor-label">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" ValidationGroup="Insert" />
            </div>
        </div>
        <br />
        <br />
        <div class="float-left">
            <asp:GridView ID="grdLecturas" runat="server" AutoGenerateColumns="False" DataSourceID="sdsLecturas" DataKeyNames="id" EnableModelValidation="True">
                <Columns>
                    <asp:CommandField HeaderText="Selección" ShowSelectButton="True" SelectText="Editar" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CommandField>
                    <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="fechalectura" HeaderText="FECHA LECTURA" SortExpression="fechalectura" />
                    <asp:BoundField DataField="lectura" HeaderText="LECTURA" SortExpression="lectura" DataFormatString="{0:N0}" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="lectura_anterior" HeaderText="LECTURA ANTERIOR" SortExpression="lectura_anterior" ReadOnly="True" DataFormatString="{0:N0}">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="litros" HeaderText="LITROS" SortExpression="litros" ReadOnly="True" DataFormatString="{0:N0}">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="recargas" HeaderText="RECARGAS" SortExpression="recargas" ReadOnly="True" DataFormatString="{0:N0}">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="diferencia" HeaderText="DIFERENCIA" SortExpression="diferencia" ReadOnly="True" DataFormatString="{0:N0}">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:Button ID="deleteButton" runat="server" CommandName="Delete" Text="Borrar"
                                    OnClientClick="return confirm('Esta seguro de borrar el registro?');" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsLecturas" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>"
                DeleteCommand="DELETE FROM [lecturasBomba] WHERE [Id] = @Id"
                InsertCommand="INSERT INTO [lecturasBomba] ([fechaLectura], [lectura], [litros], [recargas], [diferencia]) VALUES (@fechaLectura, @lectura, @litros, @recargas, @diferencia)"
                SelectCommand="Trae_Lecturas_Bombas"
                UpdateCommand="UPDATE [lecturasBomba] SET [fechaLectura] = @fechaLectura, [lectura] = @lectura, [litros] = @litros, [recargas] = @recargas, [diferencia] = @diferencia WHERE [Id] = @Id"
                CancelSelectOnNullParameter="False" EnableViewState="False" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="fechaLectura" Type="DateTime" />
                    <asp:Parameter Name="lectura" Type="Double" />
                    <asp:Parameter Name="litros" Type="Double" />
                    <asp:Parameter Name="recargas" Type="Double" />
                    <asp:Parameter Name="diferencia" Type="Double" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txbAno" Name="nAnio" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlMes" Name="nMes" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="fechaLectura" Type="DateTime" />
                    <asp:Parameter Name="lectura" Type="Double" />
                    <asp:Parameter Name="litros" Type="Double" />
                    <asp:Parameter Name="recargas" Type="Double" />
                    <asp:Parameter Name="diferencia" Type="Double" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <br />
        <br />
    </div>
</asp:Content>
