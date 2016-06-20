Public Class configurar_cotizador
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim buscar_configuracion = (From consulta In db.configuracion_cotizadors
                                 Select consulta).FirstOrDefault()
        If Not buscar_configuracion Is Nothing Then
            txbCostoxKilometro.Text = buscar_configuracion.costo_kilometro
            txbRedondo.Text = buscar_configuracion.factor_retorno
            txbReduccionPickup.Text = buscar_configuracion.manejo_pickup
            txbReduccionRabon.Text = buscar_configuracion.manejo_rabon
            txbTarifaChofer.Text = buscar_configuracion.porcentaje_chofer
            txbDiesel.Text = buscar_configuracion.precio_diesel
            txbRendimientoPickup.Text = buscar_configuracion.rendimiento_pickup
            txbRendimientoRabon.Text = buscar_configuracion.rendimiento_rabon
            txbRendimientoTracto.Text = buscar_configuracion.rendimiento_tracto
            If Not buscar_configuracion.meses_vigencia Is Nothing Then
                txbMeses.Text = buscar_configuracion.meses_vigencia
            End If

        End If
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim buscar_configuracion = (From consulta In db.configuracion_cotizadors
                                 Select consulta).FirstOrDefault()
        If Not buscar_configuracion Is Nothing Then

            buscar_configuracion.costo_kilometro = txbCostoxKilometro.Text
            buscar_configuracion.factor_retorno = txbRedondo.Text
            buscar_configuracion.manejo_pickup = txbReduccionPickup.Text
            buscar_configuracion.manejo_rabon = txbReduccionRabon.Text
            buscar_configuracion.porcentaje_chofer = txbTarifaChofer.Text
            buscar_configuracion.precio_diesel = txbDiesel.Text
            buscar_configuracion.rendimiento_pickup = txbRendimientoPickup.Text
            buscar_configuracion.rendimiento_rabon = txbRendimientoRabon.Text
            buscar_configuracion.rendimiento_tracto = txbRendimientoTracto.Text

            buscar_configuracion.meses_vigencia = txbMeses.Text



        Else
            Dim nueva_configuracion As New configuracion_cotizador With {.costo_kilometro = txbCostoxKilometro.Text,
                                                                         .factor_retorno = txbRedondo.Text,
                                                                         .manejo_rabon = txbReduccionRabon.Text,
                                                                         .manejo_pickup = txbReduccionPickup.Text,
                                                                         .porcentaje_chofer = txbTarifaChofer.Text,
                                                                         .precio_diesel = txbDiesel.Text,
                                                                         .rendimiento_pickup = txbRendimientoPickup.Text,
                                                                         .rendimiento_rabon = txbRendimientoRabon.Text,
                                                                         .rendimiento_tracto = txbRendimientoTracto.Text,
                                                                         .meses_vigencia = txbMeses.Text
                                                                         }
            db.configuracion_cotizadors.InsertOnSubmit(nueva_configuracion)
        End If
        db.SubmitChanges()
        lblMensaje.Text = "Se guardó la información."

    End Sub
End Class