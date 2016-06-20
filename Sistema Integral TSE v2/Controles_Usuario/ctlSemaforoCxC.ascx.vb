Public Class ctlSemaforoCxC
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnConsultar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnConsultar.Click
        Dim inicio = 0
        Dim fin = 20

        Select Case ddlRango.SelectedValue
            Case 1
                inicio = 21
                fin = 30
            Case 2
                inicio = 31
                fin = 60
            Case 3
                inicio = 61
                fin = 2000
        End Select

        sdsDetalles.SelectParameters(0).DefaultValue = inicio
        sdsDetalles.SelectParameters(1).DefaultValue = fin

    End Sub
End Class