Public Class NuevoProveedor
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Session("tipo_empresa") = 2
        End If
    End Sub

End Class