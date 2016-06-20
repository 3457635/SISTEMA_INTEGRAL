Imports System.IO
Imports System.Net



Public Class testBuscaOdometro
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        TextBox1.Text = DateTime.Now.TimeOfDay().ToString()
        txthora.Text = DateTime.Now()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        'Dim strURL As String
        'Dim strResult As String
        'Dim wbrq As HttpWebRequest
        'Dim wbrs As HttpWebResponse
        'Dim sr As StreamReader

        '' Set the URL (and add any querystring values)  
        'strURL = "http://localhost:20541/evaluacionAbierta/EvaluacionChofer3.aspx?idOrden=8554&idEquipo=12&idChofer=64"

        '' Create the web request  
        'wbrq = WebRequest.Create(strURL)
        'wbrq.Method = "GET"

        '' Read the returned data   
        'wbrs = wbrq.GetResponse
        'sr = New StreamReader(wbrs.GetResponseStream)
        'strResult = sr.ReadToEnd.Trim
        'sr.Close()

        '' Write the returned data out to the page  
        'TextBox1.Text = strResult

        'EnviarCorreo("sistemas@tse.com.mx", "evaluacion", TextBox1.Text)

        Dim tipoCambio As New banxicoService.DgieWSPortClient

        TextBox1.Text = tipoCambio.tiposDeCambioBanxico()

        'TextBox1.Text = String.Format("Id: {0}  Texto:{1}", RadAutoCompleteBox1.DataValueField, RadAutoCompleteBox1.DataTextField)
    End Sub

    Protected Sub RadAutoCompleteBox1_EntryAdded(ByVal sender As Object, ByVal e As Telerik.Web.UI.AutoCompleteEntryEventArgs) Handles RadAutoCompleteBox1.EntryAdded
        TextBox1.Text = e.Entry.Value + " " + e.Entry.Text
    End Sub

    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        'Dim proxy As New wcfRef1.Service1Client()


        'Dim viatico As New wcfRef1.viatico()
        'viatico.imagen = FileUpload1.FileBytes

        'proxy.crearViatico(viatico)
        TextBox2.Text = DateTime.UtcNow()
        TextBox3.Text = DateTime.Now()
    End Sub
End Class