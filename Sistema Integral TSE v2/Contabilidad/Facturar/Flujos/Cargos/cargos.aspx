<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="cargos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.cargos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Cargos y Abonos.</p>
    <p>
        <asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="SqlDataSource6" DataTextField="cuenta" 
            DataValueField="id_cuenta" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [id_cuenta], [cuenta] FROM [conta_cuentas] WHERE id_padre is null">
        </asp:SqlDataSource>
        -<asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource7" DataTextField="cuenta" DataValueField="id_cuenta">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [cuenta], [id_cuenta] FROM [conta_cuentas] WHERE ([id_padre] = @id_padre)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="id_padre" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        -<asp:DropDownList ID="DropDownList3" runat="server" 
            DataSourceID="SqlDataSource8" DataTextField="cuenta" 
            DataValueField="id_cuenta" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource8" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [cuenta], [id_cuenta] FROM [conta_cuentas] WHERE ([id_padre] = @id_padre)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList2" Name="id_padre" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:ImageButton ID="btnNuevo" runat="server"  
            ImageUrl="~/imagenes/nuevo.png" AlternateText="Nuevo cargo" 
             />
    </p>
    <p>
        <asp:Label ID="lblCuenta" runat="server"></asp:Label>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" 
            EnableModelValidation="True" AllowPaging="True" 
            AutoGenerateColumns="False" ShowFooter="True" DataKeyNames="id_movimiento"
             OnSelectedIndexChanged="GridView1_selectedIndexChanged">
            <Columns>
                <asp:CommandField ButtonType="Image" ShowSelectButton="True" 
                    SelectImageUrl="~/imagenes/edit.png" HeaderText="Modificar" 
                      />
                      <asp:CommandField ButtonType="Image" DeleteImageUrl="~/imagenes/delete.png" 
                    ShowDeleteButton="True" HeaderText="Eliminar" />
                      <asp:BoundField DataField="id_movimiento" />
                      <asp:BoundField DataField="Importe" HeaderText="IMPORTE" 
                    SortExpression="importe" DataFormatString="{0:N}" />
                <asp:BoundField DataField="iva" DataFormatString="{0:N}" HeaderText="IVA" />
                <asp:BoundField DataField="total" DataFormatString="{0:N}" HeaderText="NETO" />
                <asp:BoundField DataField="fecha_programacion" HeaderText="PROGRAMACIÓN" 
                    SortExpression="fecha_programacion" DataFormatString="{0:d}" />
                <asp:BoundField DataField="fecha_ejecucion" HeaderText="EJECUCIÓN" 
                    SortExpression="fecha_ejecucion" DataFormatString="{0:d}" />
                <asp:BoundField DataField="movimiento" HeaderText="MOVIMIENTO" 
                    SortExpression="movimiento" />
                <asp:BoundField DataField="forma_pago" HeaderText="FORMA PAGO" 
                    SortExpression="forma_pago" />
                <asp:BoundField DataField="descripcion" HeaderText="DESCRIPCIÓN" />
                <asp:TemplateField>
                
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" />
                    </ItemTemplate>
                
                </asp:TemplateField>
            </Columns>
            <SelectedRowStyle BackColor="#669900" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            SelectCommand="SELECT [fecha_programacion], [fecha_ejecucion], [tipo_movimiento], [forma_pago], [id_movimiento] FROM [aplicacion_movimiento] WHERE (([id_cuenta] = @id_cuenta) OR ([id_cuenta] = @id_cuenta2) OR ([id_cuenta] = @id_cuenta3))">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="id_cuenta" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList2" Name="id_cuenta2" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList3" Name="id_cuenta3" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    
    <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel1"
     BackgroundCssClass="modalBackground" TargetControlID="btnNuevo">
    </asp:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" BackColor="white">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
     <table style="width: 100%">
        <tr>
            <td style="width: 196px">
                Cuenta:</td>
            <td>
                <asp:DropDownList ID="ddlRango1" runat="server" DataSourceID="SqlDataSource2" 
                    DataTextField="cuenta" DataValueField="id_cuenta" AutoPostBack="True">
                    <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"                     
                    SelectCommand="SELECT [id_cuenta], [cuenta] FROM [conta_cuentas] WHERE id_padre is null">                   
                </asp:SqlDataSource>
