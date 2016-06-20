Public Partial Class Clientes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("tipo_empresa") = 1
    End Sub

End Class