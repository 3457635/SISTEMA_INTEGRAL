<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlEmpleado.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlPersona" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<style type="text/css">
    .style1
    {
        font-family: Arial, Helvetica, sans-serif;
    }
</style>
<br />
<br />

<asp:Button ID="btnNuevo" runat="server" Text="Nuevo" 
    CausesValidation="False" />
&nbsp;<asp:Button ID="btnGuardar" runat="server" Text="Guadar" />
&nbsp;<asp:Button ID="btnBaja" runat="server" Text="Baja" 
    CausesValidation="False" />
<br />
<br />
<span class="style1">Empleados: </span>
<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
    DataSourceID="SqlDataSource1" DataTextField="empleado" 
    DataValueField="id_empleado" Height="16px" Width="249px" 
    AppendDataBoundItems="True">
    <asp:ListItem Value="0">Seleccionar....</asp:ListItem>
</asp:DropDownList>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    
    SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS empleado, empleados.id_empleado FROM personas INNER JOIN empleados ON personas.id_persona = empleados.id_persona where personas.id_status=5 order by personas.primer_nombre">
</asp:SqlDataSource>
<br />
<asp:TextBox ID="txbIdempleado" runat="server" Height="22px" Width="60px" 
    Visible="False"></asp:TextBox>
<br />
<asp:Label ID="lblmensaje" runat="server" ForeColor="Red"></asp:Label>

<asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server"
TargetControlID="btnBaja"
ConfirmText="Confirma que quiere dar de baja?"
>
</asp:ConfirmButtonExtender>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
    ShowMessageBox="True" />

    
<table >
    <tr>
        <td >
            Primer Nombre:</td>
        <td class="style4">
            <asp:TextBox ID="txbPrimerNombre" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txbPrimerNombre" Display="Dynamic" 
                ErrorMessage="*primer nombre obligatorio">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td >
            Segundo Nombre:</td>
        <td class="style4">
            <asp:TextBox ID="txbSegundoNombre" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td >
            Apellido Paterno:</td>
        <td class="style4">
            <asp:TextBox ID="txbApellidoPaterno" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txbApellidoPaterno" Display="Dynamic" 
                ErrorMessage="*apellido paterno obligatorio">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td>
            Apellido Materno:</td>
        <td class="style4">
            <asp:TextBox ID="txbApellidoMaterno" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td >
            Puesto:</td>
        <td>
            <asp:DropDownList ID="ddlPuesto" runat="server" DataSourceID="SqlDataSource2" 
                DataTextField="puesto" DataValueField="id_puesto" Height="16px" Width="119px">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [id_puesto], [puesto] FROM [puestos]">
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td>
            Estado Civil:</td>
        <td class="style4">
            <asp:DropDownList ID="ddlEstadoCivil" runat="server" 
                DataSourceID="SqlDataSource3" DataTextField="estado_civil" 
                DataValueField="id_estado_civil" Height="17px" Width="118px">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [id_estado_civil], [estado_civil] FROM [estado_civil]">
            </asp:SqlDataSource>
        </td>
    </tr>
    </table>


<br />
