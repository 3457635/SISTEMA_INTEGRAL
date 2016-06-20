Public Class Utilidad
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.Year
        End If
    End Sub

    Protected Sub btnConsultar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnConsultar.Click


    End Sub

    Protected Sub Chart5_Customize(ByVal sender As Object, ByVal e As EventArgs) Handles Chart5.Customize
        Dim contador = 0
        For Each item In Chart5.Series("Por Vencer").Points
            If contador = 0 Then
                item.Color = Drawing.Color.Black
            Else
                item.Color = Drawing.Color.Aqua
            End If
            contador += 1
        Next
    End Sub
End Class