&nbsp;-
                <asp:DropDownList ID="ddlRango2" runat="server" DataSourceID="SqlDataSource3" 
                    DataTextField="cuenta" DataValueField="id_cuenta" AutoPostBack="True">
                    <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [id_cuenta], [cuenta] FROM [conta_cuentas] WHERE ([id_padre] = @id_padre)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRango1" Name="id_padre" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
&nbsp;-
                <asp:DropDownList ID="ddlRango3" runat="server" DataSourceID="SqlDataSource4" 
                    DataTextField="cuenta" DataValueField="id_cuenta" AutoPostBack="True">
                    <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [id_cuenta], [cuenta] FROM [conta_cuentas] WHERE ([id_padre] = @id_padre)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRango3" Name="id_padre" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:TextBox ID="txbIdcuenta" runat="server" BackColor="Red" Visible="False"></asp:TextBox>
                &nbsp;<asp:TextBox ID="txbIdMovimiento" runat="server" BackColor="#FF3300" 
                    Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                &nbsp;</td>
            <td>
                <asp:Label ID="lblCuenta2" runat="server"></asp:Label>
            </td>
        </tr>
         <tr>
             <td style="width: 196px">
                 &nbsp;</td>
             <td>
                 <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                     <asp:ListItem Selected="True" Value="1">Cargo</asp:ListItem>
                     <asp:ListItem Value="2">Abono</asp:ListItem>
                 </asp:RadioButtonList>
             </td>
         </tr>
        <tr>
            <td style="width: 196px">
                Descripción:</td>
            <td>
                <asp:TextBox ID="txbDescripcion" runat="server" Height="22px" MaxLength="50" 
                    Width="260px"></asp:TextBox>
        
                
                
                
            </td>
        </tr>
         <tr>
             <td style="width: 196px">
                 Fecha de programación:</td>
             <td>
                 <asp:TextBox ID="txbFechaProgramacion" runat="server"></asp:TextBox>
                 
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                     ControlToValidate="txbFechaProgramacion" ErrorMessage="Campo Obligatorio"></asp:RequiredFieldValidator>
                 <asp:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" 
                     TargetControlID="txbFechaProgramacion">
                 </asp:CalendarExtender>
             </td>
         </tr>
        <tr>
            <td style="width: 196px">
                Fecha de ejecución:</td>
            <td>
                <asp:TextBox ID="txbFechaEjecucion" runat="server"></asp:TextBox>
                
                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txbFechaEjecucion">
                </asp:CalendarExtender>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                Forma de Pago:</td>
            <td>
                <asp:DropDownList ID="ddlFormaPago" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="forma_pago" 
                    DataValueField="id_forma_pago">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [id_forma_pago], [forma_pago] FROM [formas_pago]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                Referencia:</td>
            <td>
                <asp:TextBox ID="txbReferencia" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                Importe:</td>
            <td>
                <asp:TextBox ID="txbImporte" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                IVA:</td>
            <td>
                <asp:DropDownList ID="ddlIva" runat="server" AutoPostBack="True">
                    <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                    <asp:ListItem Value=".16">16%</asp:ListItem>
                    <asp:ListItem Value=".11">11%</asp:ListItem>
                    <asp:ListItem Value="0.00">0%</asp:ListItem>
                </asp:DropDownList>
&nbsp;
                <asp:Label ID="lblIva" runat="server" Font-Overline="False" 
                    Font-Underline="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                Total:</td>
            <td>
                <asp:Label ID="lblTotal" runat="server" Font-Underline="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
            </td>
            <td>
                <asp:Label ID="lblMensaje" runat="server" ForeColor="#006600"></asp:Label>
            </td>
        </tr>
    </table>
    </ContentTemplate>
    </asp:UpdatePanel>
        <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" 
            CausesValidation="False" />
    </asp:Panel>
   
    <p>
        &nbsp;</p>
</asp:Content>
