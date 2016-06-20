Public Class ctlTarifaChofer
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
            If Session("popup") = 1 Then
               
            End If


        End If
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim id_cliente = ddlCliente.SelectedValue
        Dim id_ruta = ddlRuta.SelectedValue
        Dim id_tipo_vehiculo = ddlVehiculo.SelectedValue
        Dim tarifa = txbTarifa.Text

        If IsNumeric(tarifa) Then
            Dim buscar_tarifa = (From consulta In db.tarifas_choferes
                                      Where consulta.id_cliente = id_cliente And consulta.id_ruta = id_ruta And consulta.id_tipo_vehiculo = id_tipo_vehiculo
                                      Select consulta).FirstOrDefault()

            If buscar_tarifa Is Nothing Then
                Dim nueva_tarifa As New tarifas_chofere With {.id_cliente = id_cliente,
                                                              .id_ruta = id_ruta,
                                                              .id_tipo_vehiculo = ddlVehiculo.SelectedValue,
                                                              .tarifa = tarifa}
                db.tarifas_choferes.InsertOnSubmit(nueva_tarifa)

            Else
                buscar_tarifa.tarifa = tarifa
            End If
            db.SubmitChanges()
            lblMensaje.Text = "Se guardó la información exitosamente."
        Else
            lblMensaje.Text = "La información ingresada es incorrecta."
        End If

    End Sub

    Protected Sub ddlVehiculo_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlVehiculo.SelectedIndexChanged
        Dim id_cliente = ddlCliente.SelectedValue
        Dim id_ruta = ddlRuta.SelectedValue
        Dim id_tipo_vehiculo = ddlVehiculo.SelectedValue
        txbTarifa.Text = String.Empty


        Dim buscar_tarifa = (From consulta In db.tarifas_choferes
                                  Where consulta.id_cliente = id_cliente And
                                  consulta.id_ruta = id_ruta And
                                  consulta.id_tipo_vehiculo = id_tipo_vehiculo
                                  Select consulta.tarifa).FirstOrDefault()

        If Not buscar_tarifa Is Nothing Then
            txbTarifa.Text = buscar_tarifa
        Else
            txbTarifa.Text = String.Empty
        End If
    End Sub

    Protected Sub ddlCliente_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.DataBound
       
        ddlCliente.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub

    Protected Sub ddlRuta_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRuta.DataBound
        
        ddlRuta.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub
 

    Protected Sub ddlVehiculo_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlVehiculo.DataBound
        ddlVehiculo.Items.Add(Crear_item("Seleccionar", 0))
    End Sub
End Class