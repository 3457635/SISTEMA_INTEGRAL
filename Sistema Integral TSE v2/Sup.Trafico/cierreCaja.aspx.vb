Public Class cierreCaja
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbFechaCierre.Text = Now.Date
        End If
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim idRenta = RadioButtonList1.SelectedValue

        Dim buscarOrdenCaja = (From consulta In db.orden_cajas
                            Where consulta.id_renta = idRenta
                            Select consulta).FirstOrDefault()
        If Not buscarOrdenCaja Is Nothing Then
            buscarOrdenCaja.Fin = txbFechaCierre.Text
            db.SubmitChanges()
            RadioButtonList1.DataBind()
        End If

    End Sub
End Class