Public Class precios_combustible
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        If ddlCombustible.SelectedValue <> 0 Then

            Dim nuevo_precio_combustible As New costo_combustible With {.fecha = txbFecha.Text,
                                                                        .precio = txbPrecio.Text,
                                                                         .tipo_combustible = ddlCombustible.SelectedValue}
            db.costo_combustibles.InsertOnSubmit(nuevo_precio_combustible)
            db.SubmitChanges()
        Else
            lblMensaje.Text = "Seleccione el tipo de combustible."
        End If

        GridView1.DataBind()
    End Sub

    Protected Sub ddlCombustible_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCombustible.DataBound
        ddlCombustible.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub
End Class