Public Class EliminarUsuario
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Dim borrado As Boolean = Membership.DeleteUser(TextBox1.Text)
        GridView1.DataBind()
    End Sub
End Class