Public Class ctlMail
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Public Sub limpiarFormulario()
        txbAsunto.Text = String.Empty
        txbMensaje.Text = String.Empty
        txbPara.Text = String.Empty
        lblAdjunto.Text = String.Empty
        lblMensaje.Text = String.Empty
    End Sub
    Protected Sub btnEnviar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEnviar.Click

        Dim archivos() As String = {Server.MapPath(String.Format("~/Contabilidad/Facturar/Pdfs/{0}", hdnPdf.Value)),
                                           Server.MapPath(String.Format("~/Contabilidad/Facturar/XMls/{0}", hdnXml.Value))}



        Dim errorAlEnviar = EnviarCorreo(txbPara.Text,
                     txbAsunto.Text,
                     txbMensaje.Text,
                     archivos)

        If Not String.IsNullOrEmpty(errorAlEnviar) Then
            lblMensaje.Text = String.Format("Ocurrió un problema al enviar el correo. {0}", errorAlEnviar)
        Else
            If Not hfldFolioFiscal.Value = String.Empty Then

                Dim buscarCfdi = (From consulta In db.cfdis
                               Where consulta.folioFiscal = hfldFolioFiscal.Value
                               Select consulta).FirstOrDefault()

                If Not buscarCfdi Is Nothing Then
                    buscarCfdi.enviadoA = txbPara.Text
                    db.SubmitChanges()
                End If


            End If

            lblMensaje.Text = "Se ha enviado el correo correctamente."
        End If
        


    End Sub
    Public Sub ingresarCorreos(ByVal ParamArray correos() As String)
        txbPara.Text = String.Empty

        For i = 0 To correos.Length - 1 Step 1
            txbPara.Text += String.Format("{0}; ", correos(i))
        Next
    End Sub

    Public Function obtenerContactos()
        Return txbPara.Text
    End Function

    Public Sub llenarFormato(ByVal asunto As String, ByVal mensaje As String, ByVal para As String,
                             ByVal xml As String, ByVal pdf As String, ByVal folioFiscal As String)

        txbPara.Text = para
        txbAsunto.Text = asunto
        txbMensaje.Text = mensaje

        hdnXml.Value = xml
        hdnPdf.Value = pdf

        lblAdjunto.Text = String.Format("{0}, {1}", xml, pdf)

        hfldFolioFiscal.Value = folioFiscal

    End Sub

End Class