Public Class ctlConceptosCotizacion
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim nuevoConcepto As New Concepto With {.concepto = txbConcepto.Text, .EstatusId = 5}
        db.Conceptos.InsertOnSubmit(nuevoConcepto)
        db.SubmitChanges()
        GridView1.DataBind()
        lblMensaje.Text = "Listo!"
    End Sub
End Class