Public Class webpart
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

   
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Label2.Text = Now.AddHours(1).ToString("dd/MM/yyyy HH:mm")
    End Sub
End Class