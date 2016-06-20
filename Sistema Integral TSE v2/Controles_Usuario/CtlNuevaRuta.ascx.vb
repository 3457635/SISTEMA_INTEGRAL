Public Partial Class NuevaRuta
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardarRuta_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarRuta.Click
        Dim id_ruta As String = ddlRuta0.SelectedValue
        'Dim id_empresa As String = ddlEmpresa.SelectedValue
        Dim id_vehiculo As String = ddlVehiculo.SelectedValue
        Dim precio As String = txbPrecio.Text
        Dim id_moneda As String = ddlMoneda.SelectedValue
        Dim especificacion As String = txbEspecificacion.Text


        'Dim query As String = "INSERT INTO ruta_empresa (id_ruta,id_empresa,id_tipo_recurso,precio,id_moneda,especificacion) VALUES (" + id_ruta + "," + id_empresa + "," + id_vehiculo + "," + precio + "," + id_moneda + ",'" + especificacion + "')"


        'InsertarActualizarRegistro(query)
        'ddlRelacion.DataBind()
        'SqlDataRutas.DataBind()

        lblGuardarRuta.Text = "La ruta se ha agregado exitosamente."
    End Sub

    Protected Sub btnGuardarRuta0_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarRuta0.Click
        Dim ruta As String = txbRuta.Text
        Dim abreviatura As String = txbAbre.Text
        Dim kms As String = txbKms.Text
        Dim tiempo As String = txbTiempo.Text
        Dim id_tiporuta As String = ddlTipoRuta.SelectedValue


        Dim query As String = "INSERT INTO rutas (ruta,abrevia,kms,tiempo,id_tiporuta) VALUES ('" + ruta + "','" + abreviatura + "'," + kms + "," + tiempo + "," + id_tiporuta + ")"
        InsertarActualizarRegistro(query)
        ddlRuta0.DataBind()

        ' mdlPopup.Show()

        lblRuta.Text = "Se guardó la ruta " + ruta + "."
    End Sub
End Class