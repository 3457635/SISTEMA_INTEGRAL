Public Class testUpdatePanel
    Inherits System.Web.UI.Page
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click

        Dim contactos(1) As String
        contactos(0) = "sistemas@tse.com.mx"
        Dim rutaArchivos(0) As String



        Label1.Text = "You clicked the button!"
    End Sub
End Class