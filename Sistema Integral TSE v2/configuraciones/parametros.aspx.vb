Public Class parametros
    Inherits System.Web.UI.Page
    Dim db As New DataClasses2DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim nuevoParametro As New parametro With {.variable = txbParametro.Text, .valor = txbValor.Text}
        db.parametros.InsertOnSubmit(nuevoParametro)
        db.SubmitChanges()
        grdParametros.DataBind()
    End Sub
End Class