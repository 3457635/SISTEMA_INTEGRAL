<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlPrenomina.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlPrenomina" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<style type="text/css">
    .style1
    {
        width: 48px;
        height: 48px;
    }
</style>
<p>
    
    </p>
<p>
    </p>

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <p>
            Desde:
            <asp:TextBox ID="txbFecha1" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                TargetControlID="txbFecha1">
            </asp:CalendarExtender>
            &nbsp;- Hasta:
            <asp:TextBox ID="txbFecha2" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" 
                TargetControlID="txbFecha2">
            </asp:CalendarExtender>
            &nbsp;<asp:ImageButton ID="ibtnActualizarG" runat="server" SkinID="ibtnActualizar" 
                style="width: 14px" />
        </p>
        <p>
            <asp:PlaceHolder ID="phrTabla" runat="server"></asp:PlaceHolder>
        </p>
        <asp:Label ID="lblTotal" runat="server"></asp:Label>
    </ContentTemplate>
    <Triggers>
 <asp:AsyncPostBackTrigger ControlID="ibtnActualizarG" EventName="Click" />
 </Triggers>

</asp:UpdatePanel>




<asp:UpdateProgress ID="UpdateProgress1" runat="server" 
    AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
        &nbsp;
        <img alt="" class="style1" 
    src="../imagenes/updateProgress.gif" />
        Procesando...
    </ProgressTemplate>
</asp:UpdateProgress>





