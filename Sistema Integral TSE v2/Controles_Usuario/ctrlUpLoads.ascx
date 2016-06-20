<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctrlUpLoads.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctrlUpLoads" %>

<script src="../../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>

<%--<script type="text/javascript">--%>
<%--$(function () {
        $("#<% = btnSubirPdf.ClientID%>").click(function () {
            var file = document.getElementById('<% = uploadFile2.ClientID%>').value;
            if (file == null || file == '') {
                alert('Seleccione el archivo a subir.');
                return false;
            }
            //DEFINE UN ARRAY CON LAS EXTENSIONES DE ARCHIVOS VALIDAS
            var extArray = new Array(".pdf");

            //SE EXTRAE LA EXTENSION DEL ARCHIVO CON EL PUNTO INCLUIDP                     
            var ext = file.slice(file.indexOf(".")).toLowerCase();

            //SE RECORRE EL ARRAY PARA VERIFICAR SI LA EXTENSSION DEL ARCHIVO ESTA DEFINIDA 
            //EN EL ARRAY QUE CONTIENE LAS EXTENSIONES VALIDAS
            for (var i = 0; i < extArray.length; i++) {
                if (extArray[i] == ext) {
                    alert("Archivo válido.");
                    return true;
                }
            }
            alert("Archivo no válido");
            return false;
        })
    })--%>
<%--</script>--%>
<asp:Panel ID="pnlUploads" runat="server" BackColor="White" Height="100%" Width="100%">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div>
                <fieldset>
                    <legend>Archivo XML</legend>
                    <label>Seleccione Archivo:</label>
                    <asp:FileUpload ID="uploadFile" runat="server" Width="400px" />
                    <asp:Button ID="btnSubirXml" runat="server" Text="Subir XML" Visible="False" />
                    <br />
                    <br />
                    <asp:Image ID="imgSubidaXml" runat="server" />
                    <br />
                    <br />
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                </fieldset>

                <fieldset>
                    <legend>Archivo PDF</legend>
                    <label>Seleccione Archivo:</label>
                    <asp:FileUpload ID="uploadFile2" runat="server" Width="400px" />
                    <asp:Button ID="btnSubirPdf" runat="server" Text="Subir PDF" Visible="False" />
                    <br />
                    <br />
                    <asp:Image ID="imgSubidaPdf" runat="server" />
                    <br />
                    <br />
                    <asp:Label ID="lblMensaje2" runat="server" ForeColor="Red"></asp:Label>
                </fieldset>
            </div>
            <div style="text-align:right">
                <asp:Button ID="btnSubirCerrar" runat="server" Text="Subir Archivos" />
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSubirCerrar" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hdnFileXml" runat="server" />
    <asp:HiddenField ID="hdnFilePdf" runat="server" />
</asp:Panel>
