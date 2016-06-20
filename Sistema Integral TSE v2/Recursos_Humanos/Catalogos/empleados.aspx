<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="empleados.aspx.vb" Inherits="Sistema_Integral_TSE_v45.empleados" %>

<%@ Register src="../../Controles_Usuario/ctlEmpleado.ascx" tagname="ctlEmpleado" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   

        
    
    <table style="width: 100%">
        <tr>
            <td>
                <uc3:ctlEmpleado ID="ctlEmpleado1" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="text-align: left">
                &nbsp;</td>
        </tr>
    </table>
   

        
    
</asp:Content>